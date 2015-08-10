
./out/mulh.out:     file format elf32-mist32


Disassembly of section .text:

00000000 <_start>:
   0:	0d 40 00 00 	wl16	r0,0x0
   4:	0d 60 00 0f 	wh16	r0,0xf
   8:	1c 00 00 00 	srspw	r0
   c:	14 30 00 18 	br	6c <check>,#al

00000010 <compare>:
  10:	00 c0 01 09 	cmp	r8,r9
  14:	14 41 03 e0 	b	rret,#eq

00000018 <error>:
  18:	0d 40 00 00 	wl16	r0,0x0
  1c:	0d 60 00 02 	wh16	r0,0x2
  20:	0e c0 00 20 	lil	r1,0
  24:	10 a0 00 20 	st32	r1,r0
  28:	0d 40 00 0c 	wl16	r0,0xc
  2c:	0d 60 00 02 	wh16	r0,0x2
  30:	10 a0 00 40 	st32	r2,r0
  34:	0d 40 00 08 	wl16	r0,0x8
  38:	0d 60 00 02 	wh16	r0,0x2
  3c:	10 a0 00 60 	st32	r3,r0
  40:	0d 40 00 10 	wl16	r0,0x10
  44:	0d 60 00 02 	wh16	r0,0x2
  48:	10 a0 01 00 	st32	r8,r0
  4c:	0d 40 00 14 	wl16	r0,0x14
  50:	0d 60 00 02 	wh16	r0,0x2
  54:	10 a0 01 20 	st32	r9,r0

00000058 <finish>:
  58:	0d 40 00 04 	wl16	r0,0x4
  5c:	0d 60 00 02 	wh16	r0,0x2
  60:	0e c0 00 21 	lil	r1,1
  64:	10 a0 00 20 	st32	r1,r0
  68:	14 30 00 00 	br	68 <finish+0x10>,#al

