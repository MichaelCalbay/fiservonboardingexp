import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_page.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:fiservonboardingexp/widgets/nav_bar.dart';

import 'package:get/get.dart';
import '../util/constants.dart';
import '../widgets/app_bar_overlay.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ExpBar _expBar = const ExpBar(barwidth: 300);
  final ProgressBar _progressBar = const ProgressBar();

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // //appbar
        appBar: const AppBarOverlay(),
        bottomNavigationBar: const CustomNavBar(),

        //Floating action button
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            int expToAdd = 200;
            _expBar.addExperience(expToAdd);
          },
        ),

        //Home Page
        body: ListView(
          children: [
            const SizedBox(height: 15),

            //expBar
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(alignment: Alignment.centerLeft, child: _expBar),
            ),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(height: 30),

            //Progress bar
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  alignment: Alignment.centerLeft, child: _progressBar),
            ),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(height: 200),

            //Read task for platypus article
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ReadPage(model: ReadController.allReadTasks[0])),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: fiservColor,
                    fixedSize: Size(120, 35)),
                child: const Text('Read Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
