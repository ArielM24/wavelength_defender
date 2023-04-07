import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'wavelength_game.dart';

class WavelengthGameWidget extends StatelessWidget {
  const WavelengthGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: WavelengthGame(),
      loadingBuilder: (_) => const Center(
        child: Text("loading"),
      ),
    );
  }
}
