import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletionsController extends GetxController {
  RxString text = 'Это предложение'.obs;
  RxString modelAi = 'text-davinci-003'.obs;

  void setText(RxString text) {
    this.text = text;
    update();
  }

  final Rx<TextEditingController> _messageController = TextEditingController().obs;
  Rx<TextEditingController> get messageController => _messageController;

  bool _awaitingResponse = false;
  set awaitingResponse(bool value) {
    _awaitingResponse = value;
  }
  bool get awaitingResponse => _awaitingResponse;

  clearCompletionsController(){
    messageController.value.clear();
  }
}