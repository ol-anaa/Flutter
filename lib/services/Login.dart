import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

/*NOTE: Essa classe terá que ser revista, visto que, um usuário pessoa física ou empresa podem fazer 
login e não temos controle disso, ou seja, não tem como saber em que tabela fazer select, além disso,
os campos de email tem nomes diferentes nas duas tabelas do banco.
Temos também que pegar o id do usuário e armaznar em algum lugar nesse momento, para conseguir usar 
na hora de chamar os reservatório ou outros dados que sejam específicos so usuário. */

class DataModel {
  DataModel({
    required this.Email,
    required this.Senha,
  });

  final String Email;
  final String Senha;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    if (json['id_email'] == null) json['id_email'] = '';
    if (json['senha'] == null) json['senha'] = '';
  
    return DataModel(
      Email: json["id_email"],
      Senha: json["senha"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_email": Email,
        "senha": Senha,
  };
}