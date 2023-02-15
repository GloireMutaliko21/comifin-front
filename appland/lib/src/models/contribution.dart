class contributions {
  String? idTaxe;
  String? nomTaxe;

  contributions({this.idTaxe, this.nomTaxe});

  contributions.fromJson(Map<String, dynamic> json) {
    idTaxe = json['idTaxe'];
    nomTaxe = json['nomTaxe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTaxe'] = this.idTaxe;
    data['nomTaxe'] = this.nomTaxe;
    return data;
  }
}
