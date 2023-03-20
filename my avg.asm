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
    mov bh,0
    add ax,bx
    mov word[num],ax
    jmp loop_read
    end_read:
    popa
    ret
print_num:
mov byte[count],0
pusha
extract_no:
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

print_no:
    cmp byte[count],0
    je end_print
    dec byte[count]
    pop dx
    mov byte[temp],dl
    add byte[temp],'0'
    mov eax,4
    mov ebx,1
    mov ecx,temp
    mov edx,1
    int 80h
    jmp print_no
    end_print:
    mov eax,4
    mov ebx,1
    mov ecx,10
    mov edx,1
    int 80h
    popa 
    ret

section .data
msg1: db "Enter n:", 10
l1: equ $-msg1

msg2: db "average is: "
l2: equ $-msg2

msg3:db"enter a number and n is ",10
l3:equ $-msg3

section .bss
n:resw 1
n1:resw 1
temp:resb 1
count :resb 1
sum:resw 1
num :resw 1
avg :resw 1
count :resw 1


section .txt
    global _start
        _start:
        mov eax,4
        mov ebx,1
        mov ecx,msg1
        mov edx,l1
        int 80h
        call read_num
        
      mov ax,word[num]
      mov word[count],ax
      mov word[n],0
      mov word[n1],ax
      mov word[sum],0
      sub word[sum],'0'
      pusha

      loop1:
      inc word[n]
      mov bx,word[n]
      cmp bx,word[count]
      je print_avg
      
      mov eax,4
      mov ebx,1
      mov ecx,msg3
      mov edx,l3
      int 80h
      mov eax,4
      mov ebx,1
      mov ecx,n
      mov edx,1
      int 80h
      
      
      call read_num
      mov ax,word[num]
      add word[sum],ax
      sub word[sum],'0'
      jmp loop1

      

      print_avg:
      mov ax,word[sum]
      mov bx,word[n1]
      div bx

      mov word[num],ax
      mov eax,4
      mov ebx,1
      mov ecx,msg2
      mov edx,l2
      int 80h

      mov word[num],ax
      call print_num
      mov eax,1
      mov ebx,0
      int 80h
      



