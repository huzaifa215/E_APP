import 'package:flutter/material.dart';
import 'package:jin_ecomm/src/view/home/HomePage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(EcommApp());
}

class EcommApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    // set the time for the splash screen
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 300.0,width: 300.0,
                child: Lottie.asset("assets/splashbackground.json"),
              ),
              SizedBox(height: 20,),
              Text("Eitox", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
            ],
           ),
      ),
    );
    // return AnimatedSplashScreen(
    //     splash:Image.asset("assets/download.png"),
    //     splashTransition: SplashTransition.fadeTransition,
    //     backgroundColor: Colors.amber,
    //     duration: 1000,
    //     nextScreen: HomePage(title: 'Login',));
  }
}


