import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';

class PopUpMessage extends StatelessWidget {
  const PopUpMessage({
    required this.content,
    required this.isUserMessage,
    super.key,
  });

  final String content;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUserMessage
            ? Get.theme.colorScheme.primary.withOpacity(0.4)
            : Get.theme.colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.only(
          topLeft: isUserMessage
              ? const Radius.circular(12)
              : const Radius.circular(36),
          topRight: isUserMessage
              ? const Radius.circular(36)
              : const Radius.circular(12),
          bottomLeft: const Radius.circular(12),
          bottomRight:const Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment:
              isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isUserMessage
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black12,
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Image(
                    image: AssetImage(
                      isUserMessage
                          ? 'assets/pict/people.png'
                          : 'assets/pict/robot.png',
                    ),
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            //Text(content),
            MarkdownWidget(
              padding: const EdgeInsets.only(top: 8),
                data: content,
                selectable: true,
                shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
