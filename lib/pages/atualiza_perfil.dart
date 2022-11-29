import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';


import 'package:tcc/pages/menu.dart';
import 'package:tcc/services/users.dart';

Future<List<User>> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt('key') ?? 0;
  var response = await http.get(
      Uri.parse("https://sensor-quali.herokuapp.com/Usuario/${id}"),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => User.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado...');
  }
}

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PessoaAt();
}

class _PessoaAt extends State<PerfilPage> {
  late Future<List<User>> futureData;
  XFile? pessoaAt;
  late Dio _dio;

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerSobrenome = TextEditingController();
  TextEditingController _controllerDtNasc = TextEditingController();
  TextEditingController _controllerImg = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureData = fetchData();

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
            padding: const EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/logoSensor.png'),
                ),
                Column(
                  children: const [
                    Center(
                      heightFactor: 2,
                      child: Text(
                        'Atualização de dados',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 110, 107, 107),
                          fontFamily: 'Staatliches',
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<User>>(
                    future: futureData,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        List<User> data = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            _controllerNome = TextEditingController(text: data[index].nome);
                            _controllerSobrenome = TextEditingController(text:data[index].sobrenome);
                            _controllerDtNasc = TextEditingController(text: data[index].dataNasc);
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _controllerNome,
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.account_circle,
                                              size: 30.0),
                                          labelText: "Nome",
                                          labelStyle: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20,
                                          ),
                                        ),
                                        style: const TextStyle(fontSize: 20),
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
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.datetime,
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
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin:
                                      (EdgeInsets.only(left: 35, right: 35)),
                                  child: ListTile(
                                    leading: const Icon(Icons.attach_file,
                                        size: 30.0),
                                    title: const Text(
                                      "Selecione uma imagem",
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onTap: AtualizaPer,
                                    trailing: pessoaAt != null
                                        ? Image.file(File(pessoaAt!.path))
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  margin:
                                      (EdgeInsets.only(left: 25, right: 25)),
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF4065C3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: TextButton(
                                    child: Center(
                                      child: Text(
                                        'ATUALIZE!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Roboto Condensed',
                                        ),
                                      ),
                                    ),
                                    onPressed: () => AtualizaUser(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void AtualizaUser() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt('key') ?? 0;
    
    Response response = await _dio.put("/Usuario/Atualizar/${id}", data: {
      "nome": _controllerNome.text,
      "sobrenome": _controllerSobrenome.text,
      "dtnasci": _controllerDtNasc.text
    });
  }

  AtualizaPer() async {
    ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => pessoaAt = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
