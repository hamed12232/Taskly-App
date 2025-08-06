import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/Constant/ColorPlatte.dart';
import 'package:to_do_list/business_logic/Cubit/notes_cubit.dart';
import 'package:to_do_list/data/Storage/SqlDb.dart';
import 'package:to_do_list/presention/Screen/AnimatedDrawer.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.asset(
                  "assets/animation/Animation - 1738388702584.json",
                  fit: BoxFit.fill,
                ),
              ),
              const Text("TASKLY APP",style: TextStyle(fontSize: 30),)

            ],
          ),
        ),
      ),
      backgroundColor: ColorPalette.getBackgroundColor(isDarkMode),
      nextScreen: BlocProvider(
        create: (context) => NotesCubit(sqlDb),
        child: const MyHomePageDrawer(),
      ),
      duration: 3000,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 500,
    );
  }
}
