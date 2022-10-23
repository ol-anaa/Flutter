import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:tcc/pages/menu.dart';

class Wifi extends StatefulWidget {
  const Wifi({Key? key}) : super(key: key);

  @override
  State<Wifi> createState() => _ConfigWiFi();
}

class _ConfigWiFi extends State<Wifi> {
  final _formKey = GlobalKey<FormState>();
  late Dio _dio;

  final TextEditingController _controllerWiFi = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  void initState() {
    super.initState();

    BaseOptions options = new BaseOptions(
      baseUrl: "https://sensor-quali.herokuapp.com",
      connectTimeout: 5000,
    );

    _dio = new Dio(options);
  }

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
            padding: (const EdgeInsets.all(20)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 180,
                  child: Image.asset('assets/logoSensor.png'),
                ),
                Column(
                  children: const [
                    Center(
                      heightFactor: 1.5,
                      child: Text(
                        'Configurações Wi-fi',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 110, 107, 107),
                          fontFamily: 'Staatliches',
                        ),
                      ),
                    )
                  ],
                ),
                const Center(
                  child: Text(
                    'Devido ao fato de o sensor de qualidade necessitar de acesso a internet, é preciso configurar seu aplicativo e conecta-lo a sua rede Wi-fi. ',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 110, 107, 107),
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _controllerWiFi,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.wifi_find_sharp, size: 30.0),
                          labelText: "Rede",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _controllerSenha,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.vpn_key, size: 30.0),
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: (const EdgeInsets.only(
                            top: 10, left: 25, right: 25)),
                        height: 50,
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Color(0xFF4065C3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                          child: const Center(
                            child: Text(
                              'ENVIAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Roboto Condensed',
                              ),
                            ),
                          ),
                          onPressed: () => _submit(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

    void submitWifi() async {
    Response response = await _dio.post("/ /", data: {
      "": _controllerWiFi.text,
      "": _controllerSenha,
    });
   }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    submitWifi();
  }
}
