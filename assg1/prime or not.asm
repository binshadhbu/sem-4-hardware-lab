section .data
msg: db 'is a prime number'
len: equ $-msg

msg1: db ' is not a prime number'
len1: equ $-msg1

section .bss
    digit1: resw 1
    digit2: resw 1
    num : resw 10

section .text
    global _start:
    _start:

    mov eax,3
    mov ebx,1
    mov ecx,digit1
    mov edx,1
    int 80h

    sub word[digit1],30h

    mov eax,3
    mov ebx,1
    mov ecx,digit2
    mov edx,1
    int 80h

    sub word[digit2],30h

    mov ax,word[digit1]
    mov bx,10
    mul bx
    add ax,word[digit2]
    mov word[num],ax

    cmp word[num],11
    je print

    cmp word[num],13
    je print

    cmp word[num],17
    je print

    cmp word[num],19
    je print

    cmp word[num],23
    je print

    cmp word[num],29
    je print

    cmp word[num],31
    je print

    cmp word[num],37
    je print

    cmp word[num],41
    je print

    cmp word[num],43
    je print

    cmp word[num],47
    je print

    cmp word[num],53
    je print

    cmp word[num],59
    je print

    cmp word[num],61
    je print

    cmp word[num],67
    je print

    cmp word[num],71
    je print

    cmp word[num],73
    je print

    cmp word[num],79
    je print

    cmp word[num],83
    je print

    cmp word[num],89
    je print

    cmp word[num],97
    je print

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80h
    jmp exit

print:
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,len
    int 80h
    
exit: 
    mov eax,1
    mov ebx,0
    int 80h




