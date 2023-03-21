; read_array:
; pusha
; reading:
; push ebx
; mov eax,3
; mov ebx,0
; mov ecx,temp
; mov edx,1
; int 80h
; pop ebx
; cmp byte[temp], 10
; ;; check if the input is ’Enter’
; je end_reading
; inc byte[string_len]
; mov al,byte[temp]
; mov byte[ebx], al
; inc ebx
; jmp reading
; end_reading:
; ;; Similar to putting a null character at the end of a string
; mov byte[ebx], 0
; mov ebx, string
; popa
; ret

; print_array:
; pusha
; mov ebx, string
; printing:
; mov al, byte[ebx]
; mov temp, al
; cmp byte[temp], 10
; je end_printing
; ;; checks if the character is NULL character
; push ebx
; mov eax, 4
; mov ebx, 1
; mov ecx, temp
; mov edx, 1
; int 80h
; pop ebx
; inc ebx
; jmp printing
; end_printing:
; popa
; ret
section .data
string_len: db 0
msg1: db "Enter a string : "
section .bss
string: resb 50
temp:resb 1

section .data

global _start:
_start:
mov ebx,string
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
mov ebx,string

print_array:
pusha
mov ebx, string
printing:
mov al, byte[ebx]
mov byte[temp],al
cmp byte[temp], 10
je end_printing
;; checks if the character is NULL character
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
mov eax, 1
xor ebx, ebx
int 0x80
