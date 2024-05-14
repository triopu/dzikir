import 'dart:convert';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:dzikir/app/data/dzikir_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class DzikirController extends GetxController {
  final AppinioSwiperController controller = AppinioSwiperController();
  final ScrollController scrollController = ScrollController();
  var index = 0.obs;
  var count = 0.obs;
  var dzikirs = <DzikirModel>[].obs;
  var animate = false.obs;
  var isSwiping = false.obs;

  loadJson() async {
    dzikirs.clear();
    var args = Get.arguments;
    String jsonData = "";
    if (args == 0) {
      jsonData = await rootBundle.loadString('assets/data/dzikir-pagi.json');
    } else {
      jsonData = await rootBundle.loadString('assets/data/dzikir-petang.json');
    }
    if (jsonData == "") return;
    var data = json.decode(jsonData);
    for (var dzikir in data) {
      dzikirs.add(DzikirModel.fromJson(dzikir));
    }
    index.value = 0;
  }

  right() {
    if (isSwiping.value) return;
    if (index.value == dzikirs.length - 1) Get.back();
    if (index.value < dzikirs.length - 1) {
      controller.swipeLeft();
    }
  }

  left() {
    if (isSwiping.value) return;
    if (index.value == 0) return;
    controller.unswipe();
  }

  buttonDzikir(int maxCount) async {
    if (animate.value) return;
    if (count.value < maxCount) count.value += 1;
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = false;
    if (count.value == maxCount) right();
  }

  Future<void> vibrate() async {
    bool canVibrate = await Vibration.hasVibrator() ?? false;
    if (canVibrate) {
      Vibration.vibrate(duration: 100);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadJson();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
