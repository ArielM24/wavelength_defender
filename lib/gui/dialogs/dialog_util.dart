import 'package:flutter/material.dart';
import 'package:wavelength_defender/gui/dialogs/game_pause_dialog.dart';

showPauseDialog({required BuildContext context}) async {
  await showDialog(
      context: context, builder: (context) => const GamePauseDialog());
}
