CC=clang
CFLAGS=-pipe -O2 -Wall

make: main

main: main.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm main *.o
