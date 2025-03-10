; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv -spirv-text %t.bc -o - | FileCheck %s --check-prefix=CHECK-SPIRV
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: spirv-val %t.spv
; RUN: llvm-spirv -r %t.spv -o - | llvm-dis -o - | FileCheck %s --check-prefix=CHECK-LLVM

; CHECK-SPIRV: Name [[#FUNC0:]] "main_l3"
; CHECK-SPIRV: Name [[#FUNC1:]] "main_l6"
; CHECK-SPIRV: Name [[#FUNC2:]] "main_l9"
; CHECK-SPIRV: Name [[#FUNC3:]] "main_l13"
; CHECK-SPIRV: Name [[#FUNC4:]] "main_l19"

; CHECK-SPIRV: Decorate [[#FUNC0]] UserSemantic "num-thread-per-eu 4"
; CHECK-SPIRV: Decorate [[#FUNC1]] UserSemantic "num-thread-per-eu 8"
; CHECK-SPIRV:  Decorate [[#FUNC2]] UserSemantic "num-thread-per-eu 0"
; CHECK-SPIRV-NOT: Decorate [[#FUNC3]] UserSemantic
; CHECK-SPIRV-NOT: Decorate [[#FUNC4]] UserSemantic

; CHECK-LLVM: @[[FLAG0:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 4\00", section "llvm.metadata"
; CHECK-LLVM: @[[FLAG1:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 8\00", section "llvm.metadata"
; CHECK-LLVM: @[[FLAG2:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 0\00", section "llvm.metadata"
; CHECK-LLVM: @[[FLAG3:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 4\00", section "llvm.metadata"
; CHECK-LLVM: @[[FLAG4:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 8\00", section "llvm.metadata"
; CHECK-LLVM: @[[FLAG5:[0-9]+]] = private unnamed_addr constant [20 x i8] c"num-thread-per-eu 0\00", section "llvm.metadata"

; CHECK-LLVM: @llvm.global.annotations = appending global [6 x { ptr, ptr, ptr, i32, ptr }] [{ ptr, ptr, ptr, i32, ptr } { ptr @main_l3, ptr @[[FLAG0]], ptr poison, i32 poison, ptr poison }, { ptr, ptr, ptr, i32, ptr } { ptr @main_l6, ptr @[[FLAG1]], ptr poison, i32 poison, ptr poison }, { ptr, ptr, ptr, i32, ptr } { ptr @main_l9, ptr @[[FLAG2]], ptr poison, i32 poison, ptr poison }, { ptr, ptr, ptr, i32, ptr } { ptr @main_l3, ptr @[[FLAG3]], ptr poison, i32 poison, ptr poison }, { ptr, ptr, ptr, i32, ptr } { ptr @main_l6, ptr @[[FLAG4]], ptr poison, i32 poison, ptr poison }, { ptr, ptr, ptr, i32, ptr } { ptr @main_l9, ptr @[[FLAG5]], ptr poison, i32 poison, ptr poison }], section "llvm.metadata"

target datalayout = "e-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-n8:16:32:64"
target triple = "spir64"

; Function Attrs: noinline nounwind optnone
define weak dso_local spir_kernel void @main_l3() #0 !RegisterAllocMode !10 {
newFuncRoot:
  ret void
}

; Function Attrs: noinline nounwind optnone
define weak dso_local spir_kernel void @main_l6() #0 !RegisterAllocMode !11 {
newFuncRoot:
  ret void
}

; Function Attrs: noinline nounwind optnone
define weak dso_local spir_kernel void @main_l9() #0 !RegisterAllocMode !12 {
newFuncRoot:
  ret void
}

; Function Attrs: noinline nounwind optnone
define weak dso_local spir_kernel void @main_l13() #0 !RegisterAllocMode !13 {
newFuncRoot:
  ret void
}

; Function Attrs: noinline nounwind optnone
define weak dso_local spir_kernel void @main_l19() #0 {
newFuncRoot:
  ret void
}

attributes #0 = { noinline nounwind optnone }


!opencl.compiler.options = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!spirv.Source = !{!2, !3, !3, !3, !3, !3, !2, !3, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2, !2}
!llvm.module.flags = !{!4, !5, !6, !7, !8}
!spirv.MemoryModel = !{!9, !9, !9, !9, !9, !9}
!spirv.ExecutionMode = !{}

!0 = !{}
!2 = !{i32 4, i32 200000}
!3 = !{i32 3, i32 200000}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"openmp", i32 50}
!6 = !{i32 7, !"openmp-device", i32 50}
!7 = !{i32 8, !"PIC Level", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{i32 2, i32 2}
!10 = !{i32 2}
!11 = !{i32 1}
!12 = !{i32 0}
!13 = !{i32 3}
