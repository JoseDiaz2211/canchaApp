class AgendaCanchaModel {
  int id;
  String cancha;
  DateTime fecha;
  String usuarioNombre;
  String lluviaPromedio;

  AgendaCanchaModel(
      {this.id,
      this.cancha,
      this.fecha,
      this.usuarioNombre,
      this.lluviaPromedio});

  AgendaCanchaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cancha = json['cancha'];
    fecha = DateTime.parse(json['fecha']);
    usuarioNombre = json['usuarioNombre'];
    lluviaPromedio = json['lluviaPromedio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancha'] = this.cancha;
    data['fecha'] = this.fecha.toIso8601String();
    data['usuarioNombre'] = this.usuarioNombre;
    data['lluviaPromedio'] = this.lluviaPromedio;
    return data;
  }
}
