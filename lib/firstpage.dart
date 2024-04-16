import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/signin.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), // Replace with your actual background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 190, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: 'Welcome to ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Quiz App',
                              style: TextStyle(color: Color(0xFF705AFA)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20), // Adding some spacing
                      Padding(
                         padding: const EdgeInsets.only(left:130, top:10),

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignInScreen()),
                            );
                          },
                        
                          
                          child: Text('Sign In', style: TextStyle(fontSize: 20, color: Colors.white), ),
                          style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF705AFA), 
      onPrimary: Colors.white,
                            minimumSize: Size(150, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              
                            ),
                            
                            textStyle: TextStyle(fontSize: 20),
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


