section .bss
string: resb 200
n1:resd 1
n2:resd 1
temp: resb 1
dup:resd 1
temp1: resb 1
symbol: resb 1
mycount: resw 1
num: resw 1
count: resb 1
string_len: resd 1
string_len1: resd 1
timess:resw 1
section .data
newline : db 10
msg1: db "Enter string of size n : ",10
size1: equ $-msg1
msg2: db "Enter the n1 and n2(indices) : ",10
size2: equ $-msg2
msg3: db "substring is : ",10
size3: equ $-msg3


section .text
global _start
_start:
mov dword[string_len],0
mov dword[string_len1],0
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, size1
int 80h

mov ebx, string
call read_array



mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, size2
int 80h

call read_num
mov ax,word[num]
mov word[n1],ax

call read_num
mov ax,word[num]
mov word[n2],ax

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, size3
int 80h

mov ebx,string
add ebx,dword[n1]

loop:
cmp byte[ebx],10
je endit
mov eax,dword[n1]
cmp dword[n2],eax
je endit
mov cl,byte[ebx]
mov byte[temp],cl
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc dword[n1]
inc ebx
jmp loop



endit:

jmp exit

read_array:
pusha
reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

pop ebx
cmp byte[temp], 10
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading

end_reading:
mov byte[ebx], 10
;mov ebx, string
popa
ret

print_array:
pusha
mov ebx, string

printing:
mov al, byte[ebx]
mov byte[temp], al
cmp byte[temp],10 
je end_printing
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing

end_printing:
popa
ret

print_num :
   mov byte[count],0
   pusha
extract_no :
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
print_no :
   
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
end_print :
   
    int 80h
    popa
    ret
exit:
mov eax,1
mov ebx,0
int 80h

zeroo:
    pusha
    mov byte[temp],0
    add byte[temp],30h
    mov eax,4
    mov ebx,1
    mov ecx,temp
    mov edx,1
    int 80h

    popa
    ret
    
    read_num :
    pusha
    mov word[num],0
loop_read :
    mov eax, 3
    mov ebx ,0
    mov ecx, temp
    mov edx, 1
    int 80h
    cmp byte[temp],10
    je end_read
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num],ax
    jmp loop_read
end_read :
    popa
    ret