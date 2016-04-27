; составить подпрограмму с именем set1 типа
;   procedure (var a: longword; n:longword; p:longword)
; выполняющую установку разряда n битовой строки s
; в ноль, если p = 0, 
; в единицу, если p не равен 0.
.386
.model flat,pascal
public setcler 

.code
setcler proc
	push ebp
	mov ebp,esp
	sub esp,100
	push ds
	push ss	
	
	xor edx,edx		 ; reseting edx (faster than mov)
	mov eax,[ebp+12] ; put n value to eax
	mov	ecx,[ebp+8]	 ; put p value to ecx

	mov ebx, 32		; put 32 to ebx (word length)
	div ebx			; divide eax(n) on 32: eax gets integer (number of word 0 or 1), edx gets remainer (number of bit in word)

	push edx		; saving edx (could be chage in multiplication)
	
	mov ebx, 4		; setting offset
	mul ebx			; eax  * 4 = getting proper offset of start address to point on right word
	
	mov ebx,[ebp+16]; put p value to ebx
	
	add ebx, eax	; ebx = ebx + eax, shift ebx on right ord
	
	pop edx			; getting p from stack
	cmp ecx,0		; checking p
	jne	s1
	
	; if p == 0, set 0 to bit-number edx (remainer)
	s0: btr [ebx],edx
	jmp rt
	
	; if p != 0, set 1 to bit-number edx (remainer)
	s1: bts [ebx],edx
	
	rt:
	; turbopascal agreement 
	pop ss
	pop ds
		
	mov esp,ebp
	pop ebp
	ret 12
setcler endp
end