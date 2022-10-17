class Reserv {
  String localReserv;
  String descricao;
 // String imgReserv;

  Reserv(this.localReserv, this.descricao, /*this.imgReserv*/);

Map toJson() => {'local_reserv': localReserv, 'descricao': descricao, /*'img': imgReserv*/};

factory Reserv.fromJson(dynamic json){

  if (json ['local_reserv'] == null) json ['nomeReservatorio'] = '';
  if(json ['descricao'] == null) json ['descricao'] = '';
 /* if( json ['img'] == null) json ['img'] = ''; */
  return Reserv(json['local_reserv'], json['descricao']/*,json['img']*/);

}

  @override 
  String toString(){
    return '{${this.localReserv},${this.descricao}}';
  }
}

/* ,${this.imgReserv}*/