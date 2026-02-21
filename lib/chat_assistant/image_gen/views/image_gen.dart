import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/color.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';
import 'package:helper_open_ai/chat_assistant/image_gen/controllers/imageTextController.dart';
import '../../api/chat_api.dart';
import 'create_image_from_text.dart';
import 'image_from_text_and_picture.dart';
//import "package:images_picker/images_picker.dart";

class ImageGen extends StatefulWidget {
  const ImageGen({super.key, required this.imageApi});
  final ChatApi imageApi;

  @override
  _ImageGenState createState() => _ImageGenState();
}

class _ImageGenState extends State<ImageGen> {
  String? path;

  @override
  void initState() {
    super.initState();
  }

  int _selectedValue = 0;
  final List _options = [
    {
      "name_options": 'imagegen.create'.tr,
    },
    {
      "name_options": 'imagegen.edit'.tr,
    },
    {
      "name_options": 'imagegen.variation'.tr,
    }
  ];

  final ImageTextController imageController = Get.put(ImageTextController());
  final double getWidth = Get.width / 2.5;
  double? _progress;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ground,
        appBar: AppBar(
          title: Text('imagegen.creation'.tr, style: TextStyle(color: Get.theme.colorScheme.onPrimary)),
          leading: iconButtonBack(Get.theme.colorScheme.onPrimary),
          backgroundColor: Get.theme.colorScheme.primary,
          shadowColor: Colors.transparent,
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 4.0, right: 4, top: 4),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                colors: [
                  orange,
                  Get.theme.colorScheme.background,
                  Get.theme.colorScheme.primary,

                ],
              )),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    //color: grey,
                      borderRadius: BorderRadius.circular(32),

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                            width: getWidth,
                            height: getWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: orange.withOpacity(0.2),
                            ),
                            child: Obx(
                              () => imageController.imagePicker.value == ''
                                  ? IconButton(
                                      icon: Icon(Icons.add,
                                          size: 50, color: orange),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['png'],
                                        );
                                        if (result != null) {
                                          File file =
                                              File(result.files.single.path!);
                                          imageController.imagePicker.value =
                                              file.path;
                                        }
                                      },
                                    )
                                  : Image.file(
                                      File(imageController.imagePicker.value)),
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
                                    type: FileType.custom,
                                    allowedExtensions: ['png'],
                                  );

                                  if (result != null) {
                                    File file = File(result.files.single.path!);
                                    imageController.imagePicker.value = file.path;
                                  }
                                },
                                icon: const Icon(Icons.image_outlined, color: orange,)),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.black12,
                            ),
                            child: IconButton(
                                onPressed: () async {
                                  //не поддерживается нужно поменять на другой Image_picker???
                                  // List<Media>? res = await ImagesPicker.openCamera(
                                  //   pickType: PickType.image,
                                  //   quality: 0.8,
                                  //   maxSize: 800,
                                  //   maxTime: 15,
                                  // );
                                  // if (res != null) {
                                  //   setState(() {
                                  //     path = res[0].thumbPath;
                                  //   });
                                  // }
                                },
                                icon: const Icon(Icons.photo_camera_outlined, color: orange,)),
                          ),
                        ),
                      ]),
                      const SizedBox(width: 8,),
                      Column(
                        children: List.generate(
                          _options.length,
                          (index) => Column(
                            children: [
                              SizedBox(
                                width: Get.width/2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: SizedBox(
                                        width: Get.width/3,
                                        child: Text(
                                          _options[index]["name_options"],
                                          maxLines: 2,
                                          style: TextStyle(color: Get.theme.colorScheme.onSurfaceVariant),
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
                                        activeColor: orange,
                                        hoverColor: orange,
                                        overlayColor: MaterialStateProperty.all(orange),
                                        side: const BorderSide(color: orange, width: 2,),
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
                              const SizedBox(height: 8,),
                            ],
                          ),
                        ),
                      ),
                      path != null
                          ? SizedBox(
                              height: 200,
                              child: Image.file(
                                File(path!),
                                fit: BoxFit.contain,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Expanded(
                    child: Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(width: 2, color: orange),
                        //color: yellow,
                      ),
                      alignment: Alignment.center,
                      child: imageController.imagePickerGen.value.isNotEmpty
                        ? GestureDetector(
                            child: Image.network(
                                imageController.imagePickerGen.value,
                              fit: BoxFit.fill,

                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },

                              errorBuilder: (context, exception, stackTrace) {
                                return Image.asset(
                                  "assets/pict/ErrorImg.png",
                                  fit: BoxFit.cover,
                                  height: Get.height/5,
                                );
                              },


                            ),
                            onLongPress: () async {

                              //save file
                              if(GetPlatform.isAndroid) {
                                Get.dialog(
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 40),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Icon(Icons.save_alt_outlined, color: Colors.red[200],size: 36,),
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    'imagegen.savefile'.tr,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 18),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  //Buttons
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: lightGray,
                                                            minimumSize: const Size(0, 45),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(16),
                                                            ),

                                                          ),
                                                          onPressed: () {
                                                            Get.back();
                                                            },
                                                          child: Text(
                                                            'drawer.dialog_no'.tr, style: TextStyle(color: red, fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: lightGray,
                                                            minimumSize: const Size(0, 45),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(16),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            await FileDownloader.downloadFile(url: imageController.imagePickerGen.value.trim(),
                                                                onProgress: (name, progress){
                                                                  _progress=progress;
                                                                },
                                                                onDownloadCompleted: (value){
                                                                  SnackBar(content: Text("File $value saved"),);
                                                                  _progress = null;
                                                                }
                                                            );
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                              'drawer.dialog_yes'.tr, style: TextStyle(color: red, fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                await saveFileWindow(imageController.imagePickerGen.value);
                              }
                            },
                          )
                        : Container(),
                    ),)
                ),
                if (_selectedValue != 0)
                  if (_selectedValue == 1)
                    ImageFromTextAndPicture(imageApiObj: widget.imageApi, imagePath: imageController.imagePicker.value,)
                  else Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(

                            decoration: BoxDecoration(
                              color: Colors.white60,//<--------------------------------------------------------
                              borderRadius: BorderRadius.circular(24),
                              border:Border.all(width: 1, color: Get.theme.colorScheme.outline),),



                          width: Get.width/1.5,
                            height: 60,
                            child: Text(imageController.imagePicker.value==""?"Путь файла:":imageController.imagePicker.value,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis, style: TextStyle(
                                  color: Colors.brown),)),
                        Expanded(child: SizedBox(),),




                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                final String response;
                                response = (await widget.imageApi.variationImage(
                                    imagePath: imageController.imagePicker.value)
                                )!;
                                imageController.imagePickerGen.value = response;
                              },
                            icon: const Icon(Icons.mail_outline, color: orange),
                            ),
                        ),
                      ],
                    ),
                  )
                else CreateImageFromText(imageApiObg: widget.imageApi,),
              ],
            ),

        ),
      );

  saveFileWindow(String value) async {
    final dio = Dio();
    String? savePath = await FilePicker.platform.getDirectoryPath();
    await dio.download(value, savePath);
  }
}