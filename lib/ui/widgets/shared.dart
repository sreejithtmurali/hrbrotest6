import 'package:flutter/material.dart';

import '../../app/utils.dart';

Widget backButton({VoidCallback? onPressed, Color? color}) {
  return IconButton(
    onPressed: onPressed ?? () => navigationService.back(),
    icon: Image.asset(
      "assets/images/arrow-back.png",
      color: color,
    ),
    splashRadius: kToolbarHeight / 2,
  );
}
