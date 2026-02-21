import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/views/text_page.dart';
import '../text_entry_getx.dart';
import 'api/chat_api.dart';
import 'bindings/chat_bindings.dart';
import 'completions/completions.dart';
import 'config/config_chat.dart';
import 'drawer/controller/controller_drawer.dart';

class Routes {
  static String textEntry = "/textEntry";
  static String home = "/home";
  static String completions = "/Completions";

}
/// assign this list variable into your GetMaterialApp as the value of getPages parameter.
/// you can get the reference to the above GetMaterialApp code.

final drawerController = Get.put(ControllerDrawer());


final List keyCompanyList = drawerController.readeKeyAndCompany();

String keyGpt =
keyCompanyList.isNotEmpty
    ?keyCompanyList[0].keyGptName.toString() :'';
String companyKey = keyCompanyList.isNotEmpty
    ?keyCompanyList[0].anyCompany.toString() :'';

final chatApiParam = ChatApi(
openAiApiKeyBD: keyGpt, openAiOrgBD: companyKey
);

final pages = [
  GetPage(
    name: Routes.textEntry,
    page: () => TextEntryGet(imageApi: chatApiParam),
    binding: ChatBindings(),
  ),
  GetPage(
    name: Routes.home,
    page: ()=> TextPage(chatApi: chatApiParam,),
    binding: ChatBindings(),
  ),
  GetPage(
    name: Routes.completions,
    page: () => Completions(chatApi: chatApiParam,),
    binding: ChatBindings(),
  ),
];