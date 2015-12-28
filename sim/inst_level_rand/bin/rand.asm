
rand.out:     ファイル形式 elf32-mist32


セクション .text の逆アセンブル:

00000000 <_start>:
   0:	0d 40 00 20 	wl16	r1,0x0
   4:	0d 60 00 23 	wh16	r1,0x3
   8:	10 40 00 21 	ld32	r1,r1
   c:	0d 40 00 10 	wl16	r0,0x10
  10:	0d 60 00 03 	wh16	r0,0x3
  14:	10 40 00 00 	ld32	r0,r0
  18:	04 00 00 21 	rand	r1,r1
  1c:	00 c0 00 01 	cmp	r0,r1
  20:	14 52 00 77 	b	1dc <_error>,#ne
  24:	0d 40 00 14 	wl16	r0,0x14
  28:	0d 60 00 03 	wh16	r0,0x3
  2c:	10 40 00 00 	ld32	r0,r0
  30:	04 00 00 21 	rand	r1,r1
  34:	00 c0 00 01 	cmp	r0,r1
  38:	14 52 00 77 	b	1dc <_error>,#ne
  3c:	0d 40 00 18 	wl16	r0,0x18
  40:	0d 60 00 03 	wh16	r0,0x3
  44:	10 40 00 00 	ld32	r0,r0
  48:	04 00 00 21 	rand	r1,r1
  4c:	00 c0 00 01 	cmp	r0,r1
  50:	14 52 00 77 	b	1dc <_error>,#ne
  54:	0d 40 00 1c 	wl16	r0,0x1c
  58:	0d 60 00 03 	wh16	r0,0x3
  5c:	10 40 00 00 	ld32	r0,r0
  60:	04 00 00 21 	rand	r1,r1
  64:	00 c0 00 01 	cmp	r0,r1
  68:	14 52 00 77 	b	1dc <_error>,#ne

0000006c <_test1>:
  6c:	0d 40 00 24 	wl16	r1,0x4
  70:	0d 60 00 23 	wh16	r1,0x3
  74:	10 40 00 21 	ld32	r1,r1
  78:	0d 40 04 00 	wl16	r0,0x20
  7c:	0d 60 00 03 	wh16	r0,0x3
  80:	10 40 00 00 	ld32	r0,r0
  84:	04 00 00 21 	rand	r1,r1
  88:	00 c0 00 01 	cmp	r0,r1
  8c:	14 52 00 77 	b	1dc <_error>,#ne
  90:	0d 40 04 04 	wl16	r0,0x24
  94:	0d 60 00 03 	wh16	r0,0x3
  98:	10 40 00 00 	ld32	r0,r0
  9c:	04 00 00 21 	rand	r1,r1
  a0:	00 c0 00 01 	cmp	r0,r1
  a4:	14 52 00 77 	b	1dc <_error>,#ne
  a8:	0d 40 04 08 	wl16	r0,0x28
  ac:	0d 60 00 03 	wh16	r0,0x3
  b0:	10 40 00 00 	ld32	r0,r0
  b4:	04 00 00 21 	rand	r1,r1
  b8:	00 c0 00 01 	cmp	r0,r1
  bc:	14 52 00 77 	b	1dc <_error>,#ne
  c0:	0d 40 04 0c 	wl16	r0,0x2c
  c4:	0d 60 00 03 	wh16	r0,0x3
  c8:	10 40 00 00 	ld32	r0,r0
  cc:	04 00 00 21 	rand	r1,r1
  d0:	00 c0 00 01 	cmp	r0,r1
  d4:	14 52 00 77 	b	1dc <_error>,#ne

000000d8 <_test2>:
  d8:	0d 40 00 28 	wl16	r1,0x8
  dc:	0d 60 00 23 	wh16	r1,0x3
  e0:	10 40 00 21 	ld32	r1,r1
  e4:	0d 40 04 10 	wl16	r0,0x30
  e8:	0d 60 00 03 	wh16	r0,0x3
  ec:	10 40 00 00 	ld32	r0,r0
  f0:	04 00 00 21 	rand	r1,r1
  f4:	00 c0 00 01 	cmp	r0,r1
  f8:	14 52 00 77 	b	1dc <_error>,#ne
  fc:	0d 40 04 14 	wl16	r0,0x34
 100:	0d 60 00 03 	wh16	r0,0x3
 104:	10 40 00 00 	ld32	r0,r0
 108:	04 00 00 21 	rand	r1,r1
 10c:	00 c0 00 01 	cmp	r0,r1
 110:	14 52 00 77 	b	1dc <_error>,#ne
 114:	0d 40 04 18 	wl16	r0,0x38
 118:	0d 60 00 03 	wh16	r0,0x3
 11c:	10 40 00 00 	ld32	r0,r0
 120:	04 00 00 21 	rand	r1,r1
 124:	00 c0 00 01 	cmp	r0,r1
 128:	14 52 00 77 	b	1dc <_error>,#ne
 12c:	0d 40 04 1c 	wl16	r0,0x3c
 130:	0d 60 00 03 	wh16	r0,0x3
 134:	10 40 00 00 	ld32	r0,r0
 138:	04 00 00 21 	rand	r1,r1
 13c:	00 c0 00 01 	cmp	r0,r1
 140:	14 52 00 77 	b	1dc <_error>,#ne

