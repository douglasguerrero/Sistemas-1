all: floppya.img
run: all
	bochs -f bochsrc.txt
kernel.o: kernel.c
	bcc -ansi -c -o $@ $<
kernel_asm.o: kernel.asm
	as86 $< -o $@
start.o: start.asm
	as86 $< -o $@
bootload.bin: bootload.asm
	nasm $< -f bin -o $@
floppya.img: bootload.bin kernel.bin syscall-test.bin
	dd if=/dev/zero of=floppya.img bs=512 count=2880
	dd if=bootload.bin of=floppya.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=floppya.img bs=512 seek=3 conv=notrunc
	dd if=message.txt of=floppya.img bs=512 count=1 seek=30 conv=notrunc
	dd if=syscall-test.bin of=floppya.img bs=512 count=1 seek=11 conv=notrunc

clean :
	rm -f *.o
	rm -f *.bin
	rm -f bochsout.txt
	rm -f usrProgram/*.o
	rm -f usrProgram/*.bin
test.o: test.c
	bcc -ansi -c -o $@ $<
os-api.o: os-api.asm
	as86 $< -o $@
start_asm.o: start.asm
	as86 $< -o $@
syscall-test.bin: start_asm.o test.o os-api.o
	ld86 -o $@ -d $^
kernel.bin: start.o kernel.o kernel_asm.o
	ld86 -o $@ -d $^
