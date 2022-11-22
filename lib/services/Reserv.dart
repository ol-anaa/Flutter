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

Map toJson() => {'id_reservuser': id, 'nome_reserv': nome, 'id_usuario': id_user, 'local_reserv_reserv': local, 'cep': cep, 'data_ultlimp': dt_ultima, 'data_proximp': dt_prox, 'tipo': tipo, 'descricao': Descricao};

factory Reserv.fromJson(dynamic json){

  if (json ['nome_reserv'] == null) json ['nome_reserv'] = '';
  if (json ['local_reserv'] == null) json ['local_reserv'] = '';
  if (json ['cep'] == null) json ['cep'] = '';
  if (json ['data_ultlimp'] == null) json ['data_ultlimp'] = '';
  if (json ['data_proxlimp'] == null) json ['data_proxlimp'] = '';
  if (json ['tipo'] == null) json ['tipo'] = '';
  if (json ['descricao'] == null) json ['descricao'] = '';

  return Reserv(json['id_reservuser'], json['nome_reserv'],json['id_usuario'], json['local_reserv'],json['cep'], json['data_ultlimp'],json['data_proxlimp'], json['tipo'],json['descricao'] );

}

  @override 
  String toString(){
     return '{$this.id,$this.nome,$this.id_user,$this.local,$this.cep,$this.dt_ultima,$this.dt_prox,$this.tipo,$this.Descricao}';
  }
}