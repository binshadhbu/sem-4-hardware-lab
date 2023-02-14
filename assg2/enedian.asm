section .data

big: db 'big endian',0Ah
sz1: equ $-big
small: db 'little endian',0Ah
sz2: equ $-small

section .txt
global _start
_start:
mov ax,255
cmp ah,0
je little

mov eax,4
mov ebx,1
mov ecx,big
mov edx,sz1
int 80h

mov eax,1
mov ebx,0
int 80h

little:
mov eax,4
mov ebx,1
mov ecx,small
mov edx,sz2
int 80h

mov eax,1
mov ebx,0
int 80h
