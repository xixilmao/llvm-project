; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 < %s | FileCheck %s --check-prefix=LA32
; RUN: llc --mtriple=loongarch64 < %s | FileCheck %s --check-prefix=LA64

;; Exercise the 'mul' LLVM IR: https://llvm.org/docs/LangRef.html#mul-instruction

define i1 @mul_i1(i1 %a, i1 %b) {
; LA32-LABEL: mul_i1:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    mul.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i1:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    mul.d $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = mul i1 %a, %b
  ret i1 %r
}

define i8 @mul_i8(i8 %a, i8 %b) {
; LA32-LABEL: mul_i8:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    mul.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i8:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    mul.d $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = mul i8 %a, %b
  ret i8 %r
}

define i16 @mul_i16(i16 %a, i16 %b) {
; LA32-LABEL: mul_i16:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    mul.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i16:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    mul.d $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = mul i16 %a, %b
  ret i16 %r
}

define i32 @mul_i32(i32 %a, i32 %b) {
; LA32-LABEL: mul_i32:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    mul.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    mul.d $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = mul i32 %a, %b
  ret i32 %r
}

define i64 @mul_i64(i64 %a, i64 %b) {
; LA32-LABEL: mul_i64:
; LA32:       # %bb.0: # %entry
; LA32-NEXT:    mul.w $a3, $a0, $a3
; LA32-NEXT:    mulh.wu $a4, $a0, $a2
; LA32-NEXT:    add.w $a3, $a4, $a3
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64:
; LA64:       # %bb.0: # %entry
; LA64-NEXT:    mul.d $a0, $a0, $a1
; LA64-NEXT:    ret
entry:
  %r = mul i64 %a, %b
  ret i64 %r
}

define i64 @mul_pow2(i64 %a) {
; LA32-LABEL: mul_pow2:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a1, $a1, 3
; LA32-NEXT:    srli.w $a2, $a0, 29
; LA32-NEXT:    or $a1, $a1, $a2
; LA32-NEXT:    slli.w $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_pow2:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a0, $a0, 3
; LA64-NEXT:    ret
  %1 = mul i64 %a, 8
  ret i64 %1
}

define i64 @mul_p5(i64 %a) {
; LA32-LABEL: mul_p5:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 5
; LA32-NEXT:    mulh.wu $a2, $a0, $a2
; LA32-NEXT:    alsl.w $a1, $a1, $a1, 2
; LA32-NEXT:    add.w $a1, $a2, $a1
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_p5:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 2
; LA64-NEXT:    ret
  %1 = mul i64 %a, 5
  ret i64 %1
}

