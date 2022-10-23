import 'package:flutter/material.dart';
import 'package:tcc/pages/login.dart';

class red_senha extends StatelessWidget {
  const red_senha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 180,
          left: 40,
          right: 40,
        ),
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
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/logoSensor.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: const [
                Center(
                  child: Text(
                    'Redefinir senha',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'Staatliches',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: const [
                Center(
                  child: Text(
                    'Uma mensagem de redefinição de senha foi envida para seu email',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: (const EdgeInsets.only(top: 10, left: 25, right: 25)),
              height: 50,
              width: 200,
              decoration: const BoxDecoration(
                  color: Color(0xFF4065C3),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                child: const Center(
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const login()
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Não recebi o email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto Condensed',
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
