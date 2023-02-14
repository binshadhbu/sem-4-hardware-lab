section .data
str1: db 'enter numer 1',0Ah
sz1: equ $-str1
str2: db 'enter number 2',0Ah
sz2: equ $-str2
yes: db 'yes,it's divisible',0Ah
sz3: equ $-yes
no:db 'no,it's not divisible',0Ah
sz4: equ $-no

section .bss
temp: resb 1

val1: resw 1
val2: resw 1
junk: resb 1

section .txt

global _start
_start:



mov eax, 4
mov ebx, 1
mov ecx, str1
mov edx,sz1
int 80h


mov word[val1], 0
loop_read:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read
mov ax, word[val1]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[val1], ax 
jmp loop_read 
end_read:


mov eax, 4
mov ebx, 1
mov ecx, str2
mov edx,sz2
int 80h

mov word[val2], 0

loop_read2:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read2
mov ax, word[val2]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[val2], ax 
jmp loop_read2
end_read2: 



mov dx, 0
mov ax,word[val1]
mov bx,word[val2]
div bx
cmp dx,0
je if
mov eax, 4
mov ebx, 1
mov ecx, no
mov edx,sz4
int 80h
jmp end
if:
mov eax, 4
mov ebx, 1
mov ecx, yes
mov edx,sz3
int 80h

end:
mov eax, 1
mov ebx, 0
int 80h