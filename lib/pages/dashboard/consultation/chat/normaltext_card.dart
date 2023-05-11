import 'package:aec_medical/utils/colors.dart';
import 'package:flutter/material.dart';

class NormalTextCard extends StatefulWidget {
  const NormalTextCard({Key? key}) : super(key: key);

  @override
  _NormalTextCardState createState() => _NormalTextCardState();
}

class _NormalTextCardState extends State<NormalTextCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            color: AppColors.whitetextColor,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 10,
                    child: Text("Dr. Ajay",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 25, 5, 0),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.whitetextColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.appbarbackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(3, 3))
                            ],
                          ),
                          //child: Image.network(myCoursesData[index].image),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              "Good afternoon patient name! i am here to help you, please tell me more about your problem.",
                              style: TextStyle(fontSize: 14)),
                        ),

                        SizedBox(height: 3,),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [
                        Text("20:58",
                            style:
                            TextStyle(fontSize: 13, color: Colors.black)),
                        SizedBox(width: 5),
                        Icon(Icons.done_all, size: 17),
                      ],
                    ),
                  )
                ],
              )
          )),
    );
  }
}
