import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unibond/controller/letter_controller.dart';
import 'package:unibond/view/screens/test_screen.dart';
import 'package:unibond/view/screens/user/root_tab.dart';
import 'package:unibond/view/screens/letter/letter_box_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      initialBinding: InitialBinding(), //이 코드 반드시 넣어야 함
    );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LetterController());
  }
}
