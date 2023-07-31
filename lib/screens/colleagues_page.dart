import 'package:flutter/material.dart';
import 'colleagues.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ColleaguesPage extends StatefulWidget {
  const ColleaguesPage({Key? key}) : super(key: key);

  @override
  _ColleaguesPageState createState() => _ColleaguesPageState();
}

class _ColleaguesPageState extends State<ColleaguesPage> {
  List<Colleagues> colleagues = [
    Colleagues(
      name: 'IT Support',
      position: 'Help Desk',
      phoneNumber: '1111111111',
      email: 'FiservHelp@gmail.com',
      hobbies: 'Helping',
    ),
    Colleagues(
      name: 'Emily Smith',
      position: 'Manager',
      phoneNumber: '1234567890',
      email: 'emilysmith@gmail.com',
      hobbies: 'Fishing',
    ),
    Colleagues(
      name: 'Jane Kim',
      position: 'Developer',
      phoneNumber: '9876543210',
      email: 'janekim@gmail.com',
      hobbies: 'Cooking',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Colleagues List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: colleagues.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      // Add the profile icon here
                      backgroundImage: AssetImage('assets/userIcon.png'),
                      backgroundColor: Color(0xFFFF6600),
                    ),
                    title: Text(colleagues[index].name),
                    onTap: () {
                      _showColleagueDetails(colleagues[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showColleagueDetails(Colleagues colleague) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Colleague Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: ${colleague.name}'),
                Text('Position: ${colleague.position}'),
                Row(
                  children: [
                    const Text('Phone Number: '),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: colleague.phoneNumber,
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchPhoneNumber(colleague.phoneNumber);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Email: '),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: colleague.email,
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchEmail(colleague.email);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text('Hobbies: ${colleague.hobbies}'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _launchPhoneNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    final String phoneUrl = phoneUri.toString();

    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    final String emailUrl = emailUri.toString();

    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}