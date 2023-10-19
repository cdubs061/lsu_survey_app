import 'package:flutter/material.dart';
import 'package:untitled1/DataAnalysis.dart';
import 'package:untitled1/main.dart';
import 'WaitingSurvey.dart';
import 'SurveyQuestion.dart';
import 'EndingPage.dart';
class SecondSurvey extends StatefulWidget {


  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';
  String thermalSensation1 = '';
  String thermalEnviroment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  SecondSurvey({
    required this.username,
    required this.age,
    required this.gender,
    required this.race,
    required this.levelOfEdu,
    required this.thermalComfort1,
    required this.thermalSensation1,
    required this.thermalEnviroment1,
    required this.stressedLevel1,
  });
  @override
  State<StatefulWidget> createState() => _SecondSurvey
    (
    username: username,
    age: age,
    gender: gender,
    race: race,
    levelOfEdu: levelOfEdu,
    thermalComfort1: thermalComfort1,
    thermalSensation1: thermalSensation1,
    thermalEnviroment1: thermalEnviroment1,
    stressedLevel1: stressedLevel1,
  );
}
class _SecondSurvey extends State<SecondSurvey> {

  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';
  String thermalSensation1 = '';
  String thermalEnviroment1 = '';
  String thermalComfort1 = '';
  String stressedLevel1 = '';

  _SecondSurvey({
  required this.username,
  required this.age,
  required this.gender,
  required this.race,
  required this.levelOfEdu,
  required this.thermalComfort1,
  required this.thermalSensation1,
  required this.thermalEnviroment1,
  required this.stressedLevel1,
  });
  bool questionAnswered1 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Survey Question'),
          backgroundColor: Colors.purple.shade900,
        ),
        body: SingleChildScrollView
          (
          child:
          Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'What is your general thermal sensation right now?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),

                //thermalsensation
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  // Adjust the padding as needed
                  child:
                  DropdownMenu(
                    items: [ 'Cold',
                      'Cool',
                      'Slightly Cool',
                      'Neutral',
                      'Slightly Warm',
                      'Warm',
                      'Hot',
                    ],
                    value: 'Neutral',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          thermalSensation1 = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                  //thermal enviroment
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Is the thermal environment acceptable to you in general right now?',
                    style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  // Adjust the padding as needed
                  child:
                  DropdownMenu(
                    items: [ 'Acceptable', 'Unacceptable',],
                    value: 'Unacceptable',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          thermalEnviroment1 = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
                //How do you assess your level of thermal comfort right now?
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'How do you assess your level of thermal comfort right now? ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  // Adjust the padding as needed
                  child:
                  DropdownMenu(
                    items: [ 'Yes', 'No', 'Preferred not to answer'],
                    value: 'Yes',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          stressedLevel1 = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
                const Text(
                  'Do you feel stressed right now?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownMenu(
                    items: [ 'Acceptable', 'Unacceptable',],
                    value: 'Unacceptable',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          thermalComfort1 = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
            Text(
              'Username: $username'
            ),
              ],

            ),
          ),
        ),
        floatingActionButton: Visibility(
            visible: questionAnswered1,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {

                DataAnalysis dataAnalysis = DataAnalysis(userName: username, userAge: age, userGender: gender, userRace: race, userEducation: levelOfEdu, thermalComfort1: thermalComfort1, thermalSensation1: thermalSensation1, thermalEnvironment1: thermalEnviroment1, stressedLevel1: stressedLevel1,thermalComfort2: thermalComfort1,thermalEnvironment2: thermalEnviroment1,thermalSensation2: thermalSensation1,stressedLevel2: stressedLevel1);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EndingPage()),
                );
              },
              tooltip: 'Answer all of the questions',
              child: const Icon(Icons.arrow_forward),
            )
        ),

      ),


    );
  }

  void checkQuestions() {
    if (thermalSensation1.isNotEmpty && thermalEnviroment1.isNotEmpty &&
        thermalComfort1.isNotEmpty && stressedLevel1.isNotEmpty) {
      setState(() {
        questionAnswered1 = true; // Show the button when all questions are answered
      });
    } else {
      setState(() {
        questionAnswered1 = false; // Hide the button if any question is not answered
      });
    }
  }
}



class DropdownMenu extends StatelessWidget {
  final List<String> items;
  final String value;
  final Function(String?) onChanged;

  final String labelText;



// Drop down Menu
  DropdownMenu({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}