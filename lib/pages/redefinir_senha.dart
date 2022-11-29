import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tcc/pages/login.dart';

class red_senha extends StatefulWidget {
  const red_senha({Key? key}) : super(key: key);

  @override
  State<red_senha> createState() => _red_senha();
}

class _red_senha extends State<red_senha> {
  final _formKey = GlobalKey<FormState>();
  late Dio _dio;

  final TextEditingController _controllerSenha = TextEditingController();

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
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _controllerSenha,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                autofocus: true,
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
                onPressed: () => _submit(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    submitSenha();
  }

  void submitSenha() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('keySenha') ?? 0;

    Response response = await _dio.post("/Usuario/AlterarSenha/${id}", data: {
      "senha": _controllerSenha.text,
    });

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => login(),
        ),
      );
    }
  }
}
