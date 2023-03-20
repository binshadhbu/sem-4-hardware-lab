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
    mul bx
    mov bl,byte[temp]
    sub bl,'0'

    mov bh,0
    mov ax,bx
    mov word[num],ax
    jmp loop_read
    end_read:
    popa
    ret

    print_num:
    mov word[count],0
    pusha
    extract_no:
    cmp word[num],0
    je print_no
    inc word[count]
    mov dx,0
    mov ax,word[num]
    mov bx,10
    div bx
    push dx
    mov word[num],ax
    jmp extract_no


    print_no:
    cmp word[count],0
    je end_print
    dec word[count]
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
        