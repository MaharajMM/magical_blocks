import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:magical_bricks/constants/colors.dart';
import 'package:magical_bricks/constants/image_path.dart';
import 'package:magical_bricks/screens/home/widgets/my_appbar.dart';

class PuzzleSet extends StatefulWidget {
  const PuzzleSet({super.key, required this.boxNumber, required this.imageString});
  final int boxNumber;
  final String imageString;

  @override
  State<PuzzleSet> createState() => _PuzzleSetState();
}

class _PuzzleSetState extends State<PuzzleSet> {
  int counter = 0;
  late int totalNumbers;
  //  int move = 0;
  // int boxNumber = 3;
  List<int> items = [];
  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;
  final confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    totalNumbers = (widget.boxNumber * widget.boxNumber);
    for (int i = 0; i < totalNumbers; i++) {
      items.add(i);
    }
    items.shuffle();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
    timer?.cancel();
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
      appBar: MyAppBar(size: size, imageString: widget.imageString),
      body: SafeArea(
        bottom: false,
        child: Container(
          height: size.height,
          width: size.width,
          color: kPrimaryColor,
          child: Column(
            children: [
              Padding(
                // height: size.height * 0.20,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'Sliding Puzzle',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kOnboardingPage1Color,
                        fontSize: size.height * 0.04,
                      ),
                    ),
                    Text(
                      '${widget.boxNumber} * ${widget.boxNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kOnboardingPage1Color,
                        fontSize: size.height * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.boxNumber,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return items[index] != 0
                            ? ElevatedButton(
                                onPressed: () => _slidingFunction(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kWhiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "${items[index]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // color: kOnboardingPage3Color,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            : SizedBox.shrink(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kWhiteColor, width: 3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
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

  void _slidingFunction(int index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && items[index - 1] == 0 && index % widget.boxNumber != 0 ||
        index + 1 < totalNumbers && items[index + 1] == 0 && (index + 1) % widget.boxNumber != 0 ||
        (index - widget.boxNumber >= 0 && items[index - widget.boxNumber] == 0) ||
        (index + widget.boxNumber < totalNumbers && items[index + widget.boxNumber] == 0)) {
      setState(() {
        counter++;
        items[items.indexOf(0)] = items[index];
        items[index] = 0;
      });
    }
    checkWin();
  }

  void reset() {
    setState(() {
      items.shuffle();
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
    if (isSorted(items)) {
      isActive = false;
      confettiController.play();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Dialog(
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
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  confettiController.stop();
                                  Navigator.pop(context);
                                  reset();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => PuzzleSet(
                                        boxNumber: widget.boxNumber + 1,
                                        imageString: puzzle4,
                                      ),
                                    ),
                                  );

                                  // if (widget.boxNumber == 3) {

                                  // } else {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute<void>(
                                  //       builder: (BuildContext context) => const PuzzleSet(
                                  //         boxNumber: 5,
                                  //         imageString: puzzle4,
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: const Text(
                                  "Go to next level",
                                  style: TextStyle(color: Colors.black),
                                ),
                                // color: Colors.blue,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  confettiController.stop();
                                  Navigator.pop(context);
                                  reset();
                                },
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.black),
                                ),
                                // color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: true,
              ),
            ],
          );
        },
      );
    }
  }
}
