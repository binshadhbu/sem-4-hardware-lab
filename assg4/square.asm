section .bss
num: resw 1 ;For storing a number, to be read of printed....
nod: resb 1 ;For storing the number of digits....
temp: resb 2
matrix1: resw 200
sum :resw 1
m: resw 1
n: resw 1
i: resw 1
j: resw 1
section .data
msg1: db "Enter the number of rows in the matrix : "
msg_size1: equ $-msg1
msg2: db "Enter the elements one by one(row by row) : "
msg_size2: equ $-msg2
msg3: db "Enter the number of columns in the matrix : "
msg_size3: equ $-msg3
msg4: db "the sum of square of diagonal is: "
msg_size4: equ $-msg4
tab: db 9 ;ASCII for vertical tab
new_line: db 10 ;ASCII for new line
section .text
global _start
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,msg_size1
int 80h

mov ecx, 0
call read_num
mov cx, word[num]
mov word[m], cx

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msg_size3
int 80h

mov ecx, 0
call read_num
mov cx, word[num]
mov word[n], cx
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,msg_size2
int 80h

mov eax, 0
mov ebx, matrix1

mov word[i], 0
mov word[j], 0
i_loop:
mov word[j], 0
j_loop:
call read_num
mov dx , word[num]

mov word[ebx + 2 * eax], dx
inc eax
;Incrementing array index by one....
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb j_loop
inc word[i]
mov cx, word[i]
cmp cx, word[m]
jb i_loop




mov word[sum],0
mov eax, 0
mov ebx, matrix1
mov word[i], 0
mov word[j], 0
i_loop2:
mov word[j], 0
j_loop2:
mov dx, word[ebx + 2 * eax]
mov word[num] , dx
call print_num
pusha
mov ax,word[i]
mov cx,word[j]
cmp ax,cx
je square_sum
popa
square_continue:
pusha
mov eax, 4
mov ebx, 1
mov ecx, tab
mov edx, 1
int 80h
popa
inc eax
inc word[j]
mov cx, word[j]
cmp cx, word[n]
jb j_loop2
pusha
mov eax,4
mov ebx,1
mov ecx,new_line
mov edx,1
int 80h
popa

inc word[i]
mov cx, word[i]
cmp cx, word[m]
jb i_loop2
;Exit System Call.....

pusha
mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, msg_size4
int 80h
popa
pusha
mov ax,word[sum]
mov word[num],ax
call print_num
popa
pusha
mov eax,4
mov ebx,1
mov ecx,new_line
mov edx,1
int 80h
popa

exit:
mov eax, 1
mov ebx, 0
int 80h
read_num:
pusha
mov word[num], 0
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
popa
ret
;Function to print any number stored in num...
print_num:
pusha
extract_no:
cmp word[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print_no
end_print:
popa
ret


square_sum:
pusha
mov ax,dx
mov bx,dx
mul bx
add word[sum],ax
popa
jmp square_continue