0000006c <check>:
  6c:	0c 40 00 42 	xor	r2,r2
  70:	0c 40 00 63 	xor	r3,r3
  74:	0d 40 01 00 	wl16	r8,0x0
  78:	0d 60 01 03 	wh16	r8,0x3
  7c:	10 40 01 08 	ld32	r8,r8
  80:	0d 40 12 14 	wl16	r16,0x94
  84:	0d 60 02 03 	wh16	r16,0x3
  88:	10 40 02 10 	ld32	r16,r16
  8c:	0d 40 25 28 	wl16	r9,0x128
  90:	0d 60 01 23 	wh16	r9,0x3
  94:	10 40 01 29 	ld32	r9,r9
  98:	00 60 01 10 	mulh	r8,r16
  9c:	20 70 03 e2 	movepc	rret,8
  a0:	14 30 ff dc 	br	10 <compare>,#al
  a4:	00 10 00 41 	add	r2,1
  a8:	0d 40 01 04 	wl16	r8,0x4
  ac:	0d 60 01 03 	wh16	r8,0x3
  b0:	10 40 01 08 	ld32	r8,r8
  b4:	0d 40 12 18 	wl16	r16,0x98
  b8:	0d 60 02 03 	wh16	r16,0x3
  bc:	10 40 02 10 	ld32	r16,r16
  c0:	0d 40 25 2c 	wl16	r9,0x12c
  c4:	0d 60 01 23 	wh16	r9,0x3
  c8:	10 40 01 29 	ld32	r9,r9
  cc:	00 60 01 10 	mulh	r8,r16
  d0:	20 70 03 e2 	movepc	rret,8
  d4:	14 30 ff cf 	br	10 <compare>,#al
  d8:	00 10 00 41 	add	r2,1
  dc:	0d 40 01 08 	wl16	r8,0x8
  e0:	0d 60 01 03 	wh16	r8,0x3
  e4:	10 40 01 08 	ld32	r8,r8
  e8:	0d 40 12 1c 	wl16	r16,0x9c
  ec:	0d 60 02 03 	wh16	r16,0x3
  f0:	10 40 02 10 	ld32	r16,r16
  f4:	0d 40 25 30 	wl16	r9,0x130
  f8:	0d 60 01 23 	wh16	r9,0x3
  fc:	10 40 01 29 	ld32	r9,r9
 100:	00 60 01 10 	mulh	r8,r16
 104:	20 70 03 e2 	movepc	rret,8
 108:	14 30 ff c2 	br	10 <compare>,#al
 10c:	00 10 00 41 	add	r2,1
 110:	0d 40 01 0c 	wl16	r8,0xc
 114:	0d 60 01 03 	wh16	r8,0x3
 118:	10 40 01 08 	ld32	r8,r8
 11c:	0d 40 16 00 	wl16	r16,0xa0
 120:	0d 60 02 03 	wh16	r16,0x3
 124:	10 40 02 10 	ld32	r16,r16
 128:	0d 40 25 34 	wl16	r9,0x134
 12c:	0d 60 01 23 	wh16	r9,0x3
 130:	10 40 01 29 	ld32	r9,r9
 134:	00 60 01 10 	mulh	r8,r16
 138:	20 70 03 e2 	movepc	rret,8
 13c:	14 30 ff b5 	br	10 <compare>,#al
 140:	00 10 00 41 	add	r2,1
 144:	0d 40 01 10 	wl16	r8,0x10
 148:	0d 60 01 03 	wh16	r8,0x3
 14c:	10 40 01 08 	ld32	r8,r8
 150:	0d 40 16 04 	wl16	r16,0xa4
 154:	0d 60 02 03 	wh16	r16,0x3
 158:	10 40 02 10 	ld32	r16,r16
 15c:	0d 40 25 38 	wl16	r9,0x138
 160:	0d 60 01 23 	wh16	r9,0x3
 164:	10 40 01 29 	ld32	r9,r9
 168:	00 60 01 10 	mulh	r8,r16
 16c:	20 70 03 e2 	movepc	rret,8
 170:	14 30 ff a8 	br	10 <compare>,#al
 174:	00 10 00 41 	add	r2,1
 178:	0d 40 01 14 	wl16	r8,0x14
 17c:	0d 60 01 03 	wh16	r8,0x3
 180:	10 40 01 08 	ld32	r8,r8
 184:	0d 40 16 08 	wl16	r16,0xa8
 188:	0d 60 02 03 	wh16	r16,0x3
 18c:	10 40 02 10 	ld32	r16,r16
 190:	0d 40 25 3c 	wl16	r9,0x13c
 194:	0d 60 01 23 	wh16	r9,0x3
 198:	10 40 01 29 	ld32	r9,r9
 19c:	00 60 01 10 	mulh	r8,r16
 1a0:	20 70 03 e2 	movepc	rret,8
 1a4:	14 30 ff 9b 	br	10 <compare>,#al
 1a8:	00 10 00 41 	add	r2,1
 1ac:	0d 40 01 18 	wl16	r8,0x18
 1b0:	0d 60 01 03 	wh16	r8,0x3
 1b4:	10 40 01 08 	ld32	r8,r8
 1b8:	0d 40 16 0c 	wl16	r16,0xac
 1bc:	0d 60 02 03 	wh16	r16,0x3
 1c0:	10 40 02 10 	ld32	r16,r16
 1c4:	0d 40 29 20 	wl16	r9,0x140
 1c8:	0d 60 01 23 	wh16	r9,0x3
 1cc:	10 40 01 29 	ld32	r9,r9
 1d0:	00 60 01 10 	mulh	r8,r16
 1d4:	20 70 03 e2 	movepc	rret,8
 1d8:	14 30 ff 8e 	br	10 <compare>,#al
 1dc:	00 10 00 41 	add	r2,1
 1e0:	0d 40 01 1c 	wl16	r8,0x1c
 1e4:	0d 60 01 03 	wh16	r8,0x3
 1e8:	10 40 01 08 	ld32	r8,r8
 1ec:	0d 40 16 10 	wl16	r16,0xb0
 1f0:	0d 60 02 03 	wh16	r16,0x3
 1f4:	10 40 02 10 	ld32	r16,r16
 1f8:	0d 40 29 24 	wl16	r9,0x144
 1fc:	0d 60 01 23 	wh16	r9,0x3
 200:	10 40 01 29 	ld32	r9,r9
 204:	00 60 01 10 	mulh	r8,r16
 208:	20 70 03 e2 	movepc	rret,8
 20c:	14 30 ff 81 	br	10 <compare>,#al
 210:	00 10 00 41 	add	r2,1
 214:	0d 40 05 00 	wl16	r8,0x20
 218:	0d 60 01 03 	wh16	r8,0x3
 21c:	10 40 01 08 	ld32	r8,r8
 220:	0d 40 16 14 	wl16	r16,0xb4
 224:	0d 60 02 03 	wh16	r16,0x3
 228:	10 40 02 10 	ld32	r16,r16
 22c:	0d 40 29 28 	wl16	r9,0x148
 230:	0d 60 01 23 	wh16	r9,0x3
 234:	10 40 01 29 	ld32	r9,r9
 238:	00 60 01 10 	mulh	r8,r16
 23c:	20 70 03 e2 	movepc	rret,8
 240:	14 30 ff 74 	br	10 <compare>,#al
 244:	00 10 00 41 	add	r2,1
 248:	0d 40 05 04 	wl16	r8,0x24
 24c:	0d 60 01 03 	wh16	r8,0x3
 250:	10 40 01 08 	ld32	r8,r8
 254:	0d 40 16 18 	wl16	r16,0xb8
 258:	0d 60 02 03 	wh16	r16,0x3
 25c:	10 40 02 10 	ld32	r16,r16
 260:	0d 40 29 2c 	wl16	r9,0x14c
 264:	0d 60 01 23 	wh16	r9,0x3
 268:	10 40 01 29 	ld32	r9,r9
 26c:	00 60 01 10 	mulh	r8,r16
 270:	20 70 03 e2 	movepc	rret,8
 274:	14 30 ff 67 	br	10 <compare>,#al
 278:	00 10 00 41 	add	r2,1
 27c:	0d 40 05 08 	wl16	r8,0x28
 280:	0d 60 01 03 	wh16	r8,0x3
 284:	10 40 01 08 	ld32	r8,r8
 288:	0d 40 16 1c 	wl16	r16,0xbc
 28c:	0d 60 02 03 	wh16	r16,0x3
 290:	10 40 02 10 	ld32	r16,r16
 294:	0d 40 29 30 	wl16	r9,0x150
 298:	0d 60 01 23 	wh16	r9,0x3
 29c:	10 40 01 29 	ld32	r9,r9
 2a0:	00 60 01 10 	mulh	r8,r16
 2a4:	20 70 03 e2 	movepc	rret,8
 2a8:	14 30 ff 5a 	br	10 <compare>,#al
 2ac:	00 10 00 41 	add	r2,1
 2b0:	0d 40 05 0c 	wl16	r8,0x2c
 2b4:	0d 60 01 03 	wh16	r8,0x3
 2b8:	10 40 01 08 	ld32	r8,r8
 2bc:	0d 40 1a 00 	wl16	r16,0xc0
 2c0:	0d 60 02 03 	wh16	r16,0x3
 2c4:	10 40 02 10 	ld32	r16,r16
 2c8:	0d 40 29 34 	wl16	r9,0x154
 2cc:	0d 60 01 23 	wh16	r9,0x3
 2d0:	10 40 01 29 	ld32	r9,r9
 2d4:	00 60 01 10 	mulh	r8,r16
 2d8:	20 70 03 e2 	movepc	rret,8
 2dc:	14 30 ff 4d 	br	10 <compare>,#al
 2e0:	00 10 00 41 	add	r2,1
 2e4:	0d 40 05 10 	wl16	r8,0x30
 2e8:	0d 60 01 03 	wh16	r8,0x3
 2ec:	10 40 01 08 	ld32	r8,r8
 2f0:	0d 40 1a 04 	wl16	r16,0xc4
 2f4:	0d 60 02 03 	wh16	r16,0x3
 2f8:	10 40 02 10 	ld32	r16,r16
 2fc:	0d 40 29 38 	wl16	r9,0x158
 300:	0d 60 01 23 	wh16	r9,0x3
 304:	10 40 01 29 	ld32	r9,r9
 308:	00 60 01 10 	mulh	r8,r16
 30c:	20 70 03 e2 	movepc	rret,8
 310:	14 30 ff 40 	br	10 <compare>,#al
 314:	00 10 00 41 	add	r2,1
 318:	0d 40 05 14 	wl16	r8,0x34
 31c:	0d 60 01 03 	wh16	r8,0x3
 320:	10 40 01 08 	ld32	r8,r8
 324:	0d 40 1a 08 	wl16	r16,0xc8
 328:	0d 60 02 03 	wh16	r16,0x3
 32c:	10 40 02 10 	ld32	r16,r16
 330:	0d 40 29 3c 	wl16	r9,0x15c
 334:	0d 60 01 23 	wh16	r9,0x3
 338:	10 40 01 29 	ld32	r9,r9
 33c:	00 60 01 10 	mulh	r8,r16
 340:	20 70 03 e2 	movepc	rret,8
 344:	14 30 ff 33 	br	10 <compare>,#al
 348:	00 10 00 41 	add	r2,1
 34c:	0d 40 05 18 	wl16	r8,0x38
 350:	0d 60 01 03 	wh16	r8,0x3
 354:	10 40 01 08 	ld32	r8,r8
 358:	0d 40 1a 0c 	wl16	r16,0xcc
 35c:	0d 60 02 03 	wh16	r16,0x3
 360:	10 40 02 10 	ld32	r16,r16
 364:	0d 40 2d 20 	wl16	r9,0x160
 368:	0d 60 01 23 	wh16	r9,0x3
 36c:	10 40 01 29 	ld32	r9,r9
 370:	00 60 01 10 	mulh	r8,r16
 374:	20 70 03 e2 	movepc	rret,8
 378:	14 30 ff 26 	br	10 <compare>,#al
 37c:	00 10 00 41 	add	r2,1
 380:	0d 40 05 1c 	wl16	r8,0x3c
 384:	0d 60 01 03 	wh16	r8,0x3
 388:	10 40 01 08 	ld32	r8,r8
 38c:	0d 40 1a 10 	wl16	r16,0xd0
 390:	0d 60 02 03 	wh16	r16,0x3
 394:	10 40 02 10 	ld32	r16,r16
 398:	0d 40 2d 24 	wl16	r9,0x164
 39c:	0d 60 01 23 	wh16	r9,0x3
 3a0:	10 40 01 29 	ld32	r9,r9
 3a4:	00 60 01 10 	mulh	r8,r16
 3a8:	20 70 03 e2 	movepc	rret,8
 3ac:	14 30 ff 19 	br	10 <compare>,#al
 3b0:	00 10 00 41 	add	r2,1
 3b4:	0d 40 09 00 	wl16	r8,0x40
 3b8:	0d 60 01 03 	wh16	r8,0x3
 3bc:	10 40 01 08 	ld32	r8,r8
 3c0:	0d 40 1a 14 	wl16	r16,0xd4
 3c4:	0d 60 02 03 	wh16	r16,0x3
 3c8:	10 40 02 10 	ld32	r16,r16
 3cc:	0d 40 2d 28 	wl16	r9,0x168
 3d0:	0d 60 01 23 	wh16	r9,0x3
 3d4:	10 40 01 29 	ld32	r9,r9
 3d8:	00 60 01 10 	mulh	r8,r16
 3dc:	20 70 03 e2 	movepc	rret,8
 3e0:	14 30 ff 0c 	br	10 <compare>,#al
 3e4:	00 10 00 41 	add	r2,1
 3e8:	0d 40 09 04 	wl16	r8,0x44
 3ec:	0d 60 01 03 	wh16	r8,0x3
 3f0:	10 40 01 08 	ld32	r8,r8
 3f4:	0d 40 1a 18 	wl16	r16,0xd8
 3f8:	0d 60 02 03 	wh16	r16,0x3
 3fc:	10 40 02 10 	ld32	r16,r16
 400:	0d 40 2d 2c 	wl16	r9,0x16c
 404:	0d 60 01 23 	wh16	r9,0x3
 408:	10 40 01 29 	ld32	r9,r9
 40c:	00 60 01 10 	mulh	r8,r16
 410:	20 70 03 e2 	movepc	rret,8
 414:	14 30 fe ff 	br	10 <compare>,#al
 418:	00 10 00 41 	add	r2,1
 41c:	0d 40 09 08 	wl16	r8,0x48
 420:	0d 60 01 03 	wh16	r8,0x3
 424:	10 40 01 08 	ld32	r8,r8
 428:	0d 40 1a 1c 	wl16	r16,0xdc
 42c:	0d 60 02 03 	wh16	r16,0x3
 430:	10 40 02 10 	ld32	r16,r16
 434:	0d 40 2d 30 	wl16	r9,0x170
 438:	0d 60 01 23 	wh16	r9,0x3
 43c:	10 40 01 29 	ld32	r9,r9
 440:	00 60 01 10 	mulh	r8,r16
 444:	20 70 03 e2 	movepc	rret,8
 448:	14 30 fe f2 	br	10 <compare>,#al
 44c:	00 10 00 41 	add	r2,1
 450:	0d 40 09 0c 	wl16	r8,0x4c
 454:	0d 60 01 03 	wh16	r8,0x3
 458:	10 40 01 08 	ld32	r8,r8
 45c:	0d 40 1e 00 	wl16	r16,0xe0
 460:	0d 60 02 03 	wh16	r16,0x3
 464:	10 40 02 10 	ld32	r16,r16
 468:	0d 40 2d 34 	wl16	r9,0x174
 46c:	0d 60 01 23 	wh16	r9,0x3
 470:	10 40 01 29 	ld32	r9,r9
 474:	00 60 01 10 	mulh	r8,r16
 478:	20 70 03 e2 	movepc	rret,8
 47c:	14 30 fe e5 	br	10 <compare>,#al
 480:	00 10 00 41 	add	r2,1
 484:	0d 40 09 10 	wl16	r8,0x50
 488:	0d 60 01 03 	wh16	r8,0x3
 48c:	10 40 01 08 	ld32	r8,r8
 490:	0d 40 1e 04 	wl16	r16,0xe4
 494:	0d 60 02 03 	wh16	r16,0x3
 498:	10 40 02 10 	ld32	r16,r16
 49c:	0d 40 2d 38 	wl16	r9,0x178
 4a0:	0d 60 01 23 	wh16	r9,0x3
 4a4:	10 40 01 29 	ld32	r9,r9
 4a8:	00 60 01 10 	mulh	r8,r16
 4ac:	20 70 03 e2 	movepc	rret,8
 4b0:	14 30 fe d8 	br	10 <compare>,#al
 4b4:	00 10 00 41 	add	r2,1
 4b8:	0d 40 09 14 	wl16	r8,0x54
 4bc:	0d 60 01 03 	wh16	r8,0x3
 4c0:	10 40 01 08 	ld32	r8,r8
 4c4:	0d 40 1e 08 	wl16	r16,0xe8
 4c8:	0d 60 02 03 	wh16	r16,0x3
 4cc:	10 40 02 10 	ld32	r16,r16
 4d0:	0d 40 2d 3c 	wl16	r9,0x17c
 4d4:	0d 60 01 23 	wh16	r9,0x3
 4d8:	10 40 01 29 	ld32	r9,r9
 4dc:	00 60 01 10 	mulh	r8,r16
 4e0:	20 70 03 e2 	movepc	rret,8
 4e4:	14 30 fe cb 	br	10 <compare>,#al
 4e8:	00 10 00 41 	add	r2,1
 4ec:	0d 40 09 18 	wl16	r8,0x58
 4f0:	0d 60 01 03 	wh16	r8,0x3
 4f4:	10 40 01 08 	ld32	r8,r8
 4f8:	0d 40 1e 0c 	wl16	r16,0xec
 4fc:	0d 60 02 03 	wh16	r16,0x3
 500:	10 40 02 10 	ld32	r16,r16
 504:	0d 40 31 20 	wl16	r9,0x180
 508:	0d 60 01 23 	wh16	r9,0x3
 50c:	10 40 01 29 	ld32	r9,r9
 510:	00 60 01 10 	mulh	r8,r16
 514:	20 70 03 e2 	movepc	rret,8
 518:	14 30 fe be 	br	10 <compare>,#al
 51c:	00 10 00 41 	add	r2,1
 520:	0d 40 09 1c 	wl16	r8,0x5c
 524:	0d 60 01 03 	wh16	r8,0x3
 528:	10 40 01 08 	ld32	r8,r8
 52c:	0d 40 1e 10 	wl16	r16,0xf0
 530:	0d 60 02 03 	wh16	r16,0x3
 534:	10 40 02 10 	ld32	r16,r16
 538:	0d 40 31 24 	wl16	r9,0x184
 53c:	0d 60 01 23 	wh16	r9,0x3
 540:	10 40 01 29 	ld32	r9,r9
 544:	00 60 01 10 	mulh	r8,r16
 548:	20 70 03 e2 	movepc	rret,8
 54c:	14 30 fe b1 	br	10 <compare>,#al
 550:	00 10 00 41 	add	r2,1
 554:	0d 40 0d 00 	wl16	r8,0x60
 558:	0d 60 01 03 	wh16	r8,0x3
 55c:	10 40 01 08 	ld32	r8,r8
 560:	0d 40 1e 14 	wl16	r16,0xf4
 564:	0d 60 02 03 	wh16	r16,0x3
 568:	10 40 02 10 	ld32	r16,r16
 56c:	0d 40 31 28 	wl16	r9,0x188
 570:	0d 60 01 23 	wh16	r9,0x3
 574:	10 40 01 29 	ld32	r9,r9
 578:	00 60 01 10 	mulh	r8,r16
 57c:	20 70 03 e2 	movepc	rret,8
 580:	14 30 fe a4 	br	10 <compare>,#al
 584:	00 10 00 41 	add	r2,1
 588:	0d 40 0d 04 	wl16	r8,0x64
 58c:	0d 60 01 03 	wh16	r8,0x3
 590:	10 40 01 08 	ld32	r8,r8
 594:	0d 40 1e 18 	wl16	r16,0xf8
 598:	0d 60 02 03 	wh16	r16,0x3
 59c:	10 40 02 10 	ld32	r16,r16
 5a0:	0d 40 31 2c 	wl16	r9,0x18c
 5a4:	0d 60 01 23 	wh16	r9,0x3
 5a8:	10 40 01 29 	ld32	r9,r9
 5ac:	00 60 01 10 	mulh	r8,r16
 5b0:	20 70 03 e2 	movepc	rret,8
 5b4:	14 30 fe 97 	br	10 <compare>,#al
 5b8:	00 10 00 41 	add	r2,1
 5bc:	0d 40 0d 08 	wl16	r8,0x68
 5c0:	0d 60 01 03 	wh16	r8,0x3
 5c4:	10 40 01 08 	ld32	r8,r8
 5c8:	0d 40 1e 1c 	wl16	r16,0xfc
 5cc:	0d 60 02 03 	wh16	r16,0x3
 5d0:	10 40 02 10 	ld32	r16,r16
 5d4:	0d 40 31 30 	wl16	r9,0x190
 5d8:	0d 60 01 23 	wh16	r9,0x3
 5dc:	10 40 01 29 	ld32	r9,r9
 5e0:	00 60 01 10 	mulh	r8,r16
 5e4:	20 70 03 e2 	movepc	rret,8
 5e8:	14 30 fe 8a 	br	10 <compare>,#al
 5ec:	00 10 00 41 	add	r2,1
 5f0:	0d 40 0d 0c 	wl16	r8,0x6c
 5f4:	0d 60 01 03 	wh16	r8,0x3
 5f8:	10 40 01 08 	ld32	r8,r8
 5fc:	0d 40 22 00 	wl16	r16,0x100
 600:	0d 60 02 03 	wh16	r16,0x3
 604:	10 40 02 10 	ld32	r16,r16
 608:	0d 40 31 34 	wl16	r9,0x194
 60c:	0d 60 01 23 	wh16	r9,0x3
 610:	10 40 01 29 	ld32	r9,r9
 614:	00 60 01 10 	mulh	r8,r16
 618:	20 70 03 e2 	movepc	rret,8
 61c:	14 30 fe 7d 	br	10 <compare>,#al
 620:	00 10 00 41 	add	r2,1
 624:	0d 40 0d 10 	wl16	r8,0x70
 628:	0d 60 01 03 	wh16	r8,0x3
 62c:	10 40 01 08 	ld32	r8,r8
 630:	0d 40 22 04 	wl16	r16,0x104
 634:	0d 60 02 03 	wh16	r16,0x3
 638:	10 40 02 10 	ld32	r16,r16
 63c:	0d 40 31 38 	wl16	r9,0x198
 640:	0d 60 01 23 	wh16	r9,0x3
 644:	10 40 01 29 	ld32	r9,r9
 648:	00 60 01 10 	mulh	r8,r16
 64c:	20 70 03 e2 	movepc	rret,8
 650:	14 30 fe 70 	br	10 <compare>,#al
 654:	00 10 00 41 	add	r2,1
 658:	0d 40 0d 14 	wl16	r8,0x74
 65c:	0d 60 01 03 	wh16	r8,0x3
 660:	10 40 01 08 	ld32	r8,r8
 664:	0d 40 22 08 	wl16	r16,0x108
 668:	0d 60 02 03 	wh16	r16,0x3
 66c:	10 40 02 10 	ld32	r16,r16
 670:	0d 40 31 3c 	wl16	r9,0x19c
 674:	0d 60 01 23 	wh16	r9,0x3
 678:	10 40 01 29 	ld32	r9,r9
 67c:	00 60 01 10 	mulh	r8,r16
 680:	20 70 03 e2 	movepc	rret,8
 684:	14 30 fe 63 	br	10 <compare>,#al
 688:	00 10 00 41 	add	r2,1
 68c:	0d 40 0d 18 	wl16	r8,0x78
 690:	0d 60 01 03 	wh16	r8,0x3
 694:	10 40 01 08 	ld32	r8,r8
 698:	0d 40 22 0c 	wl16	r16,0x10c
 69c:	0d 60 02 03 	wh16	r16,0x3
 6a0:	10 40 02 10 	ld32	r16,r16
 6a4:	0d 40 35 20 	wl16	r9,0x1a0
 6a8:	0d 60 01 23 	wh16	r9,0x3
 6ac:	10 40 01 29 	ld32	r9,r9
 6b0:	00 60 01 10 	mulh	r8,r16
 6b4:	20 70 03 e2 	movepc	rret,8
 6b8:	14 30 fe 56 	br	10 <compare>,#al
 6bc:	00 10 00 41 	add	r2,1
 6c0:	0d 40 0d 1c 	wl16	r8,0x7c
 6c4:	0d 60 01 03 	wh16	r8,0x3
 6c8:	10 40 01 08 	ld32	r8,r8
 6cc:	0d 40 22 10 	wl16	r16,0x110
 6d0:	0d 60 02 03 	wh16	r16,0x3
 6d4:	10 40 02 10 	ld32	r16,r16
 6d8:	0d 40 35 24 	wl16	r9,0x1a4
 6dc:	0d 60 01 23 	wh16	r9,0x3
 6e0:	10 40 01 29 	ld32	r9,r9
 6e4:	00 60 01 10 	mulh	r8,r16
 6e8:	20 70 03 e2 	movepc	rret,8
 6ec:	14 30 fe 49 	br	10 <compare>,#al
 6f0:	00 10 00 41 	add	r2,1
 6f4:	0d 40 11 00 	wl16	r8,0x80
 6f8:	0d 60 01 03 	wh16	r8,0x3
 6fc:	10 40 01 08 	ld32	r8,r8
 700:	0d 40 22 14 	wl16	r16,0x114
 704:	0d 60 02 03 	wh16	r16,0x3
 708:	10 40 02 10 	ld32	r16,r16
 70c:	0d 40 35 28 	wl16	r9,0x1a8
 710:	0d 60 01 23 	wh16	r9,0x3
 714:	10 40 01 29 	ld32	r9,r9
 718:	00 60 01 10 	mulh	r8,r16
 71c:	20 70 03 e2 	movepc	rret,8
 720:	14 30 fe 3c 	br	10 <compare>,#al
 724:	00 10 00 41 	add	r2,1
 728:	0d 40 11 04 	wl16	r8,0x84
 72c:	0d 60 01 03 	wh16	r8,0x3
 730:	10 40 01 08 	ld32	r8,r8
 734:	0d 40 22 18 	wl16	r16,0x118
 738:	0d 60 02 03 	wh16	r16,0x3
 73c:	10 40 02 10 	ld32	r16,r16
 740:	0d 40 35 2c 	wl16	r9,0x1ac
 744:	0d 60 01 23 	wh16	r9,0x3
 748:	10 40 01 29 	ld32	r9,r9
 74c:	00 60 01 10 	mulh	r8,r16
 750:	20 70 03 e2 	movepc	rret,8
 754:	14 30 fe 2f 	br	10 <compare>,#al
 758:	00 10 00 41 	add	r2,1
 75c:	0d 40 11 08 	wl16	r8,0x88
 760:	0d 60 01 03 	wh16	r8,0x3
 764:	10 40 01 08 	ld32	r8,r8
 768:	0d 40 22 1c 	wl16	r16,0x11c
 76c:	0d 60 02 03 	wh16	r16,0x3
 770:	10 40 02 10 	ld32	r16,r16
 774:	0d 40 35 30 	wl16	r9,0x1b0
 778:	0d 60 01 23 	wh16	r9,0x3
 77c:	10 40 01 29 	ld32	r9,r9
 780:	00 60 01 10 	mulh	r8,r16
 784:	20 70 03 e2 	movepc	rret,8
 788:	14 30 fe 22 	br	10 <compare>,#al
 78c:	00 10 00 41 	add	r2,1
 790:	0d 40 11 0c 	wl16	r8,0x8c
 794:	0d 60 01 03 	wh16	r8,0x3
 798:	10 40 01 08 	ld32	r8,r8
 79c:	0d 40 26 00 	wl16	r16,0x120
 7a0:	0d 60 02 03 	wh16	r16,0x3
 7a4:	10 40 02 10 	ld32	r16,r16
 7a8:	0d 40 35 34 	wl16	r9,0x1b4
 7ac:	0d 60 01 23 	wh16	r9,0x3
 7b0:	10 40 01 29 	ld32	r9,r9
 7b4:	00 60 01 10 	mulh	r8,r16
 7b8:	20 70 03 e2 	movepc	rret,8
 7bc:	14 30 fe 15 	br	10 <compare>,#al
 7c0:	00 10 00 41 	add	r2,1
 7c4:	0d 40 11 10 	wl16	r8,0x90
 7c8:	0d 60 01 03 	wh16	r8,0x3
 7cc:	10 40 01 08 	ld32	r8,r8
 7d0:	0d 40 26 04 	wl16	r16,0x124
 7d4:	0d 60 02 03 	wh16	r16,0x3
 7d8:	10 40 02 10 	ld32	r16,r16
 7dc:	0d 40 35 38 	wl16	r9,0x1b8
 7e0:	0d 60 01 23 	wh16	r9,0x3
 7e4:	10 40 01 29 	ld32	r9,r9
 7e8:	00 60 01 10 	mulh	r8,r16
 7ec:	20 70 03 e2 	movepc	rret,8
 7f0:	14 30 fe 08 	br	10 <compare>,#al
 7f4:	00 10 00 41 	add	r2,1
 7f8:	0c 40 00 42 	xor	r2,r2
 7fc:	00 10 00 61 	add	r3,1
 800:	0d 40 35 1c 	wl16	r8,0x1bc
 804:	0d 60 01 03 	wh16	r8,0x3
 808:	10 40 01 08 	ld32	r8,r8
 80c:	0d 40 41 34 	wl16	r9,0x214
 810:	0d 60 01 23 	wh16	r9,0x3
 814:	10 40 01 29 	ld32	r9,r9
 818:	00 70 01 01 	mulh	r8,1
 81c:	20 70 03 e2 	movepc	rret,8
 820:	14 30 fd fc 	br	10 <compare>,#al
 824:	00 10 00 41 	add	r2,1
 828:	0d 40 39 00 	wl16	r8,0x1c0
 82c:	0d 60 01 03 	wh16	r8,0x3
 830:	10 40 01 08 	ld32	r8,r8
 834:	0d 40 41 38 	wl16	r9,0x218
 838:	0d 60 01 23 	wh16	r9,0x3
 83c:	10 40 01 29 	ld32	r9,r9
 840:	00 70 41 00 	mulh	r8,512
 844:	20 70 03 e2 	movepc	rret,8
 848:	14 30 fd f2 	br	10 <compare>,#al
 84c:	00 10 00 41 	add	r2,1
 850:	0d 40 39 04 	wl16	r8,0x1c4
 854:	0d 60 01 03 	wh16	r8,0x3
 858:	10 40 01 08 	ld32	r8,r8
 85c:	0d 40 41 3c 	wl16	r9,0x21c
 860:	0d 60 01 23 	wh16	r9,0x3
 864:	10 40 01 29 	ld32	r9,r9
 868:	00 70 81 00 	mulh	r8,-1024
 86c:	20 70 03 e2 	movepc	rret,8
 870:	14 30 fd e8 	br	10 <compare>,#al
 874:	00 10 00 41 	add	r2,1
 878:	0d 40 39 08 	wl16	r8,0x1c8
 87c:	0d 60 01 03 	wh16	r8,0x3
 880:	10 40 01 08 	ld32	r8,r8
 884:	0d 40 45 20 	wl16	r9,0x220
 888:	0d 60 01 23 	wh16	r9,0x3
 88c:	10 40 01 29 	ld32	r9,r9
 890:	00 70 01 01 	mulh	r8,1
 894:	20 70 03 e2 	movepc	rret,8
 898:	14 30 fd de 	br	10 <compare>,#al
 89c:	00 10 00 41 	add	r2,1
 8a0:	0d 40 39 0c 	wl16	r8,0x1cc
 8a4:	0d 60 01 03 	wh16	r8,0x3
 8a8:	10 40 01 08 	ld32	r8,r8
 8ac:	0d 40 45 24 	wl16	r9,0x224
 8b0:	0d 60 01 23 	wh16	r9,0x3
 8b4:	10 40 01 29 	ld32	r9,r9
 8b8:	00 70 41 00 	mulh	r8,512
 8bc:	20 70 03 e2 	movepc	rret,8
 8c0:	14 30 fd d4 	br	10 <compare>,#al
 8c4:	00 10 00 41 	add	r2,1
 8c8:	0d 40 39 10 	wl16	r8,0x1d0
 8cc:	0d 60 01 03 	wh16	r8,0x3
 8d0:	10 40 01 08 	ld32	r8,r8
 8d4:	0d 40 45 28 	wl16	r9,0x228
 8d8:	0d 60 01 23 	wh16	r9,0x3
 8dc:	10 40 01 29 	ld32	r9,r9
 8e0:	00 70 81 00 	mulh	r8,-1024
 8e4:	20 70 03 e2 	movepc	rret,8
 8e8:	14 30 fd ca 	br	10 <compare>,#al
 8ec:	00 10 00 41 	add	r2,1
 8f0:	0d 40 39 14 	wl16	r8,0x1d4
 8f4:	0d 60 01 03 	wh16	r8,0x3
 8f8:	10 40 01 08 	ld32	r8,r8
 8fc:	0d 40 45 2c 	wl16	r9,0x22c
 900:	0d 60 01 23 	wh16	r9,0x3
 904:	10 40 01 29 	ld32	r9,r9
 908:	00 70 01 01 	mulh	r8,1
 90c:	20 70 03 e2 	movepc	rret,8
 910:	14 30 fd c0 	br	10 <compare>,#al
 914:	00 10 00 41 	add	r2,1
 918:	0d 40 39 18 	wl16	r8,0x1d8
 91c:	0d 60 01 03 	wh16	r8,0x3
 920:	10 40 01 08 	ld32	r8,r8
 924:	0d 40 45 30 	wl16	r9,0x230
 928:	0d 60 01 23 	wh16	r9,0x3
 92c:	10 40 01 29 	ld32	r9,r9
 930:	00 70 41 00 	mulh	r8,512
 934:	20 70 03 e2 	movepc	rret,8
 938:	14 30 fd b6 	br	10 <compare>,#al
 93c:	00 10 00 41 	add	r2,1
 940:	0d 40 39 1c 	wl16	r8,0x1dc
 944:	0d 60 01 03 	wh16	r8,0x3
 948:	10 40 01 08 	ld32	r8,r8
 94c:	0d 40 45 34 	wl16	r9,0x234
 950:	0d 60 01 23 	wh16	r9,0x3
 954:	10 40 01 29 	ld32	r9,r9
 958:	00 70 81 00 	mulh	r8,-1024
 95c:	20 70 03 e2 	movepc	rret,8
 960:	14 30 fd ac 	br	10 <compare>,#al
 964:	00 10 00 41 	add	r2,1
 968:	0d 40 3d 00 	wl16	r8,0x1e0
 96c:	0d 60 01 03 	wh16	r8,0x3
 970:	10 40 01 08 	ld32	r8,r8
 974:	0d 40 45 38 	wl16	r9,0x238
 978:	0d 60 01 23 	wh16	r9,0x3
 97c:	10 40 01 29 	ld32	r9,r9
 980:	00 70 01 01 	mulh	r8,1
 984:	20 70 03 e2 	movepc	rret,8
 988:	14 30 fd a2 	br	10 <compare>,#al
 98c:	00 10 00 41 	add	r2,1
 990:	0d 40 3d 04 	wl16	r8,0x1e4
 994:	0d 60 01 03 	wh16	r8,0x3
 998:	10 40 01 08 	ld32	r8,r8
 99c:	0d 40 45 3c 	wl16	r9,0x23c
 9a0:	0d 60 01 23 	wh16	r9,0x3
 9a4:	10 40 01 29 	ld32	r9,r9
 9a8:	00 70 41 00 	mulh	r8,512
 9ac:	20 70 03 e2 	movepc	rret,8
 9b0:	14 30 fd 98 	br	10 <compare>,#al
 9b4:	00 10 00 41 	add	r2,1
 9b8:	0d 40 3d 08 	wl16	r8,0x1e8
 9bc:	0d 60 01 03 	wh16	r8,0x3
 9c0:	10 40 01 08 	ld32	r8,r8
 9c4:	0d 40 49 20 	wl16	r9,0x240
 9c8:	0d 60 01 23 	wh16	r9,0x3
 9cc:	10 40 01 29 	ld32	r9,r9
 9d0:	00 70 81 00 	mulh	r8,-1024
 9d4:	20 70 03 e2 	movepc	rret,8
 9d8:	14 30 fd 8e 	br	10 <compare>,#al
 9dc:	00 10 00 41 	add	r2,1
 9e0:	0d 40 3d 0c 	wl16	r8,0x1ec
 9e4:	0d 60 01 03 	wh16	r8,0x3
 9e8:	10 40 01 08 	ld32	r8,r8
 9ec:	0d 40 49 24 	wl16	r9,0x244
 9f0:	0d 60 01 23 	wh16	r9,0x3
 9f4:	10 40 01 29 	ld32	r9,r9
 9f8:	00 70 01 03 	mulh	r8,3
 9fc:	20 70 03 e2 	movepc	rret,8
 a00:	14 30 fd 84 	br	10 <compare>,#al
 a04:	00 10 00 41 	add	r2,1
 a08:	0d 40 3d 10 	wl16	r8,0x1f0
 a0c:	0d 60 01 03 	wh16	r8,0x3
 a10:	10 40 01 08 	ld32	r8,r8
 a14:	0d 40 49 28 	wl16	r9,0x248
 a18:	0d 60 01 23 	wh16	r9,0x3
 a1c:	10 40 01 29 	ld32	r9,r9
 a20:	00 70 01 07 	mulh	r8,7
 a24:	20 70 03 e2 	movepc	rret,8
 a28:	14 30 fd 7a 	br	10 <compare>,#al
 a2c:	00 10 00 41 	add	r2,1
 a30:	0d 40 3d 14 	wl16	r8,0x1f4
 a34:	0d 60 01 03 	wh16	r8,0x3
 a38:	10 40 01 08 	ld32	r8,r8
 a3c:	0d 40 49 2c 	wl16	r9,0x24c
 a40:	0d 60 01 23 	wh16	r9,0x3
 a44:	10 40 01 29 	ld32	r9,r9
 a48:	00 70 01 0f 	mulh	r8,15
 a4c:	20 70 03 e2 	movepc	rret,8
 a50:	14 30 fd 70 	br	10 <compare>,#al
 a54:	00 10 00 41 	add	r2,1
 a58:	0d 40 3d 18 	wl16	r8,0x1f8
 a5c:	0d 60 01 03 	wh16	r8,0x3
 a60:	10 40 01 08 	ld32	r8,r8
 a64:	0d 40 49 30 	wl16	r9,0x250
 a68:	0d 60 01 23 	wh16	r9,0x3
 a6c:	10 40 01 29 	ld32	r9,r9
 a70:	00 70 01 1f 	mulh	r8,31
 a74:	20 70 03 e2 	movepc	rret,8
 a78:	14 30 fd 66 	br	10 <compare>,#al
 a7c:	00 10 00 41 	add	r2,1
 a80:	0d 40 3d 1c 	wl16	r8,0x1fc
 a84:	0d 60 01 03 	wh16	r8,0x3
 a88:	10 40 01 08 	ld32	r8,r8
 a8c:	0d 40 49 34 	wl16	r9,0x254
 a90:	0d 60 01 23 	wh16	r9,0x3
 a94:	10 40 01 29 	ld32	r9,r9
 a98:	00 70 05 1f 	mulh	r8,63
 a9c:	20 70 03 e2 	movepc	rret,8
 aa0:	14 30 fd 5c 	br	10 <compare>,#al
 aa4:	00 10 00 41 	add	r2,1
 aa8:	0d 40 41 00 	wl16	r8,0x200
 aac:	0d 60 01 03 	wh16	r8,0x3
 ab0:	10 40 01 08 	ld32	r8,r8
 ab4:	0d 40 49 38 	wl16	r9,0x258
 ab8:	0d 60 01 23 	wh16	r9,0x3
 abc:	10 40 01 29 	ld32	r9,r9
 ac0:	00 70 0d 1f 	mulh	r8,127
 ac4:	20 70 03 e2 	movepc	rret,8
 ac8:	14 30 fd 52 	br	10 <compare>,#al
 acc:	00 10 00 41 	add	r2,1
 ad0:	0d 40 41 04 	wl16	r8,0x204
 ad4:	0d 60 01 03 	wh16	r8,0x3
 ad8:	10 40 01 08 	ld32	r8,r8
 adc:	0d 40 49 3c 	wl16	r9,0x25c
 ae0:	0d 60 01 23 	wh16	r9,0x3
 ae4:	10 40 01 29 	ld32	r9,r9
 ae8:	00 70 1d 1f 	mulh	r8,255
 aec:	20 70 03 e2 	movepc	rret,8
 af0:	14 30 fd 48 	br	10 <compare>,#al
 af4:	00 10 00 41 	add	r2,1
 af8:	0d 40 41 08 	wl16	r8,0x208
 afc:	0d 60 01 03 	wh16	r8,0x3
 b00:	10 40 01 08 	ld32	r8,r8
 b04:	0d 40 4d 20 	wl16	r9,0x260
 b08:	0d 60 01 23 	wh16	r9,0x3
 b0c:	10 40 01 29 	ld32	r9,r9
 b10:	00 70 3d 1f 	mulh	r8,511
 b14:	20 70 03 e2 	movepc	rret,8
 b18:	14 30 fd 3e 	br	10 <compare>,#al
 b1c:	00 10 00 41 	add	r2,1
 b20:	0d 40 41 0c 	wl16	r8,0x20c
 b24:	0d 60 01 03 	wh16	r8,0x3
 b28:	10 40 01 08 	ld32	r8,r8
 b2c:	0d 40 4d 24 	wl16	r9,0x264
 b30:	0d 60 01 23 	wh16	r9,0x3
 b34:	10 40 01 29 	ld32	r9,r9
 b38:	00 70 7d 1f 	mulh	r8,1023
 b3c:	20 70 03 e2 	movepc	rret,8
 b40:	14 30 fd 34 	br	10 <compare>,#al
 b44:	00 10 00 41 	add	r2,1
 b48:	0d 40 41 10 	wl16	r8,0x210
 b4c:	0d 60 01 03 	wh16	r8,0x3
 b50:	10 40 01 08 	ld32	r8,r8
 b54:	0d 40 4d 28 	wl16	r9,0x268
 b58:	0d 60 01 23 	wh16	r9,0x3
 b5c:	10 40 01 29 	ld32	r9,r9
 b60:	00 70 fd 1f 	mulh	r8,-1
 b64:	20 70 03 e2 	movepc	rret,8
 b68:	14 30 fd 2a 	br	10 <compare>,#al
 b6c:	00 10 00 41 	add	r2,1
 b70:	14 30 fd 3a 	br	58 <finish>,#al

