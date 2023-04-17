import 'package:flutter/material.dart';
import 'package:wavelength_defender/gui/game/overlays/confirmation_dialog_overlay.dart';

Future<bool> showConfirmationdialog({required BuildContext context}) async {
  return await showDialog<bool>(
          context: context,
          builder: (context) => const ConfirmationDialogOverlay()) ??
      false;
}
