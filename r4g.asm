;Input : memory address (32-bits)
.MODEL small,c
.386
.CODE

ReadMem_32 PROC NEAR

	push esi
	
	push 0h	;gs=0000 for access 4GB
	pop	gs

	mov	esi, [esp+4+2]
	mov eax, gs:[esi]
	
	pop	esi
	
	ret
ReadMem_32 ENDP


 END