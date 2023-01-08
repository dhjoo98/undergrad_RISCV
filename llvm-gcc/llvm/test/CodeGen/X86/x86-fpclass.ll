; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686 | FileCheck %s -check-prefix=CHECK-32
; RUN: llc < %s -mtriple=x86_64 | FileCheck %s -check-prefix=CHECK-64

define i1 @isnan_half(half %x) nounwind {
; CHECK-32-LABEL: isnan_half:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f16(half %x)
  ret i1 %0
}

define i1 @isnan_bfloat(i16 %x) nounwind {
; CHECK-32-LABEL: isnan_bfloat:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast i16 %x to bfloat
  %1 = tail call i1 @llvm.isnan.bf16(bfloat %0)
  ret i1 %1
}

define i1 @isnan_float(float %x) nounwind {
; CHECK-32-LABEL: isnan_float:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    ucomiss %xmm0, %xmm0
; CHECK-64-NEXT:    setp %al
; CHECK-64-NEXT:    retq
; NOSSE-32-LABEL: isnan_float:
entry:
  %0 = tail call i1 @llvm.isnan.f32(float %x)
  ret i1 %0
}

define i1 @isnan_double(double %x) nounwind {
; CHECK-32-LABEL: isnan_double:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    ucomisd %xmm0, %xmm0
; CHECK-64-NEXT:    setp %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f64(double %x)
  ret i1 %0
}

