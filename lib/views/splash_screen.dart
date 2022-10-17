import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tcc/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _waterController;
  bool copAnimated = false;
  bool animateAguaText = false;

  @override
  void initState() {
    super.initState();
    _waterController = AnimationController(vsync: this);
    _waterController.addListener(() {
      if (_waterController.value > 0.98) {
        _waterController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateAguaText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _waterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(255, 47, 166, 221),
              Color.fromARGB(255, 18, 125, 175),
              Color.fromARGB(255, 20, 81, 114),
              Color.fromARGB(255, 9, 41, 58),
              Colors.black
            ],
          ),
        ),
        child: Stack(
          children: [
            // White Container top half
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: copAnimated ? screenHeight / 1.9 : screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(copAnimated ? 40.0 : 0.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: !copAnimated,
                    child: Lottie.asset(
                      'assets/app/lottie/8425-water.json',
                      controller: _waterController,
                      onLoaded: (composition) {
                        _waterController
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                  Visibility(
                    visible: copAnimated,
                    child: Image.asset(
                      'assets/logoSensor.png',
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  Center(
                    child: AnimatedOpacity(
                      opacity: animateAguaText ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        'Y A R A',
                        style: TextStyle(
                            fontSize: 80,
                            fontFamily: 'Staatliches',
                            color: Color.fromARGB(255, 20, 81, 114)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text bottom part
            Visibility(visible: copAnimated, child: const _BottomPart()),
          ],
        ),
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sensor de qualidade de água',
              style: TextStyle(
                color: Colors.white,
                fontSize: 29,
                fontFamily: 'Roboto Condensed',
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Monitoramento diário da sua água, para você nunca mais se preocupar com a limpeza de seu reservatório.',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 60.0),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const login(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 500)
                        ),
                      );
                    },
                    child: Container(
                      height: 85.0,
                      width: 85.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_up_sharp,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
