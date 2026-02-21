import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/model/chat_model.dart';

class ChatApi {
  String openAiApiKeyBD;
  String openAiOrgBD;

  ChatApi({required this.openAiApiKeyBD, required this.openAiOrgBD})
  {
    OpenAI.apiKey = openAiApiKeyBD;
    OpenAI.organization = openAiOrgBD;

    // OpenAI.apiKey = openAiApiKey;
    // OpenAI.organization = openAiOrg;
  }

  //создание текста

  Future<String> completeChat(List<ChatModel> messages, model) async {

      final chatCompletion = await OpenAI.instance.chat.create(
        model: model,
        messages: messages
            .map((e) => OpenAIChatCompletionChoiceMessageModel(
          content: e.content,
          role: e.isUserMessage
              ? OpenAIChatMessageRole.user
              : OpenAIChatMessageRole.assistant,
        )).toList(),
      );
      return chatCompletion.choices.first.message.content.toString();
  }

  //Completions

  Future<String> completionsMassage(prompt, model) async {
    OpenAICompletionModel completion = await OpenAI.instance.completion.create(
      model: model, //"text-davinci-003",
      prompt: prompt,
      maxTokens: 20,
      temperature: 0.5,
      n: 1,
      stop: "\n",
      echo: true,
    );
    return completion.model;
  }


  //Генерирует новое изображение на основе заданной подсказки.
  Future<String?> singleImage(String text) async {
    try{
      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: text,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      return image.data.first.url;
    } on RequestFailedException catch(e){
      defaultDialog(e);
    }
    return null;
  }

  //tell me about snow white and the three dwarfs

  //Создает отредактированное или расширенное изображение с учетом исходного изображения и подсказки.
  Future<String?> imageAndText({imagePath, text}) async {
    try {
      OpenAIImageModel imageEdit = await OpenAI.instance.image.edit(
        image: File(imagePath),
        prompt: text,
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      return imageEdit.data.first.url;
    } on RequestFailedException catch(e){
      defaultDialog(e);
    }
    return null;
  }

  //создать вариацию изображения
  Future<String?> variationImage({imagePath}) async {
    try {
      OpenAIImageModel imageVariation =
      await OpenAI.instance.image.variation(
        image: File(imagePath),
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      return imageVariation.data.first.url;
    } on RequestFailedException catch(e) {
      defaultDialog(e);
    }
    return null;
  }

  //перевод аудио в текст (транскрипция)

  Future<String?> audioTranscription({audioFile}) async{
    try {
      Future<OpenAIAudioModel> transcription = OpenAI.instance.audio.createTranscription(
        file: File(audioFile),
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.json,
      );

      return transcription.toString();

    } on RequestFailedException catch(e){
      defaultDialog(e);
    }
    return null;
  }

  //перевод аудио файл в текст на английском
  Future<String?> audioTranslate({audioFile}) async{
    try {
      OpenAIAudioModel translation = await OpenAI.instance.audio.createTranslation(
        file: File(audioFile),
        model: "whisper-1",
        responseFormat: OpenAIAudioResponseFormat.text,
      );
      return translation.text;

    } on RequestFailedException catch(e){
      defaultDialog(e);
    }
    return null;
  }
}

defaultDialog(e) {return Get.defaultDialog(
  title: "Need your attention",
  content: Column(
    children: [
      Text(e.message),
      Text(e.statusCode.toString()),
    ],
  ),
);
}