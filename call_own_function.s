.section .data
say: .ascii "Wie oft soll ich Scheisse ausgeben?\n"
msg: .ascii "Hallo\n"
buff: .long
exit_success: .int 5
iterations: .long 0

.section .text
.globl _start

_start:
	call print
	mov $1, %rax	#syscall no 1 (exit)
	mov exit_success, %rbx	# exit code
	int $0x80
	

.type print, @function
print:
	pushq %rbp
	movq %rsp, %rbp
	mov $4, %rax 	#syscall no 4 (write)
	mov $1, %rbx	# in stdout
	mov $say, %rcx
	mov $36, %rdx
	int $0x80	# softirq no 80
	popq %rbp
	ret

