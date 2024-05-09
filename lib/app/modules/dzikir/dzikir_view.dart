import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dzikir/app/components/circular_button.dart';
import 'package:dzikir/app/components/dzikir_container.dart';
import 'package:dzikir/app/data/dzikir_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'dzikir_controller.dart';

class DzikirView extends GetView<DzikirController> {
  const DzikirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        body: Obx(() {
          int count = controller.count.value;
          int index = controller.index.value;
          List<DzikirModel> dzikirs = controller.dzikirs;
          bool animate = controller.animate.value;
          return Container(
            padding: EdgeInsets.fromLTRB(20, AppBar().preferredSize.height, 20, 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
            )),
            child: Builder(builder: (context) {
              if (controller.dzikirs.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              DzikirModel dzikir = dzikirs[index];
              int maxCount = dzikir.count ?? 0;
              bool left = !(controller.index.value == controller.dzikirs.length - 1);
              return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                  child: AppinioSwiper(
                    backgroundCardCount: 0,
                    swipeOptions: SwipeOptions.only(
                      left: left,
                      right: false,
                      up: false,
                      down: false,
                    ),
                    controller: controller.controller,
                    cardCount: controller.dzikirs.length,
                    cardBuilder: (BuildContext context, int index) {
                      DzikirModel dzikir = controller.dzikirs[index];
                      return DzikirContainer(
                        dzikir: dzikir,
                        index: index,
                        count: controller.dzikirs.length,
                        controller: controller.scrollController,
                      );
                    },
                    duration: const Duration(milliseconds: 300),
                    onSwipeBegin: (int previousIndex, int targetIndex, SwiperActivity activity) {
                      controller.isSwiping.value = true;
                    },
                    onSwipeEnd: (int previousIndex, int targetIndex, SwiperActivity activity) async {
                      controller.isSwiping.value = false;
                      switch (activity) {
                        case Swipe():
                          int index = controller.index.value;
                          int dzikirsLength = controller.dzikirs.length;
                          if (index == dzikirsLength - 1) Get.back();
                          if (index < dzikirsLength - 1) {
                            controller.index.value += 1;
                            controller.count.value = 0;
                          }
                          break;
                        case Unswipe():
                          controller.index.value -= 1;
                          controller.count.value = 0;
                          break;
                        case CancelSwipe():
                          break;
                        case DrivenActivity():
                          break;
                      }
                      controller.scrollController.animateTo(
                        0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularButton(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            controller.buttonLeft();
                          },
                          icon: Icons.navigate_before,
                        ),
                        const SizedBox(height: 8),
                        CircularButton(
                          backgroundColor: Colors.red,
                          onPressed: () {},
                          caption: "${maxCount}x",
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    AvatarGlow(
                      animate: animate,
                      child: GestureDetector(
                        onTap: () async {
                          controller.buttonDzikir(maxCount);
                        },
                        child: CircularPercentIndicator(
                          radius: 75,
                          lineWidth: 10.0,
                          percent: count / maxCount,
                          backgroundColor: Colors.grey,
                          progressColor: Colors.blue,
                          center: Text(
                            "${count}x",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularButton(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            controller.buttonRight();
                          },
                          icon: Icons.navigate_next,
                        ),
                        const SizedBox(height: 8),
                        CircularButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            controller.count.value = 0;
                          },
                          icon: Icons.restart_alt,
                        ),
                      ],
                    )
                  ],
                )
              ]);
            }),
          );
        }),
      ),
    );
  }
}

class DzikirBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DzikirController());
  }
}
