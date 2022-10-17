import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.RazaoSocial,
    required this.NomeFantasia,
    required this.CNPJ,
    required this.Email,
    required this.Senha,
    required this.AtEconomica,
    required this.DtFund,
    required this.Img,
  });

  final String RazaoSocial;
  final String NomeFantasia;
  final String CNPJ;
  final String Email;
  final String Senha;
  final String AtEconomica;
  final String DtFund;
  final String Img;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    if (json['razao_social'] == null) json['razao_social'] = '';
    if (json['nome_fantasia'] == null) json['nome_fantasia'] = '';
    if (json['CNPJ'] == null) json['CNPJ'] = '';
    if (json['email_emp'] == null) json['email_emp'] = '';
    if (json['senha'] == null) json['senha'] = '';
    if (json['Atv_Eco'] == null) json['Atv_Eco'] = '';
    if (json['dtFund'] == null) json['dtFund'] = '';
    if (json['imagemReserv'] == null) json['imagemReserv'] = '';

    return DataModel(
      RazaoSocial: json["razao_social"],
      NomeFantasia: json["nome_fantasia"],
      CNPJ: json["CNPJ"],
      Email: json["email_emp"],
      Senha: json["senha"],
      AtEconomica: json["Atv_Eco"],
      DtFund: json["dtFund"],
      Img: json['imagemReserv'],
    );
  }

  Map<String, dynamic> toJson() => {
        "razao_social": RazaoSocial,
        "nome_fantasia": NomeFantasia,
        "CNPJ": CNPJ,
        "email_emp": Email,
        "senha": Senha,
        "Atv_Eco": AtEconomica,
        "dtFund": DtFund,
        "imagemReserv": Img,
      };
}
