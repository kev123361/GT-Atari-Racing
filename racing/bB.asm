game
.L00 ;  rem Generated 12/3/2017 10:17:28 AM by Visual bB Version 1.0.0.554

.L01 ;  rem Atari racing game created for Georgia Tech LMC 2700 Fall 2017

.L02 ;  rem Created By: Alexus Clark, Ye-Ji Kim, Kevin Tang

.
 ; 

.L03 ;  set romsize  =  2k

.
 ; 

.L04 ;  rem player sprites

.L05 ;  player0:

	LDX #<playerL05_0
	STX player0pointerlo
	LDA #>playerL05_0
	STA player0pointerhi
	LDA #11
	STA player0height
.L06 ;  player0color:

	LDX #<playercolorL06_0
	STX player0color
	LDA #>playercolorL06_0
	STA player0color+1
.
 ; 

.L07 ;  player1:

	LDX #<playerL07_1
	STX player1pointerlo
	LDA #>playerL07_1
	STA player1pointerhi
	LDA #11
	STA player1height
.L08 ;  player1color:

	LDX #<playercolorL08_1
	STX player1color
	LDA #>playercolorL08_1
	STA player1color+1
.
 ; 

.L09 ;  rem Idle start screen

.startscreen
 ; startscreen

.
 ; 

.L010 ;  set kernel_options player1colors playercolors pfcolors

.L011 ;  pfcolors:

 lda # 6
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel77-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel77-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel77-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel77-84)
 endif
 sta pfcolortable
.
 ; 

.L012 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %00000011, %00000000
 endif
	.byte %00000110, %00000000
	if (pfwidth>2)
	.byte %00000100, %00000001
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %00000001, %00000000
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %00000010, %00000000
 endif
	.byte %00001111, %00000001
	if (pfwidth>2)
	.byte %00000111, %00000001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.L013 ;  f  =  f  +  1

	INC f
.L014 ;  if f  =  61 then f  =  12

	LDA f
	CMP #61
     BNE .skipL014
.condpart0
	LDA #12
	STA f
.skipL014
.
 ; 

.L015 ;  player0x = 40 : player0y = 85

	LDA #40
	STA player0x
	LDA #85
	STA player0y
.L016 ;  player1x = 105 : player1y = 85

	LDA #105
	STA player1x
	LDA #85
	STA player1y
.L017 ;  drawscreen

 jsr drawscreen
.L018 ;  if joy0fire then goto gamestart

 bit INPT4
	BMI .skipL018
.condpart1
 jmp .gamestart

.skipL018
.L019 ;  goto startscreen

 jmp .startscreen

.
 ; 

.gamestart
 ; gamestart

.L020 ;  const pfscore  =  1

.
 ; 

.L021 ;  pfscorecolor  =  $9c

	LDA #$9c
	STA pfscorecolor
.L022 ;  pfscore1  =  %00000000

	LDA #%00000000
	STA pfscore1
.L023 ;  pfscore2  =  %00000000

	LDA #%00000000
	STA pfscore2
.
 ; 

.L024 ;  player0x = 50 : player0y = 40

	LDA #50
	STA player0x
	LDA #40
	STA player0y
.L025 ;  player1x = 50 : player1y = 60

	LDA #50
	STA player1x
	LDA #60
	STA player1y
.L026 ;  g  =  0

	LDA #0
	STA g
.L027 ;  ballheight  =  4

	LDA #4
	STA ballheight
.L028 ;  CTRLPF  =  $21

	LDA #$21
	STA CTRLPF
.L029 ;  h  =  1

	LDA #1
	STA h
.
 ; 

.
 ; 

.L030 ;  rem start of the main draw loop

.sprites
 ; sprites

.L031 ;  f  =  f  +  1

	INC f
.L032 ;  g  =  g  +  1

	INC g
.
 ; 

.L033 ;  rem animation of the street passing by

