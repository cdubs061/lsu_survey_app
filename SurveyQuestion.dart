import 'package:flutter/material.dart';
import 'package:untitled1/DataAnalysis.dart';
import 'WaitingSurvey.dart';
import 'DataAnalysis.dart';
class SurveryQuestion extends StatefulWidget
{
  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';

  @override
  State<StatefulWidget> createState() => _SurveyQuestion(
    username: username,
    age: age,
    gender: gender,
    race: race,
    levelOfEdu: levelOfEdu,);


  SurveryQuestion({
    required this.username, // Add the variables as parameters
    required this.age,
    required this.gender,
    required this.race,
    required this.levelOfEdu,
  });

}
class _SurveyQuestion extends State<SurveryQuestion> {
  String username ='';
  int age = 0;
  String gender = '';
  String race = '';
  String levelOfEdu = '';
  String thermalSensation = '';
  String thermalEnviroment = '';
  String thermalComfort = '';
  String stressedLevel = '';
  bool questionAnswered = false;

  _SurveyQuestion({
    required this.username, // Add the variables as parameters
    required this.age,
    required this.gender,
    required this.race,
    required this.levelOfEdu,
  });

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
                          thermalSensation = newValue;
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
                          thermalEnviroment = newValue;
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
                          stressedLevel = newValue;
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
                          thermalComfort = newValue;
                          checkQuestions();
                        });
                      }
                    },
                    labelText: 'Select an option',
                  ),
                ),
                Text
                  (
                  'Race: $SurveryQuestion.race',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],

            ),
          ),
        ),
        floatingActionButton: Visibility(
            visible: questionAnswered,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaitingSurvey(username: username, age: age, gender: gender, race: race, levelOfEdu: levelOfEdu, thermalComfort1: thermalComfort, thermalSensation1: thermalSensation, thermalEnviroment1: thermalEnviroment, stressedLevel1: stressedLevel)),
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
    if (thermalSensation.isNotEmpty && thermalEnviroment.isNotEmpty &&
        thermalComfort.isNotEmpty && stressedLevel.isNotEmpty) {
      setState(() {
        questionAnswered = true; // Show the button when all questions are answered
      });
    } else {
      setState(() {
        questionAnswered = false; // Hide the button if any question is not answered
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