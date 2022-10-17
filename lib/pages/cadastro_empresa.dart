import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:tcc/services/CadastroEmpresa.dart';

class SouEmpresa extends StatefulWidget {
  const SouEmpresa({Key? key}) : super(key: key);

  @override
  State<SouEmpresa> createState() => _Empresa();
}

//TODO: Colocar a URL certa e mudar o códiogo de status

Future<dynamic> submitData(String RazaoSocial, String NomeFantasia, String CNPJ, String Email, String Senha, String AtEconomica, String DtFund, String Img) async{
  var response = await http.post(Uri.https('sensor-quali.herokuapp.com', ''), 
  body: {
    "razao_social" : RazaoSocial,
    "nome_fantasia": NomeFantasia,
    "CNPJ": CNPJ,
    "email_emp": Email,
    "senha": Senha,
    "Atv_Eco": AtEconomica,
    "dtFund": DtFund,
    "imagemReserv": Img,
  });
  
  var data = response.body;
  print(data);

  if(response.statusCode == 0){
    String responseString = response.body;
    dataModelFromJson(responseString);
  }
  else {
    throw Exception('Erro inesperado...');
  }
}

class _Empresa extends State<SouEmpresa> {
  XFile? empresa;
  final _formKey = GlobalKey<FormState>();

   final TextEditingController _controllerRazao = TextEditingController();
   final TextEditingController _controllerNomeFan = TextEditingController();
   final TextEditingController _controllerCNPJ = TextEditingController();
   final TextEditingController _controllerEmail = TextEditingController();
   final TextEditingController _controllerSenha = TextEditingController();
   final TextEditingController _controllerAtvEco = TextEditingController();
   final TextEditingController _controllerDtFund = TextEditingController();
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
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controllerRazao,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.business_outlined, size: 30.0),
                          labelText: "Razão social",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                         validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value)) {
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
                        controller: _controllerNomeFan,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Nome fantasia",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value)) {
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
                    controller: _controllerCNPJ,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.wallet_rounded, size: 30.0),
                      labelText: "CNPJ",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'\d{2}.?\d{3}.?\d{3}/?\d{4}-?\d{2}').hasMatch(value)) {
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
                    }
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _controllerAtvEco,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.savings_rounded, size: 30.0),
                      labelText: "Atividade econômica",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'(^[a-zA-Z ]*$)').hasMatch(value)) {
                            return 'Campo inválido';
                          }
                          return null;
                        },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _controllerDtFund,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.cake_sharp, size: 30.0),
                      labelText: "Data de fundação",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        ),
                    ),
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[0-9]{4}-[0-9]{2}-[0-9]{2}').hasMatch(value)) {
                        return 'Campo inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
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
                      trailing: empresa != null
                          ? Image.file(File(empresa!.path))
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
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
    Enviar();
  }

  Enviar() async{

    String RazaoSocial  = _controllerRazao.text;
    String NomeFantasia = _controllerNomeFan.text;
    String CNPJ         = _controllerCNPJ.text;
    String Email        = _controllerEmail.text;
    String Senha        = _controllerSenha.text;
    String AtEconomica  = _controllerAtvEco.text;
    String DtFund       = _controllerDtFund.text;
    String Img          = _controllerImg.text;

    DataModel data = await submitData(RazaoSocial, NomeFantasia, CNPJ, Email, Senha, AtEconomica, DtFund, Img);

    setState(() {
      DataModel _dataModel = data;
    });
  }

  selecionarReserv() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => empresa = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