.L034 ;  if f  =  20  ||  f  =  45 then playfield: 

	LDA f
	CMP #20
     BNE .skipL034
.condpart2
 jmp .condpart3
.skipL034
	LDA f
	CMP #45
     BNE .skip0OR
.condpart3
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.skip0OR
.L035 ;  if f  =  21  ||  f  =  46 then playfield: 

	LDA f
	CMP #21
     BNE .skipL035
.condpart4
 jmp .condpart5
.skipL035
	LDA f
	CMP #46
     BNE .skip1OR
.condpart5
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel2
PF_data2
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00110000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.skip1OR
.
 ; 

.L036 ;  if f  =  22  ||  f  =  47 then playfield: 

	LDA f
	CMP #22
     BNE .skipL036
.condpart6
 jmp .condpart7
.skipL036
	LDA f
	CMP #47
     BNE .skip2OR
.condpart7
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel3
PF_data3
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel3
	lda PF_data3,x
	sta playfield,x
	dex
	bpl pflabel3
.skip2OR
.L037 ;  if f  =  23  ||  f  =  48 then playfield: 

	LDA f
	CMP #23
     BNE .skipL037
.condpart8
 jmp .condpart9
.skipL037
	LDA f
	CMP #48
     BNE .skip3OR
.condpart9
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel4
PF_data4
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000011
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel4
	lda PF_data4,x
	sta playfield,x
	dex
	bpl pflabel4
.skip3OR
.L038 ;  if f  =  24  ||  f  =  49 then playfield: 

	LDA f
	CMP #24
     BNE .skipL038
.condpart10
 jmp .condpart11
.skipL038
	LDA f
	CMP #49
     BNE .skip4OR
.condpart11
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel5
PF_data5
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000011, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel5
	lda PF_data5,x
	sta playfield,x
	dex
	bpl pflabel5
.skip4OR
.L039 ;  if f  =  25  ||  f  =  50 then playfield: 

	LDA f
	CMP #25
     BNE .skipL039
.condpart12
 jmp .condpart13
.skipL039
	LDA f
	CMP #50
     BNE .skip5OR
.condpart13
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel6
PF_data6
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00001100, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel6
	lda PF_data6,x
	sta playfield,x
	dex
	bpl pflabel6
.skip5OR
.L040 ;  if f  =  26  ||  f  =  51 then playfield: 

	LDA f
	CMP #26
     BNE .skipL040
.condpart14
 jmp .condpart15
.skipL040
	LDA f
	CMP #51
     BNE .skip6OR
.condpart15
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel7
PF_data7
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00110000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel7
	lda PF_data7,x
	sta playfield,x
	dex
	bpl pflabel7
.skip6OR
.L041 ;  if f  =  27  ||  f  =  52 then playfield: 

	LDA f
	CMP #27
     BNE .skipL041
.condpart16
 jmp .condpart17
.skipL041
	LDA f
	CMP #52
     BNE .skip7OR
.condpart17
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel8
PF_data8
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel8
	lda PF_data8,x
	sta playfield,x
	dex
	bpl pflabel8
.skip7OR
.L042 ;  if f  =  28  ||  f  =  53 then playfield: 

	LDA f
	CMP #28
     BNE .skipL042
.condpart18
 jmp .condpart19
.skipL042
	LDA f
	CMP #53
     BNE .skip8OR
.condpart19
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel9
PF_data9
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel9
	lda PF_data9,x
	sta playfield,x
	dex
	bpl pflabel9
.skip8OR
.L043 ;  if f  =  29  ||  f  =  54 then playfield: 

	LDA f
	CMP #29
     BNE .skipL043
.condpart20
 jmp .condpart21
.skipL043
	LDA f
	CMP #54
     BNE .skip9OR
.condpart21
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel10
PF_data10
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00110000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel10
	lda PF_data10,x
	sta playfield,x
	dex
	bpl pflabel10
