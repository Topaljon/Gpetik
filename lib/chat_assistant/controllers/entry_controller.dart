import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryController extends GetxController {
  RxString text = 'Это предложение'.obs;
  RxString modelAi = 'gpt-3.5-turbo'.obs;
  RxList<String> modelAilist = ['gpt-3.5-turbo', 'text-davinci-003', 'dall-e-2'].obs;

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

  void cleanMessageController(){
    _messageController.value.clear();
  }

}