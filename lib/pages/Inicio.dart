import 'package:flutter/material.dart';
import 'package:tcc/pages/menu.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: MenuPrincipal(),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.mirror,
                colors: [
                  Colors.black,
                  Color.fromARGB(255, 9, 41, 58),
                  Color.fromARGB(255, 20, 81, 114),
                  Color.fromARGB(255, 18, 125, 175),
                  Color.fromARGB(255, 47, 166, 221),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: const [
            Center(
              heightFactor: 10,
              child: Text(
                'Página Principal. \n Aqui vai ficar os gráficos e afins..',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 110, 107, 107),
                  fontFamily: 'Roboto Condensed',
                ),
              ),
            ),
          ],
        ),
      );
}
