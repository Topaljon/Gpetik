import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helper_open_ai/chat_assistant/data_theme/app_theme.dart';

class ThemeController extends GetxController {
  final box = GetStorage();

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = box.read('isDarkMode') ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? AppTheme.dark : AppTheme.light,
    );
    box.write('isDarkMode', isDarkMode.value);
  }
}