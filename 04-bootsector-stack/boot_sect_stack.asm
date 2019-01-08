mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to bp

push 'A'
push 'B'
push 'C'

; however, don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe (look above)
mov bx, sp
mov al, bl
int 0x10 ;

mov al, '-'
int 0x10
mov al, '1'
int 0x10
mov al, [0x8000]
int 0x10
mov al, '2'
int 0x10
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10
mov al, '3'
int 0x10
mov al, [0x7ffc] ; 0x8000 - 4
int 0x10
mov al, '4'
int 0x10
mov al, [0x7ffa] ; 0x8000 - 4
int 0x10
mov al, '-'
int 0x10


; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxiliary register to manipulate
; the lower byte
pop bx
mov al, bl
int 0x10 ; prints C

mov bx, sp
mov al, bl
int 0x10 ;

mov al, '-'
int 0x10
mov al, '1'
int 0x10
mov al, [0x8000]
int 0x10
mov al, '2'
int 0x10
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10
mov al, '3'
int 0x10
mov al, [0x7ffc] ; 0x8000 - 4
int 0x10
mov al, '4'
int 0x10
mov al, [0x7ffa] ; 0x8000 - 4
int 0x10
mov al, '-'
int 0x10

pop bx
mov al, bl
int 0x10 ; prints B

mov bx, sp
mov al, bl
int 0x10 ;

mov al, '-'
int 0x10
mov al, '1'
int 0x10
mov al, [0x8000]
int 0x10
mov al, '2'
int 0x10
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10
mov al, '3'
int 0x10
mov al, [0x7ffc] ; 0x8000 - 4
int 0x10
mov al, '4'
int 0x10
mov al, [0x7ffa] ; 0x8000 - 4
int 0x10
mov al, '-'
int 0x10

pop bx
mov al, bl
int 0x10 ; prints A

mov bx, sp
mov al, bl
int 0x10 ;

mov al, '-'
int 0x10
mov al, '1'
int 0x10
mov al, [0x8000]
int 0x10
mov al, '2'
int 0x10
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10
mov al, '3'
int 0x10
mov al, [0x7ffc] ; 0x8000 - 4
int 0x10
mov al, '4'
int 0x10
mov al, [0x7ffa] ; 0x8000 - 4
int 0x10
mov al, '-'
int 0x10

; data that has been pop'd from the stack is garbage now
mov al, [0x8000]
int 0x10


jmp $
times 510-($-$$) db 0
dw 0xaa55
