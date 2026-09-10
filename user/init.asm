
init:     formato del fichero elf32-littleriscv


Desensamblado de la sección .text:

00000000 <start>:
   0:	ff010113          	addi	sp,sp,-16
   4:	00112623          	sw	ra,12(sp)
   8:	00812423          	sw	s0,8(sp)
   c:	01010413          	addi	s0,sp,16
  10:	438000ef          	jal	448 <main>
  14:	3e0000ef          	jal	3f4 <exit>
  18:	00c12083          	lw	ra,12(sp)
  1c:	00812403          	lw	s0,8(sp)
  20:	01010113          	addi	sp,sp,16
  24:	00008067          	ret

00000028 <console_read_line>:
  28:	fe010113          	addi	sp,sp,-32
  2c:	00112e23          	sw	ra,28(sp)
  30:	00812c23          	sw	s0,24(sp)
  34:	00912a23          	sw	s1,20(sp)
  38:	01212823          	sw	s2,16(sp)
  3c:	01312623          	sw	s3,12(sp)
  40:	01412423          	sw	s4,8(sp)
  44:	01512223          	sw	s5,4(sp)
  48:	02010413          	addi	s0,sp,32
  4c:	7b000a93          	li	s5,1968
  50:	00000493          	li	s1,0
  54:	05b00913          	li	s2,91
  58:	00d00993          	li	s3,13
  5c:	06000a13          	li	s4,96
  60:	03248c63          	beq	s1,s2,98 <console_read_line+0x70>
  64:	3c0000ef          	jal	424 <console_getc>
  68:	03350263          	beq	a0,s3,8c <console_read_line+0x64>
  6c:	fe150793          	addi	a5,a0,-31
  70:	fefa68e3          	bltu	s4,a5,60 <console_read_line+0x38>
  74:	00aa8023          	sb	a0,0(s5)
  78:	000a8513          	mv	a0,s5
  7c:	390000ef          	jal	40c <console_puts>
  80:	00148493          	addi	s1,s1,1
  84:	001a8a93          	addi	s5,s5,1
  88:	fd9ff06f          	j	60 <console_read_line+0x38>
  8c:	7b000793          	li	a5,1968
  90:	009787b3          	add	a5,a5,s1
  94:	00078023          	sb	zero,0(a5)
  98:	7b000513          	li	a0,1968
  9c:	01c12083          	lw	ra,28(sp)
  a0:	01812403          	lw	s0,24(sp)
  a4:	01412483          	lw	s1,20(sp)
  a8:	01012903          	lw	s2,16(sp)
  ac:	00c12983          	lw	s3,12(sp)
  b0:	00812a03          	lw	s4,8(sp)
  b4:	00412a83          	lw	s5,4(sp)
  b8:	02010113          	addi	sp,sp,32
  bc:	00008067          	ret

000000c0 <memset>:
  c0:	ff010113          	addi	sp,sp,-16
  c4:	00812623          	sw	s0,12(sp)
  c8:	01010413          	addi	s0,sp,16
  cc:	00060c63          	beqz	a2,e4 <memset+0x24>
  d0:	00c50633          	add	a2,a0,a2
  d4:	00050793          	mv	a5,a0
  d8:	00178793          	addi	a5,a5,1
  dc:	feb78fa3          	sb	a1,-1(a5)
  e0:	fef61ce3          	bne	a2,a5,d8 <memset+0x18>
  e4:	00c12403          	lw	s0,12(sp)
  e8:	01010113          	addi	sp,sp,16
  ec:	00008067          	ret

000000f0 <memcpy>:
  f0:	ff010113          	addi	sp,sp,-16
  f4:	00812623          	sw	s0,12(sp)
  f8:	01010413          	addi	s0,sp,16
  fc:	02060063          	beqz	a2,11c <memcpy+0x2c>
 100:	00c50633          	add	a2,a0,a2
 104:	00050793          	mv	a5,a0
 108:	00158593          	addi	a1,a1,1
 10c:	00178793          	addi	a5,a5,1
 110:	fff5c703          	lbu	a4,-1(a1)
 114:	fee78fa3          	sb	a4,-1(a5)
 118:	fef618e3          	bne	a2,a5,108 <memcpy+0x18>
 11c:	00c12403          	lw	s0,12(sp)
 120:	01010113          	addi	sp,sp,16
 124:	00008067          	ret

