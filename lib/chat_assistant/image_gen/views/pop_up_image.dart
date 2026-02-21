import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PopUpImage extends StatelessWidget {
  const PopUpImage({Key? key, required this.content, required this.isUserMessage}) : super(key: key);

  final String content;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    final themeData = Get.theme;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUserMessage
            ? themeData.colorScheme.primary.withOpacity(0.4)
            : themeData.colorScheme.secondary.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Image.asset(isUserMessage ? 'assets/pict/people.png' : 'assets/pict/robot.png',
                  height: 24, width: 24,)
              ],
            ),
            const SizedBox(height: 8),
            Text(content),
            //isUserMessage ? Image.file(File(content), width: Get.width/5,):Image.network(content, width: Get.width/5,),
          ],
        ),
      ),
    );
  }
}
