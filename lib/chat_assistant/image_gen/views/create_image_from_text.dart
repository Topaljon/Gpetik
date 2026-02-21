import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/chat_api.dart';
import '../../config/color.dart';
import '../../config/style_widget.dart';
import '../controllers/imageTextController.dart';

class CreateImageFromText extends GetView<ImageTextController> {
  final ChatApi imageApiObg;

  CreateImageFromText({
    required this.imageApiObg,
    super.key,
  });

  final imageTextController = Get.put(ImageTextController());

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: SafeArea(
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: imageTextController.imageTextController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Get.theme.colorScheme.outline.withOpacity(0.7)),
                  filled: true,
                  fillColor: Colors.white60,
                  hintText: 'createImage.writemessage'.tr,
                  prefixIcon: Icon(Icons.text_snippet_outlined, color: Get.theme.colorScheme.outline,),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32))
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: ground),
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                ),
              )
          ),
          const SizedBox(width: 8,),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              onPressed:
                  () async {
                final ChatApi imageApi = ChatApi(
                    openAiApiKeyBD: imageApiObg.openAiApiKeyBD,
                    openAiOrgBD: imageApiObg.openAiOrgBD);
                final String pictureFromText;
                final String response;

                pictureFromText = imageTextController.imageTextController.text;
                response = (await imageApi.singleImage(pictureFromText))!;

                imageTextController.imagePickerGen.value = response;
              },
              icon: const Icon(Icons.mail_outline, color: orange),
            ),
          ),
        ],
      ),
    ),
  );
}