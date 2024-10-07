import 'package:flutter/material.dart';

class BackgroundGradientWidget extends StatelessWidget {
  const BackgroundGradientWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xff071952),
            Color(0xFF0A216B),
            Color(0xff0B666A),
          ],
        ),
      ),
    );
  }
}
