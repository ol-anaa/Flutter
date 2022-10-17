import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.Nome,
    required this.Sobrenome,
    required this.CPF,
    required this.Email,
    required this.Senha,
    required this.DtNasci,
    required this.Img,
  });

  final String Nome;
  final String Sobrenome;
  final String CPF;
  final String Email;
  final String Senha;
  final String DtNasci;
  final String Img;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    if (json['nome'] == null) json['nome'] = '';
    if (json['sobrenome'] == null) json['sobrenome'] = '';
    if (json['cpf'] == null) json['cpf'] = '';
    if (json['email'] == null) json['email'] = '';
    if (json['senha'] == null) json['senha'] = '';
    if (json['dtnasci'] == null) json['dtnasci'] = '';
    if (json['imagemusuario'] == null) json['imagemusuario'] = '';

    return DataModel(
      Nome: json["nome"],
      Sobrenome: json["sobrenome"],
      CPF: json["cpf"],
      Email: json["email"],
      Senha: json["senha"],
      DtNasci: json["dtnasci"],
      Img: json['imagemusuario'],
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": Nome,
        "sobrenome": Sobrenome,
        "cpf": CPF,
        "email": Email,
        "senha": Senha,
        "dtnasci": DtNasci,
        "imagemusuario": Img,
      };
}