00000144 <_test3>:
 144:	0d 40 00 2c 	wl16	r1,0xc
 148:	0d 60 00 23 	wh16	r1,0x3
 14c:	10 40 00 21 	ld32	r1,r1
 150:	0d 40 08 00 	wl16	r0,0x40
 154:	0d 60 00 03 	wh16	r0,0x3
 158:	10 40 00 00 	ld32	r0,r0
 15c:	04 00 00 21 	rand	r1,r1
 160:	00 c0 00 01 	cmp	r0,r1
 164:	14 52 00 77 	b	1dc <_error>,#ne
 168:	0d 40 08 04 	wl16	r0,0x44
 16c:	0d 60 00 03 	wh16	r0,0x3
 170:	10 40 00 00 	ld32	r0,r0
 174:	04 00 00 21 	rand	r1,r1
 178:	00 c0 00 01 	cmp	r0,r1
 17c:	14 52 00 77 	b	1dc <_error>,#ne
 180:	0d 40 08 08 	wl16	r0,0x48
 184:	0d 60 00 03 	wh16	r0,0x3
 188:	10 40 00 00 	ld32	r0,r0
 18c:	04 00 00 21 	rand	r1,r1
 190:	00 c0 00 01 	cmp	r0,r1
 194:	14 52 00 77 	b	1dc <_error>,#ne
 198:	0d 40 08 0c 	wl16	r0,0x4c
 19c:	0d 60 00 03 	wh16	r0,0x3
 1a0:	10 40 00 00 	ld32	r0,r0
 1a4:	04 00 00 21 	rand	r1,r1
 1a8:	00 c0 00 01 	cmp	r0,r1
 1ac:	14 52 00 77 	b	1dc <_error>,#ne
 1b0:	0d 40 00 00 	wl16	r0,0x0
 1b4:	0d 60 00 02 	wh16	r0,0x2
 1b8:	0d 40 00 21 	wl16	r1,0x1
 1bc:	0d 60 00 20 	wh16	r1,0x0
 1c0:	10 a0 00 20 	st32	r1,r0
 1c4:	0d 40 00 04 	wl16	r0,0x4
 1c8:	0d 60 00 02 	wh16	r0,0x2
 1cc:	0d 40 00 21 	wl16	r1,0x1
 1d0:	0d 60 00 20 	wh16	r1,0x0
 1d4:	10 a0 00 20 	st32	r1,r0

000001d8 <_non_error_finish>:
 1d8:	14 50 00 76 	b	1d8 <_non_error_finish>,#al

000001dc <_error>:
 1dc:	0d 40 00 00 	wl16	r0,0x0
 1e0:	0d 60 00 02 	wh16	r0,0x2
 1e4:	0d 40 00 20 	wl16	r1,0x0
 1e8:	0d 60 00 20 	wh16	r1,0x0
 1ec:	10 a0 00 20 	st32	r1,r0
 1f0:	0d 40 00 04 	wl16	r0,0x4
 1f4:	0d 60 00 02 	wh16	r0,0x2
 1f8:	0d 40 00 21 	wl16	r1,0x1
 1fc:	0d 60 00 20 	wh16	r1,0x0
 200:	10 a0 00 20 	st32	r1,r0

00000204 <_error_finish>:
 204:	14 50 00 81 	b	204 <_error_finish>,#al

セクション .assert の逆アセンブル:

00020000 <CHECK_FLAG>:
   20000:	00 00 00 01 	add	r0,r1

00020004 <CHECK_FINISH>:
   20004:	00 00 00 00 	add	r0,r0

00020008 <ERROR_TYPE>:
   20008:	00 00 00 00 	add	r0,r0

0002000c <ERROR_NUMBER>:
   2000c:	00 00 00 00 	add	r0,r0

00020010 <ERROR_RESULT>:
   20010:	00 00 00 00 	add	r0,r0

00020014 <ERROR_EXPECT>:
   20014:	00 00 00 00 	add	r0,r0

セクション .data の逆アセンブル:

00030000 <SRC0>:
   30000:	01 23 45 67 	*unknown*

00030004 <SRC1>:
   30004:	89 ab cd ef 	*unknown*

00030008 <SRC2>:
   30008:	00 00 00 01 	add	r0,r1

0003000c <SRC3>:
   3000c:	78 9a bc de 	*unknown*

00030010 <EXPECT0_0>:
   30010:	58 7d a5 a0 	*unknown*

00030014 <EXPECT0_1>:
   30014:	75 f3 ab 44 	*unknown*

00030018 <EXPECT0_2>:
   30018:	13 fe 4a 29 	*unknown*

0003001c <EXPECT0_3>:
   3001c:	8d db e9 f4 	*unknown*

00030020 <EXPECT1_0>:
   30020:	f2 dc e9 64 	*unknown*

00030024 <EXPECT1_1>:
   30024:	91 fb 8d 1c 	*unknown*

00030028 <EXPECT1_2>:
   30028:	eb 57 db 30 	*unknown*

0003002c <EXPECT1_3>:
   3002c:	16 0b b6 28 	*unknown*

00030030 <EXPECT2_0>:
   30030:	00 04 20 21 	*unknown*

00030034 <EXPECT2_1>:
   30034:	04 08 06 01 	*unknown*

00030038 <EXPECT2_2>:
   30038:	9d cc a8 c5 	*unknown*

0003003c <EXPECT2_3>:
   3003c:	12 55 99 4f 	*unknown*

00030040 <EXPECT3_0>:
   30040:	cf 2c 00 9e 	*unknown*

00030044 <EXPECT3_1>:
   30044:	a8 c3 07 21 	*unknown*

00030048 <EXPECT3_2>:
   30048:	cc cf 25 72 	*unknown*

0003004c <EXPECT3_3>:
   3004c:	24 4f 59 02 	*unknown*

セクション .stack の逆アセンブル:

000f0000 <STACK_INDEX>:
   f0000:	00 00 00 00 	add	r0,r0
