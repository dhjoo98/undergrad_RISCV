; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i1> @vselect_nxv1i1(<vscale x 1 x i1> %a, <vscale x 1 x i1> %b, <vscale x 1 x i1> %cc) {
; CHECK-LABEL: vselect_nxv1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 1 x i1> %cc, <vscale x 1 x i1> %a, <vscale x 1 x i1> %b
  ret <vscale x 1 x i1> %v
}

define <vscale x 2 x i1> @vselect_nxv2i1(<vscale x 2 x i1> %a, <vscale x 2 x i1> %b, <vscale x 2 x i1> %cc) {
; CHECK-LABEL: vselect_nxv2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 2 x i1> %cc, <vscale x 2 x i1> %a, <vscale x 2 x i1> %b
  ret <vscale x 2 x i1> %v
}

define <vscale x 4 x i1> @vselect_nxv4i1(<vscale x 4 x i1> %a, <vscale x 4 x i1> %b, <vscale x 4 x i1> %cc) {
; CHECK-LABEL: vselect_nxv4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 4 x i1> %cc, <vscale x 4 x i1> %a, <vscale x 4 x i1> %b
  ret <vscale x 4 x i1> %v
}

define <vscale x 8 x i1> @vselect_nxv8i1(<vscale x 8 x i1> %a, <vscale x 8 x i1> %b, <vscale x 8 x i1> %cc) {
; CHECK-LABEL: vselect_nxv8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 8 x i1> %cc, <vscale x 8 x i1> %a, <vscale x 8 x i1> %b
  ret <vscale x 8 x i1> %v
}

define <vscale x 16 x i1> @vselect_nxv16i1(<vscale x 16 x i1> %a, <vscale x 16 x i1> %b, <vscale x 16 x i1> %cc) {
; CHECK-LABEL: vselect_nxv16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 16 x i1> %cc, <vscale x 16 x i1> %a, <vscale x 16 x i1> %b
  ret <vscale x 16 x i1> %v
}

define <vscale x 32 x i1> @vselect_nxv32i1(<vscale x 32 x i1> %a, <vscale x 32 x i1> %b, <vscale x 32 x i1> %cc) {
; CHECK-LABEL: vselect_nxv32i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 32 x i1> %cc, <vscale x 32 x i1> %a, <vscale x 32 x i1> %b
  ret <vscale x 32 x i1> %v
}

define <vscale x 64 x i1> @vselect_nxv64i1(<vscale x 64 x i1> %a, <vscale x 64 x i1> %b, <vscale x 64 x i1> %cc) {
; CHECK-LABEL: vselect_nxv64i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, mu
; CHECK-NEXT:    vmandnot.mm v25, v8, v9
; CHECK-NEXT:    vmand.mm v26, v0, v9
; CHECK-NEXT:    vmor.mm v0, v26, v25
; CHECK-NEXT:    ret
  %v = select <vscale x 64 x i1> %cc, <vscale x 64 x i1> %a, <vscale x 64 x i1> %b
  ret <vscale x 64 x i1> %v
}
