import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/data/preference/app_preferences.dart';
import 'package:fast_app_base/common/data/preference/prefs.dart';
import 'package:fast_app_base/common/widget/w_bid_button.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_switch_menu.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '설정'.text.make(),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Obx(() =>
              SwitchMenu('푸시 설정', Prefs.isPushOnRx.get(), onChanged: (isOn) {
                Prefs.isPushOnRx.set(isOn);
              })),
          Obx(() => Slider(
              value: Prefs.sliderPositionRx.get(),
              onChanged: (value) {
                Prefs.sliderPositionRx.set(value);
              })),
          Obx(() => BigButton(
                  '날짜  ${Prefs.birthDay.get() == null ? "" : DateFormat('yyyy년 MM월 dd일').format(Prefs.birthDay.get()!)}',
                  onTap: () async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(90.days),
                    lastDate: DateTime.now().add(90.days));
                if (date != null) {
                  Prefs.birthDay.set(date);
                }
              })),
        ],
      ),
    );
  }
}
