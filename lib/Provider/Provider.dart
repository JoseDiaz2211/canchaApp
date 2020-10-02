// import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Models/AgendaCanchaModel.dart';
import 'package:canchaflutter/Models/ClimaModel.dart';
import 'package:flutter/foundation.dart';

class NuevaCanchaViewModel with ChangeNotifier {
  AgendaCanchaModel _agendaCanchaModel = new AgendaCanchaModel(
      cancha: "Seleccionar Cancha",
      fecha: DateTime.now(),
      usuarioNombre: "Nombre Usuario",
      lluviaPromedio: "Promedio de lluvia");

  AgendaCanchaModel get agendaCanchaModel => _agendaCanchaModel;

  set nuevoCancha(AgendaCanchaModel cancha) {
    _agendaCanchaModel = cancha;
    notifyListeners();
  }

  set cancha(String cancha) {
    _agendaCanchaModel.cancha = cancha;
    notifyListeners();
  }

  set fecha(DateTime fecha) {
    _agendaCanchaModel.fecha = fecha;
    notifyListeners();
  }

  set lluvia(String lluvia) {
    _agendaCanchaModel.lluviaPromedio = lluvia;
    notifyListeners();
  }
}

class ListaCanchas with ChangeNotifier {
  List<AgendaCanchaModel> _listaCancha = [];

  List<AgendaCanchaModel> get listaCanchas => _listaCancha;

  set cargaData(List<AgendaCanchaModel> value) {
    _listaCancha = value;

    notifyListeners();
  }
}

class CargandoEstado with ChangeNotifier {
  bool _estado = true;

  bool get estado => _estado;
  set nuevoEstado(bool esta) {
    _estado = esta;
    notifyListeners();
  }
}

class ClimaProvi with ChangeNotifier {
  ClimaModel _climaModel = new ClimaModel();

  ClimaModel get climamodel => _climaModel;

  set nuevoClima(ClimaModel climaModel1) {
    _climaModel = climaModel1;
    notifyListeners();
  }
}

class MensajeDisponibilidad with ChangeNotifier {

  String _mesaje ="";

  String get mensaje => _mesaje;

  set nuevoMensaje(String msj){
    _mesaje = msj;
    notifyListeners();
  }
  
}