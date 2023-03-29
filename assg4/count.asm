section .bss
curr : resw 1
temp : resw 1
sign : resb 1
count : resb 1
n  : resd 1 
m : resd 1 
size : resd 1
arr : resw 100
str : resb 100
substr : resb 100
i : resw 1
j : resw 1
freq : resw 1
len : resd 1
strlen : resd 1
substrlen : resd 1





section .data
m1 : db "Enter the sentence: "
s1 : equ $-m1
m2 : db "Enter the word to search for: "
s2 : equ $-m2
m3 : db "Number of times the word is present in the sentence is "
s3 : equ $-m3
m4 : db "Enter the value of n2: "
s4 : equ $-m4
err : db "err check"
err_size : equ $-err



section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, m1
mov edx, s1
int 80h
mov ebx, str
mov eax, 0
call read_string
mov eax, dword[len]
mov dword[strlen], eax


mov eax, 4
mov ebx, 1
mov ecx, m2
mov edx, s2
int 80h
mov ebx, substr
mov eax, 0
call read_string
mov eax, dword[len]
mov dword[substrlen], eax



mov eax, str
mov ebx, substr
mov esi, 0
mov word[freq], 0

outer_loop:
cmp esi, dword[strlen]
jge outer_loop_end
mov edi, esi
mov dword[len], 0
in_loop:
mov ecx, dword[len]
cmp ecx, dword[substrlen]
jge in_loop_end
mov cl, byte[eax + edi]
mov edx, dword[len]
mov ch, byte[ebx + edx]
cmp cl, ch
jne in_loop_end
inc dword[len]
inc edi
jmp in_loop

in_loop_end:
mov ecx, dword[len]
cmp ecx, dword[substrlen]
je inc_freq
jmp next_iter
inc_freq:
inc word[freq]

next_iter:
inc esi
jmp outer_loop

outer_loop_end:

mov eax, 4
mov ebx, 1
mov ecx, m3
mov edx, s3
int 80h
mov cx, word[freq]
mov word[curr], cx
call print_num
call newline
jmp exit

















print_string:

print_string_loop:
cmp eax, dword[len]
jge print_string_end
mov cl, byte[ebx + eax]
mov byte[temp], cl
pusha
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa
inc eax
jmp print_string_loop

print_string_end:
ret



read_string:


read_string_loop:
pusha
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
popa
cmp byte[temp], 0Ah
je read_string_end
mov cl, byte[temp]
mov byte[ebx + eax], cl
inc eax
jmp read_string_loop

read_string_end:
mov dword[len], eax
ret





print_array:
pusha


print_array_loop:
cmp eax, dword[size]
jge print_array_end
mov cx, word[ebx + 2 * eax]
mov word[curr], cx
pusha
call print_num
call space
popa
inc eax
jmp print_array_loop


print_array_end:
popa 
ret

read_array:
pusha

read_array_loop:
cmp eax, dword[size]
jge read_array_ret
pusha
call read_num
popa
mov cx, word[curr]
mov word[ebx + 2 * eax], cx 
inc eax
jmp read_array_loop


read_array_ret:
popa
ret



read_num:
pusha
mov word[curr], 0
mov byte[sign], 0
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], '-'
je read_is_negative
mov ax, word[curr]
mov bx, 10
mul bx
mov byte[temp + 1], 0
sub byte[temp], 30h
add ax, word[temp]
mov word[curr], ax
jmp read_loop

read_is_negative:
mov byte[sign], 1


read_loop:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 0Ah
je read_end
cmp byte[temp], 20h
je read_end
mov ax, word[curr]
mov bx, 10
mul bx
mov byte[temp + 1], 0
sub byte[temp], 30h
add ax, word[temp]
mov word[curr], ax
jmp read_loop

read_end:
popa
cmp byte[sign], 1
je read_negate
ret

read_negate:
neg word[curr]
ret

print_num:
pusha
mov byte[count], 0
mov byte[sign], 0
cmp word[curr], 0
je print_is_zero
jl print_is_negative
jmp print_count

print_is_zero:
mov dx, 0
push dx
inc byte[count]
jmp print_loop

print_is_negative:
mov byte[temp], '-'
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
neg word[curr]

print_count:
cmp word[curr], 0
je print_loop
inc byte[count]
mov ax, word[curr]
mov dx, 0
mov bx, 10
div bx
push dx
mov word[curr], ax
jmp print_count

print_loop:
cmp  byte[count], 0
je print_end
dec byte[count]
pop dx
mov byte[temp], dl
add byte[temp], 30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_loop

print_end:
popa
ret

newline:
pusha
mov byte[temp], 0Ah
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa
ret

exit:
mov eax, 1
mov ebx, 0
int 80h


space: 
pusha
mov byte[temp], 20h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
popa
ret