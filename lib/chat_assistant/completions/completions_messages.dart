

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/color.dart';
import 'controllers/completions_controller.dart';

class CompletionsMessages extends GetView<CompletionsController> {
  CompletionsMessages({
    required this.onSubmitted,
    required this.awaitingResponse,
    super.key,
  });

  final void Function(String) onSubmitted;
  final bool awaitingResponse;

  final entryController = Get.put(CompletionsController());
  String entryControllerText='';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.05),
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
                  : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Fetching response...'),
                  ),
                ],
              ),
            ),const SizedBox(width: 16,),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onPrimary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: !awaitingResponse
                    ? () {
                  entryControllerText = entryController.messageController.value.text;
                      onSubmitted(entryControllerText);
                      entryController.clearCompletionsController();
                    }
                    : null,
                icon: const Icon(Icons.mail_outline, color: orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}