import 'package:flutter/material.dart';


class PenoftSplash extends StatefulWidget {
  static const routeName = 'splashScreen';

  const PenoftSplash({super.key});

  @override
  State<PenoftSplash> createState() => _PenoftSplashState();
}

class _PenoftSplashState extends State<PenoftSplash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Text("penoftttttt"),
        ),
      ),
    );
  }
}
