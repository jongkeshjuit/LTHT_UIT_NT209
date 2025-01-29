.section .data
    input_string: .string "Enter a number (1 - digit): "
    input_string_length = .-input_string
    output_string: .string "Count 4x: "
    output_string_length = .- output_string
    endline: .string "\n"

.section .bss
    .lcomm input  2
    .lcomm count  2
    .lcomm output 2

.section .text
    .globl _start

_start:
    # Khoi tao count =0
    movl $0, count 
    # Khoi tao chi so i = %esi
    movl $0, %esi
# Vong lap nhap input
loop_start:
    cmpl $5, %esi
    jge print_result
    # In thong bao nhap
    movl $4, %eax
    movl $1, %ebx
    movl $input_string, %ecx
    movl $input_string_length, %edx
    int $0x80
    # Nhap input
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $2, %edx
    int $0x80
    # Chuyen input thanh so
    movb input, %al
    subb $'0', %al
    movzx %al, %eax
    # Kiem tra chia het cho 4
    movl $4, %ebx
    xorl %edx, %edx
    divl %ebx
    cmpl $0, %edx
    jne continue_loop
    addl $1, count
continue_loop:
    # Tang i len 1 don vi va tiep tuc vong lap
    addl $1, %esi
    jmp loop_start
print_result: 
    # Chuyen count sang %eax
    movl count, %eax
    # Chuyen count thanh ky tu
    addl $'0', %eax
    movb %al, output
    movb $0x0A, output+1
    # In thong bao "Count 4x: "
    movl $4, %eax
    movl $1, %ebx
    movl $output_string, %ecx
    movl $output_string_length, %edx
    int $0x80
    # In ket qua
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $2, %edx
    int $0x80
    # Thoat chuong trinh
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80

    
    
    