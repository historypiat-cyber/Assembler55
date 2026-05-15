
Extern printf, scanf

section .data
    msg_a     db "Введіть a: ", 0
    msg_x     db "Введіть числа (літера для стопу): ", 0
    fmt_in    db "%lf", 0
    fmt_out   db 10, "Результат: %d", 10, 0
    zero      dq 0.0

section .bss
    a    resq 1
    temp resq 1

section .text
    global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    mov rdi, msg_a
    xor rax, rax
    call printf

    mov rdi, fmt_in
    lea rsi, [a]
    xor rax
