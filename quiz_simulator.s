;syedzakwan2016

start:

	LCD:    MOV R0,#4
		MOV R1,#1
		LDR R2,=text1
		SWI 0x204

		BL Mydelay
		SWI 0x206
		
		MOV R0,#0
		MOV R1,#0
		LDR R2,=text2
		SWI 0x204

		MOV RO,#0
		MOV R1,#1
		LDR R2,text3
		SWI 0x204

		MOV R0,#0
		MOV R1,#2
		LDR R2,=text4
		SWI 0x204

		MOV R0,#0
		MOV R1,#3
		LDR R2,text
		SWI 0x2-4

		BL Mydelay2
		SWI 0x206
		MOV R0,#4
		MOV R1,#1
		LDR R2,=text5
		SWI 0x204          ;PRESS RIGHT TO START QUIZ

		BL PUSHBUTTON

	PUSHBUTTON: 	SWI 0x202
			CMP R0,#0x01       ;kanan
			BEQ question1
			CMP R0,#0x02       ;kiri
			BEQ END
			BNE PUSHBUTTON

	question1:	SWI 0x206	
			LDR R1,Disp1  ;display '1' at seven segment
			LDR R0,[R1]
			SWI 0x200
			MOV R0,#0
			MOV R1.#1
			LDR R2,=text6
			SWI 0x204
			MOV R0,#0
			MOV R1,#2
			LDR R2,=text7      ;question1
			SWI 0x204
			MOV R0,#0x01
			SWI 0x201
			
			BL Mydelay3     ;LED blink left and right
			MOV R0,#0x02
			SWI 0x201
			BL Mydelay3
			MOV RO,#0x01
			SWI 0x201
			BL Mydelay3
			MOV R0,#0x02
			SWI 0x201
			BL Mydelay3
			MOV R0,#0x01
			SWI 0x201
			BL Mydelay3
			MOV R0,#0x01
			BL KEYPAD
	
	question2:	SWI 0x206
			LDR R1,=Disp   ;clear ssd
			LDR R0,[R1]
			SWI 0x200
			
			MOV R0,#0x00    ;clear led
			SWI 0x201
			SWI 0x206
			LDR R1,=Disp2   ;display '2' at ssd
			LDR R0,[R1]
			SWI 0x200
			
			MOV R0,#0
			MOV R1,#1
			LDR R2,=text12    ;soalan 2
			SWI 0x204
			MOV R0,#0
			MOV R1,#2
			LDR R2,=text13
			SWI 0x204
			MOV R0,#0x01
			SWI 0x201
			BL Mydelay3
			MOV RO,#0x02
			SWI 0x201
			BL Mydelay3
			MOV RO,#0x01

			SWI 0x201
			BL Mydelay3
			MOV R0,#0x02
			SWI 0x201
			BL Mydelay3
			MOV R0,#0x02
			
			BL KEYPAD2
			

	KEYPAD: 	SWI 0x203
			CMP R0,#0x01     ;press 0 for right answer
			BEQ RIGHTANSWER   ;if 0 pressed go to RIGHTANSWER
			CMP R0,#0x02      ;press 2 wrong answer
			BEQ WRONGANSWER
			CMP R0,#0x04
			BEQ WRONGANSWER
			CMP R0,#4
			BNE KEYPAD
	
	KEYPAD2:	SWI 0x203
			CMP R0,#0x01    ;if 1 pressed go to RIGHTANSWER
			BEQ rightanswer2
			CMP R0,#0x02
			BEQ WRONGANSWER2
			CMP R0,#0x04
			BEQ WRONGANSWER2
			CMP R0,#4
			BNE KEYPAD2

	RIGHTANSWER:	SWI 0x206
			MOV R0,#4
			MOV R1,#1
			LDR R2,=text8
			SWI 0x204
			BL Mydelay
			ADD R7,R7,#1
			BL question2

	WRONGANSWER:	SWI 0x206
			LDR R0,=0x203   ;both led ligt up
			SWI 0x201
			SWI 0x206
			MOV R0,34
			MOV R1,#1
			LDR R2,=text9
			SWI 0x204
			ADD R7,R7,#0
			BL Mydelay
			BL question2
	
	WRONGANSWER2:	LDR R0,=0x203
			SWI 0x201
			SWI 0x206
			MOV R0,#4
			MOV R1,#1
			LDR R2,=text9
			SWI 0x204
			ADD R8,R7,#0
			BL Mydelay
			BL markah

	rightanswer2:	SWI 0x206
			MOV R0,#4
			MOV R1,#1
			LDR R2,=text8
			SWI 0x204
			BL Mydelay
			ADD R8,R7,#1
			BL markah
	
	markah: 	CMP R8,#2
			BEQ great
			CMP R8,#1
			BEQ SATU
			CMP R8,#0
			BEQ KOSONG
			BNE markah
	

	great: 		SWI 0x206
			MOV R0,#5
			MOV R1,#6
			LDR R2,=text14
			SWI 0x204
			MOV R0,#5
			MOV R1,#7
			LDR R2,=text15
			SWI 0x204
			BL Mydelay
			BL tryagain

	SATU:		SWI 0x206
			MOV R0,#5
			MOV R1,#6
			LDR R2,=text16
			SWI 0x204
			BL Mydelay
			BL tryagain
			
	KOSONG: 	SWI 0x206
			MOV R0,#5
			MOV R1,#6
			LDR R2,=text17
			SWI 0x204
			BL Mydelay
			BL tryagain
			
	tryagain: 	SWI 0x206
			MOV R0,#5
			MOV R1,#5
			LDR R2,=text10
			SWI 0x204
			MOV RO,#5
			MOV R1,#6
			LDR R2,=text11
			SWI 0x204
			MOV R7,#0
			MOV R8,#0
			BL PUSHBUTTON
	END: 		SWI 0x206
			MOV R0,#5
			MOV R1,#5
			LDR R2,=text20
			SWI 0x204

	Mydelay:	MOV R2,#4000 @Wait(Delay:r2) waitfor r2 ms Wait: 
		Wait:	stmfd sp!,{r0-r1,lr}
			swi 0x6d
			mov r1,r0
		WaitLoop: swi 0x6d
			  subs r0,r0,r1
			  rsblt r0,r0,#0
			  cmp r0,r2
			  blt WaitLoop
		WaitDone: ldmfd sp!,{r0-r1,pc}


	Mydelay2: MOV R2,#8000   @Wait(Delay:r2) waitfor r2 ms Wait: 
		Wait2:	stmfd sp!,{r0-r1,lr}
			swi 0x6d
			mov r1,r0
		WaitLoop2: swi 0x6d
			  subs r0,r0,r1
			  rsblt r0,r0,#0
			  cmp r0,r2
			  blt WaitLoop
		WaitDone2: ldmfd sp!,{r0-r1,pc}

	Mydelay3: MOV R2,#800   @Wait(Delay:r2) waitfor r2 ms Wait: 
		Wait3:	stmfd sp!,{r0-r1,lr}
			swi 0x6d
			mov r1,r0
		WaitLoop3: swi 0x6d
			  subs r0,r0,r1
			  rsblt r0,r0,#0
			  cmp r0,r2
			  blt WaitLoop
		WaitDone3: ldmfd sp!,{r0-r1,pc}


	.data


	text1:	.asciz	"WELCOME KIDS"
	text2: 	.asciz 	"This is the quiz simulator. You have 4"
	text3:	.asciz	"choices A,B,C and D. If your answer is"
	text4: 	.asciz	"A press keypad 0,B press 1, C press 2"
	text: 	.asciz	"D press keypad 3"
	text5: 	.asciz	"Press the right button to start the quiz"
	text6:  .asciz	"What is the colour of sun"
	text7: 	.asciz	"a.yellow b.black c.red d.green"
	text8: 	.asciz	"Right Answer"
	text9: 	.asciz	"Wrong Answer"
	text10: .asciz	"You can press right button to try"
	text11: .asciz	"again or left button to quit"
	text12:	.asciz	"What animal known as a king of jungle"
	text13:	.asciz	"a.lion b.tiger c.snake d.bear"
	text14: .asciz	" GREAT"
	text15: .asciz	"YOU JUST GOT FULL MARKS"
	text16: .asciz 	"Not bad..you got 1/2"
	text17:	.asciz	"sorry...you got 0 mark"
	text18: .asciz	"THANK YOU"	
	Disp0: .word	0x00
	Disp1: .word 	0x40|0x20
	Disp2: .word	0x80|0x40|0x02|0x04|0x08

.end		
		
