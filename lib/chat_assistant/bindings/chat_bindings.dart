import 'package:get/get.dart';
import '../audio_to_text/controller_att/controller_audio_to_text.dart';
import '../controllers/entry_controller.dart';
import '../drawer/controller/controller_drawer.dart';


class ChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EntryController());
    Get.lazyPut(() => ControllerAudioToText());
    Get.lazyPut(() => ControllerDrawer());
  }
}
