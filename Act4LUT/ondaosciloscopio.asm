.org 0x0000
rjmp start

configurar:
	ldi r20, 0xFF         ;
	out DDRD, r20
	clr r20 
	out PORTD, r20        ; 
	call LUT  ;
	ret

esperar_inicio:
	nop
	ret

start:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	call configurar
	call esperar_inicio
	rjmp main_loop        ; 
main_loop:
	ldi ZH, high(LUT)     ; 
	ldi ZL, low(LUT)      ;

output_loop:
	ld r16, Z+            ;
	out PORTD, r16        ;
	call delay            ;
	rjmp output_loop      ;

get_u:
	mov r20, r16
	andi r20, 0x0F
	mov r1, r20
	ret

set_7seg_u:
	mov r0, r1
	call get_7seg_code
	mov r17, r20
	out PORTD, r17
	ret

get_7seg_code:
	ldi r28, 0x00
	ldi r29, 0x01
	add r28, r0
	ld r20, Y
	ret

LUT:

	ldi r28, 0x00
	ldi r29, 0x01


	ldi r20, 0x80       ; Valor 0
    ST Y+, r20
    ldi r20, 0x83       ; Valor 1
    ST Y+, r20
    ldi r20, 0x86       ; Valor 2
    ST Y+, r20
    ldi r20, 0x89       ; Valor 3
    ST Y+, r20
    ldi r20, 0x8c       ; Valor 4
    ST Y+, r20
    ldi r20, 0x8f       ; Valor 5
    ST Y+, r20
    ldi r20, 0x92       ; Valor 6
    ST Y+, r20
    ldi r20, 0x95       ; Valor 7
    ST Y+, r20
    ldi r20, 0x98       ; Valor 8
    ST Y+, r20
    ldi r20, 0x9c       ; Valor 9
    ST Y+, r20
    ldi r20, 0x9f       ; Valor 10
    ST Y+, r20
    ldi r20, 0xa2       ; Valor 11
    ST Y+, r20
    ldi r20, 0xa5       ; Valor 12
    ST Y+, r20
    ldi r20, 0xa8       ; Valor 13
    ST Y+, r20
    ldi r20, 0xab       ; Valor 14
    ST Y+, r20
    ldi r20, 0xae       ; Valor 15
    ST Y+, r20
    ldi r20, 0xb0       ; Valor 16
    ST Y+, r20
    ldi r20, 0xb3       ; Valor 17
    ST Y+, r20
    ldi r20, 0xb6       ; Valor 18
    ST Y+, r20
    ldi r20, 0xb9       ; Valor 19
    ST Y+, r20
    ldi r20, 0xbc       ; Valor 20
    ST Y+, r20
    ldi r20, 0xbf       ; Valor 21
    ST Y+, r20
    ldi r20, 0xc1       ; Valor 22
    ST Y+, r20
    ldi r20, 0xc4       ; Valor 23
    ST Y+, r20
    ldi r20, 0xc7       ; Valor 24
    ST Y+, r20
    ldi r20, 0xc9       ; Valor 25
    ST Y+, r20
    ldi r20, 0xcc       ; Valor 26
    ST Y+, r20
    ldi r20, 0xce       ; Valor 27
    ST Y+, r20
    ldi r20, 0xd1       ; Valor 28
    ST Y+, r20
    ldi r20, 0xd3       ; Valor 29
    ST Y+, r20
    ldi r20, 0xd5       ; Valor 30
    ST Y+, r20
    ldi r20, 0xd8       ; Valor 31
    ST Y+, r20
    ldi r20, 0xda       ; Valor 32
    ST Y+, r20
    ldi r20, 0xdc       ; Valor 33
    ST Y+, r20
    ldi r20, 0xde       ; Valor 34
    ST Y+, r20
    ldi r20, 0xe0       ; Valor 35
    ST Y+, r20
    ldi r20, 0xe2       ; Valor 36
    ST Y+, r20
    ldi r20, 0xe4       ; Valor 37
    ST Y+, r20
    ldi r20, 0xe6       ; Valor 38
    ST Y+, r20
    ldi r20, 0xe8       ; Valor 39
    ST Y+, r20
    ldi r20, 0xea       ; Valor 40
    ST Y+, r20
    ldi r20, 0xec       ; Valor 41
    ST Y+, r20
    ldi r20, 0xed       ; Valor 42
    ST Y+, r20
    ldi r20, 0xef       ; Valor 43
    ST Y+, r20
    ldi r20, 0xf0       ; Valor 44
    ST Y+, r20
    ldi r20, 0xf2       ; Valor 45
    ST Y+, r20
    ldi r20, 0xf3       ; Valor 46
    ST Y+, r20
    ldi r20, 0xf5       ; Valor 47
    ST Y+, r20
    ldi r20, 0xf6       ; Valor 48
    ST Y+, r20
    ldi r20, 0xf7       ; Valor 49
    ST Y+, r20
    ldi r20, 0xf8       ; Valor 50
    ST Y+, r20
    ldi r20, 0xf9       ; Valor 51
    ST Y+, r20
    ldi r20, 0xfa       ; Valor 52
    ST Y+, r20
    ldi r20, 0xfb       ; Valor 53
    ST Y+, r20
    ldi r20, 0xfc       ; Valor 54
    ST Y+, r20
    ldi r20, 0xfc       ; Valor 55
    ST Y+, r20
    ldi r20, 0xfd       ; Valor 56
    ST Y+, r20
    ldi r20, 0xfe       ; Valor 57
    ST Y+, r20
    ldi r20, 0xfe       ; Valor 58
    ST Y+, r20
    ldi r20, 0xff       ; Valor 59
    ST Y+, r20
    ldi r20, 0xff       ; Valor 60
    ST Y+, r20
    ldi r20, 0xff       ; Valor 61
    ST Y+, r20
    ldi r20, 0xff       ; Valor 62
    ST Y+, r20
    ldi r20, 0xff       ; Valor 63
    ST Y+, r20
    ldi r20, 0xff       ; Valor 64
    ST Y+, r20
    ldi r20, 0xff       ; Valor 65
    ST Y+, r20
    ldi r20, 0xff       ; Valor 66
    ST Y+, r20
    ldi r20, 0xfe       ; Valor 67
    ST Y+, r20
    ldi r20, 0xfe       ; Valor 68
    ST Y+, r20
    ldi r20, 0xfd       ; Valor 69
    ST Y+, r20
    ldi r20, 0xfc       ; Valor 70
    ST Y+, r20
    ldi r20, 0xfc       ; Valor 71
    ST Y+, r20
    ldi r20, 0xfb       ; Valor 72
    ST Y+, r20
    ldi r20, 0xfa       ; Valor 73
    ST Y+, r20
    ldi r20, 0xf9       ; Valor 74
    ST Y+, r20
    ldi r20, 0xf8       ; Valor 75
    ST Y+, r20
    ldi r20, 0xf7       ; Valor 76
    ST Y+, r20
    ldi r20, 0xf6       ; Valor 77
    ST Y+, r20
    ldi r20, 0xf5       ; Valor 78
    ST Y+, r20
    ldi r20, 0xf3       ; Valor 79
    ST Y+, r20
    ldi r20, 0xf2       ; Valor 80
    ST Y+, r20
    ldi r20, 0xf0       ; Valor 81
    ST Y+, r20
    ldi r20, 0xef       ; Valor 82
    ST Y+, r20
    ldi r20, 0xed       ; Valor 83
    ST Y+, r20
    ldi r20, 0xec       ; Valor 84
    ST Y+, r20
    ldi r20, 0xea       ; Valor 85
    ST Y+, r20
    ldi r20, 0xe8       ; Valor 86
    ST Y+, r20
    ldi r20, 0xe6       ; Valor 87
    ST Y+, r20
    ldi r20, 0xe4       ; Valor 88
    ST Y+, r20
    ldi r20, 0xe2       ; Valor 89
    ST Y+, r20
    ldi r20, 0xe0       ; Valor 90
    ST Y+, r20
    ldi r20, 0xde       ; Valor 91
    ST Y+, r20
    ldi r20, 0xdc       ; Valor 92
    ST Y+, r20
    ldi r20, 0xda       ; Valor 93
    ST Y+, r20
    ldi r20, 0xd8       ; Valor 94
    ST Y+, r20
    ldi r20, 0xd5       ; Valor 95
    ST Y+, r20
    ldi r20, 0xd3       ; Valor 96
    ST Y+, r20
    ldi r20, 0xd1       ; Valor 97
    ST Y+, r20
    ldi r20, 0xce       ; Valor 98
    ST Y+, r20
    ldi r20, 0xcc       ; Valor 99
    ST Y+, r20
    ldi r20, 0xc9       ; Valor 100
    ST Y+, r20
    ldi r20, 0xc7       ; Valor 101
    ST Y+, r20
    ldi r20, 0xc4       ; Valor 102
    ST Y+, r20
    ldi r20, 0xc1       ; Valor 103
    ST Y+, r20
    ldi r20, 0xbf       ; Valor 104
    ST Y+, r20
    ldi r20, 0xbc       ; Valor 105
    ST Y+, r20
    ldi r20, 0xb9       ; Valor 106
    ST Y+, r20
    ldi r20, 0xb6       ; Valor 107
    ST Y+, r20
    ldi r20, 0xb3       ; Valor 108
    ST Y+, r20
    ldi r20, 0xb0       ; Valor 109
    ST Y+, r20
    ldi r20, 0xae       ; Valor 110
    ST Y+, r20
    ldi r20, 0xab       ; Valor 111
    ST Y+, r20
    ldi r20, 0xa8       ; Valor 112
    ST Y+, r20
    ldi r20, 0xa5       ; Valor 113
    ST Y+, r20
    ldi r20, 0xa2       ; Valor 114
    ST Y+, r20
    ldi r20, 0x9f       ; Valor 115
    ST Y+, r20
    ldi r20, 0x9c       ; Valor 116
    ST Y+, r20
    ldi r20, 0x98       ; Valor 117
    ST Y+, r20
    ldi r20, 0x95       ; Valor 118
    ST Y+, r20
    ldi r20, 0x92       ; Valor 119
    ST Y+, r20
    ldi r20, 0x8f       ; Valor 120
    ST Y+, r20
    ldi r20, 0x8c       ; Valor 121
    ST Y+, r20
    ldi r20, 0x89       ; Valor 122
    ST Y+, r20
    ldi r20, 0x86       ; Valor 123
    ST Y+, r20
    ldi r20, 0x83       ; Valor 124
    ST Y+, r20
    ldi r20, 0x80       ; Valor 125
    ST Y+, r20
	ldi r20, 0xb0     
    ST Y+, r20
    ldi r20,0xae       
    ST Y+, r20
    ldi r20, 0xab      
    ST Y+, r20
    ldi r20,  0xa8    
    ST Y+, r20
    ldi r20, 0xa5    
	ST Y+, r20
	ldi r20,   0xa5   
    ST Y+, r20
    ldi r20, 0xa2       
    ST Y+, r20
	ldi r20, 0x9f   
    ST Y+, r20
    ldi r20,  0x9c     ;     
    ST Y+, r20
    ldi r20, 0x98     
    ST Y+, r20
    ldi r20, 0x95  ;   
    ST Y+, r20
    ldi r20,  0x92  
	ST Y+, r20
	ldi r20,  0x8f   
    ST Y+, r20
    ldi r20, 0x8c       
    ST Y+, r20
	ldi r20, 0x89 
    ST Y+, r20
    ldi r20, 0x86     ;     
    ST Y+, r20
    ldi r20, 0x83     
    ST Y+, r20
    ldi r20, 0x80  ;   
    ST Y+, r20
    ldi r20, 0x7c 
