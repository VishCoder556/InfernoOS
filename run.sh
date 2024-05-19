nasm -f bin main.asm -o bootloader.bin
nasm -f bin kernel.asm -o kernel.bin
cat bootloader.bin kernel.bin > main.bin
qemu-system-x86_64 -drive format=raw,file=main.bin


#