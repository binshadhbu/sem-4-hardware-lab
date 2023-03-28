section .data
tab: db 9
newline: db 10
msg1: db 'Enter number of rows:'
l1: equ $-msg1
msg2: db 'Enter number of columns:'
l2: equ $-msg2
msg3: db 'Enter each element:'
l3: equ $-msg3
msg4: db 'Transpose of the matrix',10
l4: equ $-msg4

section .bss
num: resw 1
n: resw 1
m: resw 1
c: resw 1
r: resw 1
i: resw 1
j: resw 1
matrix1: resw 200
matrix2: resw 200
temp: resw 1
count: resw 1
prod: resw 1

section .text
global _start:
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,l1
    int 80h
    call read_num
    mov ax,word[num]
    mov word[n],ax
    
    
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,l2
    int 80h
    call read_num
    mov ax,word[num]
    mov word[m],ax

    mov ebx,matrix1
    mov eax,0
    call read_matrix
    
    mov ebx,matrix1
    mov eax,0
    call print_matrix
    
    mov esi,matrix1
    mov edi,matrix2
    mov ecx,0
    mov edx,0
    call transpose
    call print_msg4
    
    mov ax,word[m]
    mov bx,word[n]
    mov word[m],bx
    mov word[n],ax
    mov ebx,matrix2
    mov eax,0
    call print_matrix
    
    end:
    mov eax,1
    mov ebx,0
    int 80h
    
transpose:
 	pusha
 	mov word[i],0
 	mov word[j],0
 	
 	loop1:
 		mov word[j],0
 		loop2:
	 		mov ax,word[esi+2*ecx]
	 		mov word[edi+2*edx],ax
	 		inc word[j]
	 		inc edx
	 		add cx,word[m]
	 		mov ax,word[n]
	 		cmp ax,word[j]
	 		ja loop2
	 	inc word[i]
	 	inc esi
	 	inc esi
	 	mov ax,word[i]
	 	cmp ax,word[m]
	 	mov ecx,0
	 	jb loop1
	 	
	end_loop1:			
 	popa
 	ret
    
print_msg4:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,l4
	int 80h
	popa
	ret
read_matrix:
	pusha
	mov word[i], 0
	mov word[j], 0
	i_loop:
		mov word[j], 0
	j_loop:
		call print_msg
		call read_num
		mov dx , word[num]
		mov word[ebx+2*eax], dx
		inc eax 
		inc word[j]
		mov cx, word[j]
		cmp cx, word[m]
		jb j_loop
	inc word[i]
	mov cx, word[i]
	cmp cx, word[n]
	jb i_loop
	end_mread:
		popa
		ret    


print_matrix:
	pusha
	mov word[i], 0
	mov word[j], 0
	ip_loop:
		mov word[j], 0
	jp_loop:
		mov dx,word[ebx+2*eax]
		mov word[num],dx
		call print_num
		call print_tab
		inc eax 
		inc word[j]
		mov cx, word[j]
		cmp cx, word[m]
		jb jp_loop
	call print_newline
	inc word[i]
	mov cx, word[i]
	cmp cx, word[n]
	jb ip_loop
	end_mprint:
		popa
		ret    


print_msg:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,l3
	int 80h
	popa
	ret
	
print_tab:
	pusha
	mov eax,4
	mov ebx,1
	mov ecx,tab
	mov edx,1
	int 80h
	popa
	ret
	
print_newline:
	pusha	
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
	ret
	
read_num:
	pusha 
	mov word[num],0
	reading:
		mov eax,3
		mov ebx,0
		mov ecx,temp
		mov edx,1
		int 80h
		cmp word[temp],10
		je end_read
		mov ax,word[num]
		mov bx,10
		mul bx
		mov bx,word[temp]
		sub bx,30h
		add ax,bx
		mov word[num],ax
		jmp reading
	
	end_read:
		popa
		ret

print_num:
	pusha
	mov word[count],0
	
	extracting:
		mov ax,word[num]
		cmp ax,0
		je printing
		mov bx,10
		mov dx,0
		div bx
		push dx
		mov word[num],ax
		inc word[count]
		jmp extracting
	printing:
		cmp word[count],0
		je end_printing
		pop dx
		dec word[count]
		mov word[temp],dx
		add word[temp],30h
		mov eax,4
		mov ebx,1
		mov ecx,temp
		mov edx,1
		int 80h
		jmp printing
	end_printing:
		popa
		ret