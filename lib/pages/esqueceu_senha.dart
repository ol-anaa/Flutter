import 'package:flutter/material.dart';

import 'package:tcc/pages/login.dart';

class esqSenha extends StatefulWidget {
  const esqSenha({Key? key}) : super(key: key);

  @override
  State<esqSenha> createState() => _esqSenha();
}

/*NOTE: Para onde essas dados vão? Como será feito o email de esquecimento de senha? Será um email 
realmente? Coisas a se pensar se sobrar tempo. */

class _esqSenha extends State<esqSenha> {
  final _formKey = GlobalKey<FormState>();

 final TextEditingController _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 170,
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
                    'Encontre sua conta',
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
                    'Insira seu email para procurar a sua conta',
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _controllerEmail,
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
                    height: 30,
                  ),
                  Container(
                    margin:
                        (const EdgeInsets.only(top: 10, left: 25, right: 25)),
                    height: 50,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Color(0xFF4065C3),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                      child: const Center(
                        child: Text(
                          'PESQUISAR',
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
                  Container(
                    height: 40,
                    child: TextButton(
                      child: const Text(
                        "Voltar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto Condensed',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const login()))
                      },
                    ),
                  ),
                ],
              ),
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
  }

}
