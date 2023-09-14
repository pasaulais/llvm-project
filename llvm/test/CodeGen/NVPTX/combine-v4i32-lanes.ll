; RUN: llc < %s -march=nvptx64 -mcpu=sm_20 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -march=nvptx64 -mcpu=sm_20 | %ptxas-verify %}
target triple = "nvptx64-nvidia-cuda"

define void @preserve_v16i8_v4i32(ptr noundef align 16 %ptr1, ptr noundef align 16 %ptr2, i32 %idx) {
  ; CHECK-LABEL: preserve_v16i8_v4i32
  
  ; CHECK: ld.v4.u32
  
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8

  ; CHECK: st.u32

  %vec = load <16 x i8>, ptr %ptr1, align 16
  %val0 = extractelement <16 x i8> %vec, i32 0
  %val1 = extractelement <16 x i8> %vec, i32 1
  %val2 = extractelement <16 x i8> %vec, i32 2
  %val3 = extractelement <16 x i8> %vec, i32 3
  %val4 = extractelement <16 x i8> %vec, i32 4
  %val5 = extractelement <16 x i8> %vec, i32 5
  %val6 = extractelement <16 x i8> %vec, i32 6
  %val7 = extractelement <16 x i8> %vec, i32 7
  %val8 = extractelement <16 x i8> %vec, i32 8
  %val9 = extractelement <16 x i8> %vec, i32 9
  %val10 = extractelement <16 x i8> %vec, i32 10
  %val11 = extractelement <16 x i8> %vec, i32 11
  %val12 = extractelement <16 x i8> %vec, i32 12
  %val13 = extractelement <16 x i8> %vec, i32 13
  %val14 = extractelement <16 x i8> %vec, i32 14
  %val15 = extractelement <16 x i8> %vec, i32 15
  %lane0 = zext i8 %val0 to i32
  %lane1 = zext i8 %val1 to i32
  %lane2 = zext i8 %val2 to i32
  %lane3 = zext i8 %val3 to i32
  %lane4 = zext i8 %val4 to i32
  %lane5 = zext i8 %val5 to i32
  %lane6 = zext i8 %val6 to i32
  %lane7 = zext i8 %val7 to i32
  %lane8 = zext i8 %val8 to i32
  %lane9 = zext i8 %val9 to i32
  %lane10 = zext i8 %val10 to i32
  %lane11 = zext i8 %val11 to i32
  %lane12 = zext i8 %val12 to i32
  %lane13 = zext i8 %val13 to i32
  %lane14 = zext i8 %val14 to i32
  %lane15 = zext i8 %val15 to i32
  %red.1 = add i32 %lane0, %lane1
  %red.2 = add i32 %red.1, %lane2
  %red.3 = add i32 %red.2, %lane3
  %red.4 = add i32 %red.3, %lane4
  %red.5 = add i32 %red.4, %lane5
  %red.6 = add i32 %red.5, %lane6
  %red.7 = add i32 %red.6, %lane7
  %red.8 = add i32 %red.7, %lane8
  %red.9 = add i32 %red.8, %lane9
  %red.10 = add i32 %red.9, %lane10
  %red.11 = add i32 %red.10, %lane11
  %red.12 = add i32 %red.11, %lane12
  %red.13 = add i32 %red.12, %lane13
  %red.14 = add i32 %red.13, %lane14
  %red = add i32 %red.14, %lane15
  store i32 %red, ptr %ptr2, align 4
  ret void
}

