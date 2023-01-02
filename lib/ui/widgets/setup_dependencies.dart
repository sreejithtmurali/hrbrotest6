import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/utils.dart';

Future<void> setupDependencies() async {
  setupLocator();
  setupDialogs();
  setupBottomSheet();
}

typedef DialogBuilder = Widget Function(
  BuildContext,
  DialogRequest,
  Function(DialogResponse),
);

enum DialogType { basic }

void setupDialogs() {
  final Map<DialogType, DialogBuilder> builders = {
    // DialogType.basic: (context, request, completer) {
    //   return BasicDialog(request: request, completer: completer);
    // },
  };

  dialogService.registerCustomDialogBuilders(builders);
}

typedef SheetBuilder = Widget Function(
  BuildContext,
  SheetRequest,
  void Function(SheetResponse),
);

enum BottomSheetType { players }

void setupBottomSheet() {
  final Map<BottomSheetType, SheetBuilder> builders = {
    // BottomSheetType.players: (context, request, completer) {
    //   return BasicSheet(request: request, completer: completer);
    // },
  };

  sheetService.setCustomSheetBuilders(builders);
}
