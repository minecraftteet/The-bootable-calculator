;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;               the is a os deved for a chairdy stream
;
;       at 17:57:26 
;         on 2023-12-02
;
;
;
;
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 16]

section .data
  result dw 0
  buffer db 10 BUP(0)
  operator db 0

section .text
  org 0x7c00
  
  mov ax, 0x7c0
  add ax, 288
  mov ss, ax
  mov sp, 4096

  mov ax, 0x07c0
  mov sp, ax
  

  ; Display promt
  mov ah, 0x09
  lea dx, [prompt]
  int 0x21
  
  ;read input
  lea dx, [buffer]
  mov ah, 0x0a
  int 0x21
  
  ;beep sound 
  mov ax, 0x0E07
  mov bh, 0
  mov bl, 7
  mov cx, 1
  int 0x10
  
  
  ;read  operator
  lea dx, [operator]
  mov ah, 0x0a
  int 0x21
  
  ;convert string to int 
  lea si, [buffer]
  call str2int
  mov bx, ax

  lea si, [operator]
  call str2int
  mov bx, ax

  ;preforimg ops
  mov ax, 0
  cmp byte [operator], "+"
  je add_nums
  cmp byte [operator], "-"
  je sub_nums
  cmp byte [operator], "*"
  je mul_nums
  cmp byte [operator], "/"
  je div_nums


add_nums:
  add bx,dx
  jmp done
sub_nums:
  sub bx,dx
  jmp done
mul_nums:
  imul bx, dx
  jmp done

div_nums:
  cmp dx, 0
  je div_by_zeo
  xor dx, dx
  div bx
  mov dx, ax
  jmp done




















