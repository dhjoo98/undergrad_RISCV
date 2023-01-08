; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

declare void @byval_i32(i32* byval(i32) %ptr)

define void @call_byval_i32(i32* %incoming) {
; CHECK-LABEL: call_byval_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    str x30, [sp, #16] // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    str w8, [sp]
; CHECK-NEXT:    bl byval_i32
; CHECK-NEXT:    ldr x30, [sp, #16] // 8-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #32
; CHECK-NEXT:    ret
  call void @byval_i32(i32* byval(i32) %incoming)
  ret void
}

declare void @byval_a64i32([64 x i32]* byval([64 x i32]) %ptr)

define void @call_byval_a64i32([64 x i32]* %incoming) {
; CHECK-LABEL: call_byval_a64i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #288
; CHECK-NEXT:    stp x29, x30, [sp, #256] // 16-byte Folded Spill
; CHECK-NEXT:    str x28, [sp, #272] // 8-byte Folded Spill
; CHECK-NEXT:    add x29, sp, #256
; CHECK-NEXT:    .cfi_def_cfa w29, 32
; CHECK-NEXT:    .cfi_offset w28, -16
; CHECK-NEXT:    .cfi_offset w30, -24
; CHECK-NEXT:    .cfi_offset w29, -32
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    ldr q0, [x0, #16]
; CHECK-NEXT:    str q0, [sp, #16]
; CHECK-NEXT:    ldr q0, [x0, #32]
; CHECK-NEXT:    str q0, [sp, #32]
; CHECK-NEXT:    ldr q0, [x0, #48]
; CHECK-NEXT:    str q0, [sp, #48]
; CHECK-NEXT:    ldr q0, [x0, #64]
; CHECK-NEXT:    str q0, [sp, #64]
; CHECK-NEXT:    ldr q0, [x0, #80]
; CHECK-NEXT:    str q0, [sp, #80]
; CHECK-NEXT:    ldr q0, [x0, #96]
; CHECK-NEXT:    str q0, [sp, #96]
; CHECK-NEXT:    ldr q0, [x0, #112]
; CHECK-NEXT:    str q0, [sp, #112]
; CHECK-NEXT:    ldr q0, [x0, #128]
; CHECK-NEXT:    str q0, [sp, #128]
; CHECK-NEXT:    ldr q0, [x0, #144]
; CHECK-NEXT:    str q0, [sp, #144]
; CHECK-NEXT:    ldr q0, [x0, #160]
; CHECK-NEXT:    str q0, [sp, #160]
; CHECK-NEXT:    ldr q0, [x0, #176]
; CHECK-NEXT:    str q0, [sp, #176]
; CHECK-NEXT:    ldr q0, [x0, #192]
; CHECK-NEXT:    str q0, [sp, #192]
; CHECK-NEXT:    ldr q0, [x0, #208]
; CHECK-NEXT:    str q0, [sp, #208]
; CHECK-NEXT:    ldr q0, [x0, #224]
; CHECK-NEXT:    str q0, [sp, #224]
; CHECK-NEXT:    ldr q0, [x0, #240]
; CHECK-NEXT:    str q0, [sp, #240]
; CHECK-NEXT:    bl byval_a64i32
; CHECK-NEXT:    ldr x28, [sp, #272] // 8-byte Folded Reload
; CHECK-NEXT:    ldp x29, x30, [sp, #256] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #288
; CHECK-NEXT:    ret
  call void @byval_a64i32([64 x i32]* byval([64 x i32]) %incoming)
  ret void
}