Disassembly of section .assert:

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

Disassembly of section .data:

00030000 <T_SRC0_0>:
   30000:	00 00 00 00 	add	r0,r0

00030004 <T_SRC0_1>:
   30004:	00 00 00 00 	add	r0,r0

00030008 <T_SRC0_2>:
   30008:	00 00 00 01 	add	r0,r1

0003000c <T_SRC0_3>:
   3000c:	00 00 00 01 	add	r0,r1

00030010 <T_SRC0_4>:
   30010:	80 00 00 00 	*unknown*

00030014 <T_SRC0_5>:
   30014:	80 00 00 00 	*unknown*

00030018 <T_SRC0_6>:
   30018:	00 00 00 03 	add	r0,r3

0003001c <T_SRC0_7>:
   3001c:	00 00 00 07 	add	r0,rtmp

00030020 <T_SRC0_8>:
   30020:	00 00 00 0f 	add	r0,r15

00030024 <T_SRC0_9>:
   30024:	00 00 00 1f 	add	r0,rret

00030028 <T_SRC0_10>:
   30028:	00 00 00 3f 	add	r1,rret

0003002c <T_SRC0_11>:
   3002c:	00 00 00 7f 	add	r3,rret

00030030 <T_SRC0_12>:
   30030:	00 00 00 ff 	add	rtmp,rret

