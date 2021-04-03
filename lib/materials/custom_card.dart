import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String text;

  CustomCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.CARD_COLOR,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          )),
      child: SizedBox(
        width: double.infinity,
        height: 64.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: CustomColors.PRIMARY_COLOR,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ),
    );
  }}