define i32 @mulh_w(i32 %a, i32 %b) {
; LA32-LABEL: mulh_w:
; LA32:       # %bb.0:
; LA32-NEXT:    mulh.w $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mulh_w:
; LA64:       # %bb.0:
; LA64-NEXT:    mulw.d.w $a0, $a0, $a1
; LA64-NEXT:    srli.d $a0, $a0, 32
; LA64-NEXT:    ret
  %1 = sext i32 %a to i64
  %2 = sext i32 %b to i64
  %3 = mul i64 %1, %2
  %4 = lshr i64 %3, 32
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

define i32 @mulh_wu(i32 %a, i32 %b) {
; LA32-LABEL: mulh_wu:
; LA32:       # %bb.0:
; LA32-NEXT:    mulh.wu $a0, $a0, $a1
; LA32-NEXT:    ret
;
; LA64-LABEL: mulh_wu:
; LA64:       # %bb.0:
; LA64-NEXT:    mulw.d.wu $a0, $a0, $a1
; LA64-NEXT:    srli.d $a0, $a0, 32
; LA64-NEXT:    ret
  %1 = zext i32 %a to i64
  %2 = zext i32 %b to i64
  %3 = mul i64 %1, %2
  %4 = lshr i64 %3, 32
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

define i64 @mulh_d(i64 %a, i64 %b) {
; LA32-LABEL: mulh_d:
; LA32:       # %bb.0:
; LA32-NEXT:    mulh.wu $a4, $a0, $a2
; LA32-NEXT:    mul.w $a5, $a1, $a2
; LA32-NEXT:    add.w $a4, $a5, $a4
; LA32-NEXT:    sltu $a5, $a4, $a5
; LA32-NEXT:    mulh.wu $a6, $a1, $a2
; LA32-NEXT:    add.w $a5, $a6, $a5
; LA32-NEXT:    mul.w $a6, $a0, $a3
; LA32-NEXT:    add.w $a4, $a6, $a4
; LA32-NEXT:    sltu $a4, $a4, $a6
; LA32-NEXT:    mulh.wu $a6, $a0, $a3
; LA32-NEXT:    add.w $a4, $a6, $a4
; LA32-NEXT:    add.w $a4, $a5, $a4
; LA32-NEXT:    sltu $a5, $a4, $a5
; LA32-NEXT:    mulh.wu $a6, $a1, $a3
; LA32-NEXT:    add.w $a5, $a6, $a5
; LA32-NEXT:    mul.w $a6, $a1, $a3
; LA32-NEXT:    add.w $a4, $a6, $a4
; LA32-NEXT:    sltu $a6, $a4, $a6
; LA32-NEXT:    add.w $a5, $a5, $a6
; LA32-NEXT:    srai.w $a6, $a1, 31
; LA32-NEXT:    mul.w $a7, $a2, $a6
; LA32-NEXT:    mulh.wu $a2, $a2, $a6
; LA32-NEXT:    add.w $a2, $a2, $a7
; LA32-NEXT:    mul.w $a6, $a3, $a6
; LA32-NEXT:    add.w $a2, $a2, $a6
; LA32-NEXT:    srai.w $a3, $a3, 31
; LA32-NEXT:    mul.w $a1, $a3, $a1
; LA32-NEXT:    mulh.wu $a6, $a3, $a0
; LA32-NEXT:    add.w $a1, $a6, $a1
; LA32-NEXT:    mul.w $a0, $a3, $a0
; LA32-NEXT:    add.w $a1, $a1, $a0
; LA32-NEXT:    add.w $a1, $a1, $a2
; LA32-NEXT:    add.w $a2, $a0, $a7
; LA32-NEXT:    sltu $a0, $a2, $a0
; LA32-NEXT:    add.w $a0, $a1, $a0
; LA32-NEXT:    add.w $a1, $a5, $a0
; LA32-NEXT:    add.w $a0, $a4, $a2
; LA32-NEXT:    sltu $a2, $a0, $a4
; LA32-NEXT:    add.w $a1, $a1, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mulh_d:
; LA64:       # %bb.0:
; LA64-NEXT:    mulh.d $a0, $a0, $a1
; LA64-NEXT:    ret
  %1 = sext i64 %a to i128
  %2 = sext i64 %b to i128
  %3 = mul i128 %1, %2
  %4 = lshr i128 %3, 64
  %5 = trunc i128 %4 to i64
  ret i64 %5
}

define i64 @mulh_du(i64 %a, i64 %b) {
; LA32-LABEL: mulh_du:
; LA32:       # %bb.0:
; LA32-NEXT:    mulh.wu $a4, $a0, $a2
; LA32-NEXT:    mul.w $a5, $a1, $a2
; LA32-NEXT:    add.w $a4, $a5, $a4
; LA32-NEXT:    sltu $a5, $a4, $a5
; LA32-NEXT:    mulh.wu $a2, $a1, $a2
; LA32-NEXT:    add.w $a2, $a2, $a5
; LA32-NEXT:    mul.w $a5, $a0, $a3
; LA32-NEXT:    add.w $a4, $a5, $a4
; LA32-NEXT:    sltu $a4, $a4, $a5
; LA32-NEXT:    mulh.wu $a0, $a0, $a3
; LA32-NEXT:    add.w $a0, $a0, $a4
; LA32-NEXT:    mul.w $a4, $a1, $a3
; LA32-NEXT:    mulh.wu $a1, $a1, $a3
; LA32-NEXT:    add.w $a0, $a2, $a0
; LA32-NEXT:    sltu $a2, $a0, $a2
; LA32-NEXT:    add.w $a1, $a1, $a2
; LA32-NEXT:    add.w $a0, $a4, $a0
; LA32-NEXT:    sltu $a2, $a0, $a4
; LA32-NEXT:    add.w $a1, $a1, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mulh_du:
; LA64:       # %bb.0:
; LA64-NEXT:    mulh.du $a0, $a0, $a1
; LA64-NEXT:    ret
  %1 = zext i64 %a to i128
  %2 = zext i64 %b to i128
  %3 = mul i128 %1, %2
  %4 = lshr i128 %3, 64
  %5 = trunc i128 %4 to i64
  ret i64 %5
}

define i64 @mulw_d_w(i32 %a, i32 %b) {
; LA32-LABEL: mulw_d_w:
; LA32:       # %bb.0:
; LA32-NEXT:    mul.w $a2, $a0, $a1
; LA32-NEXT:    mulh.w $a1, $a0, $a1
; LA32-NEXT:    move $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mulw_d_w:
; LA64:       # %bb.0:
; LA64-NEXT:    mulw.d.w $a0, $a0, $a1
; LA64-NEXT:    ret
  %1 = sext i32 %a to i64
  %2 = sext i32 %b to i64
  %3 = mul i64 %1, %2
  ret i64 %3
}

define i64 @mulw_d_wu(i32 %a, i32 %b) {
; LA32-LABEL: mulw_d_wu:
; LA32:       # %bb.0:
; LA32-NEXT:    mul.w $a2, $a0, $a1
; LA32-NEXT:    mulh.wu $a1, $a0, $a1
; LA32-NEXT:    move $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mulw_d_wu:
; LA64:       # %bb.0:
; LA64-NEXT:    mulw.d.wu $a0, $a0, $a1
; LA64-NEXT:    ret
  %1 = zext i32 %a to i64
  %2 = zext i32 %b to i64
  %3 = mul i64 %1, %2
  ret i64 %3
}

define signext i32 @mul_i32_11(i32 %a) {
; LA32-LABEL: mul_i32_11:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_11:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i32 %a, 11
  ret i32 %b
}

define signext i32 @mul_i32_13(i32 %a) {
; LA32-LABEL: mul_i32_13:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_13:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i32 %a, 13
  ret i32 %b
}

define signext i32 @mul_i32_19(i32 %a) {
; LA32-LABEL: mul_i32_19:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_19:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i32 %a, 19
  ret i32 %b
}

define signext i32 @mul_i32_21(i32 %a) {
; LA32-LABEL: mul_i32_21:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_21:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i32 %a, 21
  ret i32 %b
}

define signext i32 @mul_i32_25(i32 %a) {
; LA32-LABEL: mul_i32_25:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_25:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 25
  ret i32 %b
}

define signext i32 @mul_i32_27(i32 %a) {
; LA32-LABEL: mul_i32_27:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_27:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 27
  ret i32 %b
}

define signext i32 @mul_i32_35(i32 %a) {
; LA32-LABEL: mul_i32_35:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_35:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i32 %a, 35
  ret i32 %b
}

define signext i32 @mul_i32_37(i32 %a) {
; LA32-LABEL: mul_i32_37:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_37:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i32 %a, 37
  ret i32 %b
}

define signext i32 @mul_i32_41(i32 %a) {
; LA32-LABEL: mul_i32_41:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_41:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 41
  ret i32 %b
}

define signext i32 @mul_i32_45(i32 %a) {
; LA32-LABEL: mul_i32_45:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_45:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 45
  ret i32 %b
}

define signext i32 @mul_i32_49(i32 %a) {
; LA32-LABEL: mul_i32_49:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_49:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 49
  ret i32 %b
}

define signext i32 @mul_i32_51(i32 %a) {
; LA32-LABEL: mul_i32_51:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_51:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 51
  ret i32 %b
}

define signext i32 @mul_i32_69(i32 %a) {
; LA32-LABEL: mul_i32_69:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_69:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i32 %a, 69
  ret i32 %b
}

define signext i32 @mul_i32_73(i32 %a) {
; LA32-LABEL: mul_i32_73:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_73:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 73
  ret i32 %b
}

define signext i32 @mul_i32_81(i32 %a) {
; LA32-LABEL: mul_i32_81:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_81:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 81
  ret i32 %b
}

define signext i32 @mul_i32_85(i32 %a) {
; LA32-LABEL: mul_i32_85:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_85:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 85
  ret i32 %b
}

define signext i32 @mul_i32_137(i32 %a) {
; LA32-LABEL: mul_i32_137:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_137:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 137
  ret i32 %b
}

define signext i32 @mul_i32_145(i32 %a) {
; LA32-LABEL: mul_i32_145:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_145:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 145
  ret i32 %b
}

define signext i32 @mul_i32_153(i32 %a) {
; LA32-LABEL: mul_i32_153:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_153:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 153
  ret i32 %b
}

define signext i32 @mul_i32_273(i32 %a) {
; LA32-LABEL: mul_i32_273:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA32-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_273:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.w $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 273
  ret i32 %b
}

define signext i32 @mul_i32_289(i32 %a) {
; LA32-LABEL: mul_i32_289:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_289:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 289
  ret i32 %b
}

define i64 @mul_i64_11(i64 %a) {
; LA32-LABEL: mul_i64_11:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 11
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_11:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i64 %a, 11
  ret i64 %b
}

define i64 @mul_i64_13(i64 %a) {
; LA32-LABEL: mul_i64_13:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 13
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_13:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i64 %a, 13
  ret i64 %b
}

define i64 @mul_i64_19(i64 %a) {
; LA32-LABEL: mul_i64_19:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 19
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_19:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i64 %a, 19
  ret i64 %b
}

define i64 @mul_i64_21(i64 %a) {
; LA32-LABEL: mul_i64_21:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 21
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_21:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i64 %a, 21
  ret i64 %b
}

define i64 @mul_i64_25(i64 %a) {
; LA32-LABEL: mul_i64_25:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 25
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_25:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 25
  ret i64 %b
}

define i64 @mul_i64_27(i64 %a) {
; LA32-LABEL: mul_i64_27:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 27
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_27:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 1
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 27
  ret i64 %b
}

define i64 @mul_i64_35(i64 %a) {
; LA32-LABEL: mul_i64_35:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 35
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_35:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 1
; LA64-NEXT:    ret
  %b = mul i64 %a, 35
  ret i64 %b
}

define i64 @mul_i64_37(i64 %a) {
; LA32-LABEL: mul_i64_37:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 37
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_37:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i64 %a, 37
  ret i64 %b
}

define i64 @mul_i64_41(i64 %a) {
; LA32-LABEL: mul_i64_41:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 41
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_41:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 41
  ret i64 %b
}

define i64 @mul_i64_45(i64 %a) {
; LA32-LABEL: mul_i64_45:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 45
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_45:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 45
  ret i64 %b
}

define i64 @mul_i64_49(i64 %a) {
; LA32-LABEL: mul_i64_49:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 49
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_49:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 1
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 49
  ret i64 %b
}

define i64 @mul_i64_51(i64 %a) {
; LA32-LABEL: mul_i64_51:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 51
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_51:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 1
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 51
  ret i64 %b
}

define i64 @mul_i64_69(i64 %a) {
; LA32-LABEL: mul_i64_69:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 69
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_69:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 2
; LA64-NEXT:    ret
  %b = mul i64 %a, 69
  ret i64 %b
}

define i64 @mul_i64_73(i64 %a) {
; LA32-LABEL: mul_i64_73:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 73
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_73:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 73
  ret i64 %b
}

define i64 @mul_i64_81(i64 %a) {
; LA32-LABEL: mul_i64_81:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 81
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_81:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 81
  ret i64 %b
}

define i64 @mul_i64_85(i64 %a) {
; LA32-LABEL: mul_i64_85:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 85
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_85:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 2
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 85
  ret i64 %b
}

define i64 @mul_i64_137(i64 %a) {
; LA32-LABEL: mul_i64_137:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 137
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_137:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 137
  ret i64 %b
}

define i64 @mul_i64_145(i64 %a) {
; LA32-LABEL: mul_i64_145:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 145
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_145:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 3
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 145
  ret i64 %b
}

define i64 @mul_i64_153(i64 %a) {
; LA32-LABEL: mul_i64_153:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 153
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_153:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 3
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 153
  ret i64 %b
}

define i64 @mul_i64_273(i64 %a) {
; LA32-LABEL: mul_i64_273:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 273
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_273:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a1, $a0, $a0, 4
; LA64-NEXT:    alsl.d $a0, $a1, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 273
  ret i64 %b
}

define i64 @mul_i64_289(i64 %a) {
; LA32-LABEL: mul_i64_289:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 289
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_289:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 289
  ret i64 %b
}

define signext i32 @mul_i32_4098(i32 %a) {
; LA32-LABEL: mul_i32_4098:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a1, $a0, 12
; LA32-NEXT:    alsl.w $a0, $a0, $a1, 1
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_4098:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.w $a0, $a0, $a1, 1
; LA64-NEXT:    ret
  %b = mul i32 %a, 4098
  ret i32 %b
}

define signext i32 @mul_i32_4100(i32 %a) {
; LA32-LABEL: mul_i32_4100:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a1, $a0, 12
; LA32-NEXT:    alsl.w $a0, $a0, $a1, 2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_4100:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.w $a0, $a0, $a1, 2
; LA64-NEXT:    ret
  %b = mul i32 %a, 4100
  ret i32 %b
}

define signext i32 @mul_i32_4104(i32 %a) {
; LA32-LABEL: mul_i32_4104:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a1, $a0, 12
; LA32-NEXT:    alsl.w $a0, $a0, $a1, 3
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_4104:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.w $a0, $a0, $a1, 3
; LA64-NEXT:    ret
  %b = mul i32 %a, 4104
  ret i32 %b
}

define signext i32 @mul_i32_4112(i32 %a) {
; LA32-LABEL: mul_i32_4112:
; LA32:       # %bb.0:
; LA32-NEXT:    slli.w $a1, $a0, 12
; LA32-NEXT:    alsl.w $a0, $a0, $a1, 4
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_4112:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.w $a0, $a0, $a1, 4
; LA64-NEXT:    ret
  %b = mul i32 %a, 4112
  ret i32 %b
}

define i64 @mul_i64_4098(i64 %a) {
; LA32-LABEL: mul_i64_4098:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a2, 1
; LA32-NEXT:    ori $a2, $a2, 2
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_4098:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.d $a0, $a0, $a1, 1
; LA64-NEXT:    ret
  %b = mul i64 %a, 4098
  ret i64 %b
}

define i64 @mul_i64_4100(i64 %a) {
; LA32-LABEL: mul_i64_4100:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a2, 1
; LA32-NEXT:    ori $a2, $a2, 4
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_4100:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.d $a0, $a0, $a1, 2
; LA64-NEXT:    ret
  %b = mul i64 %a, 4100
  ret i64 %b
}

define i64 @mul_i64_4104(i64 %a) {
; LA32-LABEL: mul_i64_4104:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a2, 1
; LA32-NEXT:    ori $a2, $a2, 8
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_4104:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.d $a0, $a0, $a1, 3
; LA64-NEXT:    ret
  %b = mul i64 %a, 4104
  ret i64 %b
}

define i64 @mul_i64_4112(i64 %a) {
; LA32-LABEL: mul_i64_4112:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a2, 1
; LA32-NEXT:    ori $a2, $a2, 16
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_4112:
; LA64:       # %bb.0:
; LA64-NEXT:    slli.d $a1, $a0, 12
; LA64-NEXT:    alsl.d $a0, $a0, $a1, 4
; LA64-NEXT:    ret
  %b = mul i64 %a, 4112
  ret i64 %b
}

define signext i32 @mul_i32_768(i32 %a) {
; LA32-LABEL: mul_i32_768:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA32-NEXT:    slli.w $a0, $a0, 8
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_768:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 1
; LA64-NEXT:    slli.w $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i32 %a, 768
  ret i32 %b
}

define signext i32 @mul_i32_1280(i32 %a) {
; LA32-LABEL: mul_i32_1280:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA32-NEXT:    slli.w $a0, $a0, 8
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_1280:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 2
; LA64-NEXT:    slli.w $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i32 %a, 1280
  ret i32 %b
}

define signext i32 @mul_i32_2304(i32 %a) {
; LA32-LABEL: mul_i32_2304:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA32-NEXT:    slli.w $a0, $a0, 8
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_2304:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 3
; LA64-NEXT:    slli.w $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i32 %a, 2304
  ret i32 %b
}

define signext i32 @mul_i32_4352(i32 %a) {
; LA32-LABEL: mul_i32_4352:
; LA32:       # %bb.0:
; LA32-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA32-NEXT:    slli.w $a0, $a0, 8
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i32_4352:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.w $a0, $a0, $a0, 4
; LA64-NEXT:    slli.w $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i32 %a, 4352
  ret i32 %b
}

define i64 @mul_i64_768(i64 %a) {
; LA32-LABEL: mul_i64_768:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 768
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_768:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 1
; LA64-NEXT:    slli.d $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i64 %a, 768
  ret i64 %b
}

define i64 @mul_i64_1280(i64 %a) {
; LA32-LABEL: mul_i64_1280:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 1280
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_1280:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 2
; LA64-NEXT:    slli.d $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i64 %a, 1280
  ret i64 %b
}

define i64 @mul_i64_2304(i64 %a) {
; LA32-LABEL: mul_i64_2304:
; LA32:       # %bb.0:
; LA32-NEXT:    ori $a2, $zero, 2304
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_2304:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 3
; LA64-NEXT:    slli.d $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i64 %a, 2304
  ret i64 %b
}

define i64 @mul_i64_4352(i64 %a) {
; LA32-LABEL: mul_i64_4352:
; LA32:       # %bb.0:
; LA32-NEXT:    lu12i.w $a2, 1
; LA32-NEXT:    ori $a2, $a2, 256
; LA32-NEXT:    mul.w $a1, $a1, $a2
; LA32-NEXT:    mulh.wu $a3, $a0, $a2
; LA32-NEXT:    add.w $a1, $a3, $a1
; LA32-NEXT:    mul.w $a0, $a0, $a2
; LA32-NEXT:    ret
;
; LA64-LABEL: mul_i64_4352:
; LA64:       # %bb.0:
; LA64-NEXT:    alsl.d $a0, $a0, $a0, 4
; LA64-NEXT:    slli.d $a0, $a0, 8
; LA64-NEXT:    ret
  %b = mul i64 %a, 4352
  ret i64 %b
}