define i1 @isnan_ldouble(x86_fp80 %x) nounwind {
; CHECK-32-LABEL: isnan_ldouble:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    fldt {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fxam
; CHECK-32-NEXT:    fstp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    andb $69, %ah
; CHECK-32-NEXT:    cmpb $1, %ah
; CHECK-32-NEXT:    sete %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_ldouble:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    fldt {{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    fxam
; CHECK-64-NEXT:    fstp %st(0)
; CHECK-64-NEXT:    fnstsw %ax
; CHECK-64-NEXT:    andb $69, %ah
; CHECK-64-NEXT:    cmpb $1, %ah
; CHECK-64-NEXT:    sete %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f80(x86_fp80 %x)
  ret i1 %0
}

define i1 @isnan_half_strictfp(half %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_half_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f16(half %x)
  ret i1 %0
}

define i1 @isnan_bfloat_strict(i16 %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_bfloat_strict:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat_strict:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast i16 %x to bfloat
  %1 = tail call i1 @llvm.isnan.bf16(bfloat %0)
  ret i1 %1
}

define i1 @isnan_float_strictfp(float %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_float_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    cmpl $2139095041, %eax # imm = 0x7F800001
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movd %xmm0, %eax
; CHECK-64-NEXT:    andl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-64-NEXT:    cmpl $2139095041, %eax # imm = 0x7F800001
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
; NOSSE-32-LABEL: isnan_float_strictfp:
entry:
  %0 = tail call i1 @llvm.isnan.f32(float %x)
  ret i1 %0
}

define i1 @isnan_double_strictfp(double %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_double_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    xorl %ecx, %ecx
; CHECK-32-NEXT:    cmpl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movl $2146435072, %ecx # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %eax, %ecx
; CHECK-32-NEXT:    setl %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movq %xmm0, %rax
; CHECK-64-NEXT:    movabsq $9223372036854775807, %rcx # imm = 0x7FFFFFFFFFFFFFFF
; CHECK-64-NEXT:    andq %rax, %rcx
; CHECK-64-NEXT:    movabsq $9218868437227405312, %rax # imm = 0x7FF0000000000000
; CHECK-64-NEXT:    cmpq %rax, %rcx
; CHECK-64-NEXT:    setg %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f64(double %x)
  ret i1 %0
}

define i1 @isnan_ldouble_strictfp(x86_fp80 %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_ldouble_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    fldt {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fxam
; CHECK-32-NEXT:    fstp %st(0)
; CHECK-32-NEXT:    wait
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    andb $69, %ah
; CHECK-32-NEXT:    cmpb $1, %ah
; CHECK-32-NEXT:    sete %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_ldouble_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    fldt {{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    fxam
; CHECK-64-NEXT:    fstp %st(0)
; CHECK-64-NEXT:    wait
; CHECK-64-NEXT:    fnstsw %ax
; CHECK-64-NEXT:    andb $69, %ah
; CHECK-64-NEXT:    cmpb $1, %ah
; CHECK-64-NEXT:    sete %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call i1 @llvm.isnan.f80(x86_fp80 %x)
  ret i1 %0
}

define <1 x i1> @isnan_half_vec1(<1 x half> %x) nounwind {
; CHECK-32-LABEL: isnan_half_vec1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half_vec1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f16(<1 x half> %x)
  ret <1 x i1> %0
}

define <1 x i1> @isnan_bfloat_vec1(<1 x i16> %x) nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat_vec1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <1 x i16> %x to <1 x bfloat>
  %1 = tail call <1 x i1> @llvm.isnan.v1bf16(<1 x bfloat> %0)
  ret <1 x i1> %1
}

define <1 x i1> @isnan_float_vec1(<1 x float> %x) nounwind {
; CHECK-32-LABEL: isnan_float_vec1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float_vec1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    ucomiss %xmm0, %xmm0
; CHECK-64-NEXT:    setp %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f32(<1 x float> %x)
  ret <1 x i1> %0
}

define <1 x i1> @isnan_double_vec1(<1 x double> %x) nounwind {
; CHECK-32-LABEL: isnan_double_vec1:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double_vec1:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    ucomisd %xmm0, %xmm0
; CHECK-64-NEXT:    setp %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f64(<1 x double> %x)
  ret <1 x i1> %0
}

define <2 x i1> @isnan_half_vec2(<2 x half> %x) nounwind {
; CHECK-32-LABEL: isnan_half_vec2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %ecx # imm = 0x7C01
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half_vec2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %di, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movdqa -{{[0-9]+}}(%rsp), %xmm0
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; CHECK-64-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,5,5]
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f16(<2 x half> %x)
  ret <2 x i1> %0
}

define <2 x i1> @isnan_bfloat_vec2(<2 x i16> %x) nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %ecx # imm = 0x7F81
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat_vec2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; CHECK-64-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,5,5]
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <2 x i16> %x to <2 x bfloat>
  %1 = tail call <2 x i1> @llvm.isnan.v2bf16(<2 x bfloat> %0)
  ret <2 x i1> %1
}

define <2 x i1> @isnan_float_vec2(<2 x float> %x) nounwind {
; CHECK-32-LABEL: isnan_float_vec2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %cl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    movl %ecx, %eax
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float_vec2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    xorps %xmm1, %xmm1
; CHECK-64-NEXT:    cmpunordps %xmm0, %xmm1
; CHECK-64-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,1,1,3]
; CHECK-64-NEXT:    movaps %xmm1, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f32(<2 x float> %x)
  ret <2 x i1> %0
}

define <2 x i1> @isnan_double_vec2(<2 x double> %x) nounwind {
; CHECK-32-LABEL: isnan_double_vec2:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %cl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    movl %ecx, %eax
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double_vec2:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    xorpd %xmm1, %xmm1
; CHECK-64-NEXT:    cmpunordpd %xmm1, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f64(<2 x double> %x)
  ret <2 x i1> %0
}

define <4 x i1> @isnan_half_vec4(<4 x half> %x) nounwind {
; CHECK-32-LABEL: isnan_half_vec4:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebx
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edi
; CHECK-32-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-32-NEXT:    setge %bl
; CHECK-32-NEXT:    andl $32767, %esi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %esi # imm = 0x7C01
; CHECK-32-NEXT:    setge %bh
; CHECK-32-NEXT:    addb %bh, %bh
; CHECK-32-NEXT:    orb %bl, %bh
; CHECK-32-NEXT:    andl $32767, %edx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %edx # imm = 0x7C01
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %ecx # imm = 0x7C01
; CHECK-32-NEXT:    setge %cl
; CHECK-32-NEXT:    addb %cl, %cl
; CHECK-32-NEXT:    orb %dl, %cl
; CHECK-32-NEXT:    shlb $2, %cl
; CHECK-32-NEXT:    orb %bh, %cl
; CHECK-32-NEXT:    movb %cl, (%eax)
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebx
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_half_vec4:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movw %cx, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %dx, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %di, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movdqa -{{[0-9]+}}(%rsp), %xmm0
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f16(<4 x half> %x)
  ret <4 x i1> %0
}

define <4 x i1> @isnan_bfloat_vec4(<4 x i16> %x) nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec4:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebx
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edi
; CHECK-32-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-32-NEXT:    setge %bl
; CHECK-32-NEXT:    andl $32767, %esi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %esi # imm = 0x7F81
; CHECK-32-NEXT:    setge %bh
; CHECK-32-NEXT:    addb %bh, %bh
; CHECK-32-NEXT:    orb %bl, %bh
; CHECK-32-NEXT:    andl $32767, %edx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %edx # imm = 0x7F81
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %ecx # imm = 0x7F81
; CHECK-32-NEXT:    setge %cl
; CHECK-32-NEXT:    addb %cl, %cl
; CHECK-32-NEXT:    orb %dl, %cl
; CHECK-32-NEXT:    shlb $2, %cl
; CHECK-32-NEXT:    orb %bh, %cl
; CHECK-32-NEXT:    movb %cl, (%eax)
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebx
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_bfloat_vec4:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <4 x i16> %x to <4 x bfloat>
  %1 = tail call <4 x i1> @llvm.isnan.v4bf16(<4 x bfloat> %0)
  ret <4 x i1> %1
}

