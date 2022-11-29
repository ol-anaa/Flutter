import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tcc/pages/menu.dart';
import 'package:tcc/services/Reserv.dart';
import 'package:tcc/pages/novo_reserv.dart';

//Aqui preciso fazer o usúario que não tem um reservatório recerber uma mensagem, além de ver o itemBuider

Future<List<Reserv>> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getInt('key') ?? 0;

  var response = await http.get(
      Uri.parse("https://sensor-quali.herokuapp.com/Reservatorio/${id}"),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Reserv.fromJson(data)).toList();
  } else {
    throw Exception('Erro inesperado...');
  }
}

class consult_reserv extends StatefulWidget {
  const consult_reserv({Key? key}) : super(key: key);

  @override
  _reserv createState() => _reserv();
}

class _reserv extends State<consult_reserv> with TickerProviderStateMixin {
  late Future<List<Reserv>> futureData;

  bool showFAB = true;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: FutureBuilder<List<Reserv>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Reserv futureData = snapshot.data![index];
                    return ListTile(
                      title: Text(futureData.nome!),
                      subtitle: Text('Próxima limpeza: '+futureData.dt_prox!),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const ReservPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
