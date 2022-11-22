import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tcc/pages/esqueceu_senha.dart';
import 'package:tcc/pages/cadastro_pessoa.dart';
import 'package:tcc/pages/Inicio.dart';
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  final _formKey = GlobalKey<FormState>();
  late Dio _dio;
  String mensagemError = "";

  final TextEditingController _controllerLogEmail = TextEditingController();
  final TextEditingController _controllerLogSenha = TextEditingController();

  @override
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
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 80,
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/logoSensor.png'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: const [
                          Center(
                            child: Text(
                              'Yara',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 75,
                                color: Colors.white,
                                fontFamily: 'Staatliches',
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _controllerLogEmail,
                              autofocus: true,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email_rounded, size: 30.0),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              style: const TextStyle(fontSize: 20),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return 'Campo inválido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _controllerLogSenha,
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
                            Container(
                              height: 40,
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: const Text(
                                  "Esqueceu a senha?",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Roboto Condensed'),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const esqSenha(),
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 400),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: (const EdgeInsets.only(
                                  top: 10, left: 25, right: 25)),
                              height: 50,
                              width: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4065C3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
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
                                onPressed: () => _submit(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        child: TextButton(
                          child: const Text(
                            "É novo por aqui?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto Condensed',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: const SouPessoa(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 400),
                              ),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    submitLogin();
  }

  void submitLogin() async {
    try {
      Response response = await _dio.get("/Usuario/${_controllerLogEmail.text}/${_controllerLogSenha.text}");
      Map res = response?.data;
      Map map = res["tokenUser"];
      int id = map["id_usuario"];

      final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('key', id);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Inicio(),
          ),
        );
      } 
    } 
    on DioError catch (e) {
      if (e.response != null) {
        mensagemError = e.response?.data["mensagem"] ?? "";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensagemError),
      ));
      }
    }
  }
}