.skip9OR
.L044 ;  if f  =  30  ||  f  =  55 then playfield: 

	LDA f
	CMP #30
     BNE .skipL044
.condpart22
 jmp .condpart23
.skipL044
	LDA f
	CMP #55
     BNE .skip10OR
.condpart23
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel11
PF_data11
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00001100
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel11
	lda PF_data11,x
	sta playfield,x
	dex
	bpl pflabel11
.skip10OR
.L045 ;  if f  =  31  ||  f  =  56 then playfield: 

	LDA f
	CMP #31
     BNE .skipL045
.condpart24
 jmp .condpart25
.skipL045
	LDA f
	CMP #56
     BNE .skip11OR
.condpart25
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel12
PF_data12
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000011
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel12
	lda PF_data12,x
	sta playfield,x
	dex
	bpl pflabel12
.skip11OR
.
 ; 

.L046 ;  if f  =  32  ||  f  =  57 then playfield: 

	LDA f
	CMP #32
     BNE .skipL046
.condpart26
 jmp .condpart27
.skipL046
	LDA f
	CMP #57
     BNE .skip12OR
.condpart27
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel13
PF_data13
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000011, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel13
	lda PF_data13,x
	sta playfield,x
	dex
	bpl pflabel13
.skip12OR
.L047 ;  if f  =  33  ||  f  =  58 then playfield: 

	LDA f
	CMP #33
     BNE .skipL047
.condpart28
 jmp .condpart29
.skipL047
	LDA f
	CMP #58
     BNE .skip13OR
.condpart29
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel14
PF_data14
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel14
	lda PF_data14,x
	sta playfield,x
	dex
	bpl pflabel14
.skip13OR
.
 ; 

.L048 ;  if f  =  34  ||  f  =  59 then playfield: 

	LDA f
	CMP #34
     BNE .skipL048
.condpart30
 jmp .condpart31
.skipL048
	LDA f
	CMP #59
     BNE .skip14OR
.condpart31
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel15
PF_data15
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00110000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel15
	lda PF_data15,x
	sta playfield,x
	dex
	bpl pflabel15
.skip14OR
.L049 ;  if f  =  35  ||  f  =  60 then playfield: 

	LDA f
	CMP #35
     BNE .skipL049
.condpart32
 jmp .condpart33
.skipL049
	LDA f
	CMP #60
     BNE .skip15OR
.condpart33
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel16
PF_data16
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel16
	lda PF_data16,x
	sta playfield,x
	dex
	bpl pflabel16
.skip15OR
.L050 ;  if f  =  36  ||  f  =  61 then playfield: 

	LDA f
	CMP #36
     BNE .skipL050
.condpart34
 jmp .condpart35
.skipL050
	LDA f
	CMP #61
     BNE .skip16OR
.condpart35
  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel17
PF_data17
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel17
	lda PF_data17,x
	sta playfield,x
	dex
	bpl pflabel17
.skip16OR
.
 ; 

.L051 ;  if f  =  61 then f  =  12

	LDA f
	CMP #61
     BNE .skipL051
.condpart36
	LDA #12
	STA f
.skipL051
.L052 ;  if g  =  50 then g  =  49

	LDA g
	CMP #50
     BNE .skipL052
.condpart37
	LDA #49
	STA g
.skipL052
.
 ; 

.L053 ;  rem spawn ball at random location based on f

.L054 ;  if g  =  48 then ballx  =  150 : bally  =  f  +  10

	LDA g
	CMP #48
     BNE .skipL054
.condpart38
	LDA #150
	STA ballx
	LDA f
	CLC
	ADC #10
	STA bally
.skipL054
.
 ; 

.draw_loop
 ; draw_loop

.L055 ;  drawscreen

 jsr drawscreen
.
 ; 

.L056 ;  rem ball movement

.L057 ;  ballx  =  ballx  -  1

	DEC ballx
