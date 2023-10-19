import 'package:flutter/material.dart';
import 'main.dart';
class EndingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EndingPage();
}

class _EndingPage extends State<EndingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
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
              child: Container(
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
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        tooltip: 'Back to Homepage',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}