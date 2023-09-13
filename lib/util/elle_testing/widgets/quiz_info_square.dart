import 'package:fiservonboardingexp/util/elle_testing/models/quiz_model.dart';
import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class QuizInfoSquare extends StatelessWidget {
  final IconData icon;
  final String text;

  const QuizInfoSquare({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: fiservColor),
            color: Colors.transparent),
        child: SizedBox(
          width: 80,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fiservColor),
              const SizedBox(height: 5),
              Text(
                text,
                style:
                    GoogleFonts.quicksand(fontSize: 12, color: darkTextColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
