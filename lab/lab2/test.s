# Ví dụ file: hello.s
.section .data
    msg: .ascii "Hello from VSCode!\n"
    len = . - msg

.section .text
    .global _start

_start:
    # sys_write
    movl $4, %eax       # system call for write
    movl $1, %ebx       # file descriptor 1 = stdout
    movl $msg, %ecx     # pointer to message
    movl $len, %edx     # message length
    int  $0x80          # call kernel

    # sys_exit
    movl $1, %eax       # system call for exit
    movl $0, %ebx       # exit code 0
    int  $0x80          # call kernel