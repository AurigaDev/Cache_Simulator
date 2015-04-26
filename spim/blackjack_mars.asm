	# standard Decaf preamble 
	  .text
	  .globl main
  _Random.Init:
	# BeginFunc 0
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	# *(this + 4) = seedVal
	  lw $t0, 8($fp)	# fill seedVal to $t0 from $fp+8
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 4($t1) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.GenRandom:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	# _tmp0 = 15625
	  li $t0, 15625		# load constant value 15625 into $t0
	# _tmp1 = *(this + 4)
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  lw $t2, 4($t1) 	# load with offset
	# _tmp2 = 10000
	  li $t3, 10000		# load constant value 10000 into $t3
	# _tmp3 = _tmp1 % _tmp2
	  rem $t4, $t2, $t3	
	# _tmp4 = _tmp0 * _tmp3
	  mul $t2, $t0, $t4	
	# _tmp5 = 22221
	  li $t0, 22221		# load constant value 22221 into $t0
	# _tmp6 = _tmp4 + _tmp5
	  add $t3, $t2, $t0	
	# _tmp7 = 65536
	  li $t0, 65536		# load constant value 65536 into $t0
	# _tmp8 = _tmp6 % _tmp7
	  rem $t2, $t3, $t0	
	# *(this + 4) = _tmp8
	  sw $t2, 4($t1) 	# store with offset
	# _tmp9 = *(this + 4)
	  lw $t0, 4($t1) 	# load with offset
	# Return _tmp9
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Random.RndInt:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp10 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp11 = *(_tmp10 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp12 = ACall _tmp11
	  sw $t2, -12($fp)	# spill _tmp11 from $t2 to $fp-12
	  jalr $t2            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp13 = _tmp12 % max
	  lw $t1, 8($fp)	# fill max to $t1 from $fp+8
	  rem $t2, $t0, $t1	
	# Return _tmp13
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Random
	  .data
	  .align 2
	  Random:		# label for class Random vtable
	  .word _Random.Init
	  .word _Random.GenRandom
	  .word _Random.RndInt
	  .text
  _Deck.Init:
	# BeginFunc 40
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 40	# decrement sp to make space for locals/temps
	# _tmp14 = 52
	  li $t0, 52		# load constant value 52 into $t0
	# _tmp15 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp16 = _tmp14 < _tmp15
	  slt $t2, $t0, $t1	
	# IfZ _tmp16 Goto _L0
	  sw $t0, -8($fp)	# spill _tmp14 from $t0 to $fp-8
	  sw $t2, -16($fp)	# spill _tmp16 from $t2 to $fp-16
	  beqz $t2, _L0	# branch if _tmp16 is zero 
	# _tmp17 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string1: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string1	# load label
	# PushParam _tmp17
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L0:
	# _tmp18 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp19 = _tmp18 + _tmp14
	  lw $t1, -8($fp)	# fill _tmp14 to $t1 from $fp-8
	  add $t2, $t0, $t1	
	# _tmp20 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp21 = _tmp19 * _tmp20
	  mul $t3, $t2, $t0	
	# PushParam _tmp21
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# _tmp22 = LCall _Alloc
	  sw $t0, -32($fp)	# spill _tmp20 from $t0 to $fp-32
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp22) = _tmp14
	  lw $t1, -8($fp)	# fill _tmp14 to $t1 from $fp-8
	  sw $t1, 0($t0) 	# store with offset
	# _tmp23 = _tmp22 + _tmp20
	  lw $t1, -32($fp)	# fill _tmp20 to $t1 from $fp-32
	  add $t2, $t0, $t1	
	# *(this + 8) = _tmp23
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t2, 8($t0) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.Shuffle:
	# BeginFunc 336
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 336	# decrement sp to make space for locals/temps
	# _tmp24 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp24
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 4($t1) 	# store with offset
  _L1:
	# _tmp25 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp26 = 52
	  li $t2, 52		# load constant value 52 into $t2
	# _tmp27 = _tmp25 < _tmp26
	  slt $t3, $t1, $t2	
	# IfZ _tmp27 Goto _L2
	  sw $t3, -20($fp)	# spill _tmp27 from $t3 to $fp-20
	  beqz $t3, _L2	# branch if _tmp27 is zero 
	# _tmp28 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp29 = *(this + 4)
	  lw $t2, 4($t0) 	# load with offset
	# _tmp30 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp31 = _tmp29 < _tmp30
	  slt $t4, $t2, $t3	
	# _tmp32 = *(_tmp28 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp33 = _tmp29 < _tmp32
	  slt $t6, $t2, $t5	
	# _tmp34 = _tmp33 == _tmp30
	  seq $t5, $t6, $t3	
	# _tmp35 = _tmp31 || _tmp34
	  or $t3, $t4, $t5	
	# IfZ _tmp35 Goto _L3
	  sw $t1, -24($fp)	# spill _tmp28 from $t1 to $fp-24
	  sw $t2, -28($fp)	# spill _tmp29 from $t2 to $fp-28
	  sw $t3, -52($fp)	# spill _tmp35 from $t3 to $fp-52
	  beqz $t3, _L3	# branch if _tmp35 is zero 
	# _tmp36 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string2: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string2	# load label
	# PushParam _tmp36
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L3:
	# _tmp37 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp38 = _tmp37 * _tmp29
	  lw $t1, -28($fp)	# fill _tmp29 to $t1 from $fp-28
	  mul $t2, $t0, $t1	
	# _tmp39 = _tmp28 + _tmp38
	  lw $t0, -24($fp)	# fill _tmp28 to $t0 from $fp-24
	  add $t1, $t0, $t2	
	# _tmp40 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	# _tmp41 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp42 = _tmp40 + _tmp41
	  add $t4, $t2, $t3	
	# _tmp43 = 13
	  li $t2, 13		# load constant value 13 into $t2
	# _tmp44 = _tmp42 % _tmp43
	  rem $t3, $t4, $t2	
	# *(_tmp39) = _tmp44
	  sw $t3, 0($t1) 	# store with offset
	# _tmp45 = *(this + 4)
	  lw $t1, 4($t0) 	# load with offset
	# _tmp46 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp47 = _tmp45 + _tmp46
	  add $t3, $t1, $t2	
	# *(this + 4) = _tmp47
	  sw $t3, 4($t0) 	# store with offset
	# Goto _L1
	  b _L1		# unconditional branch
  _L2:
  _L4:
	# _tmp48 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp49 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp50 = _tmp49 < _tmp48
	  slt $t3, $t2, $t1	
	# IfZ _tmp50 Goto _L5
	  sw $t3, -112($fp)	# spill _tmp50 from $t3 to $fp-112
	  beqz $t3, _L5	# branch if _tmp50 is zero 
	# _tmp51 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp52 = *(gRnd)
	  lw $t2, 0($gp)	# fill gRnd to $t2 from $gp+0
	  lw $t3, 0($t2) 	# load with offset
	# _tmp53 = *(_tmp52 + 8)
	  lw $t4, 8($t3) 	# load with offset
	# PushParam _tmp51
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# _tmp54 = ACall _tmp53
	  sw $t4, -132($fp)	# spill _tmp53 from $t4 to $fp-132
	  jalr $t4            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# r = _tmp54
	  move $t1, $t0		# copy value to register for r
	# _tmp55 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	# _tmp56 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp57 = _tmp55 - _tmp56
	  sub $t4, $t2, $t3	
	# *(this + 4) = _tmp57
	  sw $t4, 4($t0) 	# store with offset
	# _tmp58 = *(this + 8)
	  lw $t2, 8($t0) 	# load with offset
	# _tmp59 = *(this + 4)
	  lw $t3, 4($t0) 	# load with offset
	# _tmp60 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp61 = _tmp59 < _tmp60
	  slt $t5, $t3, $t4	
	# _tmp62 = *(_tmp58 + -4)
	  lw $t6, -4($t2) 	# load with offset
	# _tmp63 = _tmp59 < _tmp62
	  slt $t9, $t3, $t6	
	  sw $t9, -172($fp)	# spill _tmp63 from $t9 to $fp-172
	# _tmp64 = _tmp63 == _tmp60
	  lw $t6, -172($fp)	# fill _tmp63 to $t6 from $fp-172
	  seq $t9, $t6, $t4	
	  sw $t9, -176($fp)	# spill _tmp64 from $t9 to $fp-176
	# _tmp65 = _tmp61 || _tmp64
	  lw $t4, -176($fp)	# fill _tmp64 to $t4 from $fp-176
	  or $t6, $t5, $t4	
	# IfZ _tmp65 Goto _L6
	  sw $t1, -116($fp)	# spill r from $t1 to $fp-116
	  sw $t2, -152($fp)	# spill _tmp58 from $t2 to $fp-152
	  sw $t3, -156($fp)	# spill _tmp59 from $t3 to $fp-156
	  sw $t6, -180($fp)	# spill _tmp65 from $t6 to $fp-180
	  beqz $t6, _L6	# branch if _tmp65 is zero 
	# _tmp66 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string3: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string3	# load label
	# PushParam _tmp66
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L6:
	# _tmp67 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp68 = _tmp67 * _tmp59
	  lw $t1, -156($fp)	# fill _tmp59 to $t1 from $fp-156
	  mul $t2, $t0, $t1	
	# _tmp69 = _tmp58 + _tmp68
	  lw $t0, -152($fp)	# fill _tmp58 to $t0 from $fp-152
	  add $t1, $t0, $t2	
	# _tmp70 = *(_tmp69)
	  lw $t0, 0($t1) 	# load with offset
	# temp = _tmp70
	  move $t1, $t0		# copy value to register for temp
	# _tmp71 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	# _tmp72 = *(this + 4)
	  lw $t3, 4($t0) 	# load with offset
	# _tmp73 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp74 = _tmp72 < _tmp73
	  slt $t5, $t3, $t4	
	# _tmp75 = *(_tmp71 + -4)
	  lw $t6, -4($t2) 	# load with offset
	# _tmp76 = _tmp72 < _tmp75
	  slt $t9, $t3, $t6	
	  sw $t9, -224($fp)	# spill _tmp76 from $t9 to $fp-224
	# _tmp77 = _tmp76 == _tmp73
	  lw $t6, -224($fp)	# fill _tmp76 to $t6 from $fp-224
	  seq $t9, $t6, $t4	
	  sw $t9, -228($fp)	# spill _tmp77 from $t9 to $fp-228
	# _tmp78 = _tmp74 || _tmp77
	  lw $t4, -228($fp)	# fill _tmp77 to $t4 from $fp-228
	  or $t6, $t5, $t4	
	# IfZ _tmp78 Goto _L7
	  sw $t1, -120($fp)	# spill temp from $t1 to $fp-120
	  sw $t2, -204($fp)	# spill _tmp71 from $t2 to $fp-204
	  sw $t3, -208($fp)	# spill _tmp72 from $t3 to $fp-208
	  sw $t6, -232($fp)	# spill _tmp78 from $t6 to $fp-232
	  beqz $t6, _L7	# branch if _tmp78 is zero 
	# _tmp79 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string4: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string4	# load label
	# PushParam _tmp79
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L7:
	# _tmp80 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp81 = _tmp80 * _tmp72
	  lw $t1, -208($fp)	# fill _tmp72 to $t1 from $fp-208
	  mul $t2, $t0, $t1	
	# _tmp82 = _tmp71 + _tmp81
	  lw $t0, -204($fp)	# fill _tmp71 to $t0 from $fp-204
	  add $t1, $t0, $t2	
	# _tmp83 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	# _tmp84 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp85 = r < _tmp84
	  lw $t4, -116($fp)	# fill r to $t4 from $fp-116
	  slt $t5, $t4, $t3	
	# _tmp86 = *(_tmp83 + -4)
	  lw $t6, -4($t2) 	# load with offset
	# _tmp87 = r < _tmp86
	  slt $t9, $t4, $t6	
	  sw $t9, -268($fp)	# spill _tmp87 from $t9 to $fp-268
	# _tmp88 = _tmp87 == _tmp84
	  lw $t6, -268($fp)	# fill _tmp87 to $t6 from $fp-268
	  seq $t9, $t6, $t3	
	  sw $t9, -272($fp)	# spill _tmp88 from $t9 to $fp-272
	# _tmp89 = _tmp85 || _tmp88
	  lw $t3, -272($fp)	# fill _tmp88 to $t3 from $fp-272
	  or $t6, $t5, $t3	
	# IfZ _tmp89 Goto _L8
	  sw $t1, -248($fp)	# spill _tmp82 from $t1 to $fp-248
	  sw $t2, -252($fp)	# spill _tmp83 from $t2 to $fp-252
	  sw $t6, -276($fp)	# spill _tmp89 from $t6 to $fp-276
	  beqz $t6, _L8	# branch if _tmp89 is zero 
	# _tmp90 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string5: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string5	# load label
	# PushParam _tmp90
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L8:
	# _tmp91 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp92 = _tmp91 * r
	  lw $t1, -116($fp)	# fill r to $t1 from $fp-116
	  mul $t2, $t0, $t1	
	# _tmp93 = _tmp83 + _tmp92
	  lw $t0, -252($fp)	# fill _tmp83 to $t0 from $fp-252
	  add $t3, $t0, $t2	
	# _tmp94 = *(_tmp93)
	  lw $t0, 0($t3) 	# load with offset
	# *(_tmp82) = _tmp94
	  lw $t2, -248($fp)	# fill _tmp82 to $t2 from $fp-248
	  sw $t0, 0($t2) 	# store with offset
	# _tmp95 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	# _tmp96 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp97 = r < _tmp96
	  slt $t4, $t1, $t3	
	# _tmp98 = *(_tmp95 + -4)
	  lw $t5, -4($t2) 	# load with offset
	# _tmp99 = r < _tmp98
	  slt $t6, $t1, $t5	
	# _tmp100 = _tmp99 == _tmp96
	  seq $t5, $t6, $t3	
	# _tmp101 = _tmp97 || _tmp100
	  or $t3, $t4, $t5	
	# IfZ _tmp101 Goto _L9
	  sw $t2, -300($fp)	# spill _tmp95 from $t2 to $fp-300
	  sw $t3, -324($fp)	# spill _tmp101 from $t3 to $fp-324
	  beqz $t3, _L9	# branch if _tmp101 is zero 
	# _tmp102 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string6: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string6	# load label
	# PushParam _tmp102
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L9:
	# _tmp103 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp104 = _tmp103 * r
	  lw $t1, -116($fp)	# fill r to $t1 from $fp-116
	  mul $t2, $t0, $t1	
	# _tmp105 = _tmp95 + _tmp104
	  lw $t0, -300($fp)	# fill _tmp95 to $t0 from $fp-300
	  add $t1, $t0, $t2	
	# *(_tmp105) = temp
	  lw $t0, -120($fp)	# fill temp to $t0 from $fp-120
	  sw $t0, 0($t1) 	# store with offset
	# Goto _L4
	  b _L4		# unconditional branch
  _L5:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Deck.GetCard:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp106 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp107 = 52
	  li $t2, 52		# load constant value 52 into $t2
	# _tmp108 = _tmp107 < _tmp106
	  slt $t3, $t2, $t1	
	# _tmp109 = _tmp107 == _tmp106
	  seq $t4, $t2, $t1	
	# _tmp110 = _tmp108 || _tmp109
	  or $t1, $t3, $t4	
	# IfZ _tmp110 Goto _L10
	  sw $t1, -28($fp)	# spill _tmp110 from $t1 to $fp-28
	  beqz $t1, _L10	# branch if _tmp110 is zero 
	# _tmp111 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp111
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L10:
	# _tmp112 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp113 = *(this + 4)
	  lw $t2, 4($t0) 	# load with offset
	# _tmp114 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp115 = _tmp113 < _tmp114
	  slt $t4, $t2, $t3	
	# _tmp116 = *(_tmp112 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp117 = _tmp113 < _tmp116
	  slt $t6, $t2, $t5	
	# _tmp118 = _tmp117 == _tmp114
	  seq $t5, $t6, $t3	
	# _tmp119 = _tmp115 || _tmp118
	  or $t3, $t4, $t5	
	# IfZ _tmp119 Goto _L11
	  sw $t1, -36($fp)	# spill _tmp112 from $t1 to $fp-36
	  sw $t2, -40($fp)	# spill _tmp113 from $t2 to $fp-40
	  sw $t3, -64($fp)	# spill _tmp119 from $t3 to $fp-64
	  beqz $t3, _L11	# branch if _tmp119 is zero 
	# _tmp120 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string7: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string7	# load label
	# PushParam _tmp120
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L11:
	# _tmp121 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp122 = _tmp121 * _tmp113
	  lw $t1, -40($fp)	# fill _tmp113 to $t1 from $fp-40
	  mul $t2, $t0, $t1	
	# _tmp123 = _tmp112 + _tmp122
	  lw $t0, -36($fp)	# fill _tmp112 to $t0 from $fp-36
	  add $t1, $t0, $t2	
	# _tmp124 = *(_tmp123)
	  lw $t0, 0($t1) 	# load with offset
	# result = _tmp124
	  move $t1, $t0		# copy value to register for result
	# _tmp125 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	# _tmp126 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp127 = _tmp125 + _tmp126
	  add $t4, $t2, $t3	
	# *(this + 4) = _tmp127
	  sw $t4, 4($t0) 	# store with offset
	# Return result
	  move $v0, $t1		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Deck
	  .data
	  .align 2
	  Deck:		# label for class Deck vtable
	  .word _Deck.Init
	  .word _Deck.Shuffle
	  .word _Deck.GetCard
	  .text
  _BJDeck.Init:
	# BeginFunc 176
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 176	# decrement sp to make space for locals/temps
	# _tmp128 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp129 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp130 = _tmp128 < _tmp129
	  slt $t2, $t0, $t1	
	# IfZ _tmp130 Goto _L12
	  sw $t0, -12($fp)	# spill _tmp128 from $t0 to $fp-12
	  sw $t2, -20($fp)	# spill _tmp130 from $t2 to $fp-20
	  beqz $t2, _L12	# branch if _tmp130 is zero 
	# _tmp131 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string8: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string8	# load label
	# PushParam _tmp131
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L12:
	# _tmp132 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp133 = _tmp132 + _tmp128
	  lw $t1, -12($fp)	# fill _tmp128 to $t1 from $fp-12
	  add $t2, $t0, $t1	
	# _tmp134 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp135 = _tmp133 * _tmp134
	  mul $t3, $t2, $t0	
	# PushParam _tmp135
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# _tmp136 = LCall _Alloc
	  sw $t0, -36($fp)	# spill _tmp134 from $t0 to $fp-36
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp136) = _tmp128
	  lw $t1, -12($fp)	# fill _tmp128 to $t1 from $fp-12
	  sw $t1, 0($t0) 	# store with offset
	# _tmp137 = _tmp136 + _tmp134
	  lw $t1, -36($fp)	# fill _tmp134 to $t1 from $fp-36
	  add $t2, $t0, $t1	
	# *(this + 4) = _tmp137
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t2, 4($t0) 	# store with offset
	# _tmp138 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# i = _tmp138
	  move $t2, $t1		# copy value to register for i
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L13:
	# _tmp139 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp140 = i < _tmp139
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t2, $t1, $t0	
	# IfZ _tmp140 Goto _L14
	  sw $t2, -60($fp)	# spill _tmp140 from $t2 to $fp-60
	  beqz $t2, _L14	# branch if _tmp140 is zero 
	# _tmp141 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp142 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp143 = i < _tmp142
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp144 = *(_tmp141 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp145 = i < _tmp144
	  slt $t6, $t3, $t5	
	# _tmp146 = _tmp145 == _tmp142
	  seq $t5, $t6, $t2	
	# _tmp147 = _tmp143 || _tmp146
	  or $t2, $t4, $t5	
	# IfZ _tmp147 Goto _L15
	  sw $t1, -64($fp)	# spill _tmp141 from $t1 to $fp-64
	  sw $t2, -88($fp)	# spill _tmp147 from $t2 to $fp-88
	  beqz $t2, _L15	# branch if _tmp147 is zero 
	# _tmp148 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string9: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string9	# load label
	# PushParam _tmp148
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L15:
	# _tmp149 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp150 = _tmp149 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp151 = _tmp141 + _tmp150
	  lw $t0, -64($fp)	# fill _tmp141 to $t0 from $fp-64
	  add $t3, $t0, $t2	
	# _tmp152 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp152
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp153 = LCall _Alloc
	  sw $t3, -104($fp)	# spill _tmp151 from $t3 to $fp-104
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp154 = Deck
	  la $t1, Deck	# load label
	# *(_tmp153) = _tmp154
	  sw $t1, 0($t0) 	# store with offset
	# *(_tmp151) = _tmp153
	  lw $t1, -104($fp)	# fill _tmp151 to $t1 from $fp-104
	  sw $t0, 0($t1) 	# store with offset
	# _tmp155 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp156 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp157 = i < _tmp156
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp158 = *(_tmp155 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp159 = i < _tmp158
	  slt $t6, $t3, $t5	
	# _tmp160 = _tmp159 == _tmp156
	  seq $t5, $t6, $t2	
	# _tmp161 = _tmp157 || _tmp160
	  or $t2, $t4, $t5	
	# IfZ _tmp161 Goto _L16
	  sw $t1, -120($fp)	# spill _tmp155 from $t1 to $fp-120
	  sw $t2, -144($fp)	# spill _tmp161 from $t2 to $fp-144
	  beqz $t2, _L16	# branch if _tmp161 is zero 
	# _tmp162 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string10: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string10	# load label
	# PushParam _tmp162
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L16:
	# _tmp163 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp164 = _tmp163 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp165 = _tmp155 + _tmp164
	  lw $t0, -120($fp)	# fill _tmp155 to $t0 from $fp-120
	  add $t3, $t0, $t2	
	# _tmp166 = *(_tmp165)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp167 = *(_tmp166)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp168 = *(_tmp167)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp166
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp168
	  sw $t3, -172($fp)	# spill _tmp168 from $t3 to $fp-172
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp169 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp170 = i + _tmp169
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp170
	  move $t1, $t2		# copy value to register for i
	# Goto _L13
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L13		# unconditional branch
  _L14:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.DealCard:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	# _tmp171 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# c = _tmp171
	  move $t1, $t0		# copy value to register for c
	# _tmp172 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 8($t0) 	# load with offset
	# _tmp173 = 8
	  li $t3, 8		# load constant value 8 into $t3
	# _tmp174 = 52
	  li $t4, 52		# load constant value 52 into $t4
	# _tmp175 = _tmp173 * _tmp174
	  mul $t5, $t3, $t4	
	# _tmp176 = _tmp175 < _tmp172
	  slt $t3, $t5, $t2	
	# _tmp177 = _tmp175 == _tmp172
	  seq $t4, $t5, $t2	
	# _tmp178 = _tmp176 || _tmp177
	  or $t2, $t3, $t4	
	# IfZ _tmp178 Goto _L17
	  sw $t1, -8($fp)	# spill c from $t1 to $fp-8
	  sw $t2, -40($fp)	# spill _tmp178 from $t2 to $fp-40
	  beqz $t2, _L17	# branch if _tmp178 is zero 
	# _tmp179 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# Return _tmp179
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L17:
  _L18:
	# _tmp180 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp181 = c == _tmp180
	  lw $t1, -8($fp)	# fill c to $t1 from $fp-8
	  seq $t2, $t1, $t0	
	# IfZ _tmp181 Goto _L19
	  sw $t2, -52($fp)	# spill _tmp181 from $t2 to $fp-52
	  beqz $t2, _L19	# branch if _tmp181 is zero 
	# _tmp182 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp183 = *(gRnd)
	  lw $t1, 0($gp)	# fill gRnd to $t1 from $gp+0
	  lw $t2, 0($t1) 	# load with offset
	# _tmp184 = *(_tmp183 + 8)
	  lw $t3, 8($t2) 	# load with offset
	# PushParam _tmp182
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp185 = ACall _tmp184
	  sw $t3, -68($fp)	# spill _tmp184 from $t3 to $fp-68
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# d = _tmp185
	  move $t1, $t0		# copy value to register for d
	# _tmp186 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 4($t0) 	# load with offset
	# _tmp187 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp188 = d < _tmp187
	  slt $t4, $t1, $t3	
	# _tmp189 = *(_tmp186 + -4)
	  lw $t5, -4($t2) 	# load with offset
	# _tmp190 = d < _tmp189
	  slt $t6, $t1, $t5	
	# _tmp191 = _tmp190 == _tmp187
	  seq $t5, $t6, $t3	
	# _tmp192 = _tmp188 || _tmp191
	  or $t3, $t4, $t5	
	# IfZ _tmp192 Goto _L20
	  sw $t1, -56($fp)	# spill d from $t1 to $fp-56
	  sw $t2, -76($fp)	# spill _tmp186 from $t2 to $fp-76
	  sw $t3, -100($fp)	# spill _tmp192 from $t3 to $fp-100
	  beqz $t3, _L20	# branch if _tmp192 is zero 
	# _tmp193 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string11: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string11	# load label
	# PushParam _tmp193
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L20:
	# _tmp194 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp195 = _tmp194 * d
	  lw $t1, -56($fp)	# fill d to $t1 from $fp-56
	  mul $t2, $t0, $t1	
	# _tmp196 = _tmp186 + _tmp195
	  lw $t0, -76($fp)	# fill _tmp186 to $t0 from $fp-76
	  add $t1, $t0, $t2	
	# _tmp197 = *(_tmp196)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp198 = *(_tmp197)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp199 = *(_tmp198 + 8)
	  lw $t2, 8($t1) 	# load with offset
	# PushParam _tmp197
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp200 = ACall _tmp199
	  sw $t2, -128($fp)	# spill _tmp199 from $t2 to $fp-128
	  jalr $t2            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# c = _tmp200
	  move $t1, $t0		# copy value to register for c
	# Goto _L18
	  sw $t1, -8($fp)	# spill c from $t1 to $fp-8
	  b _L18		# unconditional branch
  _L19:
	# _tmp201 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# _tmp202 = _tmp201 < c
	  lw $t1, -8($fp)	# fill c to $t1 from $fp-8
	  slt $t2, $t0, $t1	
	# IfZ _tmp202 Goto _L21
	  sw $t2, -140($fp)	# spill _tmp202 from $t2 to $fp-140
	  beqz $t2, _L21	# branch if _tmp202 is zero 
	# _tmp203 = 10
	  li $t0, 10		# load constant value 10 into $t0
	# c = _tmp203
	  move $t1, $t0		# copy value to register for c
	# Goto _L22
	  sw $t1, -8($fp)	# spill c from $t1 to $fp-8
	  b _L22		# unconditional branch
  _L21:
	# _tmp204 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp205 = c == _tmp204
	  lw $t1, -8($fp)	# fill c to $t1 from $fp-8
	  seq $t2, $t1, $t0	
	# IfZ _tmp205 Goto _L23
	  sw $t2, -152($fp)	# spill _tmp205 from $t2 to $fp-152
	  beqz $t2, _L23	# branch if _tmp205 is zero 
	# _tmp206 = 11
	  li $t0, 11		# load constant value 11 into $t0
	# c = _tmp206
	  move $t1, $t0		# copy value to register for c
	  sw $t1, -8($fp)	# spill c from $t1 to $fp-8
  _L23:
  _L22:
	# _tmp207 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp208 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp209 = _tmp207 + _tmp208
	  add $t3, $t1, $t2	
	# *(this + 8) = _tmp209
	  sw $t3, 8($t0) 	# store with offset
	# Return c
	  lw $t0, -8($fp)	# fill c to $t0 from $fp-8
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.Shuffle:
	# BeginFunc 92
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 92	# decrement sp to make space for locals/temps
	# _tmp210 = "Shuffling..."
	  .data			# create string constant marked with label
	  _string12: .asciiz "Shuffling..."
	  .text
	  la $t0, _string12	# load label
	# PushParam _tmp210
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp211 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp211
	  move $t1, $t0		# copy value to register for i
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
  _L24:
	# _tmp212 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp213 = i < _tmp212
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t2, $t1, $t0	
	# IfZ _tmp213 Goto _L25
	  sw $t2, -24($fp)	# spill _tmp213 from $t2 to $fp-24
	  beqz $t2, _L25	# branch if _tmp213 is zero 
	# _tmp214 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp215 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp216 = i < _tmp215
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp217 = *(_tmp214 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp218 = i < _tmp217
	  slt $t6, $t3, $t5	
	# _tmp219 = _tmp218 == _tmp215
	  seq $t5, $t6, $t2	
	# _tmp220 = _tmp216 || _tmp219
	  or $t2, $t4, $t5	
	# IfZ _tmp220 Goto _L26
	  sw $t1, -28($fp)	# spill _tmp214 from $t1 to $fp-28
	  sw $t2, -52($fp)	# spill _tmp220 from $t2 to $fp-52
	  beqz $t2, _L26	# branch if _tmp220 is zero 
	# _tmp221 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string13: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string13	# load label
	# PushParam _tmp221
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L26:
	# _tmp222 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp223 = _tmp222 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp224 = _tmp214 + _tmp223
	  lw $t0, -28($fp)	# fill _tmp214 to $t0 from $fp-28
	  add $t3, $t0, $t2	
	# _tmp225 = *(_tmp224)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp226 = *(_tmp225)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp227 = *(_tmp226 + 4)
	  lw $t3, 4($t2) 	# load with offset
	# PushParam _tmp225
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp227
	  sw $t3, -80($fp)	# spill _tmp227 from $t3 to $fp-80
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp228 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp229 = i + _tmp228
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp229
	  move $t1, $t2		# copy value to register for i
	# Goto _L24
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L24		# unconditional branch
  _L25:
	# _tmp230 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 8) = _tmp230
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 8($t1) 	# store with offset
	# _tmp231 = "done.\n"
	  .data			# create string constant marked with label
	  _string14: .asciiz "done.\n"
	  .text
	  la $t0, _string14	# load label
	# PushParam _tmp231
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _BJDeck.NumCardsRemaining:
	# BeginFunc 20
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 20	# decrement sp to make space for locals/temps
	# _tmp232 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# _tmp233 = 52
	  li $t1, 52		# load constant value 52 into $t1
	# _tmp234 = _tmp232 * _tmp233
	  mul $t2, $t0, $t1	
	# _tmp235 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp236 = _tmp234 - _tmp235
	  sub $t0, $t2, $t1	
	# Return _tmp236
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class BJDeck
	  .data
	  .align 2
	  BJDeck:		# label for class BJDeck vtable
	  .word _BJDeck.Init
	  .word _BJDeck.DealCard
	  .word _BJDeck.Shuffle
	  .word _BJDeck.NumCardsRemaining
	  .text
  _Player.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp237 = 1000
	  li $t0, 1000		# load constant value 1000 into $t0
	# *(this + 12) = _tmp237
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 12($t1) 	# store with offset
	# _tmp238 = "What is the name of player #"
	  .data			# create string constant marked with label
	  _string15: .asciiz "What is the name of player #"
	  .text
	  la $t0, _string15	# load label
	# PushParam _tmp238
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam num
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill num to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp239 = "? "
	  .data			# create string constant marked with label
	  _string16: .asciiz "? "
	  .text
	  la $t0, _string16	# load label
	# PushParam _tmp239
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp240 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# *(this + 16) = _tmp240
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 16($t1) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Hit:
	# BeginFunc 120
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 120	# decrement sp to make space for locals/temps
	# _tmp241 = *(deck)
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  lw $t1, 0($t0) 	# load with offset
	# _tmp242 = *(_tmp241 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp243 = ACall _tmp242
	  sw $t2, -16($fp)	# spill _tmp242 from $t2 to $fp-16
	  jalr $t2            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# card = _tmp243
	  move $t1, $t0		# copy value to register for card
	# _tmp244 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t2, 16($t0) 	# load with offset
	# PushParam _tmp244
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, -8($fp)	# spill card from $t1 to $fp-8
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp245 = " was dealt a "
	  .data			# create string constant marked with label
	  _string17: .asciiz " was dealt a "
	  .text
	  la $t0, _string17	# load label
	# PushParam _tmp245
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# PushParam card
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, -8($fp)	# fill card to $t0 from $fp-8
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp246 = ".\n"
	  .data			# create string constant marked with label
	  _string18: .asciiz ".\n"
	  .text
	  la $t0, _string18	# load label
	# PushParam _tmp246
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp247 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp248 = _tmp247 + card
	  lw $t2, -8($fp)	# fill card to $t2 from $fp-8
	  add $t3, $t1, $t2	
	# *(this + 24) = _tmp248
	  sw $t3, 24($t0) 	# store with offset
	# _tmp249 = *(this + 20)
	  lw $t1, 20($t0) 	# load with offset
	# _tmp250 = 1
	  li $t3, 1		# load constant value 1 into $t3
	# _tmp251 = _tmp249 + _tmp250
	  add $t4, $t1, $t3	
	# *(this + 20) = _tmp251
	  sw $t4, 20($t0) 	# store with offset
	# _tmp252 = 11
	  li $t1, 11		# load constant value 11 into $t1
	# _tmp253 = card == _tmp252
	  seq $t3, $t2, $t1	
	# IfZ _tmp253 Goto _L27
	  sw $t3, -60($fp)	# spill _tmp253 from $t3 to $fp-60
	  beqz $t3, _L27	# branch if _tmp253 is zero 
	# _tmp254 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp255 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp256 = _tmp254 + _tmp255
	  add $t3, $t1, $t2	
	# *(this + 4) = _tmp256
	  sw $t3, 4($t0) 	# store with offset
  _L27:
  _L28:
	# _tmp257 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp258 = 21
	  li $t2, 21		# load constant value 21 into $t2
	# _tmp259 = _tmp258 < _tmp257
	  slt $t3, $t2, $t1	
	# _tmp260 = *(this + 4)
	  lw $t1, 4($t0) 	# load with offset
	# _tmp261 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp262 = _tmp261 < _tmp260
	  slt $t4, $t2, $t1	
	# _tmp263 = _tmp259 && _tmp262
	  and $t1, $t3, $t4	
	# IfZ _tmp263 Goto _L29
	  sw $t1, -100($fp)	# spill _tmp263 from $t1 to $fp-100
	  beqz $t1, _L29	# branch if _tmp263 is zero 
	# _tmp264 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp265 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp266 = _tmp264 - _tmp265
	  sub $t3, $t1, $t2	
	# *(this + 24) = _tmp266
	  sw $t3, 24($t0) 	# store with offset
	# _tmp267 = *(this + 4)
	  lw $t1, 4($t0) 	# load with offset
	# _tmp268 = 1
	  li $t2, 1		# load constant value 1 into $t2
	# _tmp269 = _tmp267 - _tmp268
	  sub $t3, $t1, $t2	
	# *(this + 4) = _tmp269
	  sw $t3, 4($t0) 	# store with offset
	# Goto _L28
	  b _L28		# unconditional branch
  _L29:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.DoubleDown:
	# BeginFunc 104
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 104	# decrement sp to make space for locals/temps
	# _tmp270 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp271 = 10
	  li $t2, 10		# load constant value 10 into $t2
	# _tmp272 = _tmp270 == _tmp271
	  seq $t3, $t1, $t2	
	# _tmp273 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp274 = _tmp272 == _tmp273
	  seq $t2, $t3, $t1	
	# _tmp275 = *(this + 24)
	  lw $t1, 24($t0) 	# load with offset
	# _tmp276 = 11
	  li $t3, 11		# load constant value 11 into $t3
	# _tmp277 = _tmp275 == _tmp276
	  seq $t4, $t1, $t3	
	# _tmp278 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp279 = _tmp277 == _tmp278
	  seq $t3, $t4, $t1	
	# _tmp280 = _tmp274 && _tmp279
	  and $t1, $t2, $t3	
	# IfZ _tmp280 Goto _L30
	  sw $t1, -52($fp)	# spill _tmp280 from $t1 to $fp-52
	  beqz $t1, _L30	# branch if _tmp280 is zero 
	# _tmp281 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp281
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L30:
	# _tmp282 = "Would you like to double down?"
	  .data			# create string constant marked with label
	  _string19: .asciiz "Would you like to double down?"
	  .text
	  la $t0, _string19	# load label
	# PushParam _tmp282
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp283 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp283 Goto _L31
	  sw $t0, -64($fp)	# spill _tmp283 from $t0 to $fp-64
	  beqz $t0, _L31	# branch if _tmp283 is zero 
	# _tmp284 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp285 = 2
	  li $t2, 2		# load constant value 2 into $t2
	# _tmp286 = _tmp284 * _tmp285
	  mul $t3, $t1, $t2	
	# *(this + 8) = _tmp286
	  sw $t3, 8($t0) 	# store with offset
	# _tmp287 = *(this)
	  lw $t1, 0($t0) 	# load with offset
	# _tmp288 = *(_tmp287 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp288
	  sw $t2, -84($fp)	# spill _tmp288 from $t2 to $fp-84
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp289 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp289
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp290 = ", your total is "
	  .data			# create string constant marked with label
	  _string20: .asciiz ", your total is "
	  .text
	  la $t0, _string20	# load label
	# PushParam _tmp290
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp291 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp291
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp292 = ".\n"
	  .data			# create string constant marked with label
	  _string21: .asciiz ".\n"
	  .text
	  la $t0, _string21	# load label
	# PushParam _tmp292
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp293 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# Return _tmp293
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _L31:
	# _tmp294 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# Return _tmp294
	  move $v0, $t0		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.TakeTurn:
	# BeginFunc 168
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 168	# decrement sp to make space for locals/temps
	# _tmp295 = "\n"
	  .data			# create string constant marked with label
	  _string22: .asciiz "\n"
	  .text
	  la $t0, _string22	# load label
	# PushParam _tmp295
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp296 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp296
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp297 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string23: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string23	# load label
	# PushParam _tmp297
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp298 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 24) = _tmp298
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 24($t1) 	# store with offset
	# _tmp299 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp299
	  sw $t0, 4($t1) 	# store with offset
	# _tmp300 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 20) = _tmp300
	  sw $t0, 20($t1) 	# store with offset
	# _tmp301 = *(this)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp302 = *(_tmp301 + 4)
	  lw $t2, 4($t0) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 8($fp)	# fill deck to $t0 from $fp+8
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp302
	  sw $t2, -40($fp)	# spill _tmp302 from $t2 to $fp-40
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp303 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp304 = *(_tmp303 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp304
	  sw $t2, -48($fp)	# spill _tmp304 from $t2 to $fp-48
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp305 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp306 = *(_tmp305 + 8)
	  lw $t2, 8($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp307 = ACall _tmp306
	  sw $t2, -56($fp)	# spill _tmp306 from $t2 to $fp-56
	  jalr $t2            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp308 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# _tmp309 = _tmp307 == _tmp308
	  seq $t2, $t0, $t1	
	# IfZ _tmp309 Goto _L32
	  sw $t2, -68($fp)	# spill _tmp309 from $t2 to $fp-68
	  beqz $t2, _L32	# branch if _tmp309 is zero 
	# _tmp310 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# stillGoing = _tmp310
	  move $t1, $t0		# copy value to register for stillGoing
	  sw $t1, -8($fp)	# spill stillGoing from $t1 to $fp-8
  _L33:
	# _tmp311 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp312 = 21
	  li $t2, 21		# load constant value 21 into $t2
	# _tmp313 = _tmp311 < _tmp312
	  slt $t3, $t1, $t2	
	# _tmp314 = _tmp311 == _tmp312
	  seq $t4, $t1, $t2	
	# _tmp315 = _tmp313 || _tmp314
	  or $t1, $t3, $t4	
	# _tmp316 = _tmp315 && stillGoing
	  lw $t2, -8($fp)	# fill stillGoing to $t2 from $fp-8
	  and $t3, $t1, $t2	
	# IfZ _tmp316 Goto _L34
	  sw $t3, -96($fp)	# spill _tmp316 from $t3 to $fp-96
	  beqz $t3, _L34	# branch if _tmp316 is zero 
	# _tmp317 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp317
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp318 = ", your total is "
	  .data			# create string constant marked with label
	  _string24: .asciiz ", your total is "
	  .text
	  la $t0, _string24	# load label
	# PushParam _tmp318
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp319 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp319
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp320 = ".\n"
	  .data			# create string constant marked with label
	  _string25: .asciiz ".\n"
	  .text
	  la $t0, _string25	# load label
	# PushParam _tmp320
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp321 = "Would you like a hit?"
	  .data			# create string constant marked with label
	  _string26: .asciiz "Would you like a hit?"
	  .text
	  la $t0, _string26	# load label
	# PushParam _tmp321
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp322 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# stillGoing = _tmp322
	  move $t1, $t0		# copy value to register for stillGoing
	# IfZ stillGoing Goto _L35
	  sw $t1, -8($fp)	# spill stillGoing from $t1 to $fp-8
	  beqz $t1, _L35	# branch if stillGoing is zero 
	# _tmp323 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp324 = *(_tmp323 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp324
	  sw $t2, -128($fp)	# spill _tmp324 from $t2 to $fp-128
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L35:
	# Goto _L33
	  b _L33		# unconditional branch
  _L34:
  _L32:
	# _tmp325 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp326 = 21
	  li $t2, 21		# load constant value 21 into $t2
	# _tmp327 = _tmp326 < _tmp325
	  slt $t3, $t2, $t1	
	# IfZ _tmp327 Goto _L36
	  sw $t3, -140($fp)	# spill _tmp327 from $t3 to $fp-140
	  beqz $t3, _L36	# branch if _tmp327 is zero 
	# _tmp328 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp328
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp329 = " busts with the big "
	  .data			# create string constant marked with label
	  _string27: .asciiz " busts with the big "
	  .text
	  la $t0, _string27	# load label
	# PushParam _tmp329
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp330 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp330
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp331 = "!\n"
	  .data			# create string constant marked with label
	  _string28: .asciiz "!\n"
	  .text
	  la $t0, _string28	# load label
	# PushParam _tmp331
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L37
	  b _L37		# unconditional branch
  _L36:
	# _tmp332 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp332
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp333 = " stays at "
	  .data			# create string constant marked with label
	  _string29: .asciiz " stays at "
	  .text
	  la $t0, _string29	# load label
	# PushParam _tmp333
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp334 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp334
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp335 = ".\n"
	  .data			# create string constant marked with label
	  _string30: .asciiz ".\n"
	  .text
	  la $t0, _string30	# load label
	# PushParam _tmp335
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L37:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.HasMoney:
	# BeginFunc 12
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 12	# decrement sp to make space for locals/temps
	# _tmp336 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp337 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp338 = _tmp337 < _tmp336
	  slt $t2, $t0, $t1	
	# Return _tmp338
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.PrintMoney:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp339 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp339
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp340 = ", you have $"
	  .data			# create string constant marked with label
	  _string31: .asciiz ", you have $"
	  .text
	  la $t0, _string31	# load label
	# PushParam _tmp340
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp341 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# PushParam _tmp341
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp342 = ".\n"
	  .data			# create string constant marked with label
	  _string32: .asciiz ".\n"
	  .text
	  la $t0, _string32	# load label
	# PushParam _tmp342
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.PlaceBet:
	# BeginFunc 56
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 56	# decrement sp to make space for locals/temps
	# _tmp343 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 8) = _tmp343
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 8($t1) 	# store with offset
	# _tmp344 = *(this)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp345 = *(_tmp344 + 20)
	  lw $t2, 20($t0) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp345
	  sw $t2, -16($fp)	# spill _tmp345 from $t2 to $fp-16
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L38:
	# _tmp346 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp347 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp348 = _tmp346 < _tmp347
	  slt $t3, $t1, $t2	
	# _tmp349 = _tmp346 == _tmp347
	  seq $t4, $t1, $t2	
	# _tmp350 = _tmp348 || _tmp349
	  or $t1, $t3, $t4	
	# _tmp351 = *(this + 8)
	  lw $t2, 8($t0) 	# load with offset
	# _tmp352 = *(this + 12)
	  lw $t3, 12($t0) 	# load with offset
	# _tmp353 = _tmp352 < _tmp351
	  slt $t4, $t3, $t2	
	# _tmp354 = _tmp350 || _tmp353
	  or $t2, $t1, $t4	
	# IfZ _tmp354 Goto _L39
	  sw $t2, -52($fp)	# spill _tmp354 from $t2 to $fp-52
	  beqz $t2, _L39	# branch if _tmp354 is zero 
	# _tmp355 = "How much would you like to bet? "
	  .data			# create string constant marked with label
	  _string33: .asciiz "How much would you like to bet? "
	  .text
	  la $t0, _string33	# load label
	# PushParam _tmp355
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp356 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# *(this + 8) = _tmp356
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 8($t1) 	# store with offset
	# Goto _L38
	  b _L38		# unconditional branch
  _L39:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.GetTotal:
	# BeginFunc 4
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 4	# decrement sp to make space for locals/temps
	# _tmp357 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# Return _tmp357
	  move $v0, $t1		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Player.Resolve:
	# BeginFunc 200
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 200	# decrement sp to make space for locals/temps
	# _tmp358 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# win = _tmp358
	  move $t1, $t0		# copy value to register for win
	# _tmp359 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# lose = _tmp359
	  move $t2, $t0		# copy value to register for lose
	# _tmp360 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t3, 24($t0) 	# load with offset
	# _tmp361 = 21
	  li $t4, 21		# load constant value 21 into $t4
	# _tmp362 = _tmp360 == _tmp361
	  seq $t5, $t3, $t4	
	# _tmp363 = *(this + 20)
	  lw $t3, 20($t0) 	# load with offset
	# _tmp364 = 2
	  li $t4, 2		# load constant value 2 into $t4
	# _tmp365 = _tmp363 == _tmp364
	  seq $t6, $t3, $t4	
	# _tmp366 = _tmp362 && _tmp365
	  and $t3, $t5, $t6	
	# IfZ _tmp366 Goto _L40
	  sw $t1, -8($fp)	# spill win from $t1 to $fp-8
	  sw $t2, -12($fp)	# spill lose from $t2 to $fp-12
	  sw $t3, -48($fp)	# spill _tmp366 from $t3 to $fp-48
	  beqz $t3, _L40	# branch if _tmp366 is zero 
	# _tmp367 = 2
	  li $t0, 2		# load constant value 2 into $t0
	# win = _tmp367
	  move $t1, $t0		# copy value to register for win
	# Goto _L41
	  sw $t1, -8($fp)	# spill win from $t1 to $fp-8
	  b _L41		# unconditional branch
  _L40:
	# _tmp368 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp369 = 21
	  li $t2, 21		# load constant value 21 into $t2
	# _tmp370 = _tmp369 < _tmp368
	  slt $t3, $t2, $t1	
	# IfZ _tmp370 Goto _L42
	  sw $t3, -64($fp)	# spill _tmp370 from $t3 to $fp-64
	  beqz $t3, _L42	# branch if _tmp370 is zero 
	# _tmp371 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp371
	  move $t1, $t0		# copy value to register for lose
	# Goto _L43
	  sw $t1, -12($fp)	# spill lose from $t1 to $fp-12
	  b _L43		# unconditional branch
  _L42:
	# _tmp372 = 21
	  li $t0, 21		# load constant value 21 into $t0
	# _tmp373 = _tmp372 < dealer
	  lw $t1, 8($fp)	# fill dealer to $t1 from $fp+8
	  slt $t2, $t0, $t1	
	# IfZ _tmp373 Goto _L44
	  sw $t2, -76($fp)	# spill _tmp373 from $t2 to $fp-76
	  beqz $t2, _L44	# branch if _tmp373 is zero 
	# _tmp374 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp374
	  move $t1, $t0		# copy value to register for win
	# Goto _L45
	  sw $t1, -8($fp)	# spill win from $t1 to $fp-8
	  b _L45		# unconditional branch
  _L44:
	# _tmp375 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp376 = dealer < _tmp375
	  lw $t2, 8($fp)	# fill dealer to $t2 from $fp+8
	  slt $t3, $t2, $t1	
	# IfZ _tmp376 Goto _L46
	  sw $t3, -88($fp)	# spill _tmp376 from $t3 to $fp-88
	  beqz $t3, _L46	# branch if _tmp376 is zero 
	# _tmp377 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# win = _tmp377
	  move $t1, $t0		# copy value to register for win
	# Goto _L47
	  sw $t1, -8($fp)	# spill win from $t1 to $fp-8
	  b _L47		# unconditional branch
  _L46:
	# _tmp378 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp379 = _tmp378 < dealer
	  lw $t2, 8($fp)	# fill dealer to $t2 from $fp+8
	  slt $t3, $t1, $t2	
	# IfZ _tmp379 Goto _L48
	  sw $t3, -100($fp)	# spill _tmp379 from $t3 to $fp-100
	  beqz $t3, _L48	# branch if _tmp379 is zero 
	# _tmp380 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# lose = _tmp380
	  move $t1, $t0		# copy value to register for lose
	  sw $t1, -12($fp)	# spill lose from $t1 to $fp-12
  _L48:
  _L47:
  _L45:
  _L43:
  _L41:
	# _tmp381 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp382 = _tmp381 < win
	  lw $t1, -8($fp)	# fill win to $t1 from $fp-8
	  slt $t2, $t0, $t1	
	# _tmp383 = _tmp381 == win
	  seq $t3, $t0, $t1	
	# _tmp384 = _tmp382 || _tmp383
	  or $t0, $t2, $t3	
	# IfZ _tmp384 Goto _L49
	  sw $t0, -120($fp)	# spill _tmp384 from $t0 to $fp-120
	  beqz $t0, _L49	# branch if _tmp384 is zero 
	# _tmp385 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp385
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp386 = ", you won $"
	  .data			# create string constant marked with label
	  _string34: .asciiz ", you won $"
	  .text
	  la $t0, _string34	# load label
	# PushParam _tmp386
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp387 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# PushParam _tmp387
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp388 = ".\n"
	  .data			# create string constant marked with label
	  _string35: .asciiz ".\n"
	  .text
	  la $t0, _string35	# load label
	# PushParam _tmp388
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L50
	  b _L50		# unconditional branch
  _L49:
	# _tmp389 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp390 = _tmp389 < lose
	  lw $t1, -12($fp)	# fill lose to $t1 from $fp-12
	  slt $t2, $t0, $t1	
	# _tmp391 = _tmp389 == lose
	  seq $t3, $t0, $t1	
	# _tmp392 = _tmp390 || _tmp391
	  or $t0, $t2, $t3	
	# IfZ _tmp392 Goto _L51
	  sw $t0, -152($fp)	# spill _tmp392 from $t0 to $fp-152
	  beqz $t0, _L51	# branch if _tmp392 is zero 
	# _tmp393 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp393
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp394 = ", you lost $"
	  .data			# create string constant marked with label
	  _string36: .asciiz ", you lost $"
	  .text
	  la $t0, _string36	# load label
	# PushParam _tmp394
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp395 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# PushParam _tmp395
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp396 = ".\n"
	  .data			# create string constant marked with label
	  _string37: .asciiz ".\n"
	  .text
	  la $t0, _string37	# load label
	# PushParam _tmp396
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L52
	  b _L52		# unconditional branch
  _L51:
	# _tmp397 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp397
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp398 = ", you push!\n"
	  .data			# create string constant marked with label
	  _string38: .asciiz ", you push!\n"
	  .text
	  la $t0, _string38	# load label
	# PushParam _tmp398
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L52:
  _L50:
	# _tmp399 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp400 = win * _tmp399
	  lw $t2, -8($fp)	# fill win to $t2 from $fp-8
	  mul $t3, $t2, $t1	
	# win = _tmp400
	  move $t2, $t3		# copy value to register for win
	# _tmp401 = *(this + 8)
	  lw $t1, 8($t0) 	# load with offset
	# _tmp402 = lose * _tmp401
	  lw $t3, -12($fp)	# fill lose to $t3 from $fp-12
	  mul $t4, $t3, $t1	
	# lose = _tmp402
	  move $t3, $t4		# copy value to register for lose
	# _tmp403 = *(this + 12)
	  lw $t1, 12($t0) 	# load with offset
	# _tmp404 = _tmp403 + win
	  add $t4, $t1, $t2	
	# _tmp405 = _tmp404 - lose
	  sub $t1, $t4, $t3	
	# *(this + 12) = _tmp405
	  sw $t1, 12($t0) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Player
	  .data
	  .align 2
	  Player:		# label for class Player vtable
	  .word _Player.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Player.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _Dealer.Init:
	# BeginFunc 16
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 16	# decrement sp to make space for locals/temps
	# _tmp406 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 24) = _tmp406
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 24($t1) 	# store with offset
	# _tmp407 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 4) = _tmp407
	  sw $t0, 4($t1) 	# store with offset
	# _tmp408 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# *(this + 20) = _tmp408
	  sw $t0, 20($t1) 	# store with offset
	# _tmp409 = "Dealer"
	  .data			# create string constant marked with label
	  _string39: .asciiz "Dealer"
	  .text
	  la $t0, _string39	# load label
	# *(this + 16) = _tmp409
	  sw $t0, 16($t1) 	# store with offset
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _Dealer.TakeTurn:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp410 = "\n"
	  .data			# create string constant marked with label
	  _string40: .asciiz "\n"
	  .text
	  la $t0, _string40	# load label
	# PushParam _tmp410
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp411 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp411
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp412 = "'s turn.\n"
	  .data			# create string constant marked with label
	  _string41: .asciiz "'s turn.\n"
	  .text
	  la $t0, _string41	# load label
	# PushParam _tmp412
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L53:
	# _tmp413 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp414 = 16
	  li $t2, 16		# load constant value 16 into $t2
	# _tmp415 = _tmp413 < _tmp414
	  slt $t3, $t1, $t2	
	# _tmp416 = _tmp413 == _tmp414
	  seq $t4, $t1, $t2	
	# _tmp417 = _tmp415 || _tmp416
	  or $t1, $t3, $t4	
	# IfZ _tmp417 Goto _L54
	  sw $t1, -36($fp)	# spill _tmp417 from $t1 to $fp-36
	  beqz $t1, _L54	# branch if _tmp417 is zero 
	# _tmp418 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp419 = *(_tmp418 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam deck
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, 8($fp)	# fill deck to $t1 from $fp+8
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp419
	  sw $t2, -44($fp)	# spill _tmp419 from $t2 to $fp-44
	  jalr $t2            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# Goto _L53
	  b _L53		# unconditional branch
  _L54:
	# _tmp420 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# _tmp421 = 21
	  li $t2, 21		# load constant value 21 into $t2
	# _tmp422 = _tmp421 < _tmp420
	  slt $t3, $t2, $t1	
	# IfZ _tmp422 Goto _L55
	  sw $t3, -56($fp)	# spill _tmp422 from $t3 to $fp-56
	  beqz $t3, _L55	# branch if _tmp422 is zero 
	# _tmp423 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp423
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp424 = " busts with the big "
	  .data			# create string constant marked with label
	  _string42: .asciiz " busts with the big "
	  .text
	  la $t0, _string42	# load label
	# PushParam _tmp424
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp425 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp425
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp426 = "!\n"
	  .data			# create string constant marked with label
	  _string43: .asciiz "!\n"
	  .text
	  la $t0, _string43	# load label
	# PushParam _tmp426
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# Goto _L56
	  b _L56		# unconditional branch
  _L55:
	# _tmp427 = *(this + 16)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 16($t0) 	# load with offset
	# PushParam _tmp427
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp428 = " stays at "
	  .data			# create string constant marked with label
	  _string44: .asciiz " stays at "
	  .text
	  la $t0, _string44	# load label
	# PushParam _tmp428
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp429 = *(this + 24)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 24($t0) 	# load with offset
	# PushParam _tmp429
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# LCall _PrintInt
	  jal _PrintInt      	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp430 = ".\n"
	  .data			# create string constant marked with label
	  _string45: .asciiz ".\n"
	  .text
	  la $t0, _string45	# load label
	# PushParam _tmp430
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L56:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class Dealer
	  .data
	  .align 2
	  Dealer:		# label for class Dealer vtable
	  .word _Dealer.Init
	  .word _Player.Hit
	  .word _Player.DoubleDown
	  .word _Dealer.TakeTurn
	  .word _Player.HasMoney
	  .word _Player.PrintMoney
	  .word _Player.PlaceBet
	  .word _Player.GetTotal
	  .word _Player.Resolve
	  .text
  _House.SetupGame:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp431 = "\nWelcome to CS143 BlackJack!\n"
	  .data			# create string constant marked with label
	  _string46: .asciiz "\nWelcome to CS143 BlackJack!\n"
	  .text
	  la $t0, _string46	# load label
	# PushParam _tmp431
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp432 = "---------------------------\n"
	  .data			# create string constant marked with label
	  _string47: .asciiz "---------------------------\n"
	  .text
	  la $t0, _string47	# load label
	# PushParam _tmp432
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp433 = 8
	  li $t0, 8		# load constant value 8 into $t0
	# PushParam _tmp433
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp434 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp435 = Random
	  la $t1, Random	# load label
	# *(_tmp434) = _tmp435
	  sw $t1, 0($t0) 	# store with offset
	# gRnd = _tmp434
	  move $t1, $t0		# copy value to register for gRnd
	# _tmp436 = "Please enter a random number seed: "
	  .data			# create string constant marked with label
	  _string48: .asciiz "Please enter a random number seed: "
	  .text
	  la $t0, _string48	# load label
	# PushParam _tmp436
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  sw $t1, 0($gp)	# spill gRnd from $t1 to $gp+0
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp437 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# _tmp438 = *(gRnd)
	  lw $t1, 0($gp)	# fill gRnd to $t1 from $gp+0
	  lw $t2, 0($t1) 	# load with offset
	# _tmp439 = *(_tmp438)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp437
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam gRnd
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp439
	  sw $t3, -40($fp)	# spill _tmp439 from $t3 to $fp-40
	  jalr $t3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp440 = 12
	  li $t0, 12		# load constant value 12 into $t0
	# PushParam _tmp440
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp441 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp442 = BJDeck
	  la $t1, BJDeck	# load label
	# *(_tmp441) = _tmp442
	  sw $t1, 0($t0) 	# store with offset
	# *(this + 12) = _tmp441
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 12($t1) 	# store with offset
	# _tmp443 = 28
	  li $t0, 28		# load constant value 28 into $t0
	# PushParam _tmp443
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp444 = LCall _Alloc
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp445 = Dealer
	  la $t1, Dealer	# load label
	# *(_tmp444) = _tmp445
	  sw $t1, 0($t0) 	# store with offset
	# *(this + 8) = _tmp444
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  sw $t0, 8($t1) 	# store with offset
	# _tmp446 = *(this + 12)
	  lw $t0, 12($t1) 	# load with offset
	# _tmp447 = *(_tmp446)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp448 = *(_tmp447)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp446
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp448
	  sw $t3, -76($fp)	# spill _tmp448 from $t3 to $fp-76
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp449 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp450 = *(_tmp449)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp451 = *(_tmp450 + 8)
	  lw $t2, 8($t0) 	# load with offset
	# PushParam _tmp449
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp451
	  sw $t2, -88($fp)	# spill _tmp451 from $t2 to $fp-88
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.SetupPlayers:
	# BeginFunc 196
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 196	# decrement sp to make space for locals/temps
	# _tmp452 = "How many players do we have today? "
	  .data			# create string constant marked with label
	  _string49: .asciiz "How many players do we have today? "
	  .text
	  la $t0, _string49	# load label
	# PushParam _tmp452
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp453 = LCall _ReadInteger
	  jal _ReadInteger   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# numPlayers = _tmp453
	  move $t1, $t0		# copy value to register for numPlayers
	# _tmp454 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp455 = numPlayers < _tmp454
	  slt $t2, $t1, $t0	
	# IfZ _tmp455 Goto _L57
	  sw $t1, -12($fp)	# spill numPlayers from $t1 to $fp-12
	  sw $t2, -28($fp)	# spill _tmp455 from $t2 to $fp-28
	  beqz $t2, _L57	# branch if _tmp455 is zero 
	# _tmp456 = "Decaf runtime error: Array size is <= 0\n"
	  .data			# create string constant marked with label
	  _string50: .asciiz "Decaf runtime error: Array size is <= 0\n"
	  .text
	  la $t0, _string50	# load label
	# PushParam _tmp456
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L57:
	# _tmp457 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp458 = _tmp457 + numPlayers
	  lw $t1, -12($fp)	# fill numPlayers to $t1 from $fp-12
	  add $t2, $t0, $t1	
	# _tmp459 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp460 = _tmp458 * _tmp459
	  mul $t3, $t2, $t0	
	# PushParam _tmp460
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t3, 4($sp)	# copy param value to stack
	# _tmp461 = LCall _Alloc
	  sw $t0, -44($fp)	# spill _tmp459 from $t0 to $fp-44
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# *(_tmp461) = numPlayers
	  lw $t1, -12($fp)	# fill numPlayers to $t1 from $fp-12
	  sw $t1, 0($t0) 	# store with offset
	# _tmp462 = _tmp461 + _tmp459
	  lw $t1, -44($fp)	# fill _tmp459 to $t1 from $fp-44
	  add $t2, $t0, $t1	
	# *(this + 4) = _tmp462
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  sw $t2, 4($t0) 	# store with offset
	# _tmp463 = 0
	  li $t1, 0		# load constant value 0 into $t1
	# i = _tmp463
	  move $t2, $t1		# copy value to register for i
	  sw $t2, -8($fp)	# spill i from $t2 to $fp-8
  _L58:
	# _tmp464 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp465 = *(_tmp464 + -4)
	  lw $t2, -4($t1) 	# load with offset
	# _tmp466 = i < _tmp465
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t3, $t1, $t2	
	# IfZ _tmp466 Goto _L59
	  sw $t3, -72($fp)	# spill _tmp466 from $t3 to $fp-72
	  beqz $t3, _L59	# branch if _tmp466 is zero 
	# _tmp467 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp468 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp469 = i < _tmp468
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp470 = *(_tmp467 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp471 = i < _tmp470
	  slt $t6, $t3, $t5	
	# _tmp472 = _tmp471 == _tmp468
	  seq $t5, $t6, $t2	
	# _tmp473 = _tmp469 || _tmp472
	  or $t2, $t4, $t5	
	# IfZ _tmp473 Goto _L60
	  sw $t1, -76($fp)	# spill _tmp467 from $t1 to $fp-76
	  sw $t2, -100($fp)	# spill _tmp473 from $t2 to $fp-100
	  beqz $t2, _L60	# branch if _tmp473 is zero 
	# _tmp474 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string51: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string51	# load label
	# PushParam _tmp474
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L60:
	# _tmp475 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp476 = _tmp475 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp477 = _tmp467 + _tmp476
	  lw $t0, -76($fp)	# fill _tmp467 to $t0 from $fp-76
	  add $t3, $t0, $t2	
	# _tmp478 = 28
	  li $t0, 28		# load constant value 28 into $t0
	# PushParam _tmp478
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp479 = LCall _Alloc
	  sw $t3, -116($fp)	# spill _tmp477 from $t3 to $fp-116
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp480 = Player
	  la $t1, Player	# load label
	# *(_tmp479) = _tmp480
	  sw $t1, 0($t0) 	# store with offset
	# *(_tmp477) = _tmp479
	  lw $t1, -116($fp)	# fill _tmp477 to $t1 from $fp-116
	  sw $t0, 0($t1) 	# store with offset
	# _tmp481 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp482 = i + _tmp481
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# _tmp483 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t3, 4($t0) 	# load with offset
	# _tmp484 = 0
	  li $t4, 0		# load constant value 0 into $t4
	# _tmp485 = i < _tmp484
	  slt $t5, $t1, $t4	
	# _tmp486 = *(_tmp483 + -4)
	  lw $t6, -4($t3) 	# load with offset
	# _tmp487 = i < _tmp486
	  slt $t9, $t1, $t6	
	  sw $t9, -156($fp)	# spill _tmp487 from $t9 to $fp-156
	# _tmp488 = _tmp487 == _tmp484
	  lw $t6, -156($fp)	# fill _tmp487 to $t6 from $fp-156
	  seq $t9, $t6, $t4	
	  sw $t9, -160($fp)	# spill _tmp488 from $t9 to $fp-160
	# _tmp489 = _tmp485 || _tmp488
	  lw $t4, -160($fp)	# fill _tmp488 to $t4 from $fp-160
	  or $t6, $t5, $t4	
	# IfZ _tmp489 Goto _L61
	  sw $t2, -136($fp)	# spill _tmp482 from $t2 to $fp-136
	  sw $t3, -140($fp)	# spill _tmp483 from $t3 to $fp-140
	  sw $t6, -164($fp)	# spill _tmp489 from $t6 to $fp-164
	  beqz $t6, _L61	# branch if _tmp489 is zero 
	# _tmp490 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string52: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string52	# load label
	# PushParam _tmp490
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L61:
	# _tmp491 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp492 = _tmp491 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp493 = _tmp483 + _tmp492
	  lw $t0, -140($fp)	# fill _tmp483 to $t0 from $fp-140
	  add $t3, $t0, $t2	
	# _tmp494 = *(_tmp493)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp495 = *(_tmp494)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp496 = *(_tmp495)
	  lw $t3, 0($t2) 	# load with offset
	# PushParam _tmp482
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t2, -136($fp)	# fill _tmp482 to $t2 from $fp-136
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp494
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp496
	  sw $t3, -192($fp)	# spill _tmp496 from $t3 to $fp-192
	  jalr $t3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp497 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp498 = i + _tmp497
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp498
	  move $t1, $t2		# copy value to register for i
	# Goto _L58
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L58		# unconditional branch
  _L59:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllBets:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	# _tmp499 = "\nFirst, let's take bets.\n"
	  .data			# create string constant marked with label
	  _string53: .asciiz "\nFirst, let's take bets.\n"
	  .text
	  la $t0, _string53	# load label
	# PushParam _tmp499
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp500 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp500
	  move $t1, $t0		# copy value to register for i
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
  _L62:
	# _tmp501 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp502 = *(_tmp501 + -4)
	  lw $t2, -4($t1) 	# load with offset
	# _tmp503 = i < _tmp502
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t3, $t1, $t2	
	# IfZ _tmp503 Goto _L63
	  sw $t3, -28($fp)	# spill _tmp503 from $t3 to $fp-28
	  beqz $t3, _L63	# branch if _tmp503 is zero 
	# _tmp504 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp505 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp506 = i < _tmp505
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp507 = *(_tmp504 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp508 = i < _tmp507
	  slt $t6, $t3, $t5	
	# _tmp509 = _tmp508 == _tmp505
	  seq $t5, $t6, $t2	
	# _tmp510 = _tmp506 || _tmp509
	  or $t2, $t4, $t5	
	# IfZ _tmp510 Goto _L64
	  sw $t1, -32($fp)	# spill _tmp504 from $t1 to $fp-32
	  sw $t2, -56($fp)	# spill _tmp510 from $t2 to $fp-56
	  beqz $t2, _L64	# branch if _tmp510 is zero 
	# _tmp511 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string54: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string54	# load label
	# PushParam _tmp511
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L64:
	# _tmp512 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp513 = _tmp512 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp514 = _tmp504 + _tmp513
	  lw $t0, -32($fp)	# fill _tmp504 to $t0 from $fp-32
	  add $t3, $t0, $t2	
	# _tmp515 = *(_tmp514)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp516 = *(_tmp515)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp517 = *(_tmp516 + 16)
	  lw $t3, 16($t2) 	# load with offset
	# PushParam _tmp515
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp518 = ACall _tmp517
	  sw $t3, -84($fp)	# spill _tmp517 from $t3 to $fp-84
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp518 Goto _L65
	  sw $t0, -88($fp)	# spill _tmp518 from $t0 to $fp-88
	  beqz $t0, _L65	# branch if _tmp518 is zero 
	# _tmp519 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp520 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp521 = i < _tmp520
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp522 = *(_tmp519 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp523 = i < _tmp522
	  slt $t6, $t3, $t5	
	# _tmp524 = _tmp523 == _tmp520
	  seq $t5, $t6, $t2	
	# _tmp525 = _tmp521 || _tmp524
	  or $t2, $t4, $t5	
	# IfZ _tmp525 Goto _L66
	  sw $t1, -92($fp)	# spill _tmp519 from $t1 to $fp-92
	  sw $t2, -116($fp)	# spill _tmp525 from $t2 to $fp-116
	  beqz $t2, _L66	# branch if _tmp525 is zero 
	# _tmp526 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string55: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string55	# load label
	# PushParam _tmp526
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L66:
	# _tmp527 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp528 = _tmp527 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp529 = _tmp519 + _tmp528
	  lw $t0, -92($fp)	# fill _tmp519 to $t0 from $fp-92
	  add $t3, $t0, $t2	
	# _tmp530 = *(_tmp529)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp531 = *(_tmp530)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp532 = *(_tmp531 + 24)
	  lw $t3, 24($t2) 	# load with offset
	# PushParam _tmp530
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp532
	  sw $t3, -144($fp)	# spill _tmp532 from $t3 to $fp-144
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L65:
	# _tmp533 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp534 = i + _tmp533
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp534
	  move $t1, $t2		# copy value to register for i
	# Goto _L62
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L62		# unconditional branch
  _L63:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.TakeAllTurns:
	# BeginFunc 148
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 148	# decrement sp to make space for locals/temps
	# _tmp535 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp535
	  move $t1, $t0		# copy value to register for i
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
  _L67:
	# _tmp536 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp537 = *(_tmp536 + -4)
	  lw $t2, -4($t1) 	# load with offset
	# _tmp538 = i < _tmp537
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t3, $t1, $t2	
	# IfZ _tmp538 Goto _L68
	  sw $t3, -24($fp)	# spill _tmp538 from $t3 to $fp-24
	  beqz $t3, _L68	# branch if _tmp538 is zero 
	# _tmp539 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp540 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp541 = i < _tmp540
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp542 = *(_tmp539 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp543 = i < _tmp542
	  slt $t6, $t3, $t5	
	# _tmp544 = _tmp543 == _tmp540
	  seq $t5, $t6, $t2	
	# _tmp545 = _tmp541 || _tmp544
	  or $t2, $t4, $t5	
	# IfZ _tmp545 Goto _L69
	  sw $t1, -28($fp)	# spill _tmp539 from $t1 to $fp-28
	  sw $t2, -52($fp)	# spill _tmp545 from $t2 to $fp-52
	  beqz $t2, _L69	# branch if _tmp545 is zero 
	# _tmp546 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string56: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string56	# load label
	# PushParam _tmp546
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L69:
	# _tmp547 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp548 = _tmp547 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp549 = _tmp539 + _tmp548
	  lw $t0, -28($fp)	# fill _tmp539 to $t0 from $fp-28
	  add $t3, $t0, $t2	
	# _tmp550 = *(_tmp549)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp551 = *(_tmp550)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp552 = *(_tmp551 + 16)
	  lw $t3, 16($t2) 	# load with offset
	# PushParam _tmp550
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp553 = ACall _tmp552
	  sw $t3, -80($fp)	# spill _tmp552 from $t3 to $fp-80
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp553 Goto _L70
	  sw $t0, -84($fp)	# spill _tmp553 from $t0 to $fp-84
	  beqz $t0, _L70	# branch if _tmp553 is zero 
	# _tmp554 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp555 = *(this + 4)
	  lw $t2, 4($t0) 	# load with offset
	# _tmp556 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp557 = i < _tmp556
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	  slt $t5, $t4, $t3	
	# _tmp558 = *(_tmp555 + -4)
	  lw $t6, -4($t2) 	# load with offset
	# _tmp559 = i < _tmp558
	  slt $t9, $t4, $t6	
	  sw $t9, -108($fp)	# spill _tmp559 from $t9 to $fp-108
	# _tmp560 = _tmp559 == _tmp556
	  lw $t6, -108($fp)	# fill _tmp559 to $t6 from $fp-108
	  seq $t9, $t6, $t3	
	  sw $t9, -112($fp)	# spill _tmp560 from $t9 to $fp-112
	# _tmp561 = _tmp557 || _tmp560
	  lw $t3, -112($fp)	# fill _tmp560 to $t3 from $fp-112
	  or $t6, $t5, $t3	
	# IfZ _tmp561 Goto _L71
	  sw $t1, -88($fp)	# spill _tmp554 from $t1 to $fp-88
	  sw $t2, -92($fp)	# spill _tmp555 from $t2 to $fp-92
	  sw $t6, -116($fp)	# spill _tmp561 from $t6 to $fp-116
	  beqz $t6, _L71	# branch if _tmp561 is zero 
	# _tmp562 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string57: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string57	# load label
	# PushParam _tmp562
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L71:
	# _tmp563 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp564 = _tmp563 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp565 = _tmp555 + _tmp564
	  lw $t0, -92($fp)	# fill _tmp555 to $t0 from $fp-92
	  add $t3, $t0, $t2	
	# _tmp566 = *(_tmp565)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp567 = *(_tmp566)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp568 = *(_tmp567 + 12)
	  lw $t3, 12($t2) 	# load with offset
	# PushParam _tmp554
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t2, -88($fp)	# fill _tmp554 to $t2 from $fp-88
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp566
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp568
	  sw $t3, -144($fp)	# spill _tmp568 from $t3 to $fp-144
	  jalr $t3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L70:
	# _tmp569 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp570 = i + _tmp569
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp570
	  move $t1, $t2		# copy value to register for i
	# Goto _L67
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L67		# unconditional branch
  _L68:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.ResolveAllPlayers:
	# BeginFunc 164
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 164	# decrement sp to make space for locals/temps
	# _tmp571 = "\nTime to resolve bets.\n"
	  .data			# create string constant marked with label
	  _string58: .asciiz "\nTime to resolve bets.\n"
	  .text
	  la $t0, _string58	# load label
	# PushParam _tmp571
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp572 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp572
	  move $t1, $t0		# copy value to register for i
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
  _L72:
	# _tmp573 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp574 = *(_tmp573 + -4)
	  lw $t2, -4($t1) 	# load with offset
	# _tmp575 = i < _tmp574
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t3, $t1, $t2	
	# IfZ _tmp575 Goto _L73
	  sw $t3, -28($fp)	# spill _tmp575 from $t3 to $fp-28
	  beqz $t3, _L73	# branch if _tmp575 is zero 
	# _tmp576 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp577 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp578 = i < _tmp577
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp579 = *(_tmp576 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp580 = i < _tmp579
	  slt $t6, $t3, $t5	
	# _tmp581 = _tmp580 == _tmp577
	  seq $t5, $t6, $t2	
	# _tmp582 = _tmp578 || _tmp581
	  or $t2, $t4, $t5	
	# IfZ _tmp582 Goto _L74
	  sw $t1, -32($fp)	# spill _tmp576 from $t1 to $fp-32
	  sw $t2, -56($fp)	# spill _tmp582 from $t2 to $fp-56
	  beqz $t2, _L74	# branch if _tmp582 is zero 
	# _tmp583 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string59: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string59	# load label
	# PushParam _tmp583
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L74:
	# _tmp584 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp585 = _tmp584 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp586 = _tmp576 + _tmp585
	  lw $t0, -32($fp)	# fill _tmp576 to $t0 from $fp-32
	  add $t3, $t0, $t2	
	# _tmp587 = *(_tmp586)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp588 = *(_tmp587)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp589 = *(_tmp588 + 16)
	  lw $t3, 16($t2) 	# load with offset
	# PushParam _tmp587
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp590 = ACall _tmp589
	  sw $t3, -84($fp)	# spill _tmp589 from $t3 to $fp-84
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# IfZ _tmp590 Goto _L75
	  sw $t0, -88($fp)	# spill _tmp590 from $t0 to $fp-88
	  beqz $t0, _L75	# branch if _tmp590 is zero 
	# _tmp591 = *(this + 8)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 8($t0) 	# load with offset
	# _tmp592 = *(_tmp591)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp593 = *(_tmp592 + 28)
	  lw $t3, 28($t2) 	# load with offset
	# PushParam _tmp591
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp594 = ACall _tmp593
	  sw $t3, -100($fp)	# spill _tmp593 from $t3 to $fp-100
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp595 = *(this + 4)
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  lw $t2, 4($t1) 	# load with offset
	# _tmp596 = 0
	  li $t3, 0		# load constant value 0 into $t3
	# _tmp597 = i < _tmp596
	  lw $t4, -8($fp)	# fill i to $t4 from $fp-8
	  slt $t5, $t4, $t3	
	# _tmp598 = *(_tmp595 + -4)
	  lw $t6, -4($t2) 	# load with offset
	# _tmp599 = i < _tmp598
	  slt $t9, $t4, $t6	
	  sw $t9, -124($fp)	# spill _tmp599 from $t9 to $fp-124
	# _tmp600 = _tmp599 == _tmp596
	  lw $t6, -124($fp)	# fill _tmp599 to $t6 from $fp-124
	  seq $t9, $t6, $t3	
	  sw $t9, -128($fp)	# spill _tmp600 from $t9 to $fp-128
	# _tmp601 = _tmp597 || _tmp600
	  lw $t3, -128($fp)	# fill _tmp600 to $t3 from $fp-128
	  or $t6, $t5, $t3	
	# IfZ _tmp601 Goto _L76
	  sw $t0, -104($fp)	# spill _tmp594 from $t0 to $fp-104
	  sw $t2, -108($fp)	# spill _tmp595 from $t2 to $fp-108
	  sw $t6, -132($fp)	# spill _tmp601 from $t6 to $fp-132
	  beqz $t6, _L76	# branch if _tmp601 is zero 
	# _tmp602 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string60: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string60	# load label
	# PushParam _tmp602
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L76:
	# _tmp603 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp604 = _tmp603 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp605 = _tmp595 + _tmp604
	  lw $t0, -108($fp)	# fill _tmp595 to $t0 from $fp-108
	  add $t3, $t0, $t2	
	# _tmp606 = *(_tmp605)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp607 = *(_tmp606)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp608 = *(_tmp607 + 32)
	  lw $t3, 32($t2) 	# load with offset
	# PushParam _tmp594
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t2, -104($fp)	# fill _tmp594 to $t2 from $fp-104
	  sw $t2, 4($sp)	# copy param value to stack
	# PushParam _tmp606
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp608
	  sw $t3, -160($fp)	# spill _tmp608 from $t3 to $fp-160
	  jalr $t3            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
  _L75:
	# _tmp609 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp610 = i + _tmp609
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp610
	  move $t1, $t2		# copy value to register for i
	# Goto _L72
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L72		# unconditional branch
  _L73:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PrintAllMoney:
	# BeginFunc 84
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 84	# decrement sp to make space for locals/temps
	# _tmp611 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# i = _tmp611
	  move $t1, $t0		# copy value to register for i
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
  _L77:
	# _tmp612 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp613 = *(_tmp612 + -4)
	  lw $t2, -4($t1) 	# load with offset
	# _tmp614 = i < _tmp613
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  slt $t3, $t1, $t2	
	# IfZ _tmp614 Goto _L78
	  sw $t3, -24($fp)	# spill _tmp614 from $t3 to $fp-24
	  beqz $t3, _L78	# branch if _tmp614 is zero 
	# _tmp615 = *(this + 4)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 4($t0) 	# load with offset
	# _tmp616 = 0
	  li $t2, 0		# load constant value 0 into $t2
	# _tmp617 = i < _tmp616
	  lw $t3, -8($fp)	# fill i to $t3 from $fp-8
	  slt $t4, $t3, $t2	
	# _tmp618 = *(_tmp615 + -4)
	  lw $t5, -4($t1) 	# load with offset
	# _tmp619 = i < _tmp618
	  slt $t6, $t3, $t5	
	# _tmp620 = _tmp619 == _tmp616
	  seq $t5, $t6, $t2	
	# _tmp621 = _tmp617 || _tmp620
	  or $t2, $t4, $t5	
	# IfZ _tmp621 Goto _L79
	  sw $t1, -28($fp)	# spill _tmp615 from $t1 to $fp-28
	  sw $t2, -52($fp)	# spill _tmp621 from $t2 to $fp-52
	  beqz $t2, _L79	# branch if _tmp621 is zero 
	# _tmp622 = "Decaf runtime error: Array subscript out of bound..."
	  .data			# create string constant marked with label
	  _string61: .asciiz "Decaf runtime error: Array subscript out of bounds\n"
	  .text
	  la $t0, _string61	# load label
	# PushParam _tmp622
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# LCall _Halt
	  jal _Halt          	# jump to function
  _L79:
	# _tmp623 = 4
	  li $t0, 4		# load constant value 4 into $t0
	# _tmp624 = _tmp623 * i
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  mul $t2, $t0, $t1	
	# _tmp625 = _tmp615 + _tmp624
	  lw $t0, -28($fp)	# fill _tmp615 to $t0 from $fp-28
	  add $t3, $t0, $t2	
	# _tmp626 = *(_tmp625)
	  lw $t0, 0($t3) 	# load with offset
	# _tmp627 = *(_tmp626)
	  lw $t2, 0($t0) 	# load with offset
	# _tmp628 = *(_tmp627 + 20)
	  lw $t3, 20($t2) 	# load with offset
	# PushParam _tmp626
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp628
	  sw $t3, -80($fp)	# spill _tmp628 from $t3 to $fp-80
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp629 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# _tmp630 = i + _tmp629
	  lw $t1, -8($fp)	# fill i to $t1 from $fp-8
	  add $t2, $t1, $t0	
	# i = _tmp630
	  move $t1, $t2		# copy value to register for i
	# Goto _L77
	  sw $t1, -8($fp)	# spill i from $t1 to $fp-8
	  b _L77		# unconditional branch
  _L78:
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  _House.PlayOneGame:
	# BeginFunc 112
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 112	# decrement sp to make space for locals/temps
	# _tmp631 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp632 = *(_tmp631)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp633 = *(_tmp632 + 12)
	  lw $t3, 12($t2) 	# load with offset
	# PushParam _tmp631
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp634 = ACall _tmp633
	  sw $t3, -16($fp)	# spill _tmp633 from $t3 to $fp-16
	  jalr $t3            	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp635 = 26
	  li $t1, 26		# load constant value 26 into $t1
	# _tmp636 = _tmp634 < _tmp635
	  slt $t2, $t0, $t1	
	# IfZ _tmp636 Goto _L80
	  sw $t2, -28($fp)	# spill _tmp636 from $t2 to $fp-28
	  beqz $t2, _L80	# branch if _tmp636 is zero 
	# _tmp637 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp638 = *(_tmp637)
	  lw $t2, 0($t1) 	# load with offset
	# _tmp639 = *(_tmp638 + 8)
	  lw $t3, 8($t2) 	# load with offset
	# PushParam _tmp637
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp639
	  sw $t3, -40($fp)	# spill _tmp639 from $t3 to $fp-40
	  jalr $t3            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L80:
	# _tmp640 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp641 = *(_tmp640 + 8)
	  lw $t2, 8($t1) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp641
	  sw $t2, -48($fp)	# spill _tmp641 from $t2 to $fp-48
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp642 = "\nDealer starts. "
	  .data			# create string constant marked with label
	  _string62: .asciiz "\nDealer starts. "
	  .text
	  la $t0, _string62	# load label
	# PushParam _tmp642
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp643 = 0
	  li $t0, 0		# load constant value 0 into $t0
	# _tmp644 = *(this + 8)
	  lw $t1, 4($fp)	# fill this to $t1 from $fp+4
	  lw $t2, 8($t1) 	# load with offset
	# _tmp645 = *(_tmp644)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp646 = *(_tmp645)
	  lw $t4, 0($t3) 	# load with offset
	# PushParam _tmp643
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam _tmp644
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp646
	  sw $t4, -68($fp)	# spill _tmp646 from $t4 to $fp-68
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp647 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp648 = *(this + 8)
	  lw $t2, 8($t0) 	# load with offset
	# _tmp649 = *(_tmp648)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp650 = *(_tmp649 + 4)
	  lw $t4, 4($t3) 	# load with offset
	# PushParam _tmp647
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam _tmp648
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp650
	  sw $t4, -84($fp)	# spill _tmp650 from $t4 to $fp-84
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp651 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp652 = *(_tmp651 + 12)
	  lw $t2, 12($t1) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp652
	  sw $t2, -92($fp)	# spill _tmp652 from $t2 to $fp-92
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp653 = *(this + 12)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 12($t0) 	# load with offset
	# _tmp654 = *(this + 8)
	  lw $t2, 8($t0) 	# load with offset
	# _tmp655 = *(_tmp654)
	  lw $t3, 0($t2) 	# load with offset
	# _tmp656 = *(_tmp655 + 12)
	  lw $t4, 12($t3) 	# load with offset
	# PushParam _tmp653
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam _tmp654
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t2, 4($sp)	# copy param value to stack
	# ACall _tmp656
	  sw $t4, -108($fp)	# spill _tmp656 from $t4 to $fp-108
	  jalr $t4            	# jump to function
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp657 = *(this)
	  lw $t0, 4($fp)	# fill this to $t0 from $fp+4
	  lw $t1, 0($t0) 	# load with offset
	# _tmp658 = *(_tmp657 + 16)
	  lw $t2, 16($t1) 	# load with offset
	# PushParam this
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp658
	  sw $t2, -116($fp)	# spill _tmp658 from $t2 to $fp-116
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# VTable for class House
	  .data
	  .align 2
	  House:		# label for class House vtable
	  .word _House.SetupGame
	  .word _House.SetupPlayers
	  .word _House.TakeAllBets
	  .word _House.TakeAllTurns
	  .word _House.ResolveAllPlayers
	  .word _House.PrintAllMoney
	  .word _House.PlayOneGame
	  .text
  _GetYesOrNo:
	# BeginFunc 32
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 32	# decrement sp to make space for locals/temps
	# PushParam prompt
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t0, 4($fp)	# fill prompt to $t0 from $fp+4
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp659 = " (y/n) "
	  .data			# create string constant marked with label
	  _string63: .asciiz " (y/n) "
	  .text
	  la $t0, _string63	# load label
	# PushParam _tmp659
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp660 = LCall _ReadLine
	  jal _ReadLine      	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# answer = _tmp660
	  move $t1, $t0		# copy value to register for answer
	# _tmp661 = "y"
	  .data			# create string constant marked with label
	  _string64: .asciiz "y"
	  .text
	  la $t0, _string64	# load label
	# PushParam _tmp661
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp662 = LCall _StringEqual
	  sw $t1, -8($fp)	# spill answer from $t1 to $fp-8
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp663 = "Y"
	  .data			# create string constant marked with label
	  _string65: .asciiz "Y"
	  .text
	  la $t1, _string65	# load label
	# PushParam _tmp663
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# PushParam answer
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  lw $t1, -8($fp)	# fill answer to $t1 from $fp-8
	  sw $t1, 4($sp)	# copy param value to stack
	# _tmp664 = LCall _StringEqual
	  sw $t0, -24($fp)	# spill _tmp662 from $t0 to $fp-24
	  jal _StringEqual   	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 8
	  add $sp, $sp, 8	# pop params off stack
	# _tmp665 = _tmp662 || _tmp664
	  lw $t1, -24($fp)	# fill _tmp662 to $t1 from $fp-24
	  or $t2, $t1, $t0	
	# Return _tmp665
	  move $v0, $t2		# assign return value into $v0
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
  main:
	# BeginFunc 76
	  subu $sp, $sp, 8	# decrement sp to make space to save ra, fp
	  sw $fp, 8($sp)	# save fp
	  sw $ra, 4($sp)	# save ra
	  addiu $fp, $sp, 8	# set up new fp
	  subu $sp, $sp, 76	# decrement sp to make space for locals/temps
	# _tmp666 = 1
	  li $t0, 1		# load constant value 1 into $t0
	# keepPlaying = _tmp666
	  move $t1, $t0		# copy value to register for keepPlaying
	# _tmp667 = 16
	  li $t0, 16		# load constant value 16 into $t0
	# PushParam _tmp667
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp668 = LCall _Alloc
	  sw $t1, -8($fp)	# spill keepPlaying from $t1 to $fp-8
	  jal _Alloc         	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp669 = House
	  la $t1, House	# load label
	# *(_tmp668) = _tmp669
	  sw $t1, 0($t0) 	# store with offset
	# house = _tmp668
	  move $t1, $t0		# copy value to register for house
	# _tmp670 = *(house)
	  lw $t0, 0($t1) 	# load with offset
	# _tmp671 = *(_tmp670)
	  lw $t2, 0($t0) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t1, 4($sp)	# copy param value to stack
	# ACall _tmp671
	  sw $t1, -12($fp)	# spill house from $t1 to $fp-12
	  sw $t2, -36($fp)	# spill _tmp671 from $t2 to $fp-36
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp672 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t1, 0($t0) 	# load with offset
	# _tmp673 = *(_tmp672 + 4)
	  lw $t2, 4($t1) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp673
	  sw $t2, -44($fp)	# spill _tmp673 from $t2 to $fp-44
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
  _L81:
	# IfZ keepPlaying Goto _L82
	  lw $t0, -8($fp)	# fill keepPlaying to $t0 from $fp-8
	  beqz $t0, _L82	# branch if keepPlaying is zero 
	# _tmp674 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t1, 0($t0) 	# load with offset
	# _tmp675 = *(_tmp674 + 24)
	  lw $t2, 24($t1) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp675
	  sw $t2, -52($fp)	# spill _tmp675 from $t2 to $fp-52
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp676 = "\nDo you want to play another hand?"
	  .data			# create string constant marked with label
	  _string66: .asciiz "\nDo you want to play another hand?"
	  .text
	  la $t0, _string66	# load label
	# PushParam _tmp676
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# _tmp677 = LCall _GetYesOrNo
	  jal _GetYesOrNo    	# jump to function
	  move $t0, $v0		# copy function return value from $v0
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# keepPlaying = _tmp677
	  move $t1, $t0		# copy value to register for keepPlaying
	# Goto _L81
	  sw $t1, -8($fp)	# spill keepPlaying from $t1 to $fp-8
	  b _L81		# unconditional branch
  _L82:
	# _tmp678 = *(house)
	  lw $t0, -12($fp)	# fill house to $t0 from $fp-12
	  lw $t1, 0($t0) 	# load with offset
	# _tmp679 = *(_tmp678 + 20)
	  lw $t2, 20($t1) 	# load with offset
	# PushParam house
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# ACall _tmp679
	  sw $t2, -68($fp)	# spill _tmp679 from $t2 to $fp-68
	  jalr $t2            	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp680 = "Thank you for playing...come again soon.\n"
	  .data			# create string constant marked with label
	  _string67: .asciiz "Thank you for playing...come again soon.\n"
	  .text
	  la $t0, _string67	# load label
	# PushParam _tmp680
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp681 = "\nCS143 BlackJack Copyright (c) 1999 by Peter Mor..."
	  .data			# create string constant marked with label
	  _string68: .asciiz "\nCS143 BlackJack Copyright (c) 1999 by Peter Mork.\n"
	  .text
	  la $t0, _string68	# load label
	# PushParam _tmp681
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# _tmp682 = "(2001 mods by jdz)\n"
	  .data			# create string constant marked with label
	  _string69: .asciiz "(2001 mods by jdz)\n"
	  .text
	  la $t0, _string69	# load label
	# PushParam _tmp682
	  subu $sp, $sp, 4	# decrement sp to make space for param
	  sw $t0, 4($sp)	# copy param value to stack
	# LCall _PrintString
	  jal _PrintString   	# jump to function
	# PopParams 4
	  add $sp, $sp, 4	# pop params off stack
	# EndFunc
	# (below handles reaching end of fn body with no explicit return)
	  move $sp, $fp		# pop callee frame off stack
	  lw $ra, -4($fp)	# restore saved ra
	  lw $fp, 0($fp)	# restore saved fp
	  jr $ra		# return from function
_PrintInt:
        subu $sp, $sp, 8
        sw $fp, 8($sp)
        sw $ra, 4($sp)
        addiu $fp, $sp, 8
        li   $v0, 1
        lw   $a0, 4($fp)
        syscall
        move $sp, $fp
        lw $ra, -4($fp)
        lw $fp, 0($fp)
        jr $ra
                                
_PrintString:
        subu $sp, $sp, 8
        sw $fp, 8($sp)
        sw $ra, 4($sp)
        addiu $fp, $sp, 8
        li   $v0, 4
        lw $a0, 4($fp)
        syscall
        move $sp, $fp
        lw $ra, -4($fp)
        lw $fp, 0($fp)
        jr $ra
        
_PrintBool:
	subu $sp, $sp, 8
	sw $fp, 8($sp)
	sw $ra, 4($sp)
        addiu $fp, $sp, 8
	lw $t1, 4($fp)
	blez $t1, fbr
	li   $v0, 4		# system call for print_str
	la   $a0, TRUE		# address of str to print
	syscall			
	b end
fbr:	li   $v0, 4		# system call for print_str
	la   $a0, FALSE		# address of str to print
	syscall				
end:	move $sp, $fp
	lw $ra, -4($fp)
	lw $fp, 0($fp)
	jr $ra

_Alloc:
        subu $sp, $sp, 8
        sw $fp, 8($sp)
        sw $ra, 4($sp)
        addiu $fp, $sp, 8
        li   $v0, 9
        lw $a0, 4($fp)
	syscall
        move $sp, $fp
        lw $ra, -4($fp)
        lw $fp, 0($fp) 
        jr $ra


_StringEqual:
	subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	sw $fp, 8($sp)        # save fp
	sw $ra, 4($sp)        # save ra
	addiu $fp, $sp, 8     # set up new fp
	subu $sp, $sp, 4      # decrement sp to make space for locals/temps

	li $v0,0

	#Determine length string 1
	lw $t0, 4($fp)       
	li $t3,0
bloop1: 
	lb $t5, ($t0) 
	beqz $t5, eloop1	
	addi $t0, $t0, 1
	addi $t3, $t3, 1
	b bloop1
eloop1:

	#Determine length string 2
	lw $t1, 8($fp)
	li $t4,0
bloop2: 
	lb $t5, ($t1) 
	beqz $t5, eloop2	
	addi $t1, $t1, 1
	addi $t4, $t4, 1
	b bloop2
eloop2:
	bne $t3,$t4,end1       #Check String Lengths Same

	lw $t0, 4($fp)       
	lw $t1, 8($fp)
	li $t3, 0     		
bloop3:	
	lb $t5, ($t0) 
	lb $t6, ($t1) 
	bne $t5, $t6, end1
	addi $t3, $t3, 1
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	bne $t3,$t4,bloop3
eloop3:	li $v0,1

end1:	move $sp, $fp         # pop callee frame off stack
	lw $ra, -4($fp)       # restore saved ra
	lw $fp, 0($fp)        # restore saved fp
	jr $ra                # return from function

_Halt:
        li $v0, 10
        syscall

_ReadInteger:
	subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	sw $fp, 8($sp)        # save fp
	sw $ra, 4($sp)        # save ra
	addiu $fp, $sp, 8     # set up new fp
	subu $sp, $sp, 4      # decrement sp to make space for locals/temps
	li $v0, 5
	syscall
	move $sp, $fp         # pop callee frame off stack
	lw $ra, -4($fp)       # restore saved ra
	lw $fp, 0($fp)        # restore saved fp
	jr $ra
        

_ReadLine:
	subu $sp, $sp, 8      # decrement sp to make space to save ra, fp
	sw $fp, 8($sp)        # save fp
	sw $ra, 4($sp)        # save ra
	addiu $fp, $sp, 8     # set up new fp
	subu $sp, $sp, 4      # decrement sp to make space for locals/temps
	li $a0, 128           # request 32 chars, 31 + newline
	li $v0, 9	      	  # load call for sbrk
	syscall               
	li $a1, 128	          # load size and store in buffer      
	move $a0, $v0	      	
	li $v0, 8 
	syscall

	move $t1, $a0
bloop4: 
	lb $t5, ($t1) 
	beqz $t5, eloop4	
	addi $t1, $t1, 1
	b bloop4
eloop4:
	addi $t1, $t1, -1
	li $t6,0
        sb $t6, ($t1)

	move $v0, $a0	      # save buffer location to v0 as return value	
	move $sp, $fp         # pop callee frame off stack
	lw $ra, -4($fp)       # restore saved ra
	lw $fp, 0($fp)        # restore saved fp
	jr $ra
	

	.data
TRUE:.asciiz "true"
FALSE:.asciiz "false"
SPACE:.asciiz "Making Space For Inputed Values Is Fun."
