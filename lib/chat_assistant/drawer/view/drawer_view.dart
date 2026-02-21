import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:helper_open_ai/chat_assistant/config/color.dart';
import 'package:helper_open_ai/chat_assistant/data_theme/theme_controller.dart';
import 'package:helper_open_ai/chat_assistant/drawer/view/input_view.dart';

class DrawerView extends GetView {
  const DrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> users = <String>['drawer.key_and_company'.tr];
    List<Widget> viewInput = <Widget>[InputView()];
    final themeController = Get.put(ThemeController());

    return Drawer(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Obx(
            () => Container(
              decoration: BoxDecoration(
                color: themeController.isDarkMode.value ? orange :ground,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: themeController.isDarkMode.value ? ground : lightGray,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
              ),
            ),
          ),

          //узоры с лева внизу
          Positioned(
            left: 8,
            top: 24,
            child: Stack(children: [
              SvgPicture.string(
                _svg_im2qeq,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
              SvgPicture.string(
                _svg_jpilra,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ]),
          ),
          Positioned(
            left: 8,
            top: Get.height / 2.5,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  width: Get.width / 1.5,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        Get.to(() => viewInput[index]);
                      },
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Obx(
                            ()=> Text(
                                users[index],
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 18,
                                  color: themeController.isDarkMode.value
                                      ? orange
                                      : darkGround,
                                ),
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Obx(
                            () => DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: themeController.isDarkMode.value
                                    ? orange
                                    : darkGround,),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: themeController.isDarkMode.value
                                      ? orange
                                      : darkGround,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // SizedBox(
                //   height: 50,
                //   width: Get.width / 1.5,
                //   child: Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Row(
                //       children: [
                //         const Text("Language", style: TextStyle(
                //           fontFamily: 'Segoe UI',
                //           fontSize: 20,
                //           color: Colors.black,
                //         ),),
                //         const Expanded(child: SizedBox()),
                //         const Icon(Icons.expand_circle_down, color: Colors.black26, size: 50,),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          Positioned(
            left: 8,
            top: Get.height / 1.9,
            child: SizedBox(
              height: 50,
              width: Get.width / 1.5,
              child: Row(
                children: [
                  Obx(
                    () => SizedBox(
                      width: Get.width / 2,
                      child: Text(
                        themeController.isDarkMode.value ? 'drawer.change_light_theme'.tr:'drawer.change_dark_theme'.tr,
                        maxLines: 5,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: themeController.isDarkMode.value
                              ? orange
                              : darkGround,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Obx(
                    () => Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) => themeController.toggleTheme(),
                      trackColor: MaterialStateProperty.all(themeController.isDarkMode.value
                          ? orange
                          : grey,),

                      thumbColor: MaterialStateProperty.all(themeController.isDarkMode.value?orange:grey),
                      //inactiveThumbColor: Colors.transparent,
                      activeColor: Colors.transparent,
                      //inactiveTrackColor: Colors.transparent,
                      //activeTrackColor: Colors.transparent,
                      // focusColor: Colors.transparent,
                      // hoverColor: Colors.transparent,


                      thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Icon(
                              Icons.dark_mode_outlined,
                              size: 40,
                              color: ground,
                            );
                          }
                          return const Icon(
                            Icons.light_mode,
                            size: 40,
                            color: orange,
                          ); // other states will use default thumbIcon.
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //иконка выход
          Positioned(
            left: 8,
            bottom: 24,
            child: SizedBox(
              child: Stack(
                children: <Widget>[
                  Obx(
                    () => Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Exit.svg',
                          color: themeController.isDarkMode.value
                              ? orange
                              : darkGround,
                          width: 40,
                        ),
                        Text(
                          'drawer.exit'.tr,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: themeController.isDarkMode.value
                                ? orange
                                : darkGround,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: Get.width / 4,
              top: 60,
              child: Obx(
              ()=> Image.asset(
                  'assets/pict/robot.png',
                  width: 100,
                    color: themeController.isDarkMode.value
                        ? ground
                        : darkGround,),
              )),
          Positioned(
            right: 24,
            bottom: 30,
            child: GestureDetector(
              onTap: () {
                Get.dialog(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          width: Get.width / 1.3,
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
                                  Icon(
                                    Icons.email,
                                    size: 32,
                                    color: Colors.red[200],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'drawer.dialog_email'.tr,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "vladimirk@gmail.com",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red[200], fontSize: 14),
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
              child: Row(
                children: [
                  Obx(
                    () => SizedBox(
                      width: 130,
                      child: Text(
                        'drawer.evelopment_and_design'.tr,
                        maxLines: 3,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: themeController.isDarkMode.value
                              ? orange
                              : darkGround,
                        ),
                        //softWrap: false,
                      ),
                    ),
                  ),
                  Obx(() => Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: themeController.isDarkMode.value
                            ? orange
                            : darkGround,
                        size: 30,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_im2qeq =
    '<svg viewBox="0.0 676.6 270.8 238.4" ><path transform="translate(-238.92, 372.22)" d="M 352.1136474609375 315.705078125 C 366.2786254882812 316.614990234375 380.9100341796875 303.819091796875 393.70751953125 310.0679626464844 C 406.4194946289062 316.2750854492188 402.63427734375 339.81689453125 415.125244140625 346.4729309082031 C 444.1345825195312 361.9312133789062 499.1453247070312 339.5277404785156 508.7811889648438 371.3874816894531 C 517.4642944335938 400.0971069335938 463.5170288085938 408.03662109375 438.6207275390625 424.1578674316406 C 425.7977905273438 432.4611511230469 409.4285888671875 433.2989196777344 397.795654296875 443.2544555664062 C 386.6057739257812 452.8307800292969 383.098388671875 468.3887023925781 373.6588745117188 479.7525024414062 C 355.138671875 502.0481262207031 343.7806396484375 538.346435546875 315.386962890625 542.4625244140625 C 291.4903869628906 545.9267578125 264.6933898925781 520.3539428710938 260.3841552734375 496.1735534667969 C 255.1280822753906 466.6801452636719 297.2571716308594 443.3642272949219 292.4560546875 413.7905578613281 C 288.9904479980469 392.4429321289062 248.8968505859375 397.1288146972656 241.0411071777344 377.0241088867188 C 234.2413482666016 359.6218872070312 244.8949127197266 337.9136352539062 257.4648132324219 324.2394714355469 C 269.90087890625 310.7109375 289.5423278808594 306.1758422851562 307.6707153320312 304.5412292480469 C 323.0938415527344 303.1505432128906 336.6608581542969 314.7124328613281 352.1136474609375 315.705078125" fill="#FBCEB1" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jpilra =
    '<svg viewBox="-43.4 630.1 230.8 284.9" ><path transform="translate(-368.94, 406.89)" d="M 408.0894775390625 223.4529724121094 C 428.578857421875 221.3221893310547 453.0509033203125 231.8076629638672 463.4208068847656 251.5508117675781 C 474.9947204589844 273.5863037109375 448.0646667480469 307.0841064453125 462.4580688476562 326.9647827148438 C 478.6768493652344 349.3667602539062 517.8115844726562 330.694091796875 535.734130859375 351.4326782226562 C 552.3409423828125 370.6488647460938 564.0318603515625 406.7420654296875 550.2225341796875 428.51904296875 C 534.731689453125 452.947509765625 495.7381591796875 434.0030212402344 473.1182250976562 450.1759948730469 C 455.412109375 462.835693359375 459.96875 510.3959655761719 439.0194702148438 508.0279846191406 C 413.2847290039062 505.1190795898438 416.21142578125 451.2182312011719 392.0313720703125 441.0104064941406 C 372.2455444335938 432.6575927734375 350.0872802734375 476.5778198242188 332.7128295898438 463.1495361328125 C 316.5196533203125 450.6341552734375 332.1945495605469 419.7769775390625 337.0963745117188 398.5523071289062 C 340.3159484863281 384.611572265625 354.68212890625 375.9420776367188 356.1555786132812 361.6433715820312 C 357.6453857421875 347.1854858398438 344.8880920410156 334.9432373046875 345.1502075195312 320.3939208984375 C 345.5133056640625 300.2410278320312 347.32666015625 278.8693542480469 357.9414672851562 262.5201110839844 C 370.0600891113281 243.8546295166016 387.4609069824219 225.5982360839844 408.0894775390625 223.4529724121094" fill="#ffffff" fill-opacity="0.49" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
