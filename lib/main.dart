import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hydroponics',
      theme: ThemeData(
        primaryColor: Colors.green, // Change primary color to green
        fontFamily: 'Arial', // Change font family to Arial
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16.0, color: Colors.black), // Change default text style
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // Change app bar title style
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
        '/option1': (context) => Option1Screen(),
        '/option2': (context) => Option2Screen(),
      },
    );
  }
}


class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    // Get the entered username and password
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Check if the username and password are correct
    if (username == 'admin' && password == 'password') {
      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar background color to white
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 70.0,
              width: 70.0,
            ),
            SizedBox(width: 10.0), // Add spacing between the logo and heading
            Text(
              'Indoor Harvest',
              style: TextStyle(
                color: Colors.black, // Set heading color to black
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 55, 60, 61),
              Colors.white60,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 100.0),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 130.0,
                          width: 130.0,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () => login(context),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 55, 60, 61),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Color.alphaBlend(Colors.white, Colors.grey),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  void logout(BuildContext context) {
    // Perform logout logic here
    // You can reset session data, clear cached credentials, etc.

    // Navigate back to the login page
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Indoor Harvest',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Set navigation menu icon color to black
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.black, // Set logout button color to black
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 70.0,
                    width: 70.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Indoor Harvest',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Growth Parameter Regressor'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/option1');
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Nutrient Percentage Regressor'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, '/option2');
              },
            ),
          ],
        ),
      ),
body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hydroponic Harvest: Nourishing Nature for a Healthier You',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double imageWidth = constraints.maxWidth > 600 ? 300.0 : constraints.maxWidth * 0.4;

                      return Column(
                        children: [
                          PlantCard(
                            image: 'assets/images/basil.png',
                            title: 'Basil (Ocimum basilicum)',
                            name:
                                'Basil has medicinal properties and is known for its antimicrobial and antioxidant effects.',
                            imageWidth: imageWidth,
                          ),
                          PlantCard(
                            image: 'assets/images/peppermint.png',
                            title: 'Peppermint (Mentha × piperita)',
                            name: 'Peppermint is known for its calming and soothing properties.',
                            imageWidth: imageWidth,
                          ),
                          PlantCard(
                            image: 'assets/images/purpleBasil.png',
                            title: 'Dark Opal basil (Ocimum basilicum (Purpurascens))',
                            name:
                                'Act as antioxidants and have been associated with potential health benefits, such as reducing inflammation and protecting against chronic diseases.',
                            imageWidth: imageWidth,
                          ),
                          PlantCard(
                            image: 'assets/images/ginseng.png',
                            title: 'Ginseng (Panax ginseng)',
                            name: 'Ginseng has been used in traditional medicine for centuries and is known for its adaptogenic and revitalizing properties.',
                            imageWidth: imageWidth,
                          ),
                          PlantCard(
                            image: 'assets/images/lettuce.png',
                            title: 'Lettuce',
                            name: 'It is a low-calorie and nutrient-rich vegetable.',
                            imageWidth: imageWidth,
                          ),
                          PlantCard(
                            image: 'assets/images/kale.png',
                            title: 'Kale',
                            name: 'These nutrients support various bodily functions, including immune health, bone strength, and energy production.',
                            imageWidth: imageWidth,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String image;
  final String title;
  final String name;
  final double imageWidth;

  const PlantCard({
    required this.image,
    required this.title,
    required this.name,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: imageWidth, // Set the width of the image
            height: imageWidth * 1.2, // Adjust the height to your preference, maintaining the aspect ratio
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Option1Screen extends StatefulWidget {
  @override
  _Option1ScreenState createState() => _Option1ScreenState();
}

class _Option1ScreenState extends State<Option1Screen> {
  final TextEditingController _percentageController = TextEditingController();
  String? selectedNutrient;
  List<MapEntry<String, dynamic>>? resultEntries;

  List<String> availableNutrients = [
    'Nitrogen',
    'Phosphorous',
    'Potassium',
    'Calcium',
    'Magnesium',
    'Zinc',
    'Copper',
    'Molybdenum',
    'Sodium',
    'Aluminium',
    'Sulphur',
    'Iron',
    'Manganese',
    'Boron',
  ];

  Future<void> makeApiRequest(String percentage, String nutrient) async {
    final Uri apiUrl = Uri.parse('https://asia-south1-hydro-393709.cloudfunctions.net/predict');

    final headers = {'Content-Type': 'application/json'};
    final body = {
      'input_value': percentage,
      'input_x': nutrient,
    };

    try {
      final response = await http.post(apiUrl, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          resultEntries = data.entries.toList();
        });
      } else {
        setState(() {
          resultEntries = null;
        });
      }
    } catch (e) {
      setState(() {
        resultEntries = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Growth Parameter Regressor',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _percentageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Percentage',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 24.0),
              DropdownButtonFormField<String>(
                value: selectedNutrient,
                items: availableNutrients
                    .map((nutrient) => DropdownMenuItem<String>(
                          value: nutrient,
                          child: Text(
                            nutrient,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedNutrient = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nutrient',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  final percentage = _percentageController.text.trim();
                  if (percentage.isNotEmpty && selectedNutrient != null) {
                    makeApiRequest(percentage, selectedNutrient!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Predict',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              if (resultEntries != null)
                Expanded(
                  child: Scrollbar(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 25.0,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: resultEntries!.length,
                      itemBuilder: (context, index) {
                        final entry = resultEntries![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}:',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${entry.value}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}




class Option2Screen extends StatefulWidget {
  @override
  _Option2ScreenState createState() => _Option2ScreenState();
}

class _Option2ScreenState extends State<Option2Screen> {
  List<TextEditingController> _inputControllers = [];
  List<MapEntry<String, dynamic>> resultEntries = [];

  @override
  void initState() {
    super.initState();
    // Initialize the input controllers
    for (int i = 0; i < 5; i++) {
      _inputControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose the input controllers
    for (var controller in _inputControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> makeApiRequest(List<String> inputValues) async {
    final Uri apiUrl = Uri.parse('https://asia-south1-hydro-393709.cloudfunctions.net/predict');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'humidity': double.parse(inputValues[0]),
      'water_temp': double.parse(inputValues[1]),
      'ec': double.parse(inputValues[2]),
      'ph': double.parse(inputValues[3]),
      'temp': double.parse(inputValues[4]),
    };

    final http.Response response =
        await http.post(apiUrl, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        resultEntries = data.entries.toList();
      });
    } else {
      setState(() {
        resultEntries = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrient Percentage Regressor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter the 5 Values:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  String parameter;
                  switch (index) {
                    case 0:
                      parameter = 'Humidity';
                      break;
                    case 1:
                      parameter = 'Water Temperature';
                      break;
                    case 2:
                      parameter = 'pH';
                      break;
                    case 3:
                      parameter = 'Electrical Conductivity';
                      break;
                    case 4:
                      parameter = 'Temperature';
                      break;
                    default:
                      parameter = '';
                      break;
                  }
                  return TextField(
                    controller: _inputControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: parameter,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  final inputValues = _inputControllers
                      .map((controller) => controller.text.trim())
                      .toList();
                  if (inputValues.every((value) => value.isNotEmpty)) {
                    makeApiRequest(inputValues);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Predict',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              if (resultEntries.isNotEmpty)
  GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Change to 3 for three columns
      childAspectRatio: 10, // Adjust the aspect ratio for reduced spacing
    ),
    itemCount: resultEntries.length,
    itemBuilder: (context, index) {
      final entry = resultEntries[index];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${entry.key}:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '${entry.value}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      );
    },
  ),

            ],
          ),
        ),
      ),
    );
  }
}