00030034 <T_SRC0_13>:
   30034:	00 00 01 ff 	add	r15,rret

00030038 <T_SRC0_14>:
   30038:	00 00 03 ff 	add	rret,rret

0003003c <T_SRC0_15>:
   3003c:	00 00 07 ff 	*unknown*

00030040 <T_SRC0_16>:
   30040:	00 00 0f ff 	*unknown*

00030044 <T_SRC0_17>:
   30044:	00 00 1f ff 	*unknown*

00030048 <T_SRC0_18>:
   30048:	00 00 3f ff 	*unknown*

0003004c <T_SRC0_19>:
   3004c:	00 00 7f ff 	*unknown*

00030050 <T_SRC0_20>:
   30050:	00 00 ff ff 	*unknown*

00030054 <T_SRC0_21>:
   30054:	00 01 ff ff 	*unknown*

00030058 <T_SRC0_22>:
   30058:	00 03 ff ff 	*unknown*

0003005c <T_SRC0_23>:
   3005c:	00 07 ff ff 	*unknown*

00030060 <T_SRC0_24>:
   30060:	00 0f ff ff 	*unknown*

00030064 <T_SRC0_25>:
   30064:	00 1f ff ff 	*unknown*

00030068 <T_SRC0_26>:
   30068:	00 3f ff ff 	*unknown*

