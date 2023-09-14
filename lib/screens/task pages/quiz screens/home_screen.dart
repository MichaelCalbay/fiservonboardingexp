import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/question_card.dart';
import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controllers/quiz controllers/quiz_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find();
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Column(
        children: [
          // will need to change to pull the title from whatever category has been chosen.
          //Expanded(
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: SizedBox(
              child: Text(
                "A Collection's Task Page",
                style: headerFontStyle,
              ),
            ),
          ),
          //),
          Expanded(
            child: ContentArea(
              addPadding: false,
              child: Obx(
                () => ListView.separated(
                    padding: UIParameters.mobileScreenPadding,
                    itemBuilder: (BuildContext context, int index) {
                      return QuestionCard(
                        model: quizController.allQuizzes[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: quizController.allQuizzes.length),
              ),
            ),
          ),
        ],
      ),

      //itemCount: quizController.allQuizzes.length)),
    );
  }
}