#/bin/bash

IMAGE=$1
ITER=$2
./test_static /data/$IMAGE

##export VACCEL_IMAGENET_NETWORKS=/data/networks
export VACCEL_BACKENDS=/.local/lib/libvaccel-jetson.so


#message=$(cat /dev/stdin)

#echo $message > /data/$IMAGE


cd /data

LD_LIBRARY_PATH=/.local/lib:/usr/local/nvidia/lib:/usr/local/nvidia/lib64 qemu-system-x86_64 \
	-cpu host -m 512 -enable-kvm -nographic -vga none \
	-fsdev local,id=myid,path=/data,security_model=none \
	-device virtio-9p-pci,fsdev=myid,mount_tag=data,disable-modern=on,disable-legacy=off \
	-object acceldev-backend-vaccelrt,id=gen0 -device virtio-accel-pci,id=accl0,runtime=gen0,disable-legacy=off,disable-modern=on \
	-kernel /classify_kvm-x86_64 -append "vfs.rootdev=data -- $IMAGE $ITER"
