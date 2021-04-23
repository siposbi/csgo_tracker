import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:flutter/material.dart';

class StatisticsPageCard extends StatelessWidget {
  final String title;
  final String text;

  StatisticsPageCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: CustomColors.CARD_COLOR,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  title,
                  style: TextStyle(
                    color: CustomColors.PRIMARY_COLOR,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