ldi r20, 0x79     
    ST Y+, r20
    ldi r20, 0x76       
    ST Y+, r20
    ldi r20, 0x73       
    ST Y+, r20
    ldi r20, 0x70       
    ST Y+, r20
    ldi r20, 0x6d      
    ST Y+, r20
    ldi r20, 0x6a       
    ST Y+, r20
    ldi r20, 0x67       
    ST Y+, r20
    ldi r20, 0x63      
    ST Y+, r20
    ldi r20, 0x60       
    ST Y+, r20
    ldi r20, 0x5d      
    ST Y+, r20
    ldi r20, 0x5a       
    ST Y+, r20
    ldi r20, 0x57       
    ST Y+, r20
    ldi r20, 0x54      
    ST Y+, r20
    ldi r20, 0x51      
    ST Y+, r20
    ldi r20, 0x4f       
    ST Y+, r20
    ldi r20, 0x4c      
    ST Y+, r20
    ldi r20, 0x49       
    ST Y+, r20
    ldi r20, 0x46     
    ST Y+, r20
    ldi r20, 0x43       
    ST Y+, r20
    ldi r20, 0x40      
    ST Y+, r20
    ldi r20, 0x3e       
    ST Y+, r20
    ldi r20, 0x3b     
    ST Y+, r20
    ldi r20, 0x38      
    ST Y+, r20
    ldi r20, 0x36      
    ST Y+, r20
    ldi r20, 0x33      
    ST Y+, r20
    ldi r20, 0x31     
    ST Y+, r20
    ldi r20, 0x2e     
    ST Y+, r20
    ldi r20, 0x2c      
    ST Y+, r20
    ldi r20, 0x2a      
    ST Y+, r20
    ldi r20, 0x27       
    ST Y+, r20
    ldi r20, 0x25       
    ST Y+, r20
    ldi r20, 0x23      
    ST Y+, r20
    ldi r20, 0x21       
    ST Y+, r20
    ldi r20, 0x1f      
    ST Y+, r20
    ldi r20, 0x1d     
    ST Y+, r20
    ldi r20, 0x1b      
    ST Y+, r20
    ldi r20, 0x19      
    ST Y+, r20
    ldi r20, 0x17    
    ST Y+, r20
    ldi r20, 0x15       
    ST Y+, r20
    ldi r20, 0x13      
    ST Y+, r20
    ldi r20, 0x12   
    ST Y+, r20
    ldi r20, 0x10      
    ST Y+, r20
    ldi r20, 0x0f       
    ST Y+, r20
    ldi r20, 0x0d      
    ST Y+, r20
    ldi r20, 0x0c      
    ST Y+, r20
    ldi r20, 0x0a      
    ST Y+, r20
    ldi r20, 0x09       
    ST Y+, r20
    ldi r20, 0x08      
    ST Y+, r20
    ldi r20, 0x07      
    ST Y+, r20
    ldi r20, 0x06   
    ST Y+, r20
    ldi r20, 0x05     
    ST Y+, r20
    ldi r20, 0x04    
    ST Y+, r20
    ldi r20, 0x03   
    ST Y+, r20
    ldi r20, 0x03      
    ST Y+, r20
    ldi r20, 0x02       
    ST Y+, r20
    ldi r20, 0x01       
    ST Y+, r20
    ldi r20, 0x01      
    ST Y+, r20
    ldi r20, 0x00     
    ST Y+, r20
    ldi r20, 0x00      
    ST Y+, r20
    ldi r20, 0x00       
    ST Y+, r20
    ldi r20, 0x00       
    ST Y+, r20
    ldi r20, 0x00      
    ST Y+, r20
    ldi r20, 0x00      
    ST Y+, r20
    ldi r20, 0x00       
    ST Y+, r20
    ldi r20, 0x00      
    ST Y+, r20
    ldi r20, 0x00       
    ST Y+, r20
    ldi r20, 0x01      
    ST Y+, r20
    ldi r20, 0x01      
    ST Y+, r20
    ldi r20, 0x02     
    ST Y+, r20
    ldi r20, 0x03       
    ST Y+, r20
    ldi r20, 0x03      
    ST Y+, r20
    ldi r20, 0x04       
    ST Y+, r20
    ldi r20, 0x05      
    ST Y+, r20
    ldi r20, 0x06     
    ST Y+, r20
    ldi r20, 0x07      
    ST Y+, r20
    ldi r20, 0x08      
    ST Y+, r20
    ldi r20, 0x09       
    ST Y+, r20
    ldi r20, 0x0a      
    ST Y+, r20
    ldi r20, 0x0c       
    ST Y+, r20
    ldi r20, 0x0d      
    ST Y+, r20
    ldi r20, 0x0f       
    ST Y+, r20
    ldi r20, 0x10       
    ST Y+, r20
    ldi r20, 0x12      
    ST Y+, r20
    ldi r20, 0x13       
    ST Y+, r20
    ldi r20, 0x15      
	ldi r20, 0x17      
    ST Y+, r20
    ldi r20, 0x19     
    ST Y+, r20
    ldi r20, 0x1b      
    ST Y+, r20
    ldi r20, 0x1d       
    ST Y+, r20
    ldi r20, 0x1f       
    ST Y+, r20
    ldi r20, 0x21       
    ST Y+, r20
    ldi r20, 0x23   
    ST Y+, r20
    ldi r20, 0x25       
    ST Y+, r20
    ldi r20, 0x27       
    ST Y+, r20
    ldi r20, 0x2a     
    ST Y+, r20
    ldi r20, 0x2c      
    ST Y+, r20
    ldi r20, 0x2e      
    ST Y+, r20
    ldi r20, 0x31      
    ST Y+, r20
    ldi r20, 0x33       
    ST Y+, r20
    ldi r20, 0x36      
    ST Y+, r20
    ldi r20, 0x38       
    ST Y+, r20
    ldi r20, 0x3b       
    ST Y+, r20
    ldi r20, 0x3e      
    ST Y+, r20
    ldi r20, 0x40    
    ST Y+, r20
    ldi r20, 0x43      
    ST Y+, r20
    ldi r20, 0x46      
    ST Y+, r20
    ldi r20, 0x49     
    ST Y+, r20
    ldi r20, 0x4c     
    ST Y+, r20
    ldi r20, 0x4f     
    ST Y+, r20
    ldi r20, 0x51      
    ST Y+, r20
    ldi r20, 0x54       
    ST Y+, r20
    ldi r20, 0x57      
    ST Y+, r20
    ldi r20, 0x5a       
    ST Y+, r20
    ldi r20, 0x5d     
    ST Y+, r20
    ldi r20, 0x60      
    ST Y+, r20
    ldi r20, 0x63      
    ST Y+, r20
    ldi r20, 0x67     
    ST Y+, r20
    ldi r20, 0x6a      
    ST Y+, r20
    ldi r20, 0x6d      
    ST Y+, r20
    ldi r20, 0x70       
    ST Y+, r20
    ldi r20, 0x73       
    ST Y+, r20
    ldi r20, 0x76       
    ST Y+, r20
    ldi r20, 0x79       
    ST Y+, r20
    ldi r20, 0x7c      
    ST Y+, r20


	ret

	
delay:
	ldi r17, 0xFF         ; 
delay_loop:
	dec r17
	brne delay_loop       ; Esperar hasta que r17 llegue a cero
	ret