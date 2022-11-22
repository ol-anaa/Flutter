import 'package:flutter/material.dart';
import 'package:tcc/pages/menu.dart';
import 'package:url_launcher/url_launcher.dart';

//NOTE: Perguntar ao professor motivos pelo qual eu não consigo abrir o emial.

class CentralAjuda extends StatelessWidget {
  const CentralAjuda({super.key});

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
        body: SingleChildScrollView(
          child: Container(
            padding: (const EdgeInsets.all(25)),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.asset('assets/logoSensor.png'),
                ),
                Center(
                  heightFactor: 1.2,
                  child: Column(
                    children: const <Widget>[
                      Center(
                        child: Text(
                          'Central de ajuda',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 50,
                            color: Color.fromARGB(255, 110, 107, 107),
                            fontFamily: 'Staatliches',
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Este  aplicativo  encontra-se  em  período  de  desenvolvimento  e  está  suscetível  a  erros\ne  mudanças. Quaisquer  bugs,  informações incorretas ou problemas relacionados, relatar no  endereço  eletrônico.',
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
                ),
                Center(
                  heightFactor: 1.5,
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 110, 107, 107),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                        child: const Center(
                          child: Text(
                            'yarasensorqualidade@gmail.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Roboto Condensed',
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'yarasensorqualidade@gmail.com',
                            query:
                                'subject=Reportar&body=Detalhe aqui qual bug você encontrou: ',
                          );

                          var url = params.toString();
                          if (!await canLaunchUrl(params)) {
                            await launchUrl(params);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                  ),
                ),
                const Text(
                  '*Colocar no assunto: "Bugs no aplicativo"',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 110, 107, 107),
                    fontFamily: 'Roboto Condensed',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}