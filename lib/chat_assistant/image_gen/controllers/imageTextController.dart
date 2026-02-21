import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageTextController extends GetxController {

  final TextEditingController _imageTextController = TextEditingController();
  TextEditingController get imageTextController => _imageTextController;

  final RxString imagePicker =''.obs;
  final RxString imagePickerGen=''.obs;
}