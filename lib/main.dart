import 'custom_dropdown_menu.dart';
import 'survey_question.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final firstSurveyCompleted = prefs.getBool('firstSurveyCompleted') ?? false;

  runApp(MyApp(firstSurveyCompleted: firstSurveyCompleted));
}

class MyApp extends StatelessWidget {
  final bool firstSurveyCompleted;

  const MyApp({super.key, required this.firstSurveyCompleted});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSU CM Research',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold ),
        ),
    ),
      initialRoute: firstSurveyCompleted ? '/SurveyQuestion' : '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'LSU CM Research'),
        '/SurveyQuestion': (context) => const SurveyQuestion()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String username = '';
  int age = 0 ; // Default age value
  String gender = '';
  String levelEducation = '';
  final ageController = TextEditingController();
  Color buttonColor = Colors.purple.shade900;

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  Future<bool> isFirstSurveyCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstSurveyCompleted') ?? false;
  }

  Future<bool> completeFirstSurvey() async {
    Map<String, dynamic> toMap() {
      return {
        'username': username,
        'age': age,
        'gender': gender,
        'levelEducation': levelEducation,
      };
    }

    Future<File> createTempFile(String content) async {
      final String fileName = 'demographic_data_$username';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      return file.writeAsString(content);
    }

    String toCsv(Map<String, dynamic> data) {
      List<String> values = data.values.map((e) => '"$e"').toList();
      String currentDate = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
      return '$currentDate,${values.join(',')}\n';
    }

    Map<String, dynamic> map = toMap();
    String csv = toCsv(map);
    File file = await createTempFile(csv);

    var uri = Uri.parse('http://96.125.114.42:5000/upload');
    var request = http.MultipartRequest('POST', uri);

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    try {
      var response = await request.send().timeout(const Duration(seconds: 2));
      if (response.statusCode != 200) {
        return false;
      }
    } on TimeoutException catch (_) {
      // Handle timeout situation
        return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstSurveyCompleted', true);
    await prefs.setString('username', username);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView (

        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please Enter Your Name',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                child: Text(
                  'Please type the first two letters of your first name and the first two letters of your last name (e.g., Robert King ---> Roki)',
                  style: TextStyle(color: Colors.black,),
                ),
              ),

              const SizedBox(height: 8),
              // UserName
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              //Age
              const Text(
                'Please Enter Your Age (between 18 and 65)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: ageController,
                  onChanged: (value) {
                    // Handle age input and validate it
                    final enteredAge = int.tryParse(value);
                    if (enteredAge != null && enteredAge >= 18 && enteredAge <= 65) {
                      setState(() {
                        age = enteredAge;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0,20.0,0,0),
                child: Text (
                  'Please Select Your Gender',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

                ),
              ),
              // Gender with the Drop Down Menu
              Padding(
                padding: const EdgeInsets.all(10.0), // Adjust the padding as needed
                child:
                CustomDropdownMenu(
                  items: const [ 'Male',
                    'Female',
                    'Other',
                    'Prefer not to answer',],
                  value: '',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        gender = newValue;
                      });
                    }
                  },
                  labelText: 'Select an option',
                ),
              ),
              // Level of Education
                const Text(
                'Please Select Your Level of Education',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0), // Adjust the padding as needed
                  child: CustomDropdownMenu(
                    items: const [ 'No schooling completed',
                      'High school diploma (for example: GED)',
                      'Some college credit, no degree',
                      'Post-secondary Non-Degree Award',
                      'Associate degree',
                      'Bachelor’s degree',
                      'Master’s degree',
                      'Doctorate or Professional degree',],
                    value: '',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          levelEducation = newValue;
                        });
                      }
                    },
                    labelText: 'Select an option',
                  )
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
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () async {

          bool error = await completeFirstSurvey();

          if(mounted) {
            if(username.isNotEmpty && age >= 18 && age <= 65 && gender.isNotEmpty && levelEducation.isNotEmpty) { // && error) {
              setState(() {
                buttonColor = Colors.green;
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SurveyQuestion()),
              );
            } else if (username.isNotEmpty && age >= 18 && age <= 65 && gender.isNotEmpty && levelEducation.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Please connect to the LSU wi-fi. If you are connected '
                    'and still receive this error that means the server is down.'
                              'please contact Arup to get the server back up.'),
                  backgroundColor: Colors.red.shade900,
                ),
              );
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                        'Please answer all questions before proceeding.'),
                  backgroundColor: Colors.red.shade900,
                ),
              );
            }
          }
        },
        tooltip: 'Answer all of the question',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}