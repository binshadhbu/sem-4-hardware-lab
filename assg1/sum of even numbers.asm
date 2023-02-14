section .data
add1: db 'enter number',0Ah
val1: equ $-add1
newline:db 0ah
newval:equ $-newline
section .bss
temp: resb 1
num:resw 1
count:resw 1
sum:resw 1

section .text
global _start
_start:
read_num:
mov word[num], 0

mov eax, 4
mov ebx, 1
mov ecx, add1
mov edx, val1
int 80h

loop_read:

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

mov word[count],0
mov word[sum],0
mov ax,word[sum]
mov bx,word[count]
for:


add bx,2
cmp bx,word[num]
ja print_num
add ax,bx
jmp for


print_num:

mov word[sum],ax
mov word[count],0
pusha
extract_no:
cmp word[sum], 0
je print_no
inc word[count]
mov dx, 0
mov ax, word[sum]
mov bx, 10
div bx
push dx
mov word[sum], ax
jmp extract_no
print_no:
cmp word[count], 0
je end_print
dec word[count]
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

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, newval
int 80h

mov eax, 1
mov ebx, 0
int 80h