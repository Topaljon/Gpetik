import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/key_and_company.dart';


class ControllerDrawer extends GetxController{

  final Rx<TextEditingController> _keyGptController = TextEditingController().obs;
  Rx<TextEditingController> get keyGptController => _keyGptController;

  final Rx<TextEditingController> _companyController = TextEditingController().obs;
  Rx<TextEditingController> get companyController => _companyController;

  final RxString keyGptText = 'inputView.needkey'.tr.obs;
  final RxString companyText = 'drawer.inter_name'.tr.obs;
  final RxString dbGptik = 'dbGptik'.obs;

  void addKeyGpt(KeyAndCompany gptKeyCompanyName) {
    final keyGptBox = Hive.box(dbGptik.value);
    keyGptBox.add(gptKeyCompanyName);
    cleanForm();
  }

  List readeKeyAndCompany(){
    final keyGptBox = Hive.box(dbGptik.value);
    return keyGptBox.values.toList();
  }

  void deleteKeyGpt(int index) {
    final keyGptBox = Hive.box(dbGptik.value);
    keyGptBox.deleteAt(index);
  }

  void cleanForm() {
    _keyGptController.value.clear();
    _companyController.value.clear();
  }

}