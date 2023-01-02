import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/assets.gen.dart';
import '../../tools/screen_size.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model) => model.startTimer(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            width: ScreenSize.width,
            height: ScreenSize.height,
            alignment: Alignment.center,
            child: Assets.images.img.image(height: 100,width: 100),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
