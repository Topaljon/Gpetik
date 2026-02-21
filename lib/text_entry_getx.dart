import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helper_open_ai/chat_assistant/config/color.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';
import 'package:helper_open_ai/chat_assistant/drawer/view/drawer_view.dart';
import 'package:helper_open_ai/chat_assistant/routes.dart';
import 'chat_assistant/ai_model_reader/models/controller_models.dart';
import 'chat_assistant/api/chat_api.dart';
import 'chat_assistant/audio_to_text/views/audio_file.dart';
import 'chat_assistant/controllers/entry_controller.dart';
import 'chat_assistant/data_theme/theme_controller.dart';
import 'chat_assistant/image_gen/views/image_gen.dart';

class TextEntryGet extends GetView {
  const TextEntryGet({required this.imageApi, super.key});
  final ChatApi imageApi;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final themeControllerMain = Get.put(ThemeController());

    return GetBuilder<EntryController>(
      builder: (controller) => Scaffold(
        drawer: const DrawerView(),
        appBar: AppBar(
          leadingWidth: 35,
          leading: Builder(
              builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                    },
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 5,
                        child: Obx(()=> buildIconMenu(themeControllerMain.isDarkMode.value? orange: darkGround)),
                      ),],)),),
          // flexibleSpace: Obx(
          //     ()=> DecoratedBox(
          //     decoration: BoxDecoration(
          //       color: themeControllerMain.isDarkMode.value
          //           ?ground
          //           :grey
          //     ),
          //   ),
          // ),
        ),
        body: Obx(
          () => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: themeControllerMain.isDarkMode.value
                      ? [orange, ground, darkGround]
                      :[orange, lightGray,grey ],
                )),
            child: Stack(
              children: [
                Positioned(
                    left: -111,
                    top: 100,
                    child: Image.asset(
                      'assets/pict/chappie2.png',
                      width: 380,
                    )
                ),
                Positioned(
                  right: 15,
                  top: 20,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ImageGen(
                            imageApi: ChatApi(
                                openAiApiKeyBD: imageApi.openAiApiKeyBD,
                                openAiOrgBD: imageApi.openAiOrgBD),),);
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            //color: yellow,
                              border: Border.all(width: 2, color: themeControllerMain.isDarkMode.value? orange: darkGround)
                          ),
                          height: Get.height/4,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: iconDecoration(themeControllerMain.isDarkMode.value? orange: darkGround),
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 30,
                                          color: themeControllerMain.isDarkMode.value? orange: darkGround,
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: iconDecoration(themeControllerMain.isDarkMode.value? orange: darkGround),
                                        child: SvgPicture.asset(
                                          'assets/icons/File_Edit.svg',
                                          color: themeControllerMain.isDarkMode.value? orange: darkGround,
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: iconDecoration(themeControllerMain.isDarkMode.value? orange: darkGround),
                                        child: SvgPicture.asset(
                                          'assets/icons/Files.svg',
                                          color: themeControllerMain.isDarkMode.value? orange: darkGround,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 16,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: Get.width,
                                        color: themeControllerMain.isDarkMode.value? orange: ground,
                                        child: Text("dall-e-2", style: GoogleFonts.poppins(
                                          fontSize: 14, color: themeControllerMain.isDarkMode.value? ground: orange,)
                                          ,)
                                    ),Text(
                                      'textentry.createpicture'.tr,
                                      style: GoogleFonts.poppins(fontSize: 16, color: themeControllerMain.isDarkMode.value? orange: darkGround,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.home);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 2, color: themeControllerMain.isDarkMode.value? orange: darkGround)
                          ),
                          height: Get.height/4,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: iconDecoration(themeControllerMain.isDarkMode.value? orange: darkGround),
                                  child: Icon(
                                    Icons.message_outlined,
                                    size: 25,
                                    color: themeControllerMain.isDarkMode.value? orange: darkGround,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      color: themeControllerMain.isDarkMode.value? orange: ground,
                                        child: Text("gpt-3.5-turbo", style: GoogleFonts.poppins(
                                          fontSize: 14, color: themeControllerMain.isDarkMode.value? ground: orange,),)),
                                    Text(
                                      'textentry.writemessage'.tr,
                                      style: GoogleFonts.poppins(fontSize: 16, color: themeControllerMain.isDarkMode.value? orange: darkGround,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),


                      //онформация о моделях    --------------//не работает пока
                      // GestureDetector(
                      //   onTap: () async {
                      //     final List response;
                      //
                      //     final modelsController = Get.put(ControllerModels());
                      //
                      //     print(11);
                      //     response = (await modelsController.providedModels())!;
                      //
                      //     modelsController.listModels.value=response;
                      //     // for (var t in modelsController.listModels)
                      //     //   print(t);
                      //     // print(22);
                      //
                      //
                      //     //Get.to(()=>ViewsAIModels());
                      //   },
                      //   child: Container(
                      //     decoration: circularDecoration(),
                      //     height: 130,
                      //     width: 200,
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(40),
                      //         color: yellow,
                      //       ),
                      //       height: 200,
                      //       width: 200,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 8, top: 8),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               padding: const EdgeInsets.all(6),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.black26,
                      //                 borderRadius: BorderRadius.circular(30),
                      //               ),
                      //               child: const Icon(
                      //                 Icons.message_outlined,
                      //                 size: 25,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               height: 16,
                      //             ),
                      //             Text(
                      //               "Models",
                      //               style: GoogleFonts.poppins(fontSize: 22, color: darkGround,),
                      //
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //транскрипция и перевод

                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(() => AudioFile(
                      //       audioApi: ChatApi(
                      //           openAiApiKeyBD: imageApi.openAiApiKeyBD,
                      //           openAiOrgBD: imageApi.openAiOrgBD),),);
                      //     },
                      //   child: Container(
                      //     decoration: circularDecoration(),
                      //     height: Get.height/4,
                      //     width: 200,
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(40),
                      //         color: yellow,
                      //       ),
                      //       height: Get.height/4,
                      //       width: 200,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 8, top: 8),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Container(
                      //                     padding: const EdgeInsets.all(6),
                      //                     decoration: circularDecoration(),
                      //                     child: const Icon(
                      //                       Icons.audiotrack_rounded,
                      //                       size: 25,
                      //                       color: Colors.white,
                      //                     )),
                      //                 const SizedBox(
                      //                   width: 4,
                      //                 ),
                      //                 Container(
                      //                     padding: const EdgeInsets.all(6),
                      //                     decoration: circularDecoration(),
                      //                     child: const Icon(
                      //                       Icons.text_snippet_outlined,
                      //                       size: 25,
                      //                       color: Colors.white,
                      //                     )),
                      //                 const SizedBox(
                      //                   width: 4,
                      //                 ),
                      //                 Container(
                      //                     padding: const EdgeInsets.all(6),
                      //                     decoration: circularDecoration(),
                      //                     child: const Icon(
                      //                       Icons.translate_outlined,
                      //                       size: 25,
                      //                       color: Colors.white,
                      //                     )),
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 16,
                      //             ),
                      //             Text(
                      //               "audio transcription and translation",
                      //               style: GoogleFonts.poppins(fontSize: 22, color: darkGround,),
                      //
                      //               // TextStyle(
                      //               //   fontSize: 25,
                      //               //   color: darkGround,
                      //               // ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //Completions
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.completions);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            //color: yellow,
                              border: Border.all(width: 2, color: themeControllerMain.isDarkMode.value? orange: darkGround)
                          ),
                          height: Get.height/4,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: iconDecoration(themeControllerMain.isDarkMode.value? orange: darkGround),
                                  child: SvgPicture.asset(
                                    'assets/icons/File_Check.svg',
                                    color: themeControllerMain.isDarkMode.value? orange: darkGround,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Container(
                                        width: Get.width,
                                        color: themeControllerMain.isDarkMode.value? orange: ground,
                                        child: Text("text-davinci-003", style: GoogleFonts.poppins(
                                          fontSize: 14, color: themeControllerMain.isDarkMode.value? ground: orange,),),),
                                    Text(
                                      'completions.completions'.tr,
                                      style: GoogleFonts.poppins(fontSize: 16, color: themeControllerMain.isDarkMode.value? orange: darkGround,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Positioned(
                  left: 1,
                  top: 20,
                  child: Text(
                    "Gptik",
                    style: GoogleFonts.poppins(fontSize: 62,
                        color: themeControllerMain.isDarkMode.value?red:Color(0xFF57545B),
                        fontWeight: FontWeight.bold),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Transform buildIconMenu(colorGround) => Transform.rotate(
        angle: 2.6,
        child: SizedBox(
          child: Column(
            children: [
              buildContainer(colorGround),
              const SizedBox(height: 2,),
              buildContainer(colorGround),
              const SizedBox(height: 2,),
              buildContainer(colorGround),
            ],
          ),
        ),
      );

  Container buildContainer(colorGround) {
    return Container(
        height: 10,
        width: 28,
        decoration: BoxDecoration(
            color: colorGround,
            borderRadius: BorderRadius.circular(5)),
      );
  }
}
