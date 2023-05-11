import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text1;
  final String text2;
  final double width;
  final double height;
  const CustomButton({
    required this.text1,
    required this.text2,
    required this.width,
    required this.height,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(colors: [
            Color(0xffED816E),
            Color(0xffB93342),
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        height: widget.height,
        width: widget.width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(widget.text1,
                    style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Center(
                child: Text(widget.text2,
                    style: TextStyle(
                      color: AppColors.whitetextColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    )),
              ),
            ],
          ),
        ));
  }
}
