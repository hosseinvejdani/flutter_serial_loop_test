import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'src/controller/bindings.dart';
import 'src/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/home',
          getPages: [
            GetPage(
              name: '/home',
              page: () => const HomePage(),
              binding: AppBinding(),
            )
          ],
        );
      },
      child: const HomePage(),
    );
  }
}