00000128 <strlen>:
 128:	ff010113          	addi	sp,sp,-16
 12c:	00812623          	sw	s0,12(sp)
 130:	01010413          	addi	s0,sp,16
 134:	00054783          	lbu	a5,0(a0)
 138:	02078463          	beqz	a5,160 <strlen+0x38>
 13c:	00050713          	mv	a4,a0
 140:	00000513          	li	a0,0
 144:	00150513          	addi	a0,a0,1
 148:	00a707b3          	add	a5,a4,a0
 14c:	0007c783          	lbu	a5,0(a5)
 150:	fe079ae3          	bnez	a5,144 <strlen+0x1c>
 154:	00c12403          	lw	s0,12(sp)
 158:	01010113          	addi	sp,sp,16
 15c:	00008067          	ret
 160:	00000513          	li	a0,0
 164:	ff1ff06f          	j	154 <strlen+0x2c>

00000168 <strcpy>:
 168:	ff010113          	addi	sp,sp,-16
 16c:	00812623          	sw	s0,12(sp)
 170:	01010413          	addi	s0,sp,16
 174:	0005c783          	lbu	a5,0(a1)
 178:	02078663          	beqz	a5,1a4 <strcpy+0x3c>
 17c:	00050713          	mv	a4,a0
 180:	00158593          	addi	a1,a1,1
 184:	00170713          	addi	a4,a4,1
 188:	fef70fa3          	sb	a5,-1(a4)
 18c:	0005c783          	lbu	a5,0(a1)
 190:	fe0798e3          	bnez	a5,180 <strcpy+0x18>
 194:	00070023          	sb	zero,0(a4)
 198:	00c12403          	lw	s0,12(sp)
 19c:	01010113          	addi	sp,sp,16
 1a0:	00008067          	ret
 1a4:	00050713          	mv	a4,a0
 1a8:	fedff06f          	j	194 <strcpy+0x2c>

000001ac <strcmp>:
 1ac:	ff010113          	addi	sp,sp,-16
 1b0:	00812623          	sw	s0,12(sp)
 1b4:	01010413          	addi	s0,sp,16
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	02078063          	beqz	a5,1dc <strcmp+0x30>
 1c0:	0005c703          	lbu	a4,0(a1)
 1c4:	00070c63          	beqz	a4,1dc <strcmp+0x30>
 1c8:	00f71a63          	bne	a4,a5,1dc <strcmp+0x30>
 1cc:	00150513          	addi	a0,a0,1
 1d0:	00158593          	addi	a1,a1,1
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	fe0794e3          	bnez	a5,1c0 <strcmp+0x14>
 1dc:	0005c503          	lbu	a0,0(a1)
 1e0:	40a78533          	sub	a0,a5,a0
 1e4:	00c12403          	lw	s0,12(sp)
 1e8:	01010113          	addi	sp,sp,16
 1ec:	00008067          	ret

