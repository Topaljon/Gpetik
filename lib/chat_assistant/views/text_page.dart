import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';
import 'package:helper_open_ai/chat_assistant/views/pop_up_message.dart';
import '../api/chat_api.dart';
import '../config/color.dart';
import '../controllers/entry_controller.dart';
import '../model/chat_model.dart';
import 'creating_messages.dart';

class TextPage extends StatefulWidget {
  const TextPage({
    required this.chatApi,
    super.key,
  });
  final ChatApi chatApi;

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {

  final _messages = <ChatModel>[
    ChatModel('completions.help'.tr, false),
  ];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'textentry.writemessage'.tr, style: TextStyle(color: Get.theme.colorScheme.onPrimary),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: iconButtonBack(Get.theme.colorScheme.onPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: [
                orange,
                Get.theme.colorScheme.onSecondary,
                Get.theme.colorScheme.primary,
              ]
            )),

        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ..._messages.map(
                        (msg) => PopUpMessage(
                          content: msg.content,
                          isUserMessage: msg.isUserMessage,
                        ),
                  ),
                ],),),
            CreatingMessages(
              onSubmitted: _onSubmitted,
              awaitingResponse: _awaitingResponse,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(String message) async {
    final entryController = Get.put(EntryController());

    setState(() {
      _messages.add(ChatModel(message, true));
      _awaitingResponse = true;
    });
    try {
      final response = await widget.chatApi.completeChat(_messages, entryController.modelAi.value ///<---------model openAi---------------------------------
      );
      setState(() {
        _messages.add(ChatModel(response, false));
        _awaitingResponse = false;
      });
    } catch (err) {
      Get.snackbar('', 'completions.error'.tr);
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
