import 'survey_question.dart';
import 'package:flutter/material.dart';

class EndingPage extends StatefulWidget {
  const EndingPage({super.key});

  @override
  State<StatefulWidget> createState() => _EndingPage();
}

class _EndingPage extends State<EndingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Thank you for your participation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 160,
                height: 100,
                child: Image.network(
                  'https://1000logos.net/wp-content/uploads/2021/06/LSU-logo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SurveyQuestion())
          );
        },
        tooltip: 'Back to Homepage',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}