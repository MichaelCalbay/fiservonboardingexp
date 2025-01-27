import 'package:provider/provider.dart';
import '../../../../controllers/quiz controllers/question_controller.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/loading_status.dart';
import 'package:fiservonboardingexp/screens/module/task%20pages/quiz%20screens/quiz_outcome_screen.dart';
import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/background_decoration.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/content_area.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/question_placeholder.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/answer_option_tiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../themes/theme_provider.dart';
import '../../../../util/constants.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionScreen";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: GoogleFonts.quicksand(
          fontSize: 20,
        ),
        backgroundColor: selectedTheme.colorScheme.background);
    const double buttonHeight = 40;
    const double buttonWidth = 150;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: lightBackgroundColor,
      body: BackgroundDecoration(
        child: Obx(() => Column(
              children: [
                controller.loadingStatus.value == LoadingStatus.loading
                    ? const Expanded(
                        child: ContentArea(child: QuestionPlaceholder()))
                    : Expanded(
                        child: ContentArea(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                Text(
                                  ' Q: ${(controller.questionIndex.value + 1).toString()} out of ${controller.allQuizQuestions.length}',
                                  style: GoogleFonts.quicksand(
                                      color:
                                          selectedTheme.colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(
                                  thickness: 1.5,
                                  color: darkTextColor.withOpacity(0.2),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  child: Text(
                                    controller.currentQuestion.value!.question,
                                    style: GoogleFonts.quicksand(
                                        color:
                                            selectedTheme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                    softWrap: true,
                                  ),
                                ),
                                GetBuilder<QuestionController>(
                                    // id allows for the allowing the package to know which GetBuilder<QuestionController> we want updated
                                    id: 'answers_list',
                                    builder: (context) {
                                      return ListView.separated(
                                          shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final option = controller
                                                .currentQuestion
                                                .value!
                                                .options![index];
                                            return AnswerOptionTiles(
                                              answerIdentifier:
                                                  '${option.identifier}.',
                                              answerOption: '${option.answer}',
                                              onTap: () {
                                                controller.selectedAnswer(
                                                    option.identifier);
                                              },
                                              isSelected: option.identifier ==
                                                  controller.currentQuestion
                                                      .value!.selectedAnswer,
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const SizedBox(height: 10),
                                          itemCount: controller.currentQuestion
                                              .value!.options!.length);
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                ColoredBox(
                  color: selectedTheme.colorScheme.onBackground,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              height: buttonHeight,
                              width: buttonWidth,
                              child: ElevatedButton(
                                style: style,
                                onPressed: () {
                                  controller.prevQuestion();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Previous",
                                    selectionColor:
                                        selectedTheme.colorScheme.background,
                                    style: GoogleFonts.quicksand(
                                        color: selectedTheme
                                            .colorScheme.secondary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: SizedBox(
                                  height: buttonHeight,
                                  width: controller.isLastQuestion
                                      ? buttonWidth
                                      : 100,
                                  child: ElevatedButton(
                                      style: style,
                                      onPressed: () {
                                        controller.isLastQuestion
                                            ? Get.toNamed(
                                                QuizOutcomeScreen.routeName)
                                            : controller.nextQuestion();
                                      },
                                      child: controller.isLastQuestion
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Submit Answers',
                                                selectionColor: selectedTheme
                                                    .colorScheme.background,
                                                style: GoogleFonts.quicksand(
                                                    color: selectedTheme
                                                        .colorScheme.secondary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Next',
                                                  selectionColor: selectedTheme
                                                      .colorScheme.background,
                                                  style: GoogleFonts.quicksand(
                                                      color: selectedTheme
                                                          .colorScheme
                                                          .secondary)),
                                            )),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
