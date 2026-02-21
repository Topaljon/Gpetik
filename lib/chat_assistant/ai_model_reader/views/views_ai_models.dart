
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/style_widget.dart';
import '../models/controller_models.dart';

class ViewsAIModels extends GetView<ControllerModels> {
  ViewsAIModels({super.key});

  final modelsController = Get.put(ControllerModels());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Models', style: TextStyle(color: Colors.black,)),
        leading: iconButtonBack(Colors.greenAccent),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),

      ////////////////////////////////////////////////////////////
      body: Column(
            children: [
              Obx(()=> Row(
                  children: [
                      Text(modelsController.listModels.first.id.toString(),
                        style: TextStyle(color: Colors.red[100]),
                      ),
                  ],
                ),
              )
            ],
          )
    );
  }
}
