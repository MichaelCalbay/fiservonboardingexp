import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String taskCategory;

  const ProgressBar({Key? key, required this.taskCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(taskCategory) // Use title as the document ID
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data available for $taskCategory');
        }

        // Accesses the document data directly
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        // Creates a TaskCategoryModel using the retrieved data
        TaskCategoryModel category = TaskCategoryModel(
          id: taskCategory, // Use title as the ID
          title: data['title'],
          curPoints: data['curPoints'],
          maxPoints: data['maxPoints'],
        );

        final double progressPercentage =
            (category.curPoints / category.maxPoints);

        // Displays the progress indicator
        return Container(
          // child: Column(
          //   children: [
          //     Text(
          //       '${category.curPoints} / ${category.maxPoints}',
          //       style: TextStyle(
          //         color: selectedTheme.colorScheme.primary,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     const SizedBox(height: 3),
          //     SizedBox(
          //       width: 80,
          //       height: 10,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(5),
          //         child: LinearProgressIndicator(
          //           value: progressPercentage,
          //           valueColor: AlwaysStoppedAnimation<Color>(
          //             selectedTheme.colorScheme.primary,
          //           ),
          //           backgroundColor: selectedTheme.colorScheme.surface,
          //         ),
          //       ),
          //     ),

          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1.15,
                child: CircularProgressIndicator(
                  value: progressPercentage,
                  strokeWidth: 4.0,
                  color: selectedTheme.colorScheme.primary,
                  backgroundColor: selectedTheme.colorScheme.surface,
                ),
              ),
              Text(
                '${category.curPoints} / ${category.maxPoints}',
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
