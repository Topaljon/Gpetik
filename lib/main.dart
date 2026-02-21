import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'chat_assistant/data_theme/app_theme.dart';
import 'chat_assistant/data_theme/theme_controller.dart';
import 'chat_assistant/drawer/controller/controller_drawer.dart';
import 'chat_assistant/drawer/model/key_and_company.dart';
import 'chat_assistant/translations/translate_app.g.dart';

void main() async {
  final drawerController = Get.put(ControllerDrawer());

  await Hive.initFlutter();
  Hive.registerAdapter(KeyAndCompanyAdapter());
  await Hive.openBox(drawerController.dbGptik.value);


  return runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      // textDirection: Get.locale == 'ar'
      //     ? TextDirection.rtl
      //     : TextDirection.ltr,
      initialRoute: Routes.textEntry,
      getPages: pages,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      translations: Localization(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}