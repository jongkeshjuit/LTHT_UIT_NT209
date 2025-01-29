.section .data
	prompt: .asciz "Enter a string (<255 chars): "
.section .bss
	.lcomm flag, 1
	.lcomm string, 255
	.lcomm ketqu, 255
	.lcomm n, 4
.section .text
	.globl _start
_start:
	# In ra thong bao
	movl $4, %eax
	movl $1, %ebx
	movl $prompt, %ecx
	movl $28, %edx
	int $0x80

	#Nhap chuoi
	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $255, %edx
	int $0x80

	movl $0, %ecx
	jmp .test
# Cap nhat gia tri
.for:
	addl $1, %ecx  
# Tinh chuoi
.test:
	movl $0, %ebx
	addl $string, %ebx
	addl %ecx, %ebx
	movb (%ebx), %ah
	cmpb $10, %ah
	je .exit_for
	jne .for
# Thoat vong lap
.exit_for:
	movl %ecx, n
	
	movl $0, %ebx
	addl $string, %ebx
	
	movl $0, %ecx
	movb $1, flag
# Vong lap xu ly chuoi
.while:	
	cmpl n, %ecx
	jge .exit_while
	
	movl $0, %ebx
	addl $string, %ebx
	add %ecx, %ebx
	
	movb (%ebx), %ah
	
	cmpb $32, %ah
	je .space
	
	cmpb $1, flag
	je .first_letter_of_word
	jne .in_word_letter
# Cap nhat flag
.space:	
	movb $1, flag
	jmp .update
# Ky tu dau tien
.first_letter_of_word:
	cmpb $97, %ah
	jl .change.flag
	cmpb $122, %ah
	jg .change.flag
	subb $32, %ah
	movb %ah, (%ebx)
	movb $0, flag
	jmp .update
# Thay doi flag
.change.flag:
	movb $0, flag
	jmp .update
# Xu ly chuoi
.in_word_letter:
	cmpb $65, %ah
	jl .update
	cmpb $90, %ah
	jg .update
	addb $32, %ah
	movb %ah, (%ebx)
	jmp .update
# Cap nhat
.update:
	addl $1, %ecx
	jmp .while
# Thoat khoi vong lap
.exit_while:
	movl $4, %eax
	movl $1, %ebx
	movl $string, %ecx
	movl n, %edx
	int $0x80
	
	movl $1, %eax
	int $0x80
	
	
	
