import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
import 'package:wavelength_defender/gui/dialogs/dialog_util.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Material(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    context.read<GameBloc>().add(ResumeButtonPressed());
                  },
                  child: const Text(
                    "Resume",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Restart",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () async {
                    bool confirmation =
                        await showConfirmationdialog(context: context);
                    if (confirmation && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    "Quit",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
