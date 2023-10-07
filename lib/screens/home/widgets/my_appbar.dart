import 'package:flutter/material.dart';
import 'package:magical_bricks/constants/colors.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.size,
    required this.imageString,
  });

  final Size size;
  final String imageString;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
      backgroundColor: kPrimaryColor,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back, color: kWhiteColor),
      ),
      actions: [
        GestureDetector(
            child: Row(
          children: [
            const Text(
              "Hint",
              style: TextStyle(color: kWhiteColor, fontSize: 20),
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
                          width: widget.size.width * 0.9,
                          height: widget.size.height * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kPrimaryColor,
                          ),
                          child: Container(
                            // width: 200,
                            // height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.imageString),
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
    );
  }
}
