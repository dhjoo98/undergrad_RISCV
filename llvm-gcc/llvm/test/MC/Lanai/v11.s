! RUN: llvm-mc -arch=lanai -show-encoding %s | FileCheck %s

add %r17, 0, %r21
! CHECK: 0x0a,0xc4,0x00,0x00
add %r17, 0x00001234, %r21
! CHECK: 0x0a,0xc4,0x12,0x34
add %r17, 0x12340000, %r21
! CHECK: 0x0a,0xc5,0x12,0x34
add.f %r17, 0, %r21
! CHECK: 0x0a,0xc6,0x00,0x00
add.f %r17, 0x00001234, %r21
! CHECK: 0x0a,0xc6,0x12,0x34
add.f %r17, 0x12340000, %r21
! CHECK: 0x0a,0xc7,0x12,0x34
add %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x90,0x00
add.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x90,0x00
addc %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x91,0x00
addc.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x91,0x00
addc %r17, 0, %r21
! CHECK: 0x1a,0xc4,0x00,0x00
addc %r17, 0x00001234, %r21
! CHECK: 0x1a,0xc4,0x12,0x34
addc %r17, 0x12340000, %r21
! CHECK: 0x1a,0xc5,0x12,0x34
addc.f %r17, 0, %r21
! CHECK: 0x1a,0xc6,0x00,0x00
addc.f %r17, 0x00001234, %r21
! CHECK: 0x1a,0xc6,0x12,0x34
addc.f %r17, 0x12340000, %r21
! CHECK: 0x1a,0xc7,0x12,0x34
and %r17, 0xffff1234, %r21
! CHECK: 0x4a,0xc4,0x12,0x34
and %r17, 0x1234ffff, %r21
! CHECK: 0x4a,0xc5,0x12,0x34
and.f %r17, 0xffff1234, %r21
! CHECK: 0x4a,0xc6,0x12,0x34
and.f %r17, 0x1234ffff, %r21
! CHECK: 0x4a,0xc7,0x12,0x34
and %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x94,0x00
and.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x94,0x00
bt 0x123454
! CHECK: 0xe0,0x12,0x34,0x54
bf 0x123454
! CHECK: 0xe0,0x12,0x34,0x55
bhi 0x123454
! CHECK: 0xe2,0x12,0x34,0x54
bugt 0x123454
! CHECK: 0xe2,0x12,0x34,0x54
bls 0x123454
! CHECK: 0xe2,0x12,0x34,0x55
bule 0x123454
! CHECK: 0xe2,0x12,0x34,0x55
bcc 0x123454
! CHECK: 0xe4,0x12,0x34,0x54
bult 0x123454
! CHECK: 0xe4,0x12,0x34,0x54
bcs 0x123454
! CHECK: 0xe4,0x12,0x34,0x55
buge 0x123454
! CHECK: 0xe4,0x12,0x34,0x55
bne 0x123454
! CHECK: 0xe6,0x12,0x34,0x54
beq 0x123454
! CHECK: 0xe6,0x12,0x34,0x55
bvc 0x123454
! CHECK: 0xe8,0x12,0x34,0x54
bvs 0x123454
! CHECK: 0xe8,0x12,0x34,0x55
bpl 0x123454
! CHECK: 0xea,0x12,0x34,0x54
bmi 0x123454
! CHECK: 0xea,0x12,0x34,0x55
bge 0x123454
! CHECK: 0xec,0x12,0x34,0x54
blt 0x123454
! CHECK: 0xec,0x12,0x34,0x55
bgt 0x123454
! CHECK: 0xee,0x12,0x34,0x54
bt %r19
! CHECK: 0xc1,0x00,0x9d,0x00
bt.r 0x5678
! CHECK: 0xe1,0x00,0x56,0x7a
bf.r 0x5678
! CHECK: 0xe1,0x00,0x56,0x7b
bhi.r 0x5678
! CHECK: 0xe3,0x00,0x56,0x7a
bugt.r 0x5678
! CHECK: 0xe3,0x00,0x56,0x7a
bls.r 0x5678
! CHECK: 0xe3,0x00,0x56,0x7b
bule.r 0x5678
! CHECK: 0xe3,0x00,0x56,0x7b
bcc.r 0x5678
! CHECK: 0xe5,0x00,0x56,0x7a
bult.r 0x5678
! CHECK: 0xe5,0x00,0x56,0x7a
bcs.r 0x5678
! CHECK: 0xe5,0x00,0x56,0x7b
buge.r 0x5678
! CHECK: 0xe5,0x00,0x56,0x7b
bne.r 0x5678
! CHECK: 0xe7,0x00,0x56,0x7a
beq.r 0x5678
! CHECK: 0xe7,0x00,0x56,0x7b
bvc.r 0x5678
! CHECK: 0xe9,0x00,0x56,0x7a
bvs.r 0x5678
! CHECK: 0xe9,0x00,0x56,0x7b
bpl.r 0x5678
! CHECK: 0xeb,0x00,0x56,0x7a
bmi.r 0x5678
! CHECK: 0xeb,0x00,0x56,0x7b
bge.r 0x5678
! CHECK: 0xed,0x00,0x56,0x7a
blt.r 0x5678
! CHECK: 0xed,0x00,0x56,0x7b
bgt.r 0x5678
! CHECK: 0xef,0x00,0x56,0x7a
ld -32768[%r17], %r21
! CHECK: 0x8a,0xc6,0x80,0x00
ld -1024[%r17], %r21
! CHECK: 0x8a,0xc6,0xfc,0x00
ld 0[%r17], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
ld 1024[%r17], %r21
! CHECK: 0x8a,0xc6,0x04,0x00
ld 32767[%r17], %r21
! CHECK: 0x8a,0xc6,0x7f,0xff
uld -32768[%r17], %r21
! CHECK: 0x8a,0xc6,0x80,0x00
uld -1024[%r17], %r21
! CHECK: 0x8a,0xc6,0xfc,0x00
uld 0[%r17], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
uld 1024[%r17], %r21
! CHECK: 0x8a,0xc6,0x04,0x00
uld 32767[%r17], %r21
! CHECK: 0x8a,0xc6,0x7f,0xff
ld %r18[%r17], %r21
! CHECK: 0xaa,0xc6,0x90,0x02
uld %r18[%r17], %r21
! CHECK: 0xaa,0xc6,0x90,0x03
ld.h -512[%r17], %r21
! CHECK: 0xfa,0xc7,0x0a,0x00
ld.h -13[%r17], %r21
! CHECK: 0xfa,0xc7,0x0b,0xf3
ld.h 18[%r17], %r21
! CHECK: 0xfa,0xc7,0x08,0x12
ld.h 511[%r17], %r21
! CHECK: 0xfa,0xc7,0x09,0xff
ld.b -512[%r17], %r21
! CHECK: 0xfa,0xc7,0x4a,0x00
ld.b -13[%r17], %r21
! CHECK: 0xfa,0xc7,0x4b,0xf3
ld.b 18[%r17], %r21
! CHECK: 0xfa,0xc7,0x48,0x12
ld.b 511[%r17], %r21
! CHECK: 0xfa,0xc7,0x49,0xff
uld.h -512[%r17], %r21
! CHECK: 0xfa,0xc7,0x1a,0x00
uld.h -13[%r17], %r21
! CHECK: 0xfa,0xc7,0x1b,0xf3
uld.h 18[%r17], %r21
! CHECK: 0xfa,0xc7,0x18,0x12
uld.h 511[%r17], %r21
! CHECK: 0xfa,0xc7,0x19,0xff
uld.b -512[%r17], %r21
! CHECK: 0xfa,0xc7,0x5a,0x00
uld.b -13[%r17], %r21
! CHECK: 0xfa,0xc7,0x5b,0xf3
uld.b 18[%r17], %r21
! CHECK: 0xfa,0xc7,0x58,0x12
uld.b 511[%r17], %r21
! CHECK: 0xfa,0xc7,0x59,0xff
ld -32768[*%r17], %r21
! CHECK: 0x8a,0xc7,0x80,0x00
ld -1024[*%r17], %r21
! CHECK: 0x8a,0xc7,0xfc,0x00
ld 0[*%r17], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
ld 1024[*%r17], %r21
! CHECK: 0x8a,0xc7,0x04,0x00
ld 32767[*%r17], %r21
! CHECK: 0x8a,0xc7,0x7f,0xff
uld -32768[*%r17], %r21
! CHECK: 0x8a,0xc7,0x80,0x00
uld -1024[*%r17], %r21
! CHECK: 0x8a,0xc7,0xfc,0x00
uld 0[*%r17], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
uld 1024[*%r17], %r21
! CHECK: 0x8a,0xc7,0x04,0x00
uld 32767[*%r17], %r21
! CHECK: 0x8a,0xc7,0x7f,0xff
ld [--%r17], %r21
! CHECK: 0x8a,0xc7,0xff,0xfc
ld [++%r17], %r21
! CHECK: 0x8a,0xc7,0x00,0x04
ld.h [--%r17], %r21
! CHECK: 0xfa,0xc7,0x0f,0xfe
ld.h [++%r17], %r21
! CHECK: 0xfa,0xc7,0x0c,0x02
uld.h [--%r17], %r21
! CHECK: 0xfa,0xc7,0x1f,0xfe
uld.h [++%r17], %r21
! CHECK: 0xfa,0xc7,0x1c,0x02
ld.b [--%r17], %r21
! CHECK: 0xfa,0xc7,0x4f,0xff
ld.b [++%r17], %r21
! CHECK: 0xfa,0xc7,0x4c,0x01
uld.b [--%r17], %r21
! CHECK: 0xfa,0xc7,0x5f,0xff
uld.b [++%r17], %r21
! CHECK: 0xfa,0xc7,0x5c,0x01
ld %r18[*%r17], %r21
! CHECK: 0xaa,0xc7,0x90,0x02
uld %r18[*%r17], %r21
! CHECK: 0xaa,0xc7,0x90,0x03
ld.h -512[*%r17], %r21
! CHECK: 0xfa,0xc7,0x0e,0x00
ld.h -13[*%r17], %r21
! CHECK: 0xfa,0xc7,0x0f,0xf3
ld.h 18[*%r17], %r21
! CHECK: 0xfa,0xc7,0x0c,0x12
ld.h 511[*%r17], %r21
! CHECK: 0xfa,0xc7,0x0d,0xff
ld.b -512[*%r17], %r21
! CHECK: 0xfa,0xc7,0x4e,0x00
ld.b -13[*%r17], %r21
! CHECK: 0xfa,0xc7,0x4f,0xf3
ld.b 18[*%r17], %r21
! CHECK: 0xfa,0xc7,0x4c,0x12
ld.b 511[*%r17], %r21
! CHECK: 0xfa,0xc7,0x4d,0xff
uld.h -512[*%r17], %r21
! CHECK: 0xfa,0xc7,0x1e,0x00
uld.h -13[*%r17], %r21
! CHECK: 0xfa,0xc7,0x1f,0xf3
uld.h 18[*%r17], %r21
! CHECK: 0xfa,0xc7,0x1c,0x12
uld.h 511[*%r17], %r21
! CHECK: 0xfa,0xc7,0x1d,0xff
uld.b -512[*%r17], %r21
! CHECK: 0xfa,0xc7,0x5e,0x00
uld.b -13[*%r17], %r21
! CHECK: 0xfa,0xc7,0x5f,0xf3
uld.b 18[*%r17], %r21
! CHECK: 0xfa,0xc7,0x5c,0x12
uld.b 511[*%r17], %r21
! CHECK: 0xfa,0xc7,0x5d,0xff
ld -32768[%r17*], %r21
! CHECK: 0x8a,0xc5,0x80,0x00
ld -1024[%r17*], %r21
! CHECK: 0x8a,0xc5,0xfc,0x00
ld 0[%r17*], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
ld 1024[%r17*], %r21
! CHECK: 0x8a,0xc5,0x04,0x00
ld 32767[%r17*], %r21
! CHECK: 0x8a,0xc5,0x7f,0xff
uld -32768[%r17*], %r21
! CHECK: 0x8a,0xc5,0x80,0x00
uld -1024[%r17*], %r21
! CHECK: 0x8a,0xc5,0xfc,0x00
uld 0[%r17*], %r21
! CHECK: 0x8a,0xc4,0x00,0x00
uld 1024[%r17*], %r21
! CHECK: 0x8a,0xc5,0x04,0x00
uld 32767[%r17*], %r21
! CHECK: 0x8a,0xc5,0x7f,0xff
ld [%r17--], %r21
! CHECK: 0x8a,0xc5,0xff,0xfc
ld [%r17++], %r21
! CHECK: 0x8a,0xc5,0x00,0x04
ld.h [%r17--], %r21
! CHECK: 0xfa,0xc7,0x07,0xfe
ld.h [%r17++], %r21
! CHECK: 0xfa,0xc7,0x04,0x02
uld.h [%r17--], %r21
! CHECK: 0xfa,0xc7,0x17,0xfe
uld.h [%r17++], %r21
! CHECK: 0xfa,0xc7,0x14,0x02
ld.b [%r17--], %r21
! CHECK: 0xfa,0xc7,0x47,0xff
ld.b [%r17++], %r21
! CHECK: 0xfa,0xc7,0x44,0x01
uld.b [%r17--], %r21
! CHECK: 0xfa,0xc7,0x57,0xff
uld.b [%r17++], %r21
! CHECK: 0xfa,0xc7,0x54,0x01
ld %r18[%r17*], %r21
! CHECK: 0xaa,0xc5,0x90,0x02
uld %r18[%r17*], %r21
! CHECK: 0xaa,0xc5,0x90,0x03
ld.h -512[%r17*], %r21
! CHECK: 0xfa,0xc7,0x06,0x00
ld.h -13[%r17*], %r21
! CHECK: 0xfa,0xc7,0x07,0xf3
ld.h 18[%r17*], %r21
! CHECK: 0xfa,0xc7,0x04,0x12
ld.h 511[%r17*], %r21
! CHECK: 0xfa,0xc7,0x05,0xff
ld.b -512[%r17*], %r21
! CHECK: 0xfa,0xc7,0x46,0x00
ld.b -13[%r17*], %r21
! CHECK: 0xfa,0xc7,0x47,0xf3
ld.b 18[%r17*], %r21
! CHECK: 0xfa,0xc7,0x44,0x12
ld.b 511[%r17*], %r21
! CHECK: 0xfa,0xc7,0x45,0xff
uld.h -512[%r17*], %r21
! CHECK: 0xfa,0xc7,0x16,0x00
uld.h -13[%r17*], %r21
! CHECK: 0xfa,0xc7,0x17,0xf3
uld.h 18[%r17*], %r21
! CHECK: 0xfa,0xc7,0x14,0x12
uld.h 511[%r17*], %r21
! CHECK: 0xfa,0xc7,0x15,0xff
uld.b -512[%r17*], %r21
! CHECK: 0xfa,0xc7,0x56,0x00
uld.b -13[%r17*], %r21
! CHECK: 0xfa,0xc7,0x57,0xf3
uld.b 18[%r17*], %r21
! CHECK: 0xfa,0xc7,0x54,0x12
uld.b 511[%r17*], %r21
! CHECK: 0xfa,0xc7,0x55,0xff
ld [%r17 add %r18], %r21
! CHECK: 0xaa,0xc6,0x90,0x02
ld [%r17 addc %r18], %r21
! CHECK: 0xaa,0xc6,0x91,0x02
ld [%r17 sub %r18], %r21
! CHECK: 0xaa,0xc6,0x92,0x02
ld [%r17 subb %r18], %r21
! CHECK: 0xaa,0xc6,0x93,0x02
ld [%r17 and %r18], %r21
! CHECK: 0xaa,0xc6,0x94,0x02
ld [%r17 or %r18], %r21
! CHECK: 0xaa,0xc6,0x95,0x02
ld [%r17 xor %r18], %r21
! CHECK: 0xaa,0xc6,0x96,0x02
ld [%r17 sh %r18], %r21
! CHECK: 0xaa,0xc6,0x97,0x82
ld [%r17 sha %r18], %r21
! CHECK: 0xaa,0xc6,0x97,0xc2
ld [*%r17 add %r18], %r21
! CHECK: 0xaa,0xc7,0x90,0x02
ld [*%r17 addc %r18], %r21
! CHECK: 0xaa,0xc7,0x91,0x02
ld [*%r17 sub %r18], %r21
! CHECK: 0xaa,0xc7,0x92,0x02
ld [*%r17 subb %r18], %r21
! CHECK: 0xaa,0xc7,0x93,0x02
ld [*%r17 and %r18], %r21
! CHECK: 0xaa,0xc7,0x94,0x02
ld [*%r17 or %r18], %r21
! CHECK: 0xaa,0xc7,0x95,0x02
ld [*%r17 xor %r18], %r21
! CHECK: 0xaa,0xc7,0x96,0x02
ld [*%r17 sh %r18], %r21
! CHECK: 0xaa,0xc7,0x97,0x82
ld [*%r17 sha %r18], %r21
! CHECK: 0xaa,0xc7,0x97,0xc2
ld [%r17* add %r18], %r21
! CHECK: 0xaa,0xc5,0x90,0x02
ld [%r17* addc %r18], %r21
! CHECK: 0xaa,0xc5,0x91,0x02
ld [%r17* sub %r18], %r21
! CHECK: 0xaa,0xc5,0x92,0x02
ld [%r17* subb %r18], %r21
! CHECK: 0xaa,0xc5,0x93,0x02
ld [%r17* and %r18], %r21
! CHECK: 0xaa,0xc5,0x94,0x02
ld [%r17* or %r18], %r21
! CHECK: 0xaa,0xc5,0x95,0x02
ld [%r17* xor %r18], %r21
! CHECK: 0xaa,0xc5,0x96,0x02
ld [%r17* sh %r18], %r21
! CHECK: 0xaa,0xc5,0x97,0x82
ld [%r17* sha %r18], %r21
! CHECK: 0xaa,0xc5,0x97,0xc2
ld [0x12344], %r21
! CHECK: 0xfa,0x84,0x23,0x44
leadz %r17, %r21
! CHECK: 0xda,0xc4,0x00,0x02
mov 0, %r17
! CHECK: 0x08,0x80,0x00,0x00
mov 0x00001234, %r17
! CHECK: 0x08,0x80,0x12,0x34
mov 0x12340000, %r17
! CHECK: 0x08,0x81,0x12,0x34
mov 0xaaaa0000, %r17
! CHECK: 0x08,0x81,0xaa,0xaa
mov %r18, %r17
! CHECK: 0xc8,0xc8,0x00,0x00
mov 0x12344, %r17
! CHECK: 0xf8,0x86,0x23,0x44
mov 0xffff1234, %r17
! CHECK: 0x48,0x84,0x12,0x34
mov 0x1234ffff, %r17
! CHECK: 0x48,0x85,0x12,0x34
nop
! CHECK: 0x00,0x00,0x00,0x01
or %r17, 0, %r21
! CHECK: 0x5a,0xc4,0x00,0x00
or %r17, 0x00001234, %r21
! CHECK: 0x5a,0xc4,0x12,0x34
or %r17, 0x12340000, %r21
! CHECK: 0x5a,0xc5,0x12,0x34
or.f %r17, 0, %r21
! CHECK: 0x5a,0xc6,0x00,0x00
or.f %r17, 0x00001234, %r21
! CHECK: 0x5a,0xc6,0x12,0x34
or.f %r17, 0x12340000, %r21
! CHECK: 0x5a,0xc7,0x12,0x34
or %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x95,0x00
or.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x95,0x00
popc %r17, %r21
! CHECK: 0xda,0xc4,0x00,0x01
st %r21
! CHECK: 0xe0,0x54,0x00,0x02
shi %r21
! CHECK: 0xe2,0x54,0x00,0x02
sugt %r21
! CHECK: 0xe2,0x54,0x00,0x02
sls %r21
! CHECK: 0xe2,0x54,0x00,0x03
sule %r21
! CHECK: 0xe2,0x54,0x00,0x03
scc %r21
! CHECK: 0xe4,0x54,0x00,0x02
sult %r21
! CHECK: 0xe4,0x54,0x00,0x02
scs %r21
! CHECK: 0xe4,0x54,0x00,0x03
suge %r21
! CHECK: 0xe4,0x54,0x00,0x03
sne %r21
! CHECK: 0xe6,0x54,0x00,0x02
seq %r21
! CHECK: 0xe6,0x54,0x00,0x03
svc %r21
! CHECK: 0xe8,0x54,0x00,0x02
svs %r21
! CHECK: 0xe8,0x54,0x00,0x03
spl %r21
! CHECK: 0xea,0x54,0x00,0x02
smi %r21
! CHECK: 0xea,0x54,0x00,0x03
sge %r21
! CHECK: 0xec,0x54,0x00,0x02
slt %r21
! CHECK: 0xec,0x54,0x00,0x03
sgt %r21
! CHECK: 0xee,0x54,0x00,0x02
sh %r17, -31, %r21
! CHECK: 0x7a,0xc4,0xff,0xe1
sh %r17, -5, %r21
! CHECK: 0x7a,0xc4,0xff,0xfb
sh %r17, 2, %r21
! CHECK: 0x7a,0xc4,0x00,0x02
sh %r17, 31, %r21
! CHECK: 0x7a,0xc4,0x00,0x1f
sh.f %r17, -31, %r21
! CHECK: 0x7a,0xc6,0xff,0xe1
sh.f %r17, -5, %r21
! CHECK: 0x7a,0xc6,0xff,0xfb
sh.f %r17, 2, %r21
! CHECK: 0x7a,0xc6,0x00,0x02
sh.f %r17, 31, %r21
! CHECK: 0x7a,0xc6,0x00,0x1f
sh %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x97,0x80
sh.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x97,0x80
sha %r17, -31, %r21
! CHECK: 0x7a,0xc5,0xff,0xe1
sha %r17, -5, %r21
! CHECK: 0x7a,0xc5,0xff,0xfb
sha %r17, 2, %r21
! CHECK: 0x7a,0xc5,0x00,0x02
sha %r17, 31, %r21
! CHECK: 0x7a,0xc5,0x00,0x1f
sha.f %r17, -31, %r21
! CHECK: 0x7a,0xc7,0xff,0xe1
sha.f %r17, -5, %r21
! CHECK: 0x7a,0xc7,0xff,0xfb
sha.f %r17, 2, %r21
! CHECK: 0x7a,0xc7,0x00,0x02
sha.f %r17, 31, %r21
! CHECK: 0x7a,0xc7,0x00,0x1f
sha %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x97,0xc0
sha.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x97,0xc0
st %r17, -32768[%r19]
! CHECK: 0x98,0xce,0x80,0x00
st %r17, -1024[%r19]
! CHECK: 0x98,0xce,0xfc,0x00
st %r17, 0[%r19]
! CHECK: 0x98,0xcc,0x00,0x00
st %r17, 1024[%r19]
! CHECK: 0x98,0xce,0x04,0x00
st %r17, 32767[%r19]
! CHECK: 0x98,0xce,0x7f,0xff
st.h %r17, -512[%r19]
! CHECK: 0xf8,0xcf,0x2a,0x00
st.h %r17, -13[%r19]
! CHECK: 0xf8,0xcf,0x2b,0xf3
st.h %r17, 18[%r19]
! CHECK: 0xf8,0xcf,0x28,0x12
st.h %r17, 511[%r19]
! CHECK: 0xf8,0xcf,0x29,0xff
st.b %r17, -512[%r19]
! CHECK: 0xf8,0xcf,0x6a,0x00
st.b %r17, -13[%r19]
! CHECK: 0xf8,0xcf,0x6b,0xf3
st.b %r17, 18[%r19]
! CHECK: 0xf8,0xcf,0x68,0x12
st.b %r17, 511[%r19]
! CHECK: 0xf8,0xcf,0x69,0xff
st %r17, %r18[%r19]
! CHECK: 0xb8,0xce,0x90,0x02
st.h %r17, %r18[%r19]
! CHECK: 0xb8,0xce,0x90,0x00
st.b %r17, %r18[%r19]
! CHECK: 0xb8,0xce,0x90,0x04
st %r17, -32768[*%r19]
! CHECK: 0x98,0xcf,0x80,0x00
st %r17, -1024[*%r19]
! CHECK: 0x98,0xcf,0xfc,0x00
st %r17, 0[*%r19]
! CHECK: 0x98,0xcc,0x00,0x00
st %r17, 1024[*%r19]
! CHECK: 0x98,0xcf,0x04,0x00
st %r17, 32767[*%r19]
! CHECK: 0x98,0xcf,0x7f,0xff
st.h %r17, -512[*%r19]
! CHECK: 0xf8,0xcf,0x2e,0x00
st.h %r17, -13[*%r19]
! CHECK: 0xf8,0xcf,0x2f,0xf3
st.h %r17, 18[*%r19]
! CHECK: 0xf8,0xcf,0x2c,0x12
st.h %r17, 511[*%r19]
! CHECK: 0xf8,0xcf,0x2d,0xff
st.b %r17, -512[*%r19]
! CHECK: 0xf8,0xcf,0x6e,0x00
st.b %r17, -13[*%r19]
! CHECK: 0xf8,0xcf,0x6f,0xf3
st.b %r17, 18[*%r19]
! CHECK: 0xf8,0xcf,0x6c,0x12
st.b %r17, 511[*%r19]
! CHECK: 0xf8,0xcf,0x6d,0xff
st %r17, [--%r19]
! CHECK: 0x98,0xcf,0xff,0xfc
st %r17, [++%r19]
! CHECK: 0x98,0xcf,0x00,0x04
st.h %r17, [--%r19]
! CHECK: 0xf8,0xcf,0x2f,0xfe
st.h %r17, [++%r19]
! CHECK: 0xf8,0xcf,0x2c,0x02
st.b %r17, [--%r19]
! CHECK: 0xf8,0xcf,0x6f,0xff
st.b %r17, [++%r19]
! CHECK: 0xf8,0xcf,0x6c,0x01
st %r17, %r18[*%r19]
! CHECK: 0xb8,0xcf,0x90,0x02
st.h %r17, %r18[*%r19]
! CHECK: 0xb8,0xcf,0x90,0x00
st.b %r17, %r18[*%r19]
! CHECK: 0xb8,0xcf,0x90,0x04
st %r17, -32768[%r19*]
! CHECK: 0x98,0xcd,0x80,0x00
st %r17, -1024[%r19*]
! CHECK: 0x98,0xcd,0xfc,0x00
st %r17, 0[%r19*]
! CHECK: 0x98,0xcc,0x00,0x00
st %r17, 1024[%r19*]
! CHECK: 0x98,0xcd,0x04,0x00
st %r17, 32767[%r19*]
! CHECK: 0x98,0xcd,0x7f,0xff
st.h %r17, -512[%r19*]
! CHECK: 0xf8,0xcf,0x26,0x00
st.h %r17, -13[%r19*]
! CHECK: 0xf8,0xcf,0x27,0xf3
st.h %r17, 18[%r19*]
! CHECK: 0xf8,0xcf,0x24,0x12
st.h %r17, 511[%r19*]
! CHECK: 0xf8,0xcf,0x25,0xff
st.b %r17, -512[%r19*]
! CHECK: 0xf8,0xcf,0x66,0x00
st.b %r17, -13[%r19*]
! CHECK: 0xf8,0xcf,0x67,0xf3
st.b %r17, 18[%r19*]
! CHECK: 0xf8,0xcf,0x64,0x12
st.b %r17, 511[%r19*]
! CHECK: 0xf8,0xcf,0x65,0xff
st %r17, [%r19--]
! CHECK: 0x98,0xcd,0xff,0xfc
st %r17, [%r19++]
! CHECK: 0x98,0xcd,0x00,0x04
st.h %r17, [%r19--]
! CHECK: 0xf8,0xcf,0x27,0xfe
st.h %r17, [%r19++]
! CHECK: 0xf8,0xcf,0x24,0x02
st.b %r17, [%r19--]
! CHECK: 0xf8,0xcf,0x67,0xff
st.b %r17, [%r19++]
! CHECK: 0xf8,0xcf,0x64,0x01
st %r17, %r18[%r19*]
! CHECK: 0xb8,0xcd,0x90,0x02
st.h %r17, %r18[%r19*]
! CHECK: 0xb8,0xcd,0x90,0x00
st.b %r17, %r18[%r19*]
! CHECK: 0xb8,0xcd,0x90,0x04
st %r21, [%r17 add %r18]
! CHECK: 0xba,0xc6,0x90,0x02
st %r21, [%r17 addc %r18]
! CHECK: 0xba,0xc6,0x91,0x02
st %r21, [%r17 sub %r18]
! CHECK: 0xba,0xc6,0x92,0x02
st %r21, [%r17 subb %r18]
! CHECK: 0xba,0xc6,0x93,0x02
st %r21, [%r17 and %r18]
! CHECK: 0xba,0xc6,0x94,0x02
st %r21, [%r17 or %r18]
! CHECK: 0xba,0xc6,0x95,0x02
st %r21, [%r17 xor %r18]
! CHECK: 0xba,0xc6,0x96,0x02
st %r21, [%r17 sh %r18]
! CHECK: 0xba,0xc6,0x97,0x82
st %r21, [%r17 sha %r18]
! CHECK: 0xba,0xc6,0x97,0xc2
st.h %r21, [%r17 add %r18]
! CHECK: 0xba,0xc6,0x90,0x00
st.h %r21, [%r17 addc %r18]
! CHECK: 0xba,0xc6,0x91,0x00
st.h %r21, [%r17 sub %r18]
! CHECK: 0xba,0xc6,0x92,0x00
st.h %r21, [%r17 subb %r18]
! CHECK: 0xba,0xc6,0x93,0x00
st.h %r21, [%r17 and %r18]
! CHECK: 0xba,0xc6,0x94,0x00
st.h %r21, [%r17 or %r18]
! CHECK: 0xba,0xc6,0x95,0x00
st.h %r21, [%r17 xor %r18]
! CHECK: 0xba,0xc6,0x96,0x00
st.h %r21, [%r17 sh %r18]
! CHECK: 0xba,0xc6,0x97,0x80
st.h %r21, [%r17 sha %r18]
! CHECK: 0xba,0xc6,0x97,0xc0
st.b %r21, [%r17 add %r18]
! CHECK: 0xba,0xc6,0x90,0x04
st.b %r21, [%r17 addc %r18]
! CHECK: 0xba,0xc6,0x91,0x04
st.b %r21, [%r17 sub %r18]
! CHECK: 0xba,0xc6,0x92,0x04
st.b %r21, [%r17 subb %r18]
! CHECK: 0xba,0xc6,0x93,0x04
st.b %r21, [%r17 and %r18]
! CHECK: 0xba,0xc6,0x94,0x04
st.b %r21, [%r17 or %r18]
! CHECK: 0xba,0xc6,0x95,0x04
st.b %r21, [%r17 xor %r18]
! CHECK: 0xba,0xc6,0x96,0x04
st.b %r21, [%r17 sh %r18]
! CHECK: 0xba,0xc6,0x97,0x84
st.b %r21, [%r17 sha %r18]
! CHECK: 0xba,0xc6,0x97,0xc4
st %r21, [*%r17 add %r18]
! CHECK: 0xba,0xc7,0x90,0x02
st %r21, [*%r17 addc %r18]
! CHECK: 0xba,0xc7,0x91,0x02
st %r21, [*%r17 sub %r18]
! CHECK: 0xba,0xc7,0x92,0x02
st %r21, [*%r17 subb %r18]
! CHECK: 0xba,0xc7,0x93,0x02
st %r21, [*%r17 and %r18]
! CHECK: 0xba,0xc7,0x94,0x02
st %r21, [*%r17 or %r18]
! CHECK: 0xba,0xc7,0x95,0x02
st %r21, [*%r17 xor %r18]
! CHECK: 0xba,0xc7,0x96,0x02
st %r21, [*%r17 sha %r18]
! CHECK: 0xba,0xc7,0x97,0xc2
st.h %r21, [*%r17 add %r18]
! CHECK: 0xba,0xc7,0x90,0x00
st.h %r21, [*%r17 addc %r18]
! CHECK: 0xba,0xc7,0x91,0x00
st.h %r21, [*%r17 sub %r18]
! CHECK: 0xba,0xc7,0x92,0x00
st.h %r21, [*%r17 subb %r18]
! CHECK: 0xba,0xc7,0x93,0x00
st.h %r21, [*%r17 and %r18]
! CHECK: 0xba,0xc7,0x94,0x00
st.h %r21, [*%r17 or %r18]
! CHECK: 0xba,0xc7,0x95,0x00
st.h %r21, [*%r17 xor %r18]
! CHECK: 0xba,0xc7,0x96,0x00
st.h %r21, [*%r17 sha %r18]
! CHECK: 0xba,0xc7,0x97,0xc0
st.b %r21, [*%r17 add %r18]
! CHECK: 0xba,0xc7,0x90,0x04
st.b %r21, [*%r17 addc %r18]
! CHECK: 0xba,0xc7,0x91,0x04
st.b %r21, [*%r17 sub %r18]
! CHECK: 0xba,0xc7,0x92,0x04
st.b %r21, [*%r17 subb %r18]
! CHECK: 0xba,0xc7,0x93,0x04
st.b %r21, [*%r17 and %r18]
! CHECK: 0xba,0xc7,0x94,0x04
st.b %r21, [*%r17 or %r18]
! CHECK: 0xba,0xc7,0x95,0x04
st.b %r21, [*%r17 xor %r18]
! CHECK: 0xba,0xc7,0x96,0x04
st.b %r21, [*%r17 sha %r18]
! CHECK: 0xba,0xc7,0x97,0xc4
st %r21, [%r17* add %r18]
! CHECK: 0xba,0xc5,0x90,0x02
st %r21, [%r17* addc %r18]
! CHECK: 0xba,0xc5,0x91,0x02
st %r21, [%r17* sub %r18]
! CHECK: 0xba,0xc5,0x92,0x02
st %r21, [%r17* subb %r18]
! CHECK: 0xba,0xc5,0x93,0x02
st %r21, [%r17* and %r18]
! CHECK: 0xba,0xc5,0x94,0x02
st %r21, [%r17* or %r18]
! CHECK: 0xba,0xc5,0x95,0x02
st %r21, [%r17* xor %r18]
! CHECK: 0xba,0xc5,0x96,0x02
st %r21, [%r17* sh %r18]
! CHECK: 0xba,0xc5,0x97,0x82
st %r21, [%r17* sha %r18]
! CHECK: 0xba,0xc5,0x97,0xc2
st.h %r21, [%r17* add %r18]
! CHECK: 0xba,0xc5,0x90,0x00
st.h %r21, [%r17* addc %r18]
! CHECK: 0xba,0xc5,0x91,0x00
st.h %r21, [%r17* sub %r18]
! CHECK: 0xba,0xc5,0x92,0x00
st.h %r21, [%r17* subb %r18]
! CHECK: 0xba,0xc5,0x93,0x00
st.h %r21, [%r17* and %r18]
! CHECK: 0xba,0xc5,0x94,0x00
st.h %r21, [%r17* or %r18]
! CHECK: 0xba,0xc5,0x95,0x00
st.h %r21, [%r17* xor %r18]
! CHECK: 0xba,0xc5,0x96,0x00
st.h %r21, [%r17* sh %r18]
! CHECK: 0xba,0xc5,0x97,0x80
st.h %r21, [%r17* sha %r18]
! CHECK: 0xba,0xc5,0x97,0xc0
st.b %r21, [%r17* add %r18]
! CHECK: 0xba,0xc5,0x90,0x04
st.b %r21, [%r17* addc %r18]
! CHECK: 0xba,0xc5,0x91,0x04
st.b %r21, [%r17* sub %r18]
! CHECK: 0xba,0xc5,0x92,0x04
st.b %r21, [%r17* subb %r18]
! CHECK: 0xba,0xc5,0x93,0x04
st.b %r21, [%r17* and %r18]
! CHECK: 0xba,0xc5,0x94,0x04
st.b %r21, [%r17* or %r18]
! CHECK: 0xba,0xc5,0x95,0x04
st.b %r21, [%r17* xor %r18]
! CHECK: 0xba,0xc5,0x96,0x04
st.b %r21, [%r17* sh %r18]
! CHECK: 0xba,0xc5,0x97,0x84
st.b %r21, [%r17* sha %r18]
! CHECK: 0xba,0xc5,0x97,0xc4
st %r21, [0x12344]
! CHECK: 0xfa,0x85,0x23,0x44
sub %r17, 0, %r21
! CHECK: 0x2a,0xc4,0x00,0x00
sub %r17, 0x00001234, %r21
! CHECK: 0x2a,0xc4,0x12,0x34
sub %r17, 0x12340000, %r21
! CHECK: 0x2a,0xc5,0x12,0x34
sub.f %r17, 0, %r21
! CHECK: 0x2a,0xc6,0x00,0x00
sub.f %r17, 0x00001234, %r21
! CHECK: 0x2a,0xc6,0x12,0x34
sub.f %r17, 0x12340000, %r21
! CHECK: 0x2a,0xc7,0x12,0x34
sub %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x92,0x00
sub.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x92,0x00
subb %r17, 0, %r21
! CHECK: 0x3a,0xc4,0x00,0x00
subb %r17, 0x00001234, %r21
! CHECK: 0x3a,0xc4,0x12,0x34
subb %r17, 0x12340000, %r21
! CHECK: 0x3a,0xc5,0x12,0x34
subb.f %r17, 0, %r21
! CHECK: 0x3a,0xc6,0x00,0x00
subb.f %r17, 0x00001234, %r21
! CHECK: 0x3a,0xc6,0x12,0x34
subb.f %r17, 0x12340000, %r21
! CHECK: 0x3a,0xc7,0x12,0x34
subb %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x93,0x00
subb.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x93,0x00
xor %r17, 0, %r21
! CHECK: 0x6a,0xc4,0x00,0x00
xor %r17, 0x00001234, %r21
! CHECK: 0x6a,0xc4,0x12,0x34
xor %r17, 0x12340000, %r21
! CHECK: 0x6a,0xc5,0x12,0x34
xor.f %r17, 0, %r21
! CHECK: 0x6a,0xc6,0x00,0x00
xor.f %r17, 0x00001234, %r21
! CHECK: 0x6a,0xc6,0x12,0x34
xor.f %r17, 0x12340000, %r21
! CHECK: 0x6a,0xc7,0x12,0x34
xor %r17, %r18, %r21
! CHECK: 0xca,0xc4,0x96,0x00
xor.f %r17, %r18, %r21
! CHECK: 0xca,0xc6,0x96,0x00
sel.ne %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x03
sel.gt %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x07
xor.lt %r17, %r18, %r21
! CHECK: 0xca,0xc5,0x96,0x06
xor.f.eq %r17, %r18, %r21
! CHECK: 0xca,0xc7,0x96,0x03
add.ge %r13, %r14, %r18
! CHECK: 0xc9,0x34,0x70,0x06
spl %r19
! CHECK: 0xea,0x4c,0x00,0x02
bt 0x1234
! CHECK: 0xe0,0x00,0x12,0x34
sel.t %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x00
sel.f %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x00
sel.ugt %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x01
sel.ule %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x01
sel.ult %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x02
sel.uge %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x02
sel.ne %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x03
sel.eq %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x03
sel.vc %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x04
sel.vs %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x04
sel.pl %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x05
sel.mi %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x05
sel.ge %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x06
sel.lt %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x06
sel.gt %r9, %r15, %r12
! CHECK: 0xc6,0x24,0x7f,0x07
sel.le %r9, %r15, %r12
! CHECK: 0xc6,0x25,0x7f,0x07
trailz %r15, %r12
! CHECK: 0xd6,0x3c,0x00,0x03
