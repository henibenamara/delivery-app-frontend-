import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:livraison_front/widgets/button_widget.dart';

import 'auth/login.dart';
import 'auth/register.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [


        PageViewModel(
          title: 'Today a reader, tomorrow a leader',
          body: 'Start your journey',
          footer: Text("TEEEEEEEXT"),
          image: buildImage('assets/images/livraison1.jpg'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'Today a reader, tomorrow a leader',
          body: 'Start your journey',
          footer: Column(
            children: [
              RaisedButton(
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                color: Colors.purpleAccent,
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "S'authentifier",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(

                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.purpleAccent),

                ),
              ),
            ],
          ),
          image: buildImage('assets/images/colis.jpg'),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text('login', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: false,
      skip: Text('Skip'),
      onSkip: () => goToHome(context),
      next: Icon(Icons.arrow_forward),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Theme.of(context).backgroundColor,
      dotsFlex: 0,
      nextFlex: 0,
      //isProgressTap: true,
      // isProgress: true,
      //showNextButton: true,
      // freeze: true,
      // animationDuration: 1000,
    ),
  );

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginScreen()),
  );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Color(0xFFBDBDBD),
    activeColor: Colors.purpleAccent,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),

    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );
}