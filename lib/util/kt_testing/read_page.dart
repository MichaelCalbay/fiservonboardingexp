import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar_overlay.dart';
import '../../widgets/nav_bar.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';

class ReadPage extends GetView<ReadController> {
  final ProgressBar _progressBar = const ProgressBar();
  final ReadModel model;

  const ReadPage({required this.model});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: FutureBuilder<ReadModel>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is still loading
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there was an error
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView(
                children: [
                  const SizedBox(height: 30),

                  // Title
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: selectedTheme.colorScheme.secondary),
                      ),
                    ),
                  ),

                  // Image (from local assets folder not firebase). Needs to be changed as its hard coded.
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Image(image: AssetImage('assets/images/Read.jpg')),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: model.content.split(r'\n\n').map((paragraph) {
                        // Replace '\n' with two new lines '\n\n', and trim leading/trailing spaces.
                        final trimmedParagraph =
                            paragraph.replaceAll(r'\n\n', '\n' '\n').trim();
                        return Column(
                          children: [
                            // Display the trimmed paragraph as text.
                            Text(
                              trimmedParagraph,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: selectedTheme.colorScheme.primary,
                              ),
                            ),
                            // Add space (SizedBox) between paragraphs.
                            const SizedBox(height: 16.0),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // Puts the two buttons in a row so it is positioned side by side
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Back button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedTheme.colorScheme.tertiary,
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: selectedTheme.colorScheme.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts
                                .quicksand()), // Merge styles with GoogleFonts
                          ),
                        ),

                        // Task finished button
                        ElevatedButton(
                          onPressed: () {
                            int points = 1;
                            _progressBar.addPoints(points);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedTheme.colorScheme.tertiary,
                          ),
                          child: Text(
                            'Task Finished',
                            style: TextStyle(
                              color: selectedTheme.colorScheme.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts
                                .quicksand()), // Merge styles with GoogleFonts
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
