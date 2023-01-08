; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu < %s -o -| FileCheck %s

define void @matrix_mul_unsigned(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_unsigned:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    and w9, w3, #0xffff
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:    dup v0.4h, w9
; CHECK-NEXT:  .LBB0_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x9, x2, w0, uxtw #1
; CHECK-NEXT:    ldp d1, d2, [x9]
; CHECK-NEXT:    add x9, x1, w0, uxtw #2
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    umull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    umull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q2, [x9]
; CHECK-NEXT:    b.ne .LBB0_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = zext i16 %val to i32
  %wide.trip.count = zext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = zext i32 %4 to i64
  %6 = getelementptr inbounds i16, i16* %A, i64 %5
  %7 = bitcast i16* %6 to <4 x i16>*
  %wide.load = load <4 x i16>, <4 x i16>* %7, align 2
  %8 = getelementptr inbounds i16, i16* %6, i64 4
  %9 = bitcast i16* %8 to <4 x i16>*
  %wide.load30 = load <4 x i16>, <4 x i16>* %9, align 2
  %10 = zext <4 x i16> %wide.load to <4 x i32>
  %11 = zext <4 x i16> %wide.load30 to <4 x i32>
  %12 = mul nuw nsw <4 x i32> %broadcast.splat, %10
  %13 = mul nuw nsw <4 x i32> %broadcast.splat32, %11
  %14 = getelementptr inbounds i32, i32* %C, i64 %5
  %15 = bitcast i32* %14 to <4 x i32>*
  store <4 x i32> %12, <4 x i32>* %15, align 4
  %16 = getelementptr inbounds i32, i32* %14, i64 4
  %17 = bitcast i32* %16 to <4 x i32>*
  store <4 x i32> %13, <4 x i32>* %17, align 4
  %index.next = add i64 %index, 8
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}

define void @matrix_mul_signed(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_signed:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    sxth w9, w3
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:    dup v0.4h, w9
; CHECK-NEXT:  .LBB1_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    add x9, x2, w0, sxtw #1
; CHECK-NEXT:    ldp d1, d2, [x9]
; CHECK-NEXT:    add x9, x1, w0, sxtw #2
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    smull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    smull v2.4s, v0.4h, v2.4h
; CHECK-NEXT:    stp q1, q2, [x9]
; CHECK-NEXT:    b.ne .LBB1_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = sext i16 %val to i32
  %wide.trip.count = sext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds i16, i16* %A, i64 %5
  %7 = bitcast i16* %6 to <4 x i16>*
  %wide.load = load <4 x i16>, <4 x i16>* %7, align 2
  %8 = getelementptr inbounds i16, i16* %6, i64 4
  %9 = bitcast i16* %8 to <4 x i16>*
  %wide.load30 = load <4 x i16>, <4 x i16>* %9, align 2
  %10 = sext <4 x i16> %wide.load to <4 x i32>
  %11 = sext <4 x i16> %wide.load30 to <4 x i32>
  %12 = mul nsw <4 x i32> %broadcast.splat, %10
  %13 = mul nsw <4 x i32> %broadcast.splat32, %11
  %14 = getelementptr inbounds i32, i32* %C, i64 %5
  %15 = bitcast i32* %14 to <4 x i32>*
  store <4 x i32> %12, <4 x i32>* %15, align 4
  %16 = getelementptr inbounds i32, i32* %14, i64 4
  %17 = bitcast i32* %16 to <4 x i32>*
  store <4 x i32> %13, <4 x i32>* %17, align 4
  %index.next = add i64 %index, 8
  %18 = icmp eq i64 %index.next, %n.vec
  br i1 %18, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}


define void @matrix_mul_double_shuffle(i32 %N, i32* nocapture %C, i16* nocapture readonly %A, i16 %val) {
; CHECK-LABEL: matrix_mul_double_shuffle:
; CHECK:       // %bb.0: // %vector.header
; CHECK-NEXT:    and w9, w3, #0xffff
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    and x8, x0, #0xfffffff8
; CHECK-NEXT:    dup v0.4h, w9
; CHECK-NEXT:  .LBB2_1: // %vector.body
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh w9, [x2], #16
; CHECK-NEXT:    mov w10, w0
; CHECK-NEXT:    subs x8, x8, #8
; CHECK-NEXT:    lsl x10, x10, #2
; CHECK-NEXT:    dup v1.4h, w9
; CHECK-NEXT:    umull v1.4s, v0.4h, v1.4h
; CHECK-NEXT:    add w0, w0, #8
; CHECK-NEXT:    str q1, [x1, x10]
; CHECK-NEXT:    b.ne .LBB2_1
; CHECK-NEXT:  // %bb.2: // %for.end12
; CHECK-NEXT:    ret
vector.header:
  %conv4 = zext i16 %val to i32
  %wide.trip.count = zext i32 %N to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %min.iters.check = icmp ult i32 %N, 8
  %1 = trunc i64 %0 to i32
  %2 = icmp ugt i64 %0, 4294967295
  %n.vec = and i64 %wide.trip.count, 4294967288
  %broadcast.splatinsert = insertelement <4 x i32> undef, i32 %conv4, i32 0
  %broadcast.splat = shufflevector <4 x i32> %broadcast.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br label %vector.body

vector.body:                                      ; preds = %vector.header, %vector.body
  %index = phi i64 [ %index.next, %vector.body ], [ 0, %vector.header ]
  %g = getelementptr inbounds i16, i16* %A, i64 %index
  %val1 = load i16, i16* %g
  %splat.input.ext = zext i16 %val1 to i32
  %broadcast.splatinsert31 = insertelement <4 x i32> undef, i32 %splat.input.ext, i32 0
  %broadcast.splat32 = shufflevector <4 x i32> %broadcast.splatinsert31, <4 x i32> %broadcast.splat, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %3 = trunc i64 %index to i32
  %4 = add i32 %N, %3
  %5 = zext i32 %4 to i64
  %6 = mul nuw nsw <4 x i32> %broadcast.splat, %broadcast.splat32
  %7 = getelementptr inbounds i32, i32* %C, i64 %5
  %8 = bitcast i32* %7 to <4 x i32>*
  store <4 x i32> %6, <4 x i32>* %8, align 4
  %index.next = add i64 %index, 8
  %9 = icmp eq i64 %index.next, %n.vec
  br i1 %9, label %for.end12, label %vector.body

for.end12:                                        ; preds = %vector.body
  ret void
}
