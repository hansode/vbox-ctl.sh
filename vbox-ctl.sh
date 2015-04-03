#!/bin/bash
#
# requires:
#  bash
#  VBoxManage
#
# usage:
#  $ vbox-ctl.sh index
#
#  $ vbox-ctl.sh setup <name>
#  $ vbox-ctl.sh show  <name>
#  $ vbox-ctl.sh start        <name>
#  $ vbox-ctl.sh softpoweroff <name>
#  $ vbox-ctl.sh poweroff     <name>
#  $ vbox-ctl.sh destroy      <name>
#
set -e
set -o pipefail

function setup_vm() {
  VBoxManage createvm --name ${name} --register

  # via boot2docker
  VBoxManage modifyvm ${name} --ostype RedHat_64

  VBoxManage modifyvm ${name} --cpus ${cpus:-1}
  VBoxManage modifyvm ${name} --memory ${memory:-2048}
  VBoxManage modifyvm ${name} --rtcuseutc on
  VBoxManage modifyvm ${name} --acpi on
  VBoxManage modifyvm ${name} --ioapic on
  VBoxManage modifyvm ${name} --hpet on
  VBoxManage modifyvm ${name} --hwvirtex on
  VBoxManage modifyvm ${name} --vtxvpid on
  VBoxManage modifyvm ${name} --nestedpaging on
  VBoxManage modifyvm ${name} --largepages on
  VBoxManage modifyvm ${name} --firmware bios
  VBoxManage modifyvm ${name} --bioslogofadein off
  VBoxManage modifyvm ${name} --bioslogofadeout off
  VBoxManage modifyvm ${name} --bioslogodisplaytime 0
  VBoxManage modifyvm ${name} --biosbootmenu disabled

  # ttyS0
  VBoxManage modifyvm ${name} --uart1 0x3f8 4

  # eth0
  VBoxManage modifyvm ${name} --nic1 nat --nictype1 virtio --cableconnected1 on
  VBoxManage modifyvm ${name} --natpf1 ssh,tcp,127.0.0.1,2222,,22

  # hdd
  VBoxManage storagectl    ${name} --name       IDE --add ide --hostiocache on
  [[ -f box-disk1.vmdk ]] || \
  VboxManage createhd --filename box-disk1.vmdk --format VMDK --size 4096
  vboxmanage storageattach ${name} --storagectl IDE --port 0 --device 0 --type hdd --medium box-disk1.vmdk
}

function start_vm() {
  VBoxManage startvm ${name} # --type headless
}

function softpoweroff_vm() {
  VBoxManage controlvm ${name} acpipowerbutton
}

function poweroff_vm() {
  VBoxManage controlvm ${name} poweroff
}

function destroy_vm() {
  VBoxManage unregistervm --delete ${name}
}

function show_vm() {
  VBoxManage showvminfo ${name}
}

cmd=${1:-status}
name=${2:-sandbox}

case "${cmd}" in
  setup)
    setup_vm
    ;;
  start|poweron)
    start_vm
    ;;
  acpipowerbutton|softpoweroff)
    softpoweroff_vm
    ;;
  stop|poweroff)
    poweroff_vm
    ;;
  destroy|delete|remove)
    destroy_vm
    ;;
  show)
    show_vm
    ;;
  status)
    ;;
  index)
    VBoxManage list vms
    ;;
  *)
    echo "[ERROR] Bad command: ${cmd}" >&2
    exit 1
    ;;
esac
