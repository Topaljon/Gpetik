import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';
import '../../api/chat_api.dart';
import '../../config/color.dart';
import '../controllers/imageTextController.dart';

class ImageFromTextAndPicture extends GetView<ImageTextController> {
  final ChatApi imageApiObj;
  final String imagePath;

  ImageFromTextAndPicture({
    required this.imageApiObj,
    required this.imagePath,
    super.key,});

  final imageTextController = Get.put(ImageTextController());

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(4),
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
                  hintText: 'Write your message here...',
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
          SizedBox(width: 8,),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              onPressed:() async {
                final ChatApi imageApi = ChatApi(
                    openAiApiKeyBD: imageApiObj.openAiApiKeyBD,
                    openAiOrgBD: imageApiObj.openAiOrgBD);
                final String response;
                response = (await imageApi.imageAndText(
                    imagePath: imagePath,
                    text: imageTextController.imageTextController.text))!;
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