000001f0 <printf>:
 1f0:	fa010113          	addi	sp,sp,-96
 1f4:	02112e23          	sw	ra,60(sp)
 1f8:	02812c23          	sw	s0,56(sp)
 1fc:	02912a23          	sw	s1,52(sp)
 200:	04010413          	addi	s0,sp,64
 204:	00050493          	mv	s1,a0
 208:	00b42223          	sw	a1,4(s0)
 20c:	00c42423          	sw	a2,8(s0)
 210:	00d42623          	sw	a3,12(s0)
 214:	00e42823          	sw	a4,16(s0)
 218:	00f42a23          	sw	a5,20(s0)
 21c:	01042c23          	sw	a6,24(s0)
 220:	01142e23          	sw	a7,28(s0)
 224:	00440793          	addi	a5,s0,4
 228:	fcf42623          	sw	a5,-52(s0)
 22c:	00054503          	lbu	a0,0(a0)
 230:	06050663          	beqz	a0,29c <printf+0xac>
 234:	03212823          	sw	s2,48(sp)
 238:	03312623          	sw	s3,44(sp)
 23c:	03412423          	sw	s4,40(sp)
 240:	03512223          	sw	s5,36(sp)
 244:	03612023          	sw	s6,32(sp)
 248:	01712e23          	sw	s7,28(sp)
 24c:	01812c23          	sw	s8,24(sp)
 250:	02500993          	li	s3,37
 254:	06400a13          	li	s4,100
 258:	07300a93          	li	s5,115
 25c:	1180006f          	j	374 <printf+0x184>
 260:	00078c63          	beqz	a5,278 <printf+0x88>
 264:	02500713          	li	a4,37
 268:	10e79063          	bne	a5,a4,368 <printf+0x178>
 26c:	02500513          	li	a0,37
 270:	1a8000ef          	jal	418 <console_putc>
 274:	0f40006f          	j	368 <printf+0x178>
 278:	02500513          	li	a0,37
 27c:	19c000ef          	jal	418 <console_putc>
 280:	03012903          	lw	s2,48(sp)
 284:	02c12983          	lw	s3,44(sp)
 288:	02812a03          	lw	s4,40(sp)
 28c:	02412a83          	lw	s5,36(sp)
 290:	02012b03          	lw	s6,32(sp)
 294:	01c12b83          	lw	s7,28(sp)
 298:	01812c03          	lw	s8,24(sp)
 29c:	03c12083          	lw	ra,60(sp)
 2a0:	03812403          	lw	s0,56(sp)
 2a4:	03412483          	lw	s1,52(sp)
 2a8:	06010113          	addi	sp,sp,96
 2ac:	00008067          	ret
 2b0:	fcc42783          	lw	a5,-52(s0)
 2b4:	00478713          	addi	a4,a5,4
 2b8:	fce42623          	sw	a4,-52(s0)
 2bc:	0007a483          	lw	s1,0(a5)
 2c0:	0004c503          	lbu	a0,0(s1)
 2c4:	0a050263          	beqz	a0,368 <printf+0x178>
 2c8:	150000ef          	jal	418 <console_putc>
 2cc:	00148493          	addi	s1,s1,1
 2d0:	0004c503          	lbu	a0,0(s1)
 2d4:	fe051ae3          	bnez	a0,2c8 <printf+0xd8>
 2d8:	0900006f          	j	368 <printf+0x178>
 2dc:	fcc42783          	lw	a5,-52(s0)
 2e0:	00478713          	addi	a4,a5,4
 2e4:	fce42623          	sw	a4,-52(s0)
 2e8:	0007ab03          	lw	s6,0(a5)
 2ec:	040b4e63          	bltz	s6,348 <printf+0x158>
 2f0:	00900793          	li	a5,9
 2f4:	0767d263          	bge	a5,s6,358 <printf+0x168>
 2f8:	00100493          	li	s1,1
 2fc:	00900713          	li	a4,9
 300:	00249793          	slli	a5,s1,0x2
 304:	009787b3          	add	a5,a5,s1
 308:	00179793          	slli	a5,a5,0x1
 30c:	00078493          	mv	s1,a5
 310:	02fb47b3          	div	a5,s6,a5
 314:	fef746e3          	blt	a4,a5,300 <printf+0x110>
 318:	04905863          	blez	s1,368 <printf+0x178>
 31c:	00a00c13          	li	s8,10
 320:	00900b93          	li	s7,9
 324:	029b4533          	div	a0,s6,s1
 328:	03050513          	addi	a0,a0,48
 32c:	0ff57513          	zext.b	a0,a0
 330:	0e8000ef          	jal	418 <console_putc>
 334:	029b6b33          	rem	s6,s6,s1
 338:	00048793          	mv	a5,s1
 33c:	0384c4b3          	div	s1,s1,s8
 340:	fefbc2e3          	blt	s7,a5,324 <printf+0x134>
 344:	0240006f          	j	368 <printf+0x178>
 348:	02d00513          	li	a0,45
 34c:	0cc000ef          	jal	418 <console_putc>
 350:	41600b33          	neg	s6,s6
 354:	f9dff06f          	j	2f0 <printf+0x100>
 358:	00100493          	li	s1,1
 35c:	fc1ff06f          	j	31c <printf+0x12c>
 360:	0b8000ef          	jal	418 <console_putc>
 364:	00048913          	mv	s2,s1
 368:	00190493          	addi	s1,s2,1
 36c:	00194503          	lbu	a0,1(s2)
 370:	06050263          	beqz	a0,3d4 <printf+0x1e4>
 374:	ff3516e3          	bne	a0,s3,360 <printf+0x170>
 378:	00148913          	addi	s2,s1,1
 37c:	0014c783          	lbu	a5,1(s1)
 380:	f5478ee3          	beq	a5,s4,2dc <printf+0xec>
 384:	ecfa7ee3          	bgeu	s4,a5,260 <printf+0x70>
 388:	f35784e3          	beq	a5,s5,2b0 <printf+0xc0>
 38c:	07800713          	li	a4,120
 390:	fce79ce3          	bne	a5,a4,368 <printf+0x178>
 394:	fcc42783          	lw	a5,-52(s0)
 398:	00478713          	addi	a4,a5,4
 39c:	fce42623          	sw	a4,-52(s0)
 3a0:	0007ac03          	lw	s8,0(a5)
 3a4:	01c00493          	li	s1,28
 3a8:	00000b97          	auipc	s7,0x0
 3ac:	148b8b93          	addi	s7,s7,328 # 4f0 <main+0xa8>
 3b0:	ffc00b13          	li	s6,-4
 3b4:	409c57b3          	sra	a5,s8,s1
 3b8:	00f7f793          	andi	a5,a5,15
 3bc:	017787b3          	add	a5,a5,s7
 3c0:	0007c503          	lbu	a0,0(a5)
 3c4:	054000ef          	jal	418 <console_putc>
 3c8:	ffc48493          	addi	s1,s1,-4
 3cc:	ff6494e3          	bne	s1,s6,3b4 <printf+0x1c4>
 3d0:	f99ff06f          	j	368 <printf+0x178>
 3d4:	03012903          	lw	s2,48(sp)
 3d8:	02c12983          	lw	s3,44(sp)
 3dc:	02812a03          	lw	s4,40(sp)
 3e0:	02412a83          	lw	s5,36(sp)
 3e4:	02012b03          	lw	s6,32(sp)
 3e8:	01c12b83          	lw	s7,28(sp)
 3ec:	01812c03          	lw	s8,24(sp)
 3f0:	eadff06f          	j	29c <printf+0xac>

