import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/color.dart';
import '../controllers/entry_controller.dart';

class CreatingMessages extends GetView<EntryController> {
  CreatingMessages({
    required this.onSubmitted,
    required this.awaitingResponse,
    super.key,
  });

  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  final entryController = Get.put(EntryController());
  String controllerText = '';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      //color: Colors.transparent,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: !awaitingResponse
                    ? TextField(
                        controller: entryController.messageController.value,
                        onSubmitted: onSubmitted,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.text_snippet_outlined, color: Get.theme.colorScheme.outline,),
                          hintText: 'createImage.writemessage'.tr,
                          hintStyle: TextStyle(color: Get.theme.colorScheme.outline.withOpacity(0.7)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Get.theme.colorScheme.outline),
                            borderRadius: const BorderRadius.all(Radius.circular(32))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Get.theme.colorScheme.outline),
                            borderRadius: const BorderRadius.all(Radius.circular(32)),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text('creationmessges.fetching'.tr),
                          ),
                        ],
                ),
            ),

            const SizedBox(width: 16,),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onPrimary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: !awaitingResponse
                    ? () {
                  //create a class for writing text to a file in python

                  controllerText = entryController.messageController.value.text;
                      onSubmitted(controllerText);
                      entryController.cleanMessageController();
                    }
                    : null,
                icon: Icon(Icons.mail_outline, color: orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
