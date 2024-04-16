// import 'package:flutter/material.dart';

// class HomeScreen1 extends StatelessWidget {
//   const HomeScreen1({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) =>   Scaffold(
//     appBar: AppBar(
//       title: const Text('Push Notifications'),
      
//     ),
//     body: const Center(child: Text('Home Page'))
//     ElevatedButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => QuizListPage()),
//     );

//   },
//   child: Text('Quiz List'),
//   style: ElevatedButton.styleFrom(
//     minimumSize: Size(300, 50),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     textStyle: TextStyle(fontSize: 18),
//   ),
// ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:quizapp/current_location.dart';
import 'package:quizapp/simple_map_screen.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Push Notifications'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SimpleMapScreen()),
              );
            },
            child: Text('Simple Map Screen'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CurrentLocation()),
              );
            },
            child: Text('Current Location'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}