define void @preserve_v8i16_v4i32(ptr noundef align 16 %ptr1, ptr noundef align 16 %ptr2, i32 %idx) {
  ; CHECK-LABEL: preserve_v8i16_v4i32
  
  ; CHECK: ld.v4.u32
  
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535

  ; CHECK: st.u32
  %vec = load <8 x i16>, ptr %ptr1, align 16
  %val0 = extractelement <8 x i16> %vec, i32 0
  %val1 = extractelement <8 x i16> %vec, i32 1
  %val2 = extractelement <8 x i16> %vec, i32 2
  %val3 = extractelement <8 x i16> %vec, i32 3
  %val4 = extractelement <8 x i16> %vec, i32 4
  %val5 = extractelement <8 x i16> %vec, i32 5
  %val6 = extractelement <8 x i16> %vec, i32 6
  %val7 = extractelement <8 x i16> %vec, i32 7
  %lane0 = zext i16 %val0 to i32
  %lane1 = zext i16 %val1 to i32
  %lane2 = zext i16 %val2 to i32
  %lane3 = zext i16 %val3 to i32
  %lane4 = zext i16 %val4 to i32
  %lane5 = zext i16 %val5 to i32
  %lane6 = zext i16 %val6 to i32
  %lane7 = zext i16 %val7 to i32
  %red.1 = add i32 %lane0, %lane1
  %red.2 = add i32 %red.1, %lane2
  %red.3 = add i32 %red.2, %lane3
  %red.4 = add i32 %red.3, %lane4
  %red.5 = add i32 %red.4, %lane5
  %red.6 = add i32 %red.5, %lane6
  %red = add i32 %red.6, %lane7
  store i32 %red, ptr %ptr2, align 4
  ret void
}

define void @combine_v16i8_v4i32(ptr noundef align 16 %ptr1, ptr noundef align 16 %ptr2, i32 %idx) {
  ; CHECK-LABEL: combine_v16i8_v4i32
  
  ; CHECK: ld.v4.u32
  
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 24
  
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 255
  
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 8, 8
  
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8
  ; CHECK-DAG: bfe.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16, 8

  ; CHECK: st.u32

  %val0 = load i8, ptr %ptr1, align 16
  %ptr1.1 = getelementptr inbounds i8, ptr %ptr1, i64 1
  %val1 = load i8, ptr %ptr1.1, align 1
  %ptr1.2 = getelementptr inbounds i8, ptr %ptr1, i64 2
  %val2 = load i8, ptr %ptr1.2, align 2
  %ptr1.3 = getelementptr inbounds i8, ptr %ptr1, i64 3
  %val3 = load i8, ptr %ptr1.3, align 1
  %ptr1.4 = getelementptr inbounds i8, ptr %ptr1, i64 4
  %val4 = load i8, ptr %ptr1.4, align 4
  %ptr1.5 = getelementptr inbounds i8, ptr %ptr1, i64 5
  %val5 = load i8, ptr %ptr1.5, align 1
  %ptr1.6 = getelementptr inbounds i8, ptr %ptr1, i64 6
  %val6 = load i8, ptr %ptr1.6, align 2
  %ptr1.7 = getelementptr inbounds i8, ptr %ptr1, i64 7
  %val7 = load i8, ptr %ptr1.7, align 1
  %ptr1.8 = getelementptr inbounds i8, ptr %ptr1, i64 8
  %val8 = load i8, ptr %ptr1.8, align 8
  %ptr1.9 = getelementptr inbounds i8, ptr %ptr1, i64 9
  %val9 = load i8, ptr %ptr1.9, align 1
  %ptr1.10 = getelementptr inbounds i8, ptr %ptr1, i64 10
  %val10 = load i8, ptr %ptr1.10, align 2
  %ptr1.11 = getelementptr inbounds i8, ptr %ptr1, i64 11
  %val11 = load i8, ptr %ptr1.11, align 1
  %ptr1.12 = getelementptr inbounds i8, ptr %ptr1, i64 12
  %val12 = load i8, ptr %ptr1.12, align 4
  %ptr1.13 = getelementptr inbounds i8, ptr %ptr1, i64 13
  %val13 = load i8, ptr %ptr1.13, align 1
  %ptr1.14 = getelementptr inbounds i8, ptr %ptr1, i64 14
  %val14 = load i8, ptr %ptr1.14, align 2
  %ptr1.15 = getelementptr inbounds i8, ptr %ptr1, i64 15
  %val15 = load i8, ptr %ptr1.15, align 1
  %lane0 = zext i8 %val0 to i32
  %lane1 = zext i8 %val1 to i32
  %lane2 = zext i8 %val2 to i32
  %lane3 = zext i8 %val3 to i32
  %lane4 = zext i8 %val4 to i32
  %lane5 = zext i8 %val5 to i32
  %lane6 = zext i8 %val6 to i32
  %lane7 = zext i8 %val7 to i32
  %lane8 = zext i8 %val8 to i32
  %lane9 = zext i8 %val9 to i32
  %lane10 = zext i8 %val10 to i32
  %lane11 = zext i8 %val11 to i32
  %lane12 = zext i8 %val12 to i32
  %lane13 = zext i8 %val13 to i32
  %lane14 = zext i8 %val14 to i32
  %lane15 = zext i8 %val15 to i32
  %red.1 = add i32 %lane0, %lane1
  %red.2 = add i32 %red.1, %lane2
  %red.3 = add i32 %red.2, %lane3
  %red.4 = add i32 %red.3, %lane4
  %red.5 = add i32 %red.4, %lane5
  %red.6 = add i32 %red.5, %lane6
  %red.7 = add i32 %red.6, %lane7
  %red.8 = add i32 %red.7, %lane8
  %red.9 = add i32 %red.8, %lane9
  %red.10 = add i32 %red.9, %lane10
  %red.11 = add i32 %red.10, %lane11
  %red.12 = add i32 %red.11, %lane12
  %red.13 = add i32 %red.12, %lane13
  %red.14 = add i32 %red.13, %lane14
  %red = add i32 %red.14, %lane15
  store i32 %red, ptr %ptr2, align 4
  ret void
}

