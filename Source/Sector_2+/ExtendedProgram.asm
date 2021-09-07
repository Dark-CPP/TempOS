
jmp EnterProtectedMode

%include "Sector_2+\gdt.asm"

EnterProtectedMode:
	call EnableA20
	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 1

	mov cr0, eax

	jmp codeseg:StartProtectedMode

EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

[bits 32]

%include "Sector_2+\CPUID.asm"
%include "Sector_2+\SimplePaging.asm"

StartProtectedMode:

	mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov [0xb8000], byte 'H'

	call DetectCPUID
	call DetectLongModeSupport
	call SetUpIdentityPaging
	call EditGDT

	jmp codeseg:StartLongMode

[bits 64]
[extern _start]

StartLongMode:
	mov edi, 0xb8000
	mov rax, 0x1f201f201f201f20
	mov ecx, 500
	rep stosq
	call _start
	jmp $

times 2048-($-$$) db 0
