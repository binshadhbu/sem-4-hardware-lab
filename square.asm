section .data
;res: db "square is :" ,10A

section .bss
val:resw 1
sq :resw 1
temp :resw 1
section .txt 
global _start:
   _start:


mov word[val], 0
loop_read:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read1
mov ax, word[val]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[val], ax
jmp loop_read
end_read1:


   mov ax,[val]
   mov bx,[val]
   mul bx
   mov [sq],bx


   mov eax,4
   mov ebx,1
   mov ecx,sq
   mov edx,1
   int 80h

   mov eax,1
   mov ebx,0
   int 80h

