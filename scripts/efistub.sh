#!/usr/bin/sh

# A simple script to install a very basic UEFI boot entry
# Make sure your UEFI supports directly booting images

DISK="${1:?Missing target disk}"
DISK_PART_BOOT="${2:?Missing part number of efi partition}"
DISK_PART_ROOT="${3:?Missing path to root partition}"
DISK_PART_ROOT_UUID="$()"

LABEL="${LABEL:-arch}"

get_root_uuid() {
    DISK_PART_ROOT_UUID="$(blkid -s PARTUUID -o value ${DISK_PART_ROOT})"

    if [ ! "$?" -eq 0 ] || [ "$DISK_PART_ROOT_UUID" = "" ]; then
        echo "Failed to query UUID for root partition "${DISK_PART_ROOT}"" 2>&1
        exit 1
    fi
}

create_boot_entry() {
    sudo efibootmgr --disk "${DISK}" --part "${DISK_PART_BOOT}" --create --label ${LABEL} --loader /vmlinuz-linux --unicode "root=PARTUUID=${DISK_PART_ROOT_UUID} rw initrd=\initramfs-linux.img"
}

get_root_uuid

echo "boot_part:   ${DISK}p${DISK_PART_BOOT}"
echo "root_part:   ${DISK_PART_ROOT}"
echo "root_uuid:   ${DISK_PART_ROOT_UUID}"
echo "entry_label: ${LABEL}"
echo
echo "creating boot entry.."

create_boot_entry