000003f4 <exit>:
 3f4:	00000893          	li	a7,0
 3f8:	00000073          	ecall
 3fc:	00008067          	ret

00000400 <getpid>:
 400:	00100893          	li	a7,1
 404:	00000073          	ecall
 408:	00008067          	ret

0000040c <console_puts>:
 40c:	00200893          	li	a7,2
 410:	00000073          	ecall
 414:	00008067          	ret

00000418 <console_putc>:
 418:	00300893          	li	a7,3
 41c:	00000073          	ecall
 420:	00008067          	ret

00000424 <console_getc>:
 424:	00400893          	li	a7,4
 428:	00000073          	ecall
 42c:	00008067          	ret

00000430 <sleep>:
 430:	00500893          	li	a7,5
 434:	00000073          	ecall
 438:	00008067          	ret

0000043c <time>:
 43c:	00600893          	li	a7,6
 440:	00000073          	ecall
 444:	00008067          	ret

00000448 <main>:
 448:	ff010113          	addi	sp,sp,-16
 44c:	00112623          	sw	ra,12(sp)
 450:	00812423          	sw	s0,8(sp)
 454:	00912223          	sw	s1,4(sp)
 458:	01212023          	sw	s2,0(sp)
 45c:	01010413          	addi	s0,sp,16
 460:	fa1ff0ef          	jal	400 <getpid>
 464:	00050593          	mv	a1,a0
 468:	00000517          	auipc	a0,0x0
 46c:	09c50513          	addi	a0,a0,156 # 504 <main+0xbc>
 470:	d81ff0ef          	jal	1f0 <printf>
 474:	fc9ff0ef          	jal	43c <time>
 478:	00050493          	mv	s1,a0
 47c:	00050593          	mv	a1,a0
 480:	00000517          	auipc	a0,0x0
 484:	0a050513          	addi	a0,a0,160 # 520 <main+0xd8>
 488:	d69ff0ef          	jal	1f0 <printf>
 48c:	00000517          	auipc	a0,0x0
 490:	0c050513          	addi	a0,a0,192 # 54c <main+0x104>
 494:	f79ff0ef          	jal	40c <console_puts>
 498:	00400513          	li	a0,4
 49c:	f95ff0ef          	jal	430 <sleep>
 4a0:	f9dff0ef          	jal	43c <time>
 4a4:	00050913          	mv	s2,a0
 4a8:	00050593          	mv	a1,a0
 4ac:	00000517          	auipc	a0,0x0
 4b0:	0c450513          	addi	a0,a0,196 # 570 <main+0x128>
 4b4:	d3dff0ef          	jal	1f0 <printf>
 4b8:	409905b3          	sub	a1,s2,s1
 4bc:	00000517          	auipc	a0,0x0
 4c0:	0dc50513          	addi	a0,a0,220 # 598 <main+0x150>
 4c4:	d2dff0ef          	jal	1f0 <printf>
 4c8:	00000517          	auipc	a0,0x0
 4cc:	0f450513          	addi	a0,a0,244 # 5bc <main+0x174>
 4d0:	f3dff0ef          	jal	40c <console_puts>
 4d4:	00000513          	li	a0,0
 4d8:	00c12083          	lw	ra,12(sp)
 4dc:	00812403          	lw	s0,8(sp)
 4e0:	00412483          	lw	s1,4(sp)
 4e4:	00012903          	lw	s2,0(sp)
 4e8:	01010113          	addi	sp,sp,16
 4ec:	00008067          	ret