0003006c <T_SRC0_27>:
   3006c:	00 7f ff ff 	*unknown*

00030070 <T_SRC0_28>:
   30070:	00 ff ff ff 	*unknown*

00030074 <T_SRC0_29>:
   30074:	01 ff ff ff 	*unknown*

00030078 <T_SRC0_30>:
   30078:	03 ff ff ff 	*unknown*

0003007c <T_SRC0_31>:
   3007c:	07 ff ff ff 	*unknown*

00030080 <T_SRC0_32>:
   30080:	0f ff ff ff 	*unknown*

00030084 <T_SRC0_33>:
   30084:	1f ff ff ff 	*unknown*

00030088 <T_SRC0_34>:
   30088:	3f ff ff ff 	*unknown*

0003008c <T_SRC0_35>:
   3008c:	7f ff ff ff 	*unknown*

00030090 <T_SRC0_36>:
   30090:	ff ff ff ff 	*unknown*

00030094 <T_SRC1_0>:
   30094:	00 00 00 01 	add	r0,r1

00030098 <T_SRC1_1>:
   30098:	80 00 00 00 	*unknown*

0003009c <T_SRC1_2>:
   3009c:	00 00 00 01 	add	r0,r1

000300a0 <T_SRC1_3>:
   300a0:	80 00 00 00 	*unknown*

