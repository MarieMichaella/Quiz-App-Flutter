import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004840),
      body: Container(
        child: Column(
          children: [
        Padding(
          padding: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Row(
            children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xFFf35b32), 
                borderRadius: BorderRadius.circular(60)),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios, 
                  color: Colors.white,
                  ))),
              SizedBox(
                width: 10.0
                 ),
              Text(
                "Sports",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 22.0, 
                  fontWeight: FontWeight.bold))
          ],),
        ),
        SizedBox(height: 20.0),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height/1.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, right:20.0, top: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("images/assets/Icon.png", height: 300, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,)),
              ),
              SizedBox(height: 15.0),
                      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: 
          BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Crisitano", 
            style: TextStyle(
              color: Colors.black, 
              fontSize: 18.0, 
              fontWeight: FontWeight.w500)),

        ),
        SizedBox(height: 15.0),
         Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: 
          BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Crisitano", 
            style: TextStyle(
              color: Colors.black, 
              fontSize: 18.0, 
              fontWeight: FontWeight.w500)),

        ),

                SizedBox(height: 15.0),
         Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: 
          BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Crisitano", 
            style: TextStyle(
              color: Colors.black, 
              fontSize: 18.0, 
              fontWeight: FontWeight.w500)),

        ),

                SizedBox(height: 15.0),
         Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: 
          BoxDecoration(border: Border.all(color: Color(0xFF818181), width: 1.5), borderRadius: BorderRadius.circular(15)),
          child: Text(
            "Crisitano", 
            style: TextStyle(
              color: Colors.black, 
              fontSize: 18.0, 
              fontWeight: FontWeight.w500)),

        ),
            ],)
          ),
        ),



      ],),)
    );
  } 
}