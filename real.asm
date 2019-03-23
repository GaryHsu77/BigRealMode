.MODEL small,c
.386p
.DATA

DESCRIPTOR STRUC
	lim_0_15		DW	? ;Limit [15:0]
	bas_0_15		DW	? ;Base [15:0]
	bas_16_23		DB	? ;Base [23:16]
	access			DB	? ;Access Right
	gran			DB	? ;G/D/B/0/AVL, Limit [19:16]
	bas_24_31		DB	? ;Base [31:24]
DESCRIPTOR ENDS

GDTTable LABEL BYTE
	NULLDESC	DESCRIPTOR <0, 0, 0, 0, 0, 0>
	LINEARDESC	DESCRIPTOR <0ffffh, 0000h, 00h, 93h, 8fh, 00h>
GDTSize	EQU  16


GDTR_STRUCT STRUC
	limit	DW	?
	base	DQ	?
GDTR_STRUCT ENDS

GDTR_PTR 	GDTR_STRUCT <GDTSize-1,0>

.CODE
BigReal_Mode PROC NEAR 
		
	xor	eax, eax
	mov	ax, ds
	shl	eax, 4
	add	eax, Offset NULLDESC
	mov	dword ptr ds:GDTR_PTR.GDTR_STRUCT.base, eax

	cli

	lgdt	fword ptr ds:GDTR_PTR
	mov	eax, CR0
	or	eax, 1
	mov	CR0, eax

	jmp	$+2

	mov	ax, 08h
	mov	es, ax
	mov	fs, ax
	mov	gs, ax
	mov	eax, CR0
	and	eax, NOT 1
	mov	CR0, eax

	jmp	$+2
	ret
BigReal_Mode  ENDP

END