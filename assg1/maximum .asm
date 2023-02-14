section .data
msg1: db 'Enter n:', 10
l1: equ $-msg1

msg2: db 'Max number is: '
l2: equ $-msg2

section .bss
    n: resw 1
    count: resb 1
    num: resw 1
    temp: resb 1
    max: resw 1

section .text
    global _start:
    _start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, l1
int 80h

mov word[n], 0
loop_read:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read1
mov ax, word[n]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[n], ax
jmp loop_read
end_read1:
popa

mov word[max], 0

input:
    cmp word[n], 0
    je print_max
    
    sub word[n], 1
   
   
    ;input number
    read_num:
    pusha
    mov word[num], 0
    
    read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp], 10
    je end_read
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax
    jmp read
   
    end_read:
    
    mov ax, word[max]
    cmp word[num], ax
    jna input
    
    mov ax, word[num]
    mov word[max], ax
    jmp input

print_max:
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h

    mov byte[count],0
    pusha
    
    extract_no:
    cmp word[max], 0
    je print_no
    inc byte[count]
    mov dx, 0
    mov ax, word[max]
    mov bx, 10
    div bx
    push dx
    mov word[max], ax
    jmp extract_no
    
    print_no:
    cmp byte[count], 0
    je end_print
    dec byte[count]
    pop dx
    mov byte[temp], dl
    add byte[temp], 30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    jmp print_no
    
    end_print:
    mov eax,4
    mov ebx,1
    mov ecx,10
    mov edx,1
    int 80h
    popa
    mov eax, 1
    mov ebx, 0
    int 80h