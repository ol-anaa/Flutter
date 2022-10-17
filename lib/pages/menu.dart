import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tcc/pages/login.dart';
import 'package:tcc/pages/atiliza_perfil.dart';
import 'package:tcc/pages/consult_reserv.dart';
import 'package:tcc/pages/central_ajuda.dart';
import 'package:tcc/pages/user_page.dart';
import 'package:tcc/pages/config_wi-fi.dart';


class MenuPrincipal extends StatelessWidget {

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final Uri _url = Uri.parse('https://ol-anaa.github.io/tcc_pagesWeb/');

  @override
  Widget build(BuildContext context) {
    const name = 'AnaBia'; //Trazer nome do banco
    const BemVindo = 'Seja bem-vindo(a)!';
    const urlImage = 'https://cdn.maioresemelhores.com/imagens/mm-gatos-1-cke.jpg'; //Trazer banco
    
    return Drawer(
      child: Material(
        color: const Color.fromARGB(172, 15, 76, 190),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              texto: BemVindo,
              onCliked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UserPage(
                  name: name,
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Perfil',
                    icon: Icons.account_circle,
                    onClicked: () => selectdItem(context, 0),
                  ),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Seus reservatórios',
                    icon: Icons.compare_arrows_sharp,
                    onClicked: () => selectdItem(context, 1),
                  ),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Configuração Wi-Fi',
                    icon: Icons.wifi_password_rounded,
                    onClicked: () => selectdItem(context, 2),
                  ),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Central de ajuda',
                    icon: Icons.help_rounded,
                    onClicked: () => selectdItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Funcionamento',
                    icon: Icons.book_rounded,
                    onClicked: () => _launchUrl()
                  ),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Novidades',
                    icon: Icons.notifications,
                    onClicked: () => _launchUrl()
                  ),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Conheça o projeto',
                    icon: Icons.emoji_objects,
                    onClicked: () => _launchUrl()
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 48),
                  buildMenuItem(
                    text: 'Sair',
                    icon: Icons.exit_to_app,
                    onClicked: () => selectdItem(context, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String texto,
    required VoidCallback onCliked,
  }) =>
      InkWell(
        onTap: onCliked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    texto,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectdItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PerfilPage(),
        ));
        break;

      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const consult_reserv(),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Wifi(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CentralAjuda(),
        ));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => login(),
        ));
        break;
        
    }
  }

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
}
