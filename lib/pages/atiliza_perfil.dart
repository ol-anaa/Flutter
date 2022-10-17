import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:tcc/pages/menu.dart';
import 'package:tcc/services/users.dart';

const String URL = "https://sensor-quali.herokuapp.com/usuario";

Future<List<User>> fetchData() async {
  var response =
      await http.get(Uri.parse(URL), headers: {"Accept": "application/json"});
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

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
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
            padding: (const EdgeInsets.all(25)),
            child: Column(children: <Widget>[
              SizedBox(
                width: 180,
                height: 180,
                child: Image.asset('assets/logoSensor.png'),
              ),
              Column(
                children: const [
                  Center(
                    heightFactor: 1.2,
                    child: Text(
                      'Atualização de dados',
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
              const SizedBox(
                height: 15,
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
                              return Row(children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    initialValue: data[index].nome,
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
                              ]);
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }),
                  ))
            ]),
          ),
        ),
      );
}

                /*
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
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
              ]);
              

              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
              SizedBox(
                height: 5,
              ),
              Container(
                margin: (EdgeInsets.only(left: 35, right: 35)),
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
                margin: (EdgeInsets.only(left: 25, right: 25)),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xFF4065C3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      );

  AtualizaPer() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => pessoaAt = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    
  }
}
*/

