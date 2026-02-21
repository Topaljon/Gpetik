import 'package:dart_openai/dart_openai.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';

import '../../api/chat_api.dart';

class ControllerModels extends GetxController{
  RxList listModels = [].obs;
  var idModel = ''.obs;
  final RxString dbGptik = 'dbGptik'.obs;

  void openAiKeyOrg() async {
    final List keyCompanyList = readeKeyAndCompany();
    OpenAI.apiKey = keyCompanyList[0].keyGptName.toString();
    OpenAI.organization = keyCompanyList[0].anyCompany.toString();
  }

  Future<List> providedModels() async {
    try {
      print(33);
      final List models;
      models = await OpenAI.instance.model.list();
      print(44);
      print(models.first.id);
      return models;

    }on RequestFailedException catch(e){
      defaultDialog(e);
    }
    return listModels;

  }


  Future <OpenAIModelModel> identifModel(String modelIdent) async {
    openAiKeyOrg();

    OpenAIModelModel model = await OpenAI.instance.model.retrieve(modelIdent);
    return model;
  }

  List readeKeyAndCompany(){
    final keyGptBox = Hive.box(dbGptik.value);
    return keyGptBox.values.toList();
  }
}