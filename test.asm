section .data
msg1:db "enter m" ,10
smsg1:equ $-msg1
msg2:db "enter n" ,10
smsg2:equ $-msg2
msg3:db "check" ,10
smsg3:equ $-msg3
new_line:db 10
tab:db 9
section .bss
m:resw 1
n:resw 1
i:resw 1
j:resw 1
matrix:resw 100
count:resb 1
temp :resb 1
num:resw 1
 
 section .text
 global _start:
 _start:
 mov eax,4
 mov ebx,1
 mov ecx,msg1
 mov edx,smsg1
 int 80h

 call read_num
 mov cx,word[num]
 mov word[m],cx
 
  mov eax,4
 mov ebx,1
 mov ecx,msg2
 mov edx,smsg2
 int 80h

call read_num
 mov cx,word[num]
 mov word[n],cx

mov eax,0
mov ebx,matrix
mov word[i],0
mov word[j],0

i_loop:
mov word[j],0
j_loop:
call read_num
mov cx,word[num]
mov word[ebx+2*eax],cx
inc word[j]
inc eax
mov cx,word[j]
cmp cx,word[n]
jb j_loop

inc word[i]
mov cx,word[i]
cmp cx,word[m]
jb i_loop

mov ebx,matrix
mov eax,0
mov word[i],0
mov word[j],0





exit:
mov eax,1
mov ebx,0
int 80h

read_num:
pusha
mov word[num],0
loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read
mov ax,word[num]
mov bx,10
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret

print_num:
pusha
extract_no:
cmp word[num],0
je print_no
inc byte[count]
mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_no
print_no:
cmp byte[count],0
je end_print
dec byte[count]
pop dx
mov byte[temp],dl
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

jmp print_no
end_print:
popa 
ret
