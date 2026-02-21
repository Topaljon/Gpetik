import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/color.dart';
import 'package:helper_open_ai/chat_assistant/config/style_widget.dart';
import 'package:helper_open_ai/chat_assistant/controllers/entry_controller.dart';
import 'package:helper_open_ai/chat_assistant/drawer/model/key_and_company.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data_theme/theme_controller.dart';
import '../controller/controller_drawer.dart';

class InputView extends GetView<ControllerDrawer> {
   InputView({super.key});

  final drawerController = Get.put(ControllerDrawer());
  final entryController = Get.put(EntryController());
  final inputViewController = Get.put(ThemeController());


@override
Widget build(BuildContext context) {
  final listModel = [...entryController.modelAilist];

  return Scaffold(
  appBar: AppBar(
    leadingWidth: 25,
    title: Text('drawer.input_view'.tr, style: TextStyle(color: inputViewController.isDarkMode.value
        ?orange
        :darkGround),),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leading: iconButtonBack(inputViewController.isDarkMode.value?orange:darkGround),
    flexibleSpace: Obx(
          ()=> DecoratedBox(
            decoration: BoxDecoration(
                color: inputViewController.isDarkMode.value
                    ?darkGround
                    :grey
            ),),),),
    body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: inputViewController.isDarkMode.value
                ? [orange, ground, darkGround]
                : [orange, lightGray,grey ],
          ),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          child: ValueListenableBuilder(
            valueListenable: Hive.box(drawerController.dbGptik.value).listenable(),
            builder: (BuildContext context, value, child)
            {List keyCompanyList = drawerController.readeKeyAndCompany();
              return Column(children: [
                for(int index=0; index < keyCompanyList.length; index++)
                  Dismissible(
                    key: Key(keyCompanyList[index].keyGptName),
                    onDismissed: (DismissDirection direction) {
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
                                        Icon(Icons.delete_forever, size: 50, color: Colors.red[100],),
                                        const SizedBox(height: 15),
                                        Text(
                                          'drawer.data_deleted'.tr,
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
                                                  minimumSize: const Size(0, 45),
                                                  backgroundColor: grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'drawer.dialog_no'.tr, style: TextStyle(fontSize: 18, color: Get.theme.colorScheme.onSurface),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(0, 45),
                                                  backgroundColor: grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  drawerController.deleteKeyGpt(index);
                                                  Get.back();
                                                },
                                                child: Text(
                                                  'drawer.dialog_yes'.tr, style: TextStyle(fontSize: 18, color: Get.theme.colorScheme.onSurface),
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
                    },
                    background: Row(
                      children: [
                        Icon(Icons.delete_forever, color: Colors.red[100], size: 60,),
                        const Expanded(child: SizedBox()),
                        Icon(Icons.delete_forever, color: Colors.red[100], size: 60,),
                      ],
                    ),

                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: inputViewController.isDarkMode.value ? orange :ground, width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width/2.4,
                                height: Get.height/4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(24),
                                                color: inputViewController.isDarkMode.value ? ground :lightGray,
                                                border: Border.all(width: 2, color: inputViewController.isDarkMode.value ? orange :ground)
                                            ),
                                              child: Icon(Icons.key, color: inputViewController.isDarkMode.value ? orange :ground,)
                                          ),
                                          const SizedBox(width: 16,),
                                          Container(
                                            width: Get.width/4,
                                              color: orange,
                                              child: Text('inputView.modelskey'.tr, style: TextStyle(fontSize: 14, color: darkGround),)),
                                        ],
                                      ),
                                      Text(keyCompanyList[index].keyGptName.toString(), style: TextStyle(fontSize: 20, color: Get.theme.colorScheme.onSurfaceVariant),),
                                    ],
                                  ),
                              ),
                              const SizedBox(width: 8,),
                              SizedBox(
                                  width: Get.width/2.4,
                                  height: Get.height/4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24),
                                                  color: inputViewController.isDarkMode.value ? ground :lightGray,
                                                  border: Border.all(width: 2, color: inputViewController.isDarkMode.value ? orange :ground)
                                              ),
                                              child: Icon(Icons.workspaces, color: inputViewController.isDarkMode.value ? orange :ground,)),
                                          const SizedBox(width: 16,),
                                          Container(
                                            width: Get.width/4,
                                              color: orange,
                                              child: Text(
                                                'inputView.modelsorganization'.tr,
                                                maxLines: 2,
                                                style: const TextStyle(fontSize: 14, color: darkGround),)),
                                        ],
                                      ),
                                      Text(keyCompanyList[index].anyCompany.toString(), style: TextStyle(fontSize: 20, color: Get.theme.colorScheme.onSurfaceVariant),),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          SizedBox(
                              width: Get.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(24),
                                              color: inputViewController.isDarkMode.value ? ground :lightGray,
                                              border: Border.all(width: 2, color: inputViewController.isDarkMode.value ? orange :ground)
                                          ),
                                          child: Icon(Icons. data_usage_rounded, color: inputViewController.isDarkMode.value ? orange :ground,)),
                                      const SizedBox(width: 16,),

                                      Container(
                                        width: Get.width/1.4,
                                          color: orange,
                                          child: Text('inputView.model'.tr, style: const TextStyle(fontSize: 14, color: darkGround),)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      for (var ml in listModel) Row(
                                        children: [
                                          const SizedBox(width: 8,),
                                          const Icon(Icons.circle_rounded, size: 10, color: orange,),
                                          const SizedBox(width: 8,),
                                          Text(ml, style: TextStyle(fontSize: 20, color: Get.theme.colorScheme.onSurfaceVariant),),
                                          const SizedBox(width: 8,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,)

                            ],
                          )),
                        ],
                      ),
                    ),
                  ),

                keyCompanyList.isEmpty? Column(
                  children: [
                    const SizedBox(height: 16,),
                    Container(
                      decoration: buildBoxDecoration(),
                      child: TextField(
                        controller: drawerController.keyGptController.value,
                        //obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          labelText: 'KeyGpt',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      decoration: buildBoxDecoration(),
                      child: TextField(
                        controller: drawerController.companyController.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          labelText: 'inputView.company_name'.tr,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(200, 30),
                          backgroundColor: Colors.black26,
                          textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24),),),),
                        onPressed: (){
                          String keyText = drawerController.keyGptController.value.text;
                          String companyText = drawerController.companyController.value.text;

                          if (keyText.isNotEmpty){
                            var keyAndCompany = KeyAndCompany(keyGptName: keyText, anyCompany: companyText);
                            drawerController.addKeyGpt(keyAndCompany);
                          } else{
                            Get.dialog(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40),
                                    child: Container(
                                      width: Get.width-100,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Material(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            SvgPicture.asset('assets/icons/Warning.svg', color: Colors.yellow, width: 40,),
                                            const SizedBox(height: 15),
                                            Text(
                                              'inputView.needkey'.tr,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 24),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }, child: Text('inputView.add'.tr, style: const TextStyle(color: Colors.white),)),
                  ],
                )
                    : Container(),
              ],
            );
          },
          ), // just call `controller.something`
        ),
      ),
    ),
  );
}
}
