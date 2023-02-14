print_num:
mov byte[count],0
pusha
extract_no:
cmp word[num], 0 ;if num==0 
je endmsg        ;call endmsg
inc byte[count]  ;count++
mov dx, 0        ;dx=0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
endmsg:
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,l2
    int 80h
    jmp print_no
print_no:
cmp byte[count], 0
je end_print
dec byte[count]
pop dx
mov byte[temp], dl  ;dl=temp
add byte[temp], 30h ;temp= byte[temp]+48
mov eax, 4
mov ebx, 1
mov ecx, temp       ;print(temp)
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
msg1:db "Enter number",10
l1: equ $-msg1
msg2:db "The square is:"
l2: equ $-msg2
newline: db 10 
section .text

global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h
call read_num
mov cx,word[num]
mov word[num1],cx

mov ax, word[num1]
mov bx, word[num1]
mul bx
mov [num], ax
call print_num

; Exit program
mov eax, 1
xor ebx, ebx
int 0x80
