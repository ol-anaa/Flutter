class User {
  int id;
  String cpf;
  String email;
  String nome;
  String sobrenome;
  String senha;
  String dataNasc;
  String img;

  User(this.id,this.cpf, this.email, this.nome, this.sobrenome, this.senha, this.dataNasc, this.img);

Map toJson() => {'id_usuario': id, 'cpf': cpf, 'email': email, 'nome': nome, 'sobrenome': sobrenome, 'senha': senha, 'dtnasci': dataNasc, 'imagem_user': img};

factory User.fromJson(dynamic json){
  
  if (json ['id'] == null) json ['id'] = 0;
  if (json ['cpf'] == null) json ['cpf'] = '';
  if (json ['email'] == null) json ['email'] = '';
  if (json ['nome'] == null) json ['nome'] = '';
  if (json ['sobrenome'] == null) json ['sobrenome'] = '';
  if (json ['senha'] == null) json ['senha'] = '';
  if (json ['dtnasci'] == null) json ['dtnasci'] = '';
  if (json ['imagem_user'] == null) json ['imagem_user'] = '';
  return User(json['id'],json['cpf'], json['email'],json['nome'], json['sobrenome'],json['senha'],json['dtnasci'],json['imagem_user']);

}

  @override 
  String toString(){
    return '{$this.id,$this.cpf,$this.email,$this.nome,$this.sobrenome,$this.senha,$this.dataNasc,$this.img}';
  }
}