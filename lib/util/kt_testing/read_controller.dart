import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/kt_testing/firebase_reference.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';
import 'package:get/get.dart';

class ReadController extends GetxController {
  late ReadModel document;
  final allReadTasks =
      <ReadModel>[]; //Initalizes a collection of read tasks as an array.
  RxInt selectedIndex = RxInt(0); // Initialize with a default index of 0.

  @override
  void onReady() {
    getAllReadTasks();
    super.onReady();
  }

  Future<void> getAllReadTasks() async {
    try {
      // Saves the read documents from the read collection as a map.
      QuerySnapshot<Map<String, dynamic>> data = await readref.get();
      final readList = data.docs.map((document) {
        // Convert each document to a ReadModel.
        return ReadModel(
          id: document.id,
          title: document['title'],
          content: document['content'],
        );
      }).toList();

      // Assign the list of ReadModel objects to allReadTasks.
      allReadTasks.assignAll(readList);
    } catch (e) {
      print(e);
    }
  }

  // This method sets the selected index in the ReadController.
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}