define void @combine_v8i16_v4i32(ptr noundef align 16 %ptr1, ptr noundef align 16 %ptr2, i32 %idx) {
  ; CHECK-LABEL: combine_v8i16_v4i32
  
  ; CHECK: ld.v4.u32
  
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  ; CHECK-DAG: shr.u32 %r{{[0-9]+}}, %r{{[0-9]+}}, 16
  
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535
  ; CHECK-DAG: and.b32 %r{{[0-9]+}}, %r{{[0-9]+}}, 65535

  ; CHECK: st.u32
  %val0 = load i16, ptr %ptr1, align 16
  %ptr1.1 = getelementptr inbounds i16, ptr %ptr1, i64 1
  %val1 = load i16, ptr %ptr1.1, align 2
  %ptr1.2 = getelementptr inbounds i16, ptr %ptr1, i64 2
  %val2 = load i16, ptr %ptr1.2, align 4
  %ptr1.3 = getelementptr inbounds i16, ptr %ptr1, i64 3
  %val3 = load i16, ptr %ptr1.3, align 2
  %ptr1.4 = getelementptr inbounds i16, ptr %ptr1, i64 4
  %val4 = load i16, ptr %ptr1.4, align 4
  %ptr1.5 = getelementptr inbounds i16, ptr %ptr1, i64 5
  %val5 = load i16, ptr %ptr1.5, align 2
  %ptr1.6 = getelementptr inbounds i16, ptr %ptr1, i64 6
  %val6 = load i16, ptr %ptr1.6, align 4
  %ptr1.7 = getelementptr inbounds i16, ptr %ptr1, i64 7
  %val7 = load i16, ptr %ptr1.7, align 2
  %lane0 = zext i16 %val0 to i32
  %lane1 = zext i16 %val1 to i32
  %lane2 = zext i16 %val2 to i32
  %lane3 = zext i16 %val3 to i32
  %lane4 = zext i16 %val4 to i32
  %lane5 = zext i16 %val5 to i32
  %lane6 = zext i16 %val6 to i32
  %lane7 = zext i16 %val7 to i32
  %red.1 = add i32 %lane0, %lane1
  %red.2 = add i32 %red.1, %lane2
  %red.3 = add i32 %red.2, %lane3
  %red.4 = add i32 %red.3, %lane4
  %red.5 = add i32 %red.4, %lane5
  %red.6 = add i32 %red.5, %lane6
  %red = add i32 %red.6, %lane7
  store i32 %red, ptr %ptr2, align 4
  ret void
}
