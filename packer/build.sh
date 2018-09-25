#!/bin/bash

mkdir -p ./iso
wget -nc -O ./iso/virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

PACKER_KEY_INTERVAL=25ms PACKER_LOG=1 packer build --only=qemu windows2016-feb2018.json