000300a4 <T_SRC1_4>:
   300a4:	00 00 00 01 	add	r0,r1

000300a8 <T_SRC1_5>:
   300a8:	80 00 00 00 	*unknown*

000300ac <T_SRC1_6>:
   300ac:	00 00 00 03 	add	r0,r3

000300b0 <T_SRC1_7>:
   300b0:	00 00 00 07 	add	r0,rtmp

000300b4 <T_SRC1_8>:
   300b4:	00 00 00 0f 	add	r0,r15

000300b8 <T_SRC1_9>:
   300b8:	00 00 00 1f 	add	r0,rret

000300bc <T_SRC1_10>:
   300bc:	00 00 00 3f 	add	r1,rret

000300c0 <T_SRC1_11>:
   300c0:	00 00 00 7f 	add	r3,rret

000300c4 <T_SRC1_12>:
   300c4:	00 00 00 ff 	add	rtmp,rret

000300c8 <T_SRC1_13>:
   300c8:	00 00 01 ff 	add	r15,rret

000300cc <T_SRC1_14>:
   300cc:	00 00 03 ff 	add	rret,rret

000300d0 <T_SRC1_15>:
   300d0:	00 00 07 ff 	*unknown*

000300d4 <T_SRC1_16>:
   300d4:	00 00 0f ff 	*unknown*