define <4 x i1> @isnan_float_vec4(<4 x float> %x) nounwind {
; CHECK-32-LABEL: isnan_float_vec4:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    flds {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dh
; CHECK-32-NEXT:    addb %dh, %dh
; CHECK-32-NEXT:    orb %dl, %dh
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    addb %al, %al
; CHECK-32-NEXT:    orb %dl, %al
; CHECK-32-NEXT:    shlb $2, %al
; CHECK-32-NEXT:    orb %dh, %al
; CHECK-32-NEXT:    movb %al, (%ecx)
; CHECK-32-NEXT:    movl %ecx, %eax
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_float_vec4:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    xorps %xmm1, %xmm1
; CHECK-64-NEXT:    cmpunordps %xmm1, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f32(<4 x float> %x)
  ret <4 x i1> %0
}

define <4 x i1> @isnan_double_vec4(<4 x double> %x) nounwind {
; CHECK-32-LABEL: isnan_double_vec4:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dh
; CHECK-32-NEXT:    addb %dh, %dh
; CHECK-32-NEXT:    orb %dl, %dh
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %dl
; CHECK-32-NEXT:    fucomp %st(0)
; CHECK-32-NEXT:    fnstsw %ax
; CHECK-32-NEXT:    # kill: def $ah killed $ah killed $ax
; CHECK-32-NEXT:    sahf
; CHECK-32-NEXT:    setp %al
; CHECK-32-NEXT:    addb %al, %al
; CHECK-32-NEXT:    orb %dl, %al
; CHECK-32-NEXT:    shlb $2, %al
; CHECK-32-NEXT:    orb %dh, %al
; CHECK-32-NEXT:    movb %al, (%ecx)
; CHECK-32-NEXT:    movl %ecx, %eax
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_double_vec4:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    xorpd %xmm2, %xmm2
; CHECK-64-NEXT:    cmpunordpd %xmm2, %xmm1
; CHECK-64-NEXT:    cmpunordpd %xmm2, %xmm0
; CHECK-64-NEXT:    packssdw %xmm1, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f64(<4 x double> %x)
  ret <4 x i1> %0
}


define <1 x i1> @isnan_half_vec1_strictfp(<1 x half> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_half_vec1_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half_vec1_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f16(<1 x half> %x)
  ret <1 x i1> %0
}

define <1 x i1> @isnan_bfloat_vec1_strictfp(<1 x i16> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec1_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat_vec1_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-64-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <1 x i16> %x to <1 x bfloat>
  %1 = tail call <1 x i1> @llvm.isnan.v1bf16(<1 x bfloat> %0)
  ret <1 x i1> %1
}

define <1 x i1> @isnan_float_vec1_strictfp(<1 x float> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_float_vec1_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    cmpl $2139095041, %eax # imm = 0x7F800001
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float_vec1_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movd %xmm0, %eax
; CHECK-64-NEXT:    andl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-64-NEXT:    cmpl $2139095041, %eax # imm = 0x7F800001
; CHECK-64-NEXT:    setge %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f32(<1 x float> %x)
  ret <1 x i1> %0
}

define <1 x i1> @isnan_double_vec1_strictfp(<1 x double> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_double_vec1_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebp
; CHECK-32-NEXT:    movl %esp, %ebp
; CHECK-32-NEXT:    andl $-8, %esp
; CHECK-32-NEXT:    subl $8, %esp
; CHECK-32-NEXT:    fldl 8(%ebp)
; CHECK-32-NEXT:    fstpl (%esp)
; CHECK-32-NEXT:    wait
; CHECK-32-NEXT:    movl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    xorl %ecx, %ecx
; CHECK-32-NEXT:    cmpl (%esp), %ecx
; CHECK-32-NEXT:    movl $2146435072, %ecx # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %eax, %ecx
; CHECK-32-NEXT:    setl %al
; CHECK-32-NEXT:    movl %ebp, %esp
; CHECK-32-NEXT:    popl %ebp
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double_vec1_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movq %xmm0, %rax
; CHECK-64-NEXT:    movabsq $9223372036854775807, %rcx # imm = 0x7FFFFFFFFFFFFFFF
; CHECK-64-NEXT:    andq %rax, %rcx
; CHECK-64-NEXT:    movabsq $9218868437227405312, %rax # imm = 0x7FF0000000000000
; CHECK-64-NEXT:    cmpq %rax, %rcx
; CHECK-64-NEXT:    setg %al
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <1 x i1> @llvm.isnan.v1f64(<1 x double> %x)
  ret <1 x i1> %0
}

define <2 x i1> @isnan_half_vec2_strictfp(<2 x half> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_half_vec2_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %eax # imm = 0x7C01
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %ecx # imm = 0x7C01
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_half_vec2_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %di, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movdqa -{{[0-9]+}}(%rsp), %xmm0
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; CHECK-64-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,5,5]
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f16(<2 x half> %x)
  ret <2 x i1> %0
}

