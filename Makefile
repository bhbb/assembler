
call_own_function:
	as call_own_function.s -o call_own_function.o
	ld call_own_function.o -o call_own_function

call_c_function:
	as call_c_function.s -o call_c_function.o
	# generate hello.o 
	gcc -c hello.c
	# link hello.o and call_c_function, hello() use libc (puts)
	ld --dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /lib/x86_64-linux-gnu/libc-2.19.so hello.o call_c_function.o -o call_c_function

use_libc:
	as use_libc.s -o use_libc.o
	ld --dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /lib/x86_64-linux-gnu/libc-2.19.so use_libc.o -o use_libc

clean:
	rm *.o
