;Write a program to read a mxn matrix with 2 digit numbers and do the following: Start from the top right corner, read the elements of the matrix row wise and store the alternate elements in an array. Compute the sum of the elements in this array and print the result
;Example: 11 22 33 44 55 66 77 88 99 - array elements are - 33 11 55 99 77 and sum is 275

section .bss
num: resw 1 ;For storing a number, to be read of printed....
nod: resb 1 ;For storing the number of digits....
temp: resb 2
matrix: resw 200
arr: resw 100
m: resw 1
n: resw 1
i: resw 1
j: resw 1
index: resd 1
count: resd 1
sum: resw 1

section .data
msg1: db "Enter the number of rows in the matrix: "
msg_size1: equ $-msg1
msg2: db "Enter the number of columns in the matrix: "
msg_size2: equ $-msg2
msg3: db "Enter the elements one by one(row by row) : "
msg_size3: equ $-msg3
msg4: db "Elements of the array are: "
msg_size4: equ $-msg4
msg5: db "Required Sum: ", 0xa
msg_size5: equ $-msg5
test: db "Test", 0xa
lenT: equ $ - test
tab: db 9 ;ASCII for vertical tab
new_line: db 10 ;ASCII for new line
space: db 20h

section .text
global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, msg_size1
	int 80h
	
	;mov ecx, 0
	;calling sub function read num to read a number
	call read_num
	mov cx, word[num]
	mov word[m], cx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, msg_size2
	int 80h
	
	;mov ecx, 0
	call read_num
	mov cx, word[num]
	mov word[n], cx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, msg_size3
	int 80h
	
	;Reading each element of the matrix1........
	mov eax, 0
	mov ebx, matrix
	mov word[i], 0
	mov word[j], 0
	
	i1_loop1:
		mov word[j], 0
		
		j1_loop1:
			call read_num
			mov dx , word[num]
			;eax will contain the array index and each element is 2 bytes(1 word) long
			mov word[ebx + 2 * eax], dx
			inc eax ;Incrementing array index by one....
			inc word[j]
			mov cx, word[j]
			cmp cx, word[n]
			jb j1_loop1
	
		inc word[i]
		mov cx, word[i]
		cmp cx, word[m]
		jb i1_loop1
		
	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, msg_size4
	int 0x80
	
	;Transposing........
	mov dword[index], 0
	mov word[i], 0
	mov ax, word[n]
	mov word[j], ax
	sub word[j], 1
	mov word[count], 0
	
	i3_loop0:
		
		j3_loop0:

			inc dword[count]
			movzx eax, word[i]
			movzx ebx, word[n]
			mul ebx
			movzx ecx, word[j]
			add eax, ecx
			
			mov ebx, matrix
			mov cx, word[ebx+2*eax]
			
			mov eax, dword[index]
			mov ebx, arr
			mov word[ebx+2*eax], cx
			inc dword[index]
			
			cmp word[j], 1
			je evenRow
			cmp word[j], 0
			je oddRow 
			
			sub word[j], 2
			jmp j3_loop0
	
		
		evenRow:
			mov ax, word[n]
			mov word[j], ax
			sub word[j], 1
			jmp toNext
			
		oddRow:
			mov ax, word[n]
			mov word[j], ax
			sub word[j], 2
			jmp toNext
		
		toNext:
		inc word[i]
		mov cx, word[i]
		cmp cx, word[m]
		jb i3_loop0
	
	mov word[sum], 0
	mov ebx, arr
	mov eax, 0
	
	PAloop:
		mov cx, word[ebx+2*eax]
		mov word[num], cx
		add word[sum], cx
		
		call print_num
		inc eax
		cmp eax, dword[count]
		je endPAloop
		jmp PAloop
	
	endPAloop:
		mov eax, 4
		mov ebx, 1
		mov ecx, new_line
		mov edx, 1
		int 0x80
		
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, msg_size5
	int 0x80
	
	mov cx, word[sum]
	mov word[num], cx
	call print_num
	
	mov eax, 4
	mov ebx, 1
	mov ecx, new_line
	mov edx, 1
	int 0x80
		
	mov eax, 1
	int 0x80
		
	
	
;Exit System Call.....
exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
;Function to read a number from console and to store that in num
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
		cmp byte[temp], 20h
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
		inc byte[nod]
		mov dx, 0
		mov ax, word[num]
		mov bx, 10
		div bx
		push dx
		mov word[num], ax
		cmp word[num], 0
		je print_no
		jmp extract_no

	print_no:
		cmp byte[nod], 0
		je end_print
		dec byte[nod]
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
		mov ecx, space
		mov edx, 1
		int 0x80
		popa
	ret
