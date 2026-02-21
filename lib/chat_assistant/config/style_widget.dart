import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color.dart';

Icon iconMessage() {
  return const Icon(
    Icons.messenger_outline,
    color: Colors.white,
    size: 36,
  );
}

BoxDecoration buildBoxDecoration() => BoxDecoration(
  color: Colors.black26,
  borderRadius: BorderRadius.circular(14),
);

IconButton iconButtonBack(colorGround) {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Icon(Icons.arrow_back_ios_new, color: colorGround, size: 20,),
  );
}

BoxDecoration circularDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    color: Colors.black26,
  );
}

BoxDecoration iconDecoration(color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    color: Colors.white30,
    border: Border.all(width: 2, color: color)
  );
}