# IOCLA 2016
# USO remembers

CC=gcc
ASM=nasm
ASMFLAGS=-f elf64

mainmax: main.o max.o
	$(CC) -o $@ $^ -fPIC
main.o: main.asm
	$(ASM) $(ASMFLAGS) $< -o $@

max.o: max.c
	$(CC) -m64 -c $^

clean:
	rm -f *.o mainmax
