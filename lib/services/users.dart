class User {
  String nome;
  String sobrenome;
  String img;
  String cpf;
  String email;
  String dataNasc;

  User(this.nome, this.sobrenome, this.img, this.cpf, this.email, this.dataNasc);

Map toJson() => {'nome': nome, 'sobrenome': sobrenome, 'imagemreserv': img, 'cpf': cpf, 'id_email': email, 'dtnasci': dataNasc};

factory User.fromJson(dynamic json){

  if (json ['nome'] == null) json ['nome'] = '';
  if (json ['sobrenome'] == null) json ['sobrenome'] = '';
  if (json ['imagemreserv'] == null) json ['imagemreserv'] = '';
  if (json ['cpf'] == null) json ['cpf'] = '';
  if (json ['id_email'] == null) json ['id_email'] = '';
  if (json ['dtnasci'] == null) json ['dtnasci'] = '';
  return User(json['nome'], json['sobrenome'], json['imagemreserv'], json['cpf'], json['id_email'], json['dtnasci']);

}

  @override 
  String toString(){
    return '{${this.nome},${this.sobrenome},${this.img}${this.cpf},${this.email},${this.dataNasc}}';
  }
}