class Reserv {
  int id;
  String nome;
  int id_user;
  String local;
  String cep;
  String dt_ultima;
  String dt_prox;
  String tipo;
  String Descricao;

  Reserv(
    this.id,
    this.nome,
    this.id_user,
    this.local,
    this.cep, 
    this.dt_ultima,
    this.dt_prox,
    this.tipo, 
    this.Descricao
  );

Map toJson() => {'id': id, 'nome': nome, 'id_user': id_user, 'local': local, 'cep': cep, 'dt_ult': dt_ultima, 'dt_prox': dt_prox, 'tipo': tipo, 'descricao': Descricao};

factory Reserv.fromJson(dynamic json){

  if (json ['nome'] == null) json ['nome'] = '';
  if (json ['local'] == null) json ['local'] = '';
  if (json ['cep'] == null) json ['cep'] = '';
  if (json ['dt_ult'] == null) json ['dt_ult'] = '';
  if (json ['dt_prox'] == null) json ['dt_prox'] = '';
  if (json ['tipo'] == null) json ['tipo'] = '';
  if (json ['descricao'] == null) json ['descricao'] = '';

  return Reserv(json['id'], json['nome'],json['id_user'], json['local'],json['cep'], json['dt_ult'],json['dt_prox'], json['tipo'],json['descricao'] );

}

  @override 
  String toString(){
     return '{$this.id,$this.nome,$this.id_user,$this.local,$this.cep,$this.dt_ultima,$this.dt_prox,$this.tipo,$this.Descricao}';
  }
}