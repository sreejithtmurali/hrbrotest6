import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:statusbarz/statusbarz.dart';

import 'app/app.router.dart';
import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'constants/assets.gen.dart';
import 'constants/fonts.gen.dart';
import 'ui/tools/screen_size.dart';
import 'ui/tools/smart_dialog_config.dart';
import 'ui/widgets/setup_dependencies.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // if (!kIsWeb) {
  //   if (Platform.isAndroid) {
  //     ByteData data = await PlatformAssetBundle().load(
  //       Assets.ca.letsEncryptR3,
  //     );
  //     SecurityContext.defaultContext.setTrustedCertificatesBytes(
  //       data.buffer.asUint8List(),
  //     );
  //   }
  // }
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return StatusbarzCapturer(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,

            title: AppStrings.appName,
            theme: ThemeData(
              primarySwatch: generateMaterialColor(Palette.primary),
              fontFamily: FontFamily.barlow,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color(0xff092f92),
                foregroundColor: Colors.black,
                hoverColor: Colors.red,
                splashColor: Color(0xff090f90),
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
            ),
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                ScreenSize.init(context);

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: child!,
                );
              },
              toastBuilder: toastBuilder,
              loadingBuilder: loadingBuilder,
            ),
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorObservers: [
              StackedService.routeObserver,
              Statusbarz.instance.observer,
              FlutterSmartDialog.observer
            ],
          ),
        );
      },
    );
  }
}
