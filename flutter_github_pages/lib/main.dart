import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const buildWithFlutterURL = 'https://medium.com/@cjohnston-developer';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cameron Johnston',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _renderParticleBackground(context),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HeaderText(),
                DetailText(),
                BouncingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderParticleBackground(BuildContext context) {
    return Center(
      child: CircularParticle(
        awayRadius: 50,
        numberOfParticles: 250,
        speedOfParticles: 1.5,
        height: MediaQuery.of(context).size.height * .95,
        width: MediaQuery.of(context).size.width,
        onTapAnimation: true,
        awayAnimationDuration: Duration(milliseconds: 800),
        maxParticleSize: 15,
        isRandSize: true,
        isRandomColor: true,
        randColorList: [Colors.blue.withAlpha(210), Colors.white.withAlpha(210), Colors.grey.withAlpha(210)],
        awayAnimationCurve: Curves.easeInOutBack,
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ColorizeAnimatedTextKit(
                  text: ['Cameron Johnston'],
                  textStyle: TextStyle(
                    fontSize: 70.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Colors.blue[800],
                    Colors.blue[400],
                    Colors.blue[200],
                  ],
                ),
    );
  }
}

class DetailText extends StatefulWidget {
  @override
  _DetailTextState createState() => _DetailTextState();
}

class _DetailTextState extends State<DetailText> {
  Color currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: RotateAnimatedTextKit(
        repeatForever: true,
        text: ["Flutter Educator", "Medium Author", "Full-Stack Developer", "Freelancer"],
        textStyle: TextStyle(fontSize: 50.0, color: currentColor),
        displayFullTextOnTap: true,
        onNextBeforePause: (index, isLast) {
          List colors = [Colors.green, Color(0xFF41C4FE), Color(0xFF03599C), Colors.white];
          setState(() {
            currentColor = colors[index];
          });
        },
      ),
    );
  }
}

// Shoutout to https://github.com/flutter-devs/flutter_bouncing_button_animation_demo for most of the code below
class BouncingButton extends StatefulWidget {
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton> with SingleTickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> _buttonAnimation;

  @override
  void initState() {
    _buttonController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1500,
      ),
    );

    _buttonAnimation = Tween(begin: 0.0, end: 0.2).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeIn,
      ),
    );

    _buttonAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _buttonController.reverse();
      } else if (_buttonController.status == AnimationStatus.dismissed) {
        _buttonController.forward();
      }
    });
    _buttonController.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _buttonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _buttonAnimation,
      builder: (ctx, child) {
        return GestureDetector(
          onTap: _tapDown,
          child: Transform.scale(
            scale: 1 - _buttonAnimation.value,
            child: child,
          ),
        );
      },
      child: _animatedButton(),
    );
  }

  Widget _animatedButton() {
    return Container(
      height: 75,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800],
              Colors.blue[200],
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.mediumM,
              color: Colors.white,
            ),
          ),
          Text(
            'Follow on Medium',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _tapDown() {
    launch(buildWithFlutterURL);
  }
}
