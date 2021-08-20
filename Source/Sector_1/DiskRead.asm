
PROGRAM_SPACE equ 0x8000

ReadDisk:
	mov ah, 0x02
	mov bx, PROGRAM_SPACE
	mov al, 32            ; No. of sectors, likely source of some trouble
	mov dl, [BOOT_DISK]
	mov ch, 0x00          ; 0th Cylinder in disk
	mov dh, 0x00          ; head at 0
	mov cl, 0x02          ; Read Sector 2

	int 0x13

	jc DiskReadFailed     ; Disk read has failed

	ret

BOOT_DISK:
	db 0

DiskReadFailedString:
	db 'Disk Read Failed', 0

DiskReadFailed:
	mov bx, DiskReadFailedString
	call PrintString

	jmp $
