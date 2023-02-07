
section .bss
temp resb 1
val1:resw 1
val2:resw 1
val3: resw 1
max: resw 1
section .txt
global _start:
  _start:


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

mov eax,[val1]
mov [max],eax




mov word[val2], 0
loop_read1:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read1
mov ax, word[val2]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[val2], ax 
jmp loop_read1
end_read1:

mov eax,[val2]
mov ebx,[max]
cmp eax,ebx
ja update  ;check here 

continue:             ; continue
mov word[val3], 0
loop_read2:

mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read2
mov ax, word[val3]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[val3], ax 
jmp loop_read2
end_read2:

mov ebx,[val3]
cmp ebx,eax
ja update1
continue1:

mov eax,4
mov ebx,1
mov ecx,max
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

update :
    mov [max],eax
    jmp continue
update1:
mov [max],ebx
jmp continue1