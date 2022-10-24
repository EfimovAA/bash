#!/bin/bash

VMS="/mnt/vm"
TARGET="/mnt/backup/xdelta_vm"
VM="Ubuntu 22 lts"

function mkshapshot() {
vmrun -T ws snapshot "$VMS/$VM".vmx bak
}

function rmshapshot() {
vmrun -T ws deleteSnapshot "$VMS/$VM".vmx bak
}


function fullbackup() {
mkshapshot
rsync -a "$VMS/$VM".vmdk $TARGET/
rmshapshot
exit
}


function difbackup() {
mkshapshot
xdelta3 -s "$TARGET/$VM.vmdk" "$VMS/$VM.vmdk" "$VM"_$(date +%Y%m%d).xdelta
rmshapshot
exit
}

function difrestore() {
vmrun -T ws stop "$VMS/$VM.vmx"
xdelta3 -f -d -s  "$TARGET/$VM.vmdk" "$VM.vmdk.xdelta" "$VMS/$VM.vmdk"
}


[ -f "$TARGET/$VM".vmdk ] && difbackup 
fullbackup



