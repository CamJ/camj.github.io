import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularParticle(
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
              randColorList: [
                Colors.blue.withAlpha(210),
                Colors.white.withAlpha(210),
                Colors.grey.withAlpha(210)
              ],
              awayAnimationCurve: Curves.easeInOutBack,
            ),
          ],
        ),
      ),
    );
  }
}
