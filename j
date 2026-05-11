extern printf, scanf

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
    mov rbp, rsp                ; Для коректного дебагу в SASM

    ; 1. Вводимо 'a'
    mov rdi, msg_a
    xor rax, rax
    call printf

    mov rdi, fmt_in
    mov rsi, a
    xor rax, rax
    call scanf

    ; 2. Запит на числа
    mov rdi, msg_x
    xor rax, rax
    call printf

    xor r12, r12                ; r12 — наш лічильник (count)

.loop:
    ; 3. Зчитуємо x
    mov rdi, fmt_in
    mov rsi, temp
    xor rax, rax
    call scanf
    
    cmp rax, 1                  ; Чи вдалося зчитати число?
    jne .print_res              ; Якщо ні (ввели букву) — кінець циклу

    movsd xmm0, [temp]          ; xmm0 = введене число
    movsd xmm1, [zero]          ; xmm1 = 0.0
    movsd xmm2, [a]             ; xmm2 = a

    ; ПЕРЕВІРКА: чи x < 0?
    ucomisd xmm0, xmm1
    jae .loop                   ; Якщо x >= 0, ігноруємо

    ; ПЕРЕВІРКА: чи x > a?
    ucomisd xmm0, xmm2
    jbe .loop                   ; Якщо x <= a, ігноруємо

    inc r12                     ; Якщо обидві умови пройшли, count++
    jmp .loop

.print_res:
    ; 4. Вивід результату
    mov rdi, fmt_out
    mov rsi, r12
    xor rax, rax
    call printf

    xor rax, rax
    ret
