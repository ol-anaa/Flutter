import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tcc/pages/cadastro_empresa.dart';
import 'package:tcc/services/CadastroUsuario.dart';

class SouPessoa extends StatefulWidget {
  const SouPessoa({Key? key}) : super(key: key);

  @override
  State<SouPessoa> createState() => _Pessoa();
}

//FIXME: _TypeError (type 'Null' is not a subtype of type 'DataModel'), conversar com o professor.

Future<dynamic> submitData(String Nome, String Sobrenome, String CPF, String Email, String Senha, String DtNasci, String Img) async{
  var response = await http.post(Uri.https('sensor-quali.herokuapp.com', '/api/cadastro_Usuario'), 
  body: {
    "nome" : Nome,
    "sobrenome": Sobrenome,
    "cpf": CPF,
    "email": Email,
    "senha": Senha,
    "dtnasci": DtNasci,
    "imagemusuario": Img,
  });

  var data = response.body;
  print(data);

  if(response.statusCode == 201){
    String responseString = response.body;
    dataModelFromJson(responseString);
  }
  else {
    throw Exception('Erro inesperado...');
  }
}

class _Pessoa extends State<SouPessoa> {
  XFile? pessoa;
   final _formKey = GlobalKey<FormState>();

   final TextEditingController _controllerNome = TextEditingController();
   final TextEditingController _controllerSobrenome = TextEditingController();
   final TextEditingController _controllerCpf = TextEditingController();
   final TextEditingController _controllerEmail = TextEditingController();
   final TextEditingController _controllerSenha = TextEditingController();
   final TextEditingController _controllerDtNasc = TextEditingController();
   final TextEditingController _controllerImg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
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
              width: 160,
              height: 160,
              child: Image.asset('assets/logoSensor.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: const [
                Center(
                  child: Text(
                    'Crie uma conta',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'Staatliches',
                    ),
                  ),
                )
              ],
            ),
            const Center(
              child: Text(
                "A gente promete que é rápidinho",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Roboto Condensed',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controllerNome,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle, size: 30.0),
                          labelText: "Nome",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(^[a-zA-Z]*$)').hasMatch(value)) {
                            return 'Campo inválido';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _controllerSobrenome,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Sobrenome",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(^[a-zA-Z]*$)').hasMatch(value)) {
                            return 'Campo inválido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _controllerCpf,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.co_present, size: 30.0),
                      labelText: "CPF",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$').hasMatch(value)) {
                        return 'Campo inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                    height: 5,
                  ),
                  TextFormField(
                    controller: _controllerSenha,
                    keyboardType: TextInputType.text,
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
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _controllerDtNasc,
                    autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.cake_sharp, size: 30.0),
                      labelText: "Data de nascimento",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[0-9]{4}-[0-9]{2}-[0-9]{2}").hasMatch(value)) {
                        return 'Campo inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: (const EdgeInsets.only(left: 25, right: 25)),
                    child: ListTile(
                      leading: const Icon(Icons.attach_file, size: 30.0),
                      title: const Text(
                        "Selecione uma imagem",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: selecionarReserv,
                      trailing: pessoa != null
                          ? Image.file(File(pessoa!.path))
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          'CADASTRE-SE!',
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
                    height: 15,
                  ),
                  Container(
                    height: 40,
                    child: TextButton(
                      child: const Text(
                        "Sou uma empresa",
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
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SouEmpresa()))
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

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Enviar();
  }

    Enviar() async {
    String Nome      = _controllerNome.text;
    String Sobrenome = _controllerSobrenome.text;
    String CPF       = _controllerCpf.text;
    String Senha     = _controllerSenha.text;
    String Email     = _controllerEmail.text;
    String DtNasci   = _controllerDtNasc.text;
    String Img       = _controllerImg.text;

    DataModel data = await submitData(Nome, Sobrenome, CPF, Email, Senha, DtNasci, Img
    );
    
    setState(() {
      DataModel _dataModel = data;
    });
  }

  selecionarReserv() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => pessoa = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}