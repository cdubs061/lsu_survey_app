import 'package:flutter/material.dart';
import 'SurveyQuestion.dart';
import 'DataAnalysis.dart';
import 'Second Survey.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSU CM Research',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold ),
        ),
    ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'LSU CM Research'),
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
  String race = '';
  String levelEducation = '';
  final ageController = TextEditingController();
  Color buttonColor = Colors.purple.shade900;

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,0),
              child: const Text(
                'Please type the first two letters of your first name and the first two letters of your last name (e.g., Robert King ---> Roki)',
                style: TextStyle(color: Colors.black,),
              ),
            ),

            SizedBox(height: 8),
            // UserName
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Age
            const Text(
              'Please Enter Your Age (between 18 and 65)',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
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
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20.0,0,0),
              child: const Text (
                'Please Select Your Gender',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

              ),
            ),
            // Gender with the Drop Down Menu
            Padding(
              padding: const EdgeInsets.all(10.0), // Adjust the padding as needed
              child:
              DropdownMenu(
                items: [ 'Male',
                  'Female',
                  'Other',
                  'Prefer not to answer',],
                value: 'Male',
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
            //Race with the drop down menu
            const Text (
              'Please Select Your Race',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0), // Adjust the padding as needed
              child:
                 DropdownMenu(
                  items: [ 'White',
                    'Hispanic/Latino',
                    'Black/African American',
                    'American Indian/Alaska Native',
                    'Asian',
                    'Native Hawaiian/ Other Pacific Islander',
                    'Other',
                    'Prefer not to answer',],
                  value: 'White',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        race = newValue;
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
                child: DropdownMenu(
                  items: [ 'No schooling completed',
                    'High school diploma (for example: GED)',
                    'Some college credit, no degree',
                    'Post-secondary Non-Degree Award',
                    'Associate degree',
                    'Bachelor’s degree',
                    'Master’s degree',
                    'Doctorate or Professional degree',],
                  value: 'No schooling completed',
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

            Text(
              'Username: $username',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Age: $age',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text
              (
              'Gender: $gender',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text
              (
              'Race: $race',
              style: Theme.of(context).textTheme.titleMedium,
            ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
          width: 160,
          height: 100,
          child: Image.network(
            'https://1000logos.net/wp-content/uploads/2021/06/LSU-logo.png',
          fit: BoxFit.fill,),
          ),
        ),
          ],
        ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {
          if(username.isNotEmpty && age >= 18 && age <= 65 && gender.isNotEmpty && race.isNotEmpty && levelEducation.isNotEmpty) {
            setState(() {
              buttonColor = Colors.green;
            });

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SurveryQuestion(username:username,age: age, gender: gender,levelOfEdu: levelEducation, race: race,)),
            );

          }
          else {
            // Show a message or handle the case where not all questions are answered
            // For example, you can show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please answer all questions before proceeding.'),
                backgroundColor: Colors.red.shade900,
              ),
            );
          }
        }
        ,
        tooltip: 'Answer all of the question',
        child: const Icon(Icons.arrow_forward),
      ),

    );

  }





}
//DropdownMenu Class
class DropdownMenu extends StatelessWidget {
  final List<String> items;
  final String value;
  final Function(String?) onChanged ;
  final String labelText;

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

