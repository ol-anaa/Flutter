import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

/*TODO: Verificar como realmente está o banco de dados, coisas que ainda temos que desenvolver,ver a 
ligação entre os campos para posteriormente conseguir fazer essa classe fncionar em perfeito estado.*/

class DataModel {
  DataModel({
    required this.NomeReserv,
    required this.CEP,
    required this.Responsavel,
    required this.Tipo,
    required this.Descricao,
  });

  final String NomeReserv;
  final String CEP;
  final String Responsavel;
  final String Tipo;
  final String Descricao;


  factory DataModel.fromJson(Map<String, dynamic> json) {
    if (json[''] == null) json[''] = '';
    if (json[''] == null) json[''] = '';
    if (json[''] == null) json[''] = '';
    if (json[''] == null) json[''] = '';
    if (json['descricao'] == null) json['descricao'] = '';
   
    return DataModel(
      NomeReserv: json[""],
      CEP: json[""],
      Responsavel: json[""],
      Tipo: json[""],
      Descricao: json["descricao"],
    );
  }

  Map<String, dynamic> toJson() => {
        "": NomeReserv,
        "": CEP,
        "": Responsavel,
        "": Tipo,
        "descricao": Descricao,
      };
}