000300d8 <T_SRC1_17>:
   300d8:	00 00 1f ff 	*unknown*

000300dc <T_SRC1_18>:
   300dc:	00 00 3f ff 	*unknown*

000300e0 <T_SRC1_19>:
   300e0:	00 00 7f ff 	*unknown*

000300e4 <T_SRC1_20>:
   300e4:	00 00 ff ff 	*unknown*

000300e8 <T_SRC1_21>:
   300e8:	00 01 ff ff 	*unknown*

000300ec <T_SRC1_22>:
   300ec:	00 03 ff ff 	*unknown*

000300f0 <T_SRC1_23>:
   300f0:	00 07 ff ff 	*unknown*

000300f4 <T_SRC1_24>:
   300f4:	00 0f ff ff 	*unknown*

000300f8 <T_SRC1_25>:
   300f8:	00 1f ff ff 	*unknown*

000300fc <T_SRC1_26>:
   300fc:	00 3f ff ff 	*unknown*

00030100 <T_SRC1_27>:
   30100:	00 7f ff ff 	*unknown*

00030104 <T_SRC1_28>:
   30104:	00 ff ff ff 	*unknown*

00030108 <T_SRC1_29>:
   30108:	01 ff ff ff 	*unknown*

0003010c <T_SRC1_30>:
   3010c:	03 ff ff ff 	*unknown*

00030110 <T_SRC1_31>:
   30110:	07 ff ff ff 	*unknown*

00030114 <T_SRC1_32>:
   30114:	0f ff ff ff 	*unknown*

00030118 <T_SRC1_33>:
   30118:	1f ff ff ff 	*unknown*

0003011c <T_SRC1_34>:
   3011c:	3f ff ff ff 	*unknown*

00030120 <T_SRC1_35>:
   30120:	7f ff ff ff 	*unknown*

00030124 <T_SRC1_36>:
   30124:	ff ff ff ff 	*unknown*

00030128 <T_EXPECT0>:
   30128:	00 00 00 00 	add	r0,r0

0003012c <T_EXPECT1>:
   3012c:	00 00 00 00 	add	r0,r0

00030130 <T_EXPECT2>:
   30130:	00 00 00 00 	add	r0,r0

00030134 <T_EXPECT3>:
   30134:	00 00 00 00 	add	r0,r0

00030138 <T_EXPECT4>:
   30138:	00 00 00 00 	add	r0,r0

0003013c <T_EXPECT5>:
   3013c:	40 00 00 00 	*unknown*

