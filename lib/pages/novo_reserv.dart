import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tcc/pages/menu.dart';
import 'package:tcc/services/CadastroReserv.dart';

class ReservPage extends StatefulWidget {
  const ReservPage({Key? key}) : super(key: key);

  @override
  State<ReservPage> createState() => _NewReserv();
}

/*TODO: Esperar a finalização da classe "CadastroReserv.dart" para ter todos os campos corretamente 
descritos aqui, além disso, clocar o caminho correto e mudar o status de erro código. */
Future<dynamic> submitData(String NomeReserv, String CEP, String Responsavel, String Tipo, String Descricao) async{
  var response = await http.post(Uri.https('sensor-quali.herokuapp.com', ''), 
  body: {
    "" : NomeReserv,
    "": CEP,
    "": Responsavel,
    "": Tipo,
    "": Descricao,

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

class _NewReserv extends State<ReservPage> {
  XFile? reservatorio;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerCEP = TextEditingController();
  final TextEditingController _controllerResponsavel= TextEditingController();
  final TextEditingController _controllerTipo = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();

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
                        'Novo reservatório',
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
                              icon:
                                  Icon(Icons.water_damage_rounded, size: 30.0),
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
                            controller: _controllerCEP,
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: "CEP",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'(^[0-9]*$)').hasMatch(value)) {
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
                        controller: _controllerResponsavel,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle, size: 30.0),
                          labelText: "Responsável",
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
                        controller: _controllerTipo,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.water, size: 30.0),
                          labelText:
                              "Tipo ex.Cisterna, Caixa d'água residencial...",
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
                        controller: _controllerDescricao,
                        autofocus: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description, size: 30.0),
                          labelText: "Descrição",
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
                        height: 10,
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
                          onTap: novoReserv,
                          trailing: reservatorio != null
                              ? Image.file(File(reservatorio!.path))
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                        margin: (const EdgeInsets.only(left: 25, right: 25)),
                        height: 50,
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Color(0xFF4065C3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                          child: const Center(
                            child: Text(
                              'CRIAR',
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

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Enviar();
  }

  Enviar() async{
    String NomeReserv  = _controllerNome.text;
    String CEP         = _controllerCEP.text;
    String Responsavel = _controllerResponsavel.text;
    String Tipo        = _controllerTipo.text;
    String Descricao   = _controllerDescricao.text;
   

    DataModel data = await submitData(NomeReserv, CEP, Responsavel, Tipo, Descricao);
   
    setState(() {
      DataModel _dataModel = data;
    });
  }

  novoReserv() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => reservatorio = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