.L058 ;  if g  >  48 then bally  =  bally  +  h

	LDA #48
	CMP g
     BCS .skipL058
.condpart39
	LDA bally
	CLC
	ADC h
	STA bally
.skipL058
.
 ; 

.L059 ;  rem player movement 

.L060 ;  if joy0up  &&  player0y  >  24 then player0y  =  player0y - 1

 lda #$10
 bit SWCHA
	BNE .skipL060
.condpart40
	LDA #24
	CMP player0y
     BCS .skip40then
.condpart41
	DEC player0y
.skip40then
.skipL060
.L061 ;  if joy0down  &&  player0y  <  72 then player0y  =  player0y + 1

 lda #$20
 bit SWCHA
	BNE .skipL061
.condpart42
	LDA player0y
	CMP #72
     BCS .skip42then
.condpart43
	INC player0y
.skip42then
.skipL061
.L062 ;  if joy0left  &&  player0x  >  16 then player0x  =  player0x - 1

 bit SWCHA
	BVS .skipL062
.condpart44
	LDA #16
	CMP player0x
     BCS .skip44then
.condpart45
	DEC player0x
.skip44then
.skipL062
.L063 ;  if joy0right  &&  player0x  <  138 then player0x  =  player0x + 1

 bit SWCHA
	BMI .skipL063
.condpart46
	LDA player0x
	CMP #138
     BCS .skip46then
.condpart47
	INC player0x
.skip46then
.skipL063
.
 ; 

.L064 ;  if joy1up  &&  player1y  >  28 then player1y  =  player1y - 1

 lda #1
 bit SWCHA
	BNE .skipL064
.condpart48
	LDA #28
	CMP player1y
     BCS .skip48then
.condpart49
	DEC player1y
.skip48then
.skipL064
.L065 ;  if joy1down  &&  player1y  <  72 then player1y  =  player1y + 1

 lda #2
 bit SWCHA
	BNE .skipL065
.condpart50
	LDA player1y
	CMP #72
     BCS .skip50then
.condpart51
	INC player1y
.skip50then
.skipL065
.L066 ;  if joy1left  &&  player1x  >  16 then player1x  =  player1x - 1

 lda #4
 bit SWCHA
	BNE .skipL066
.condpart52
	LDA #16
	CMP player1x
     BCS .skip52then
.condpart53
	DEC player1x
.skip52then
.skipL066
.L067 ;  if joy1right  &&  player1x  <  138 then player1x  =  player1x + 1

 lda #8
 bit SWCHA
	BNE .skipL067
.condpart54
	LDA player1x
	CMP #138
     BCS .skip54then
.condpart55
	INC player1x
.skip54then
.skipL067
.
 ; 

.L068 ;  if bally  =  20 then h  =  1

	LDA bally
	CMP #20
     BNE .skipL068
.condpart56
	LDA #1
	STA h
.skipL068
.L069 ;  if bally  =  72 then h  =   - 1

	LDA bally
	CMP #72
     BNE .skipL069
.condpart57
	LDA #255
	STA h
.skipL069
.
 ; 

.L070 ;  if ballx  =  10 then g  =  0 :  bally  =   - 50

	LDA ballx
	CMP #10
     BNE .skipL070
.condpart58
	LDA #0
	STA g
	LDA #206
	STA bally
.skipL070
.
 ; 

.L071 ;  rem collision detection

.L072 ;  if collision(player0,player1) then score  =  score  +  1 : player0x  =  player0x  -   ( player1x  -  player0x )  : player1x  =  player1x  -   ( player0x  -  player1x ) 

	bit 	CXPPMM
	BPL .skipL072
.condpart59
	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
; complex statement detected
	LDA player0x
	PHA
	LDA player1x
	SEC
	SBC player0x
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0x
; complex statement detected
	LDA player1x
	PHA
	LDA player0x
	SEC
	SBC player1x
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player1x
.skipL072
.L073 ;  if collision(player0,player1) then player0y  =  player0y  -   ( player1y  -  player0y )  : player1y  =  player1y  -   ( player0y  -  player1y ) 

	bit 	CXPPMM
	BPL .skipL073
