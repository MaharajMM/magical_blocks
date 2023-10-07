import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magical_bricks/constants/colors.dart';
import 'package:magical_bricks/constants/image_path.dart';
import 'package:magical_bricks/screens/puzzle_set/view/puzzle_set.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.65,
                      child: Text(
                        'Find your favourite games',
                        style: GoogleFonts.poppins(
                          // overflow: TextOverflow.clip,
                          textStyle: const TextStyle(overflow: TextOverflow.clip),
                          fontWeight: FontWeight.bold,
                          color: kOnboardingPage1Color,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 42,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(avatar),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.18, // Adjust the position
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PuzzleContainer(
                      size: size,
                      text: '3 * 3',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const PuzzleSet(
                              boxNumber: 3,
                              imageString: puzzle3,
                            ),
                          ),
                        );
                      },
                    ),
                    PuzzleContainer(
                      size: size,
                      text: '4 * 4',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const PuzzleSet(
                              boxNumber: 4,
                              imageString: puzzle4,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // SingleChildScrollView(
              //   child: Container(
              //       // margin: const EdgeInsets.all(12),
              //       padding: const EdgeInsets.all(20),
              //       height: size.height * 0.6,
              //       child:

              // GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 20,
              //     mainAxisSpacing: 12,
              //   ),
              //   itemCount: 2,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         color: Colors.green.shade500,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Center(
              //           child: Text(
              //         '3 * 3',
              //         style: GoogleFonts.poppins(
              //           // overflow: TextOverflow.clip,
              //           textStyle: const TextStyle(overflow: TextOverflow.clip),
              //           fontWeight: FontWeight.bold,
              //           color: kOnboardingPage1Color,
              //           fontSize: 32,
              //         ),
              //       )),
              //     );
              //   },
              // ),
              //       ),
              // ),
            ),
          ],
        ),
      )),
    );
  }
}

class PuzzleContainer extends StatelessWidget {
  const PuzzleContainer({
    super.key,
    required this.size,
    required this.text,
    required this.onTap,
  });

  final Size size;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.20,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.green.shade500,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.poppins(
            // overflow: TextOverflow.clip,
            textStyle: const TextStyle(overflow: TextOverflow.clip),
            fontWeight: FontWeight.bold,
            color: kOnboardingPage1Color,
            fontSize: 32,
          ),
        )),
      ),
    );
  }
}
