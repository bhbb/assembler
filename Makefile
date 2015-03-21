
call_own_function:
	as call_own_function.s -o call_own_function.o
	ld call_own_function.o -o call_own_function

clean:
	rm *.o