define <2 x i1> @isnan_bfloat_vec2_strictfp(<2 x i16> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec2_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl $32767, %eax # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %eax # imm = 0x7F81
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %ecx # imm = 0x7F81
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_bfloat_vec2_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,0,0]
; CHECK-64-NEXT:    pshufhw {{.*#+}} xmm0 = xmm0[0,1,2,3,5,5,5,5]
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <2 x i16> %x to <2 x bfloat>
  %1 = tail call <2 x i1> @llvm.isnan.v2bf16(<2 x bfloat> %0)
  ret <2 x i1> %1
}

define <2 x i1> @isnan_float_vec2_strictfp(<2 x float> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_float_vec2_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    movl $2147483647, %ecx # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl %ecx, %eax
; CHECK-32-NEXT:    cmpl $2139095041, %eax # imm = 0x7F800001
; CHECK-32-NEXT:    setge %al
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    cmpl $2139095041, %ecx # imm = 0x7F800001
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_float_vec2_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    shufps {{.*#+}} xmm0 = xmm0[0,1,1,3]
; CHECK-64-NEXT:    andps {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f32(<2 x float> %x)
  ret <2 x i1> %0
}

define <2 x i1> @isnan_double_vec2_strictfp(<2 x double> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_double_vec2_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebp
; CHECK-32-NEXT:    movl %esp, %ebp
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    andl $-8, %esp
; CHECK-32-NEXT:    subl $16, %esp
; CHECK-32-NEXT:    fldl 8(%ebp)
; CHECK-32-NEXT:    fstpl (%esp)
; CHECK-32-NEXT:    fldl 16(%ebp)
; CHECK-32-NEXT:    fstpl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    wait
; CHECK-32-NEXT:    movl $2147483647, %ecx # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    andl %ecx, %eax
; CHECK-32-NEXT:    xorl %edx, %edx
; CHECK-32-NEXT:    cmpl (%esp), %edx
; CHECK-32-NEXT:    movl $2146435072, %esi # imm = 0x7FF00000
; CHECK-32-NEXT:    movl $2146435072, %edi # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %eax, %edi
; CHECK-32-NEXT:    setl %al
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    cmpl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    sbbl %ecx, %esi
; CHECK-32-NEXT:    setl %dl
; CHECK-32-NEXT:    leal -8(%ebp), %esp
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebp
; CHECK-32-NEXT:    retl
;
; CHECK-64-LABEL: isnan_double_vec2_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pxor {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    movdqa {{.*#+}} xmm1 = [9218868439374888960,9218868439374888960]
; CHECK-64-NEXT:    movdqa %xmm0, %xmm2
; CHECK-64-NEXT:    pcmpgtd %xmm1, %xmm2
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm3 = xmm2[0,0,2,2]
; CHECK-64-NEXT:    pcmpeqd %xmm1, %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,3,3]
; CHECK-64-NEXT:    pand %xmm3, %xmm1
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm2[1,1,3,3]
; CHECK-64-NEXT:    por %xmm1, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <2 x i1> @llvm.isnan.v2f64(<2 x double> %x)
  ret <2 x i1> %0
}

define <4 x i1> @isnan_half_vec4_strictfp(<4 x half> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_half_vec4_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebx
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edi
; CHECK-32-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %edi # imm = 0x7C01
; CHECK-32-NEXT:    setge %bl
; CHECK-32-NEXT:    andl $32767, %esi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %esi # imm = 0x7C01
; CHECK-32-NEXT:    setge %bh
; CHECK-32-NEXT:    addb %bh, %bh
; CHECK-32-NEXT:    orb %bl, %bh
; CHECK-32-NEXT:    andl $32767, %edx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %edx # imm = 0x7C01
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $31745, %ecx # imm = 0x7C01
; CHECK-32-NEXT:    setge %cl
; CHECK-32-NEXT:    addb %cl, %cl
; CHECK-32-NEXT:    orb %dl, %cl
; CHECK-32-NEXT:    shlb $2, %cl
; CHECK-32-NEXT:    orb %bh, %cl
; CHECK-32-NEXT:    movb %cl, (%eax)
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebx
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_half_vec4_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movw %cx, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %dx, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %si, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movw %di, -{{[0-9]+}}(%rsp)
; CHECK-64-NEXT:    movdqa -{{[0-9]+}}(%rsp), %xmm0
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f16(<4 x half> %x)
  ret <4 x i1> %0
}

define <4 x i1> @isnan_bfloat_vec4_strictfp(<4 x i16> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_bfloat_vec4_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebx
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    movzwl {{[0-9]+}}(%esp), %edi
; CHECK-32-NEXT:    andl $32767, %edi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %edi # imm = 0x7F81
; CHECK-32-NEXT:    setge %bl
; CHECK-32-NEXT:    andl $32767, %esi # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %esi # imm = 0x7F81
; CHECK-32-NEXT:    setge %bh
; CHECK-32-NEXT:    addb %bh, %bh
; CHECK-32-NEXT:    orb %bl, %bh
; CHECK-32-NEXT:    andl $32767, %edx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %edx # imm = 0x7F81
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    andl $32767, %ecx # imm = 0x7FFF
; CHECK-32-NEXT:    cmpl $32641, %ecx # imm = 0x7F81
; CHECK-32-NEXT:    setge %cl
; CHECK-32-NEXT:    addb %cl, %cl
; CHECK-32-NEXT:    orb %dl, %cl
; CHECK-32-NEXT:    shlb $2, %cl
; CHECK-32-NEXT:    orb %bh, %cl
; CHECK-32-NEXT:    movb %cl, (%eax)
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebx
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_bfloat_vec4_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtw {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; CHECK-64-NEXT:    retq
entry:
  %0 = bitcast <4 x i16> %x to <4 x bfloat>
  %1 = tail call <4 x i1> @llvm.isnan.v4bf16(<4 x bfloat> %0)
  ret <4 x i1> %1
}

define <4 x i1> @isnan_float_vec4_strictfp(<4 x float> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_float_vec4_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    movl $2147483647, %ecx # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    andl %ecx, %edx
; CHECK-32-NEXT:    cmpl $2139095041, %edx # imm = 0x7F800001
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    andl %ecx, %esi
; CHECK-32-NEXT:    cmpl $2139095041, %esi # imm = 0x7F800001
; CHECK-32-NEXT:    setge %dh
; CHECK-32-NEXT:    addb %dh, %dh
; CHECK-32-NEXT:    orb %dl, %dh
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    andl %ecx, %esi
; CHECK-32-NEXT:    cmpl $2139095041, %esi # imm = 0x7F800001
; CHECK-32-NEXT:    setge %dl
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    cmpl $2139095041, %ecx # imm = 0x7F800001
; CHECK-32-NEXT:    setge %cl
; CHECK-32-NEXT:    addb %cl, %cl
; CHECK-32-NEXT:    orb %dl, %cl
; CHECK-32-NEXT:    shlb $2, %cl
; CHECK-32-NEXT:    orb %dh, %cl
; CHECK-32-NEXT:    movb %cl, (%eax)
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_float_vec4_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f32(<4 x float> %x)
  ret <4 x i1> %0
}

define <4 x i1> @isnan_double_vec4_strictfp(<4 x double> %x) strictfp nounwind {
; CHECK-32-LABEL: isnan_double_vec4_strictfp:
; CHECK-32:       # %bb.0: # %entry
; CHECK-32-NEXT:    pushl %ebp
; CHECK-32-NEXT:    movl %esp, %ebp
; CHECK-32-NEXT:    pushl %edi
; CHECK-32-NEXT:    pushl %esi
; CHECK-32-NEXT:    andl $-8, %esp
; CHECK-32-NEXT:    subl $32, %esp
; CHECK-32-NEXT:    fldl 12(%ebp)
; CHECK-32-NEXT:    fstpl (%esp)
; CHECK-32-NEXT:    fldl 20(%ebp)
; CHECK-32-NEXT:    fstpl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl 28(%ebp)
; CHECK-32-NEXT:    fstpl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    fldl 36(%ebp)
; CHECK-32-NEXT:    fstpl {{[0-9]+}}(%esp)
; CHECK-32-NEXT:    wait
; CHECK-32-NEXT:    movl $2147483647, %eax # imm = 0x7FFFFFFF
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-32-NEXT:    andl %eax, %ecx
; CHECK-32-NEXT:    xorl %edx, %edx
; CHECK-32-NEXT:    cmpl (%esp), %edx
; CHECK-32-NEXT:    movl $2146435072, %esi # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %ecx, %esi
; CHECK-32-NEXT:    setl %cl
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    andl %eax, %esi
; CHECK-32-NEXT:    cmpl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movl $2146435072, %edi # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %esi, %edi
; CHECK-32-NEXT:    setl %ch
; CHECK-32-NEXT:    addb %ch, %ch
; CHECK-32-NEXT:    orb %cl, %ch
; CHECK-32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; CHECK-32-NEXT:    andl %eax, %esi
; CHECK-32-NEXT:    cmpl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movl $2146435072, %edi # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %esi, %edi
; CHECK-32-NEXT:    setl %cl
; CHECK-32-NEXT:    andl {{[0-9]+}}(%esp), %eax
; CHECK-32-NEXT:    cmpl {{[0-9]+}}(%esp), %edx
; CHECK-32-NEXT:    movl $2146435072, %edx # imm = 0x7FF00000
; CHECK-32-NEXT:    sbbl %eax, %edx
; CHECK-32-NEXT:    setl %dl
; CHECK-32-NEXT:    addb %dl, %dl
; CHECK-32-NEXT:    orb %cl, %dl
; CHECK-32-NEXT:    shlb $2, %dl
; CHECK-32-NEXT:    orb %ch, %dl
; CHECK-32-NEXT:    movl 8(%ebp), %eax
; CHECK-32-NEXT:    movb %dl, (%eax)
; CHECK-32-NEXT:    leal -8(%ebp), %esp
; CHECK-32-NEXT:    popl %esi
; CHECK-32-NEXT:    popl %edi
; CHECK-32-NEXT:    popl %ebp
; CHECK-32-NEXT:    retl $4
;
; CHECK-64-LABEL: isnan_double_vec4_strictfp:
; CHECK-64:       # %bb.0: # %entry
; CHECK-64-NEXT:    movdqa {{.*#+}} xmm2 = [9223372036854775807,9223372036854775807]
; CHECK-64-NEXT:    pand %xmm2, %xmm0
; CHECK-64-NEXT:    pand %xmm2, %xmm1
; CHECK-64-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; CHECK-64-NEXT:    pxor %xmm2, %xmm1
; CHECK-64-NEXT:    movdqa {{.*#+}} xmm3 = [9218868439374888960,9218868439374888960]
; CHECK-64-NEXT:    movdqa %xmm1, %xmm4
; CHECK-64-NEXT:    pcmpgtd %xmm3, %xmm4
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm5 = xmm4[0,0,2,2]
; CHECK-64-NEXT:    pcmpeqd %xmm3, %xmm1
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; CHECK-64-NEXT:    pand %xmm5, %xmm1
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm4 = xmm4[1,1,3,3]
; CHECK-64-NEXT:    por %xmm1, %xmm4
; CHECK-64-NEXT:    pxor %xmm2, %xmm0
; CHECK-64-NEXT:    movdqa %xmm0, %xmm1
; CHECK-64-NEXT:    pcmpgtd %xmm3, %xmm1
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[0,0,2,2]
; CHECK-64-NEXT:    pcmpeqd %xmm3, %xmm0
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm3 = xmm0[1,1,3,3]
; CHECK-64-NEXT:    pand %xmm2, %xmm3
; CHECK-64-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[1,1,3,3]
; CHECK-64-NEXT:    por %xmm3, %xmm0
; CHECK-64-NEXT:    packssdw %xmm4, %xmm0
; CHECK-64-NEXT:    retq
entry:
  %0 = tail call <4 x i1> @llvm.isnan.v4f64(<4 x double> %x)
  ret <4 x i1> %0
}


declare i1 @llvm.isnan.f16(half)
declare i1 @llvm.isnan.bf16(bfloat)
declare i1 @llvm.isnan.f32(float)
declare i1 @llvm.isnan.f64(double)
declare i1 @llvm.isnan.f80(x86_fp80)
declare <1 x i1> @llvm.isnan.v1f16(<1 x half>)
declare <1 x i1> @llvm.isnan.v1bf16(<1 x bfloat>)
declare <1 x i1> @llvm.isnan.v1f32(<1 x float>)
declare <1 x i1> @llvm.isnan.v1f64(<1 x double>)
declare <2 x i1> @llvm.isnan.v2f16(<2 x half>)
declare <2 x i1> @llvm.isnan.v2bf16(<2 x bfloat>)
declare <2 x i1> @llvm.isnan.v2f32(<2 x float>)
declare <2 x i1> @llvm.isnan.v2f64(<2 x double>)
declare <4 x i1> @llvm.isnan.v4f16(<4 x half>)
declare <4 x i1> @llvm.isnan.v4bf16(<4 x bfloat>)
declare <4 x i1> @llvm.isnan.v4f32(<4 x float>)
declare <4 x i1> @llvm.isnan.v4f64(<4 x double>)
