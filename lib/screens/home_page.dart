import 'dart:async';

import 'package:flutter/material.dart';
import 'package:magical_bricks/constants/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  //  int move = 0;
  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  void _slidingFunction(int index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        counter++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      counter = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (timer == null) {
      timer = Timer.periodic(duration, (timer) {
        startTime();
      });
    } else {}

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: GestureDetector(
        //     child: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: kWhiteColor),
        //   onPressed: () {},
        // )),
        actions: [
          GestureDetector(
              child: Row(
            children: [
              const Text(
                "Hint",
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info, color: kWhiteColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        elevation: 4,
                        title: const Text('Hint:'),
                        actions: [
                          Container(
                            width: size.width * 0.9,
                            height: size.height * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kPrimaryColor,
                            ),
                            child: Container(
                              // width: 200,
                              // height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/hint_2.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          )),
        ],
        // title: Center(
        //   child: Text(
        //     'Sliding Puzzle',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       color: kOnboardingPage3Color,
        //       fontSize: size.height * 0.05,
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: size.height,
          width: size.width,
          color: kPrimaryColor,
          child: Column(
            children: [
              Container(
                height: size.height * 0.10,
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Sliding Puzzle',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kOnboardingPage1Color,
                    fontSize: size.height * 0.05,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        return numbers[index] != 0
                            ? ElevatedButton(
                                onPressed: () => _slidingFunction(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kWhiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "${numbers[index]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // color: kOnboardingPage3Color,
                                    fontSize: 30,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Moves: $counter",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kWhiteColor,
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      reset();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: kOnboardingPage3Color,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Timer: $secondsPassed",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kWhiteColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hurray!!! You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            reset();
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.black),
                          ),
                          // color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
