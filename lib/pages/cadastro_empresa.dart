import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:tcc/pages/login.dart';

class SouEmpresa extends StatefulWidget {
  const SouEmpresa({Key? key}) : super(key: key);

  @override
  State<SouEmpresa> createState() => _Empresa();
}

class _Empresa extends State<SouEmpresa> {
  XFile? empresa;
  final _formKey = GlobalKey<FormState>();
  late Dio _dio;
  String mensagemError = "";

  final TextEditingController _controllerRazao = TextEditingController();
  final TextEditingController _controllerNomeFan = TextEditingController();
  final TextEditingController _controllerCNPJ = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerAtvEco = TextEditingController();
  final TextEditingController _controllerDtFund = TextEditingController();
  final TextEditingController _controllerImg = TextEditingController();

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
                    keyboardType: TextInputType.datetime,
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
                          !RegExp(r'\d{2}.?\d{3}.?\d{3}/?\d{4}-?\d{2}')
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
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
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
                      }),
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
                    keyboardType: TextInputType.datetime,
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
                          !RegExp(r"^[0-9]{2}/[0-9]{2}/[0-9]{4}")
                              .hasMatch(value)) {
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
    submitEmp();
    if(mensagemError.isNotEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(mensagemError),
      ));
    }
  }

  void submitEmp() async {
    try {
      Response response = await _dio.post("/Empresa/Cadastro", data: {
        "atv_eco": _controllerAtvEco.text,
        "cnpj": _controllerCNPJ.text,
        "dtfund": _controllerDtFund.text,
        "email_emp": _controllerEmail.text,
        "imagem_emp": _controllerImg.text,
        "nome_fantasia": _controllerNomeFan.text,
        "razao_social": _controllerRazao.text,
        "senha": _controllerSenha.text,
      });

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => login(),
          ),
        );
      }
    }on DioError catch (e) {
      if (e.response != null) {
        mensagemError = e.response?.data["mensagem"] ?? "";
      }
    }
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
