import 'package:flutter/material.dart';
import 'package:gpt_dalle/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({
    Key? key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                  fontFamily: 'Cera-Pro',
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  descriptionText,
                  style: const TextStyle(
                    fontFamily: 'Cera-Pro',
                    fontSize: 14,
                    color: Pallete.blackColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
