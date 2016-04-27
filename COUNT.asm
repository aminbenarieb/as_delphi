; составить подпрограмму с именем count типа
;      function (const s: longword; l:longword):integer;
; возвращающую число единиц битовой строки s длины l.
.386
.model flat,pascal
public count

.code
count:
	; turbopascal agreement 
	push ebp		; saving ebp
	mov ebp,esp		; setting start of part stack where are localed function params
	sub esp,100		; freeing space for local variables
	push ds
	push ss	

	xor eax,eax
	mov ebx,[ebp+12] ; put address s string in ebx
	mov	ecx,[ebp+8]	 ; put length of string in ecx
	
	mov	edx,0		 ; initial cycle counter
	
	cc:
		bt [ebx],edx ; check bit with number edx [0..31] in word with address ebx
		jnc no		 ; if bit is 0 goto no
		inc eax		 ; increment eax (eax shows count of 1 in string)
	no:	
		inc edx		 ; increment cycle counter
		cmp edx,32	 ; check end of cycle
		jne neq		 ; if no next iteration
		
		mov	edx,0	 ; if yes reseting cycle counter
		add ebx,4	 ; offset ebx to get next word (4 bytes)
	neq:
	loop cc			 ; cycle l times
	
	; turbopascal agreement 
	pop ss
	pop ds
		
	mov esp,ebp
	pop ebp
	ret 8
end