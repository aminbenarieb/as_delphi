; составить подпрограмму с именем a_b типа
;   procedure (var a: longword; const b:longword; l:longword)
; выполняющую вычитание битовых строк a:=a \ b длины l. 
.386
.model flat,pascal
public a_b

.code
a_b proc
; turbopascal agreement 
	push ebp
	mov ebp,esp
	sub esp,100
	push ds
	push ss	

	mov esi,[ebp+16] ; put address a in esi
	mov ebx,[ebp+12] ; put address b in ebx
	mov	ecx,[ebp+8]	 ; put address length l in ecx
	
	mov	edx,0		 ; initial cycle counter
	
	cc:	

		; getting bit from b
		bt [ebx],edx ; checking bit with number edx [0..31] in word with adress ebx
		jnc f0		 ; if bit == 0, goto f0
	f1:	mov al,1	 ; else put 1 to al (bit from b string)
		jmp sec
	f0:	mov al,0	 ; put 0 to al (bit from b string)
	
	sec:; getting bit from a
		bt [esi],edx ; checking bit with number edx [0..31] in word with adress eax
		jnc s0		 ; if bit == 0, goto s0
	s1:	mov ah,1	 ; else put 1 to al (bit from a string)
		jmp chk
	s0:	mov ah,0	 ; put 0 to al (bit from a string)
	
		
		chk:
			;b ;a
		xor al,ah ; b = b xor a
			;b ;a
		and al,ah ; b = b and a = (b xor a) and a = a - b
	
			;b = a-b
		cmp al,0
		je	zer			; if result == 0, goto zer
	
	one:bts [esi],edx	; zanosim 1 v bit nomer edx stroki esi (menaym a)
		jmp nxt
	
	zer:btr [esi],edx	; zanosim 0 v bit nomer edx stroki esi (menaym a)


	nxt:
		inc edx		 ; increment cycle counter
		cmp edx,32	 ; check end of cycle
		jne neq		 ; if no next iteration
		
		mov	edx,0	 ; if yes reseting cycle counter
		add ebx,4	 ; offset ebx to get next word (4 bytes)
		add esi,4	 ; offset esi to get next word (4 bytes)
	neq:
	loop cc			 ; chikl po cx l raz
	
; turbopascal agreement 
	pop ss
	pop ds
		
	mov esp,ebp
	pop ebp
  ret 12
end 
