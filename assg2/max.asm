print_num:
    mov byte[count],0
    pusha

extract_no:
    cmp word[num], 0
    je ansmsg
    inc byte[count]
    mov dx, 0
    mov ax, word[num]
    mov bx, 10
    div bx
    push dx
    mov word[num], ax
    jmp extract_no
ansmsg:
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,l4
    int 80h
    jmp print_no

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
    mov ecx,newline
    mov edx,1
    int 80h
    popa
    ret

read_num:
    ;push all the used registers into the stack using pusha
    pusha
    ;store an initial value 0 to variable ’num’
    mov word[num], 0
loop_read:
    ; read a digit
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
    jmp loop_read
end_read:
    popa
    ret
section .bss
num : resw 10
count : resw 10
temp : resb 1
num1 : resw 10
num2 : resw 10
num3 : resw 10
max : resw 10

section .data
msg1: db "Enter first number",10
l1: equ $-msg1
msg2: db "Enter second number",10
l2: equ $-msg2
msg3: db "Enter third number",10
l3: equ $-msg3
msg4: db "The greatest amoung three is:"
l4: equ $-msg4
newline: db 10 
section .text

global _start:
_start:

mov eax , 4
mov ebx , 1
mov ecx , msg1
mov edx , l1
int 80h

call read_num
mov cx,word[num]
mov word[num1],cx
mov eax , 4
mov ebx , 1
mov ecx , msg2
mov edx , l2
int 80h
call read_num
mov cx,word[num]
mov word[num2],cx
mov eax , 4
mov ebx , 1
mov ecx , msg3
mov edx , l3
int 80h
call read_num
mov cx,word[num]
mov word[num3],cx

; Compare and store the maximum number
mov eax, [num1]
mov [max], eax
cmp eax, [num2]
jg greater_2
mov eax, [num2]
mov [max], eax

greater_2:
cmp eax, [num3]
jg greater_3
mov eax, [num3]
mov [max], eax

greater_3:

; Print the maximum number
mov [num],eax
call print_num

; Exit program
mov eax, 1
xor ebx, ebx
int 0x80
