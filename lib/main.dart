import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:yebelo_test/consts/color_pallet.dart';
import 'package:yebelo_test/consts/typography.dart';
import 'package:yebelo_test/controllers/home_screen_controller.dart';
import 'package:yebelo_test/views/home_screen.dart';

void main() {
  runApp(const yebelo());
}

class yebelo extends StatelessWidget {
  const yebelo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: ThemeData(
          filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
            backgroundColor: greenColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          )),
          fontFamily: regular,
        ),
      ),
    );
  }
}
