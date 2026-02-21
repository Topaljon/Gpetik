import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';

import '../../../api/chat_api.dart';
import '../../controller_att/controller_audio_to_text.dart';

class TranscriptionView extends GetView<ControllerAudioToText> {
  final ChatApi audioApiObj;
  final String audioPath;

  TranscriptionView({
    required this.audioApiObj, required this.audioPath, super.key,
  });

  final audioController = Get.put(ControllerAudioToText());

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.05),
      ),
      width: Get.width/2,
      height: 50,
      child: SafeArea(
        child: IconButton(
          onPressed:() async {
            final ChatApi audioApi = ChatApi(
                openAiApiKeyBD: audioApiObj.openAiApiKeyBD,
                openAiOrgBD: audioApiObj.openAiOrgBD);
            final String response;
            response = (await audioApi.audioTranscription(
                audioFile:audioPath
            ))!;
            audioController.audioTranslate.value = response;
          },
          icon: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("transcription", style: TextStyle(color: Colors.white, fontSize: 20),),
              Icon(Icons.audiotrack_outlined, color: Colors.white,),
            ],
          ),
        ),
      ),
    ),
  );
}