.condpart60
; complex statement detected
	LDA player0y
	PHA
	LDA player1y
	SEC
	SBC player0y
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0y
; complex statement detected
	LDA player1y
	PHA
	LDA player0y
	SEC
	SBC player1y
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player1y
.skipL073
.
 ; 

.L074 ;  if collision(player0,ball) then bally  =   - 50 : g  =  0 : goto ponescore

	bit 	CXP0FB
	BVC .skipL074
.condpart61
	LDA #206
	STA bally
	LDA #0
	STA g
 jmp .ponescore

.skipL074
.L075 ;  if collision(player1,ball) then bally  =   - 50 : g  =  0 : goto ptwoscore

	bit 	CXP1FB
	BVC .skipL075
.condpart62
	LDA #206
	STA bally
	LDA #0
	STA g
 jmp .ptwoscore

.skipL075
.
 ; 

.L076 ;  goto sprites

 jmp .sprites

.
 ; 

.ponescore
 ; ponescore

.L077 ;  if pfscore1  =  %11011000 then pfscore1  =  %11011011 : goto ponevictory

	LDA pfscore1
	CMP #%11011000
     BNE .skipL077
.condpart63
	LDA #%11011011
	STA pfscore1
 jmp .ponevictory

.skipL077
.L078 ;  if pfscore1  =  %11000000 then pfscore1  =  %11011000

	LDA pfscore1
	CMP #%11000000
     BNE .skipL078
.condpart64
	LDA #%11011000
	STA pfscore1
.skipL078
.L079 ;  if pfscore1  =  %00000000 then pfscore1  =  %11000000

	LDA pfscore1
	CMP #%00000000
     BNE .skipL079
.condpart65
	LDA #%11000000
	STA pfscore1
.skipL079
.
 ; 

.L080 ;  goto sprites

 jmp .sprites

.
 ; 

.ptwoscore
 ; ptwoscore

.L081 ;  if pfscore2  =  %11011000 then pfscore2  =  %11011011 : goto ptwovictory

	LDA pfscore2
	CMP #%11011000
     BNE .skipL081
.condpart66
	LDA #%11011011
	STA pfscore2
 jmp .ptwovictory

.skipL081
.L082 ;  if pfscore2  =  %11000000 then pfscore2  =  %11011000

	LDA pfscore2
	CMP #%11000000
     BNE .skipL082
.condpart67
	LDA #%11011000
	STA pfscore2
.skipL082
.L083 ;  if pfscore2  =  %00000000 then pfscore2  =  %11000000

	LDA pfscore2
	CMP #%00000000
     BNE .skipL083
.condpart68
	LDA #%11000000
	STA pfscore2
.skipL083
.
 ; 

.L084 ;  goto sprites

 jmp .sprites

.
 ; 

.L085 ;  rem victory screen for P1

.ponevictory
 ; ponevictory

.L086 ;  COLUBK  =  0

	LDA #0
	STA COLUBK
.L087 ;  player0x  =   - 50 : player0y  =   - 50

	LDA #206
	STA player0x
	LDA #206
	STA player0y
.L088 ;  player1x  =   - 50 : player1y  =   - 50

	LDA #206
	STA player1x
	LDA #206
	STA player1y
.L089 ;  pfcolors:

 lda # 28
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel77-131+pfres*pfwidth)
 else
 lda #>(pfcolorlabel77-83)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel77-131+pfres*pfwidth)
 else
 lda #<(pfcolorlabel77-83)
 endif
 sta pfcolortable
