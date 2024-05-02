import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quizapp/compassScreen.dart';
import 'package:quizapp/current_location.dart';
import 'package:quizapp/googlemapspage.dart';
import 'package:quizapp/lightsensor.dart';
import 'package:quizapp/session_timeout.dart';
import 'package:quizapp/stepcounter.dart';
import 'CalculatorView.dart';
import 'Aboutscreen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'themeprovider.dart';
import 'signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/google_signin_api.dart';
import 'NewScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contactlist.dart';
import 'Gallery.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizapp/savequiz.dart';
import 'package:quizapp/quizlist.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/user_answerList.dart';
import "package:quizapp/quizlistpage.dart";
import "package:quizapp/home.dart";
import "package:quizapp/stepcounterphone.dart";

class HomeScreen extends StatefulWidget {
  // final GoogleSignInAccount user;
  final GoogleSignInAccount? googleUser;
   final Users? user;
  HomeScreen({
    Key? key,
    this.user, this.googleUser
  }) :super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    removeToken()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  Uint8List? _selectedImageBytes;
  File ? _selectedImage;
  int _selectedIndex = 0;
  String _connectionStatus = 'Unknown';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _listenForConnectivityChanges();
    _listenForConnectivityChanges();
    _loadImage();
  }

  void _removeImage() {
  setState(() {
    _selectedImage = null;
    _selectedImageBytes = null;
  });
}

  void _loadImage() async {
  String? imagePath = await _getImagePath();
  if (imagePath != null) {
    setState(() {
      _selectedImage = File(imagePath);
    });
  }
}

  Future<void> _saveImagePath(String imagePath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('imagePath', imagePath);
}

Future<String?> _getImagePath() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('imagePath');
}

Future<void> _pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final compressedBytes = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 100,
      minWidth: 100,
      quality: 40,
    );

    // Save the new image path
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagePath = '${appDir.path}/gallery_image.jpg';
    await File(imagePath).writeAsBytes(compressedBytes);
    await _saveImagePath(imagePath);

    setState(() {
      _selectedImage = File(pickedFile.path);
      _selectedImageBytes = compressedBytes;
    });
  }
}

Future<void> _pickImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final compressedBytes = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 100,
      minWidth: 100,
      quality: 40,
    );

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String imagePath = '${appDir.path}/camera_image.jpg';
    await File(imagePath).writeAsBytes(compressedBytes);
    await _saveImagePath(imagePath);

    setState(() {
      _selectedImage = File(pickedFile.path);
      _selectedImageBytes = compressedBytes;
    });
  }
}

  Future<void> _initConnectivity() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {
      _connectionStatus = isConnected ? 'Connected' : 'Disconnected';
    });
  }

  void _listenForConnectivityChanges() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        _connectionStatus =
            status == InternetConnectionStatus.connected ? 'Connected' : 'Disconnected';
      });
      _showConnectivitySnackbar();
    });
  }

  void _showConnectivitySnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_connectionStatus),
        duration: Duration(seconds: 10),
      ),
    );
  }


@override
Widget build(BuildContext context) {
    Users? user = widget.user;
  GoogleSignInAccount? googleUser = widget.googleUser;
  return SessionTimeoutListener(
        duration: const Duration(seconds: 180),
      onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Session timed out. Please log in again.'),
            duration: Duration(seconds: 5),
            backgroundColor: Color(0xFF5271FF), 
          ),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignInScreen()));
      },
    child: Scaffold(
    appBar: AppBar(
    title: const Text('Home'),
    actions: [
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              leading: Text(widget.user != null ? 
              (widget.user!.email ?? 'No email') : 
              (widget.googleUser != null ? 
                (widget.googleUser!.email ?? 'No email') : 
                'No user')),
              title: Text('Sign Out'),
              onTap: () async {
                removeToken();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ),
          // PopupMenuItem(
          //   child: ListTile(
          //     leading: Icon(
          //       Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
          //           ? Icons.brightness_3 // Brightness icon for light theme
          //           : Icons.brightness_high, // Brightness icon for dark theme
          //     ),
          //     title: Text('Toggle Theme'), // Customize text as needed
          //     onTap: () {
          //       // Toggle theme here
          //       Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          //     },
          //   ),
          // ),
        ],
      ),
    ],
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
    ),
    
    
    
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
          ),
          child: Column(
            children: [
    Container(
    decoration: BoxDecoration(
      color: Color(0xFF5271FF),
    ),
    height: 150,
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top:10.0),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        SizedBox(height: 10), // Add some space between the text and the image
        Container(
          width: 70, 
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: _selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(35), // Half of the width or height for a circle
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                )
              : Icon(Icons.image, size: 70), // Placeholder icon if no image is selected
        ),
      ],
    ),
    ),
    
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(user: widget.user)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Calculator'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalculatorScreen(user: widget.user!)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Change Profile Picture'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryScreen(user: widget.user!)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.location_history),
                title: Text('Current Location'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CurrentLocation()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Sign In'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              ),
    
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Compass'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => compassScreen()),
                  );
                },
              ),
    
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Step Counter'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StepCounterScreen()),
                  );
                },
              ),
    
                          ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Step Counter 1'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StepCounterApp()),
                  );
                },
              ),
    
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Light Sensor'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LightSensorPage()),
                  );
                },
              ),
    
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Google Map Location'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleMapPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light
                  ? 'assets/images/HomeWhite.png'
                  : 'assets/images/HomeWhite.png', 
              fit: BoxFit.cover,
            ),
          ),
    
          Column(
            children: [
              SizedBox(height: 20),
              _connectionStatus == 'Connected'
                ? Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quiz App',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                _connectionStatus,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _connectionStatus == 'Connected'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),        
                        SizedBox(width: 20),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   // image: AssetImage('assets/images/image 2.png'),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: 70, 
                      child: Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Please connect to the internet to access this content.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
    
    
    
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Icon(Icons.home),
            backgroundColor: Color(0xFF5271FF),
          ),
        ),
        label: 'Home', // Add label for the Home item
      ),
      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Icon(Icons.calculate),
            backgroundColor: Color(0xFF5271FF),
          ),
        ),
        label: 'Calculator', // Add label for the Calculator item
      ),
      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Icon(Icons.info),
            backgroundColor: Color(0xFF5271FF),
          ),
        ),
        label: 'About', // Add label for the About item
      ),
      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Icon(Icons.contacts),
            backgroundColor: Color(0xFF5271FF),
          ),
        ),
        label: 'Contact', 
      ),
    
          BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            child: Icon(Icons.quiz),
            backgroundColor: Color(0xFF5271FF),
          ),
        ),
        label: 'Quiz', 
      ),
    ],
          selectedItemColor: Color(0xFF5271FF),
          currentIndex: _selectedIndex,
          onTap: (int index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(user: widget.user)),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorScreen(user: widget.user!)),
              );
            } else if (index == 2) {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs(user :widget.user!)),
                  );
            }
            else if (index == 3) {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactList(user :widget.user!)),
                  );
            }
            else if (index == 4) {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home(user :widget.user!)),
                  );
            }
          },
        ),
      ),
    ),
  );
}


}



  // Future _pickImageFromGallery() async {
  //   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(returnedImage == null) return;
  //   setState(() {
  //     _selectedImage = File(returnedImage.path);
  //   });
  // }

  //   Future _pickImageFromCamera() async {
  //   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if(returnedImage == null) return;
  //   setState(() {
  //     _selectedImage = File(returnedImage.path);
  //   });
  // }