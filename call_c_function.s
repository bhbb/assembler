.section .data

exit_success: .int 0

.section .text
.globl _start

_start:
	# call the C function hello defined in hello.c
	call hello
	mov $1, %rax	#syscall no 1 (exit)
	mov exit_success, %rbx	# exit code
	int $0x80