.L090 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel18
PF_data18
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11000100, %10001000
	if (pfwidth>2)
	.byte %00011100, %00010011
 endif
	.byte %10101100, %10001000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %10100100, %10001000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %11000100, %10101000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %10000100, %11011000
	if (pfwidth>2)
	.byte %00001000, %00011001
 endif
	.byte %10001110, %10001000
	if (pfwidth>2)
	.byte %00011100, %00010001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel18
	lda PF_data18,x
	sta playfield,x
	dex
	bpl pflabel18
.L091 ;  drawscreen

 jsr drawscreen
.L092 ;  if joy0fire then goto startscreen

 bit INPT4
	BMI .skipL092
.condpart69
 jmp .startscreen

.skipL092
.L093 ;  goto ponevictory

 jmp .ponevictory

.
 ; 

.L094 ;  rem victory screen for P2

.ptwovictory
 ; ptwovictory

.L095 ;  COLUBK  =  0

	LDA #0
	STA COLUBK
.L096 ;  player0x  =   - 50 : player0y  =   - 50

	LDA #206
	STA player0x
	LDA #206
	STA player0y
.L097 ;  player1x  =   - 50 : player1y  =   - 50

	LDA #206
	STA player1x
	LDA #206
	STA player1y
.L098 ;  pfcolors:

 lda # 28
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel77-130+pfres*pfwidth)
 else
 lda #>(pfcolorlabel77-82)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel77-130+pfres*pfwidth)
 else
 lda #<(pfcolorlabel77-82)
 endif
 sta pfcolortable
.L099 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel19
PF_data19
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11000100, %10001000
	if (pfwidth>2)
	.byte %00011100, %00010011
 endif
	.byte %10101010, %10001000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %10100010, %10001000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %11000100, %10101000
	if (pfwidth>2)
	.byte %00001000, %00010101
 endif
	.byte %10001000, %11011000
	if (pfwidth>2)
	.byte %00001000, %00011001
 endif
	.byte %10001110, %10001000
	if (pfwidth>2)
	.byte %00011100, %00010001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel19
	lda PF_data19,x
	sta playfield,x
	dex
	bpl pflabel19
.L0100 ;  drawscreen

 jsr drawscreen
.L0101 ;  if joy0fire then goto startscreen

 bit INPT4
	BMI .skipL0101
.condpart70
 jmp .startscreen

.skipL0101
.L0102 ;  goto ptwovictory
 jmp .ptwovictory
 if (<*) > (<(*+11))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL05_0
	.byte  %11000011
	.byte  %11000011
	.byte  %11000011
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11000011
	.byte  %11000011
	.byte  %11000011
 if (<*) > (<(*+11))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL06_0
	.byte  $02;
	.byte  $02;
	.byte  $F6;
	.byte  $F6;
	.byte  $0C;
	.byte  $A0;
	.byte  $A0;
	.byte  $0E;
	.byte  $F6;
	.byte  $F6;
	.byte  $02;
	.byte  $02;
 if (<*) > (<(*+11))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL07_1
	.byte  %11000011
	.byte  %11000011
	.byte  %11000011
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11111111
	.byte  %11000011
	.byte  %11000011
	.byte  %11000011
 if (<*) > (<(*+11))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL08_1
	.byte  $02;
	.byte  $02;
	.byte  $40;
	.byte  $40;
	.byte  $0C;
	.byte  $00;
	.byte  $00;
	.byte  $0E;
	.byte  $40;
	.byte  $40;
	.byte  $02;
	.byte  $02;
 ifconst pfres
 if (<*) > (254-pfres*pfwidth)
	align 256
	endif
 if (<*) < (136-pfres*pfwidth)
	repeat ((136-pfres*pfwidth)-(<*))
	.byte 0
	repend
	endif
 else
 if (<*) > 206
	align 256
	endif
 if (<*) < 88
	repeat (88-(<*))
	.byte 0
	repend
	endif
 endif
pfcolorlabel77
 .byte  196, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  28, 28, 28,0
 .byte  196, 28, 28,0
 .byte  196, 28, 28,0
 .byte  6, 28, 28,0
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