00030140 <T_EXPECT6>:
   30140:	00 00 00 00 	add	r0,r0

00030144 <T_EXPECT7>:
   30144:	00 00 00 00 	add	r0,r0

00030148 <T_EXPECT8>:
   30148:	00 00 00 00 	add	r0,r0

0003014c <T_EXPECT9>:
   3014c:	00 00 00 00 	add	r0,r0

00030150 <T_EXPECT10>:
   30150:	00 00 00 00 	add	r0,r0

00030154 <T_EXPECT11>:
   30154:	00 00 00 00 	add	r0,r0

00030158 <T_EXPECT12>:
   30158:	00 00 00 00 	add	r0,r0

0003015c <T_EXPECT13>:
   3015c:	00 00 00 00 	add	r0,r0

00030160 <T_EXPECT14>:
   30160:	00 00 00 00 	add	r0,r0

00030164 <T_EXPECT15>:
   30164:	00 00 00 00 	add	r0,r0

00030168 <T_EXPECT16>:
   30168:	00 00 00 00 	add	r0,r0

0003016c <T_EXPECT17>:
   3016c:	00 00 00 00 	add	r0,r0

00030170 <T_EXPECT18>:
   30170:	00 00 00 00 	add	r0,r0

00030174 <T_EXPECT19>:
   30174:	00 00 00 00 	add	r0,r0

00030178 <T_EXPECT20>:
   30178:	00 00 00 00 	add	r0,r0

0003017c <T_EXPECT21>:
   3017c:	00 00 00 03 	add	r0,r3

00030180 <T_EXPECT22>:
   30180:	00 00 00 0f 	add	r0,r15

00030184 <T_EXPECT23>:
   30184:	00 00 00 3f 	add	r1,rret

00030188 <T_EXPECT24>:
   30188:	00 00 00 ff 	add	rtmp,rret

0003018c <T_EXPECT25>:
   3018c:	00 00 03 ff 	add	rret,rret

00030190 <T_EXPECT26>:
   30190:	00 00 0f ff 	*unknown*

00030194 <T_EXPECT27>:
   30194:	00 00 3f ff 	*unknown*

00030198 <T_EXPECT28>:
   30198:	00 00 ff ff 	*unknown*

0003019c <T_EXPECT29>:
   3019c:	00 03 ff ff 	*unknown*

000301a0 <T_EXPECT30>:
   301a0:	00 0f ff ff 	*unknown*

000301a4 <T_EXPECT31>:
   301a4:	00 3f ff ff 	*unknown*

000301a8 <T_EXPECT32>:
   301a8:	00 ff ff ff 	*unknown*

000301ac <T_EXPECT33>:
   301ac:	03 ff ff ff 	*unknown*

000301b0 <T_EXPECT34>:
   301b0:	0f ff ff ff 	*unknown*

000301b4 <T_EXPECT35>:
   301b4:	3f ff ff ff 	*unknown*

000301b8 <T_EXPECT36>:
   301b8:	ff ff ff fe 	*unknown*

000301bc <T_IMM_DST0>:
   301bc:	00 00 00 00 	add	r0,r0

000301c0 <T_IMM_DST1>:
   301c0:	00 00 00 00 	add	r0,r0

000301c4 <T_IMM_DST2>:
   301c4:	00 00 00 00 	add	r0,r0

000301c8 <T_IMM_DST3>:
   301c8:	00 00 00 01 	add	r0,r1

000301cc <T_IMM_DST4>:
   301cc:	00 00 00 01 	add	r0,r1

000301d0 <T_IMM_DST5>:
   301d0:	00 00 00 01 	add	r0,r1

000301d4 <T_IMM_DST6>:
   301d4:	00 00 02 00 	add	r16,r0

000301d8 <T_IMM_DST7>:
   301d8:	00 00 02 00 	add	r16,r0

000301dc <T_IMM_DST8>:
   301dc:	00 00 02 00 	add	r16,r0

000301e0 <T_IMM_DST9>:
   301e0:	00 00 04 00 	*unknown*

000301e4 <T_IMM_DST10>:
   301e4:	00 00 04 00 	*unknown*

000301e8 <T_IMM_DST11>:
   301e8:	00 00 04 00 	*unknown*

000301ec <T_IMM_DST12>:
   301ec:	00 00 00 03 	add	r0,r3

000301f0 <T_IMM_DST13>:
   301f0:	00 00 00 07 	add	r0,rtmp

000301f4 <T_IMM_DST14>:
   301f4:	00 00 00 0f 	add	r0,r15

000301f8 <T_IMM_DST15>:
   301f8:	00 00 00 1f 	add	r0,rret

000301fc <T_IMM_DST16>:
   301fc:	00 00 00 3f 	add	r1,rret

00030200 <T_IMM_DST17>:
   30200:	00 00 00 7f 	add	r3,rret

00030204 <T_IMM_DST18>:
   30204:	00 00 00 ff 	add	rtmp,rret

00030208 <T_IMM_DST19>:
   30208:	00 00 01 ff 	add	r15,rret

0003020c <T_IMM_DST20>:
   3020c:	00 00 03 ff 	add	rret,rret

00030210 <T_IMM_DST21>:
   30210:	00 00 07 ff 	*unknown*

00030214 <T_IMM_EXPECT0>:
   30214:	00 00 00 00 	add	r0,r0

00030218 <T_IMM_EXPECT1>:
   30218:	00 00 00 00 	add	r0,r0

0003021c <T_IMM_EXPECT2>:
   3021c:	00 00 00 00 	add	r0,r0

00030220 <T_IMM_EXPECT3>:
   30220:	00 00 00 00 	add	r0,r0

00030224 <T_IMM_EXPECT4>:
   30224:	00 00 00 00 	add	r0,r0

00030228 <T_IMM_EXPECT5>:
   30228:	00 00 00 00 	add	r0,r0

0003022c <T_IMM_EXPECT6>:
   3022c:	00 00 00 00 	add	r0,r0

00030230 <T_IMM_EXPECT7>:
   30230:	00 00 00 00 	add	r0,r0

00030234 <T_IMM_EXPECT8>:
   30234:	00 00 01 ff 	add	r15,rret

00030238 <T_IMM_EXPECT9>:
   30238:	00 00 00 00 	add	r0,r0

0003023c <T_IMM_EXPECT10>:
   3023c:	00 00 00 00 	add	r0,r0

00030240 <T_IMM_EXPECT11>:
   30240:	00 00 03 ff 	add	rret,rret

00030244 <T_IMM_EXPECT12>:
   30244:	00 00 00 00 	add	r0,r0

00030248 <T_IMM_EXPECT13>:
   30248:	00 00 00 00 	add	r0,r0

0003024c <T_IMM_EXPECT14>:
   3024c:	00 00 00 00 	add	r0,r0

00030250 <T_IMM_EXPECT15>:
   30250:	00 00 00 00 	add	r0,r0

00030254 <T_IMM_EXPECT16>:
   30254:	00 00 00 00 	add	r0,r0

00030258 <T_IMM_EXPECT17>:
   30258:	00 00 00 00 	add	r0,r0

0003025c <T_IMM_EXPECT18>:
   3025c:	00 00 00 00 	add	r0,r0

00030260 <T_IMM_EXPECT19>:
   30260:	00 00 00 00 	add	r0,r0

00030264 <T_IMM_EXPECT20>:
   30264:	00 00 00 00 	add	r0,r0

00030268 <T_IMM_EXPECT21>:
   30268:	00 00 07 fe 	*unknown*

Disassembly of section .stack:

000f0000 <STACK_INDEX>:
   f0000:	00 00 00 00 	add	r0,r0
