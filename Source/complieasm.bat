
nasm "Sector_1\bootloader.asm" -f bin -o bootloader.bin

nasm "Sector_2+\ExtendedProgram.asm" -f elf64 -o ExtendedProgram.o

wsl $WSLENV/x86_64-elf-gcc -Ttext 0x8000 -ffreestanding -mno-red-zone -m64 -c "Kernel.cpp" -o "Kernel.o"

wsl $WSLENV/x86_64-elf-ld -T"link.ld"

copy /b bootloader.bin+kernel.bin bootloader.flp

pause
