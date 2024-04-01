import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int _gender = 1, _height = 170, _weight = 60, _age = 45;
double _bmi = 0.0;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _cartAndBMI(),
            _genderSelector(),
            _heightSelector(),
            _ageNweight(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _cartAndBMI() {
    return Column(
      children: [
        Image.asset(
          'images/bmi_chart.png',
        ),
        Text(
          "BMI : ${_bmi.toStringAsPrecision(3)}",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _ageNweight() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ageSelector(),
            _weightSelector(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _bmi = _weight / pow(_height / 100, 2);
              });
            },
            child: const Text(
              "Calculate",
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }

  Widget _genderSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _gender = 1;
                    });
                  },
                  icon: Icon(
                    Icons.male,
                    color: _gender == 1 ? Colors.deepPurple : Colors.black,
                    size: 50,
                  ),
                ),
                const Text("Male",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _gender = 0;
                    });
                  },
                  icon: Icon(
                    Icons.female,
                    color: _gender == 0 ? Colors.deepPurple : Colors.black,
                    size: 50,
                  ),
                ),
                const Text("Female",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _heightSelector() {
    return Card(
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${_height.toString()} cm",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              min: 1,
              max: 300,
              divisions: 300,
              value: _height.toDouble(),
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                  _bmi = 0;
                });
              },
            ),
            const Text(
              "Height",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _ageSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.deepPurple.shade100,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _age = _age - 1;
                            _bmi = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                        // enableFeedback: true,
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        child: Center(
                            child: Text(
                          _age.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                    Material(
                      color: Colors.deepPurple.shade100,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _age = _age + 1;
                            _bmi = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                        // enableFeedback: true,
                      ),
                    ),
                  ],
                ),
                const Text("Age",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _weightSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.deepPurple.shade100,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _weight = _weight - 1;
                            _bmi = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                        ),
                        // enableFeedback: true,
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        child: Center(
                            child: Text(
                          _weight.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
                    Material(
                      color: Colors.deepPurple.shade100,
                      elevation: 5,
                      borderRadius: BorderRadius.circular(25),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _weight = _weight + 1;
                            _bmi = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                        // enableFeedback: true,
                      ),
                    ),
                  ],
                ),
                const Text("Weight (kg)",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
