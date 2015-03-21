.section .data
msg: .ascii "Hello World %i, %i, %i!\n\0"
msg7: .ascii "Hello World %i, %i, %i, %i, %i, %i!\n\0"
msg1: .ascii "Data saved in ram: $i\n\0"
successful: .ascii "Success\n\0"

.section .text
.globl _start
_start:
	# building stack frame
	pushq %rbp
	movq %rsp, %rbp

	# first call to glibc printf function, load paramters into registers
	movq $4, %rcx
	movq $3, %rdx
	movq $2, %rsi
	movq $msg, %rdi
	movq $0, %rax
	call printf


	##call libc printf function with 7 paramters
	# the seventh parameter will be passed on the stack
	# reservate and int on the stack (int is 4 byte why 16?)
	subq $16, %rsp
	# write the value on the stack
	movl $7, (%rsp)
	movl $6, %r9d
	movl $5, %r8d
	movq $4, %rcx
	movq $3, %rdx
	movq $2, %rsi
	movq $msg7, %rdi
	movq $0, %rax
	call printf
	# give reservate int on stack free
	addq $16, %rsp
	# read out return value, printf returns the number of written characters
	cmpq $30, %rax
	jne not_successfull
	# print if printf was successfull 
	movq $successful, %rdi
	movq $0, %rax
	call printf

	# allocate some ram
	subq $16, %rsp
	movq $4, %rdi
	movq $0, %rax
	call malloc
	#save return value (pointer to memory) on stack
	movq %rax, -8(%rbp)
	# malloc successful?
	cmpq $0, -8(%rsp)
	je not_successfull
	movq $successful, %rdi
	movq $0, %rax
	call printf
	# write some data to ram
	movq -8(%rbp), %rax
	movq $5, (%rax)
	#movq -8(%rbp)
	# free memory
	movq -8(%rbp), %rdi
	call free
	# free doen't return anything, crash if parameter is shitty
	# give pointer on stack free
	movq $0, -8(%rbp)
	addq $16, %rsp

not_successfull:
	# call exit function
	movq $0, %rdi
	call _exit
