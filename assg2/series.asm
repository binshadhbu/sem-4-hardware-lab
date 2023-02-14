		arithmatic:
		mov eax,4
		mov ebx,1
		mov ecx,ap
		mov edx,s1
		int 80h
		
		mov eax,1
		mov ebx,0
		int 80h
		
		geometric:
		mov eax,4
		mov ebx,1
		mov ecx,gp
		mov edx,s2
		int 80h
		
		mov eax,1
		mov ebx,0
		int 80h
		
		neither:
		mov eax,4
		mov ebx,1
		mov ecx,nei
		mov edx,s3
		int 80h
		
		mov eax,1
		mov ebx,0
		int 80h
		
		
		
		
print_num:
mov byte[count],0
pusha
extract_no:
cmp word[num], 0 ;if num==0 
je endmsg        ;call endmsg
inc byte[count]  ;count++
mov dx, 0        ;dx=0
mov ax, word[num]
mov bx, 10
div bx
push dx
mov word[num], ax
jmp extract_no
endmsg:
    
    jmp print_no
print_no:
cmp byte[count], 0
je end_print
dec byte[count]
pop dx
mov byte[temp], dl  ;dl=temp
add byte[temp], 30h ;temp= byte[temp]+48
mov eax, 4
mov ebx, 1
mov ecx, temp       ;print(temp)
mov edx, 1
int 80h
jmp print_no
end_print:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret

read_num:
    ;push all the used registers into the stack using pusha
    pusha
    ;store an initial value 0 to variable ’num’
    mov word[num], 0
loop_read:
    ; read a digit
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
    
    
    
    ;beginning of code
    
    section .data
    msg:db "enter number ",10
    s:equ $-msg
    ap:db "its an AP" ,10
    s1:equ $-ap
    gp :db "its a gp" ,10
    s2: equ $-gp
    nei:db "neither ap or gp",10
    s3:equ $-nei
    newline: db 10 
    
    section .bss
    	num : resw 10
	count : resw 10
	temp : resb 1
	val1: resw 1
	val2: resw 1
	val3: resw 1
	val4: resw 1
	val5: resw 1
	cm1:resw 1
	cm2:resw 1
	cm3:resw 1
	cm4:resw 1
	cd1:resw 1
	cd2:resw 1
	cd3:resw 1
	cd4:resw 1
	
	section .txt
		global _start
		_start:
		mov eax,4
		mov ebx,1
		mov ecx,msg
		mov edx,s
		int 80h
		
		call read_num    ;var1
		mov cx,[num]
		mov [val1],cx
		
		
		mov eax,4
		mov ebx,1
		mov ecx,msg
		mov edx,s
		int 80h
		
		call read_num
		mov cx,[num]   ;var2
		mov [val2],cx
		
		mov eax,4
		mov ebx,1
		mov ecx,msg
		mov edx,s
		int 80h
		
		call read_num
		mov cx,[num]    ;var3
		mov [val3],cx
		
		mov eax,4
		mov ebx,1    ;var4
		mov ecx,msg
		mov edx,s
		int 80h
		
		call read_num
		mov cx,[num]
		mov [val4],cx
		
		mov eax,4
		mov ebx,1    ;var
		mov ecx,msg
		mov edx,s
		int 80h
		
		
		call read_num
		mov cx,[num]
		mov [val5],cx	
		
		
		mov dx,0
		mov ax,word[val2]   ;cm1
		mov bx,word[val1]
		div bx
		mov word[cm1],bx
		
		mov dx,0
		mov ax,word[val3]   ;cm2
		mov bx,word[val2]
		div bx
		mov word[cm2],bx
		
		mov dx,0
		mov ax,word[val4]   ;cm3
		mov bx,word[val3]
		div bx
		mov word[cm3],bx
		
		
		mov dx,0
		mov ax,word[val5]   ;cm4
		mov bx,word[val4]
		div bx
		mov word[cm4],bx
		
		
		mov ax,word[val1]
		mov bx,word[val2]
		sub bx,ax
		mov word[cd1],bx
		
		mov ax,word[val2]
		mov bx,word[val3]
		sub bx,ax
		mov word[cd2],bx
		
		mov ax,word[val3]
		mov bx,word[val4]
		sub bx,ax
		mov word[cd3],bx		
		
		mov ax,word[val4]
		mov bx,word[val5]
		sub bx,ax
		mov word[cd4],bx
		
		jmp check_ap
		
		check_gp:
		;check for gp
		mov ax,0
		mov bx,0
		
		mov dx,0
		mov ax,[cm1]
		mov bx,[cm2]
		div bx
		cmp bx,1
		jne neither
		
		mov ax,0
		mov bx,0
		
		mov dx,0	
		mov ax,[cm2]
		mov bx,[cm3]
		div bx
		cmp bx,1
		jne neither
		mov ax,0
		mov bx,0
		
		mov dx,0
		mov ax,[cm3]
		mov bx,[cm4]
		div bx
		cmp bx,1
		jne neither
		
		jmp geometric
			
		;jump to geometric
		
		 
		check_ap:
		
		;check for ap
		mov ax,word[cd1]
		mov bx,word[cd2]
		cmp ax,bx
		jne check_gp
		
		mov ax,word[cd2]
		mov bx,word[cd3]
		cmp ax,bx
		jne check_gp
		
		mov ax,word[cd3]
		mov bx,word[cd4]
		cmp ax,bx
		jne check_gp
	
		jmp arithmatic
		
		
		
		
		
			
		
    
    
    
    
    
    
    
    
    
