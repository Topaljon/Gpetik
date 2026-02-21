import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';

import '../../api/chat_api.dart';
import '../../config/color.dart';
import '../controller_att/controller_audio_to_text.dart';
import 'components/transcription_view.dart';
import 'components/translate_view.dart';

class AudioFile extends StatefulWidget {
  const AudioFile({super.key, required this.audioApi});

  final ChatApi audioApi;

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  String? path;

  @override
  void initState() {
    super.initState();
  }

  int _selectedValue = 0;
  final List _options = [
    {
      "name_options": "Pull out text",
    },
    {
      "name_options": "Translate audio text",
    },
  ];

  String testText = 'add lightning and sparks';

  final ControllerAudioToText audioController =
      Get.put(ControllerAudioToText());
  final double getWidth = Get.width / 3;
  //double? _progress;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: lightGray,
    appBar: AppBar(
      title: const Text('Image creation',
          style: TextStyle(
            color: Colors.black,
          )),
      leading: iconButtonBack(Colors.greenAccent),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                    width: getWidth,
                    height: getWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                            color: Colors.black12),
                        child: Obx(
                          () => audioController.audioPickerToText.value == ''
                              ? IconButton(
                                  icon: const Icon(Icons.add,
                                      size: 50, color: Colors.white),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.audio,
                                    );
                                    if (result != null) {
                                      File file =
                                          File(result.files.single.path!);
                                      audioController.audioPickerToText.value =
                                          file.path;
                                    }
                                  },
                                )
                              : Image.file(
                                  ///////////////////////////----------------------------------------Image на audio
                                  File(audioController.audioPickerToText.value)
                          ),
                        )),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black12,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.audio,
                              );

                              if (result != null) {
                                File file = File(result.files.single.path!);
                                audioController.audioPickerToText.value =
                                    file.path;
                              }
                            },
                            icon: const Icon(
                              Icons.audiotrack,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 4,
                    //   right: 4,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(24),
                    //       color: Colors.black12,
                    //     ),
                    //     child: IconButton(
                    //         onPressed: () async {
                    //           List<Media>? res = await ImagesPicker.openCamera(
                    //             pickType: PickType.image,
                    //             quality: 0.8,
                    //             maxSize: 800,
                    //             maxTime: 15,
                    //           );
                    //           if (res != null) {
                    //             setState(() {
                    //               path = res[0].thumbPath;
                    //             });
                    //           }
                    //         },
                    //         icon: const Icon(Icons.photo_camera_outlined, color: Colors.white,)),
                    //   ),
                    // ),
                  ]),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: List.generate(
                      _options.length,
                      (index) => Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SizedBox(
                              width: Get.width / 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        _options[index]["name_options"],
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Checkbox(
                                      focusColor: Colors.transparent,
                                      checkColor: red,
                                      shape: const CircleBorder(),
                                      activeColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      overlayColor:
                                          MaterialStateProperty.all(orange),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      value: _selectedValue == index,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            _selectedValue = index;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  path != null
                      ? SizedBox(
                          height: 200,
                          child: Image.file(
                            ///////////////----------------------------------------Image на audio
                            File(path!),
                            fit: BoxFit.contain,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: yellow,
                        ),
                        alignment: Alignment.center,
                        child: audioController.audioPickerToText.isNotEmpty
                            ? Text(audioController.audioTranscription.value)
                            : Container(),
                      ),
                ),
              ),
          if (_selectedValue != 0)
            TranscriptionView(
              audioApiObj: widget.audioApi,
              audioPath: audioController.audioPickerToText.value,
            )
          else TranslateView(
            audioApiObj: widget.audioApi,
            audioPath: audioController.audioPickerToText.value,
          ),
        ],
      ),
    ),
  );
}