import 'package:canchaflutter/Api/Clima.dart';
import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Models/AgendaCanchaModel.dart';
// import 'package:canchaflutter/Page/Home.dart';
import 'package:canchaflutter/Page/NuevaCancha.dart';
import 'package:canchaflutter/Provider/Provider.dart';
import 'package:canchaflutter/Widget/Widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Generales {
  Sqflitedata sqflitedata = new Sqflitedata();
  ClimaApi climaApi = new ClimaApi();

  canchaAlerta(BuildContext context) {
    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
    var lista = Provider.of<ListaCanchas>(context);
    var mensaje = Provider.of<MensajeDisponibilidad>(context);
    showDialog(
        context: context,
        builder: (cb) => AlertDialog(
              title: Text(
                "Lista de Canchas",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Container(
                width: double.maxFinite,
                height: 150,
                child: ListView(
                  children: <Widget>[
                    LisTitleCancha(
                      label: 'A',
                      function: () {
                        nuvaagenda.cancha = "A";
                        var listavalida = lista.listaCanchas.where((element) =>
                            element.cancha ==
                                nuvaagenda.agendaCanchaModel.cancha &&
                            DateFormat('dd/MM/yyyy')
                                    .format(element.fecha.toLocal()) ==
                                DateFormat('dd/MM/yyyy').format(nuvaagenda
                                    .agendaCanchaModel.fecha
                                    .toLocal()));

                        if (listavalida.length >= 3) {
                          nuvaagenda.cancha = "Seleccionar Cancha";

                          mensaje.nuevoMensaje =
                              "No tiene disponibilidad para esta fecha.";
                        } else {
                          mensaje.nuevoMensaje = "Hay disponibilidad";
                        }
                        Navigator.of(cb).pop();
                      },
                    ),
                    LisTitleCancha(
                      label: 'B',
                      function: () {
                        nuvaagenda.cancha = "B";
                        var listavalida = lista.listaCanchas.where((element) =>
                            element.cancha ==
                                nuvaagenda.agendaCanchaModel.cancha &&
                            DateFormat('dd/MM/yyyy')
                                    .format(element.fecha.toLocal()) ==
                                DateFormat('dd/MM/yyyy').format(nuvaagenda
                                    .agendaCanchaModel.fecha
                                    .toLocal()));

                        if (listavalida.length >= 3) {
                          nuvaagenda.cancha = "Seleccionar Cancha";
                          mensaje.nuevoMensaje =
                              "No tiene disponibilidad para esta fecha.";
                        } else {
                          mensaje.nuevoMensaje = "Hay disponibilidad";
                        }
                        Navigator.of(cb).pop();
                      },
                    ),
                    LisTitleCancha(
                      label: 'c',
                      function: () {
                        nuvaagenda.cancha = "C";
                        var listavalida = lista.listaCanchas.where((element) =>
                            element.cancha ==
                                nuvaagenda.agendaCanchaModel.cancha &&
                            DateFormat('dd/MM/yyyy')
                                    .format(element.fecha.toLocal()) ==
                                DateFormat('dd/MM/yyyy').format(nuvaagenda
                                    .agendaCanchaModel.fecha
                                    .toLocal()));

                        if (listavalida.length >= 3) {
                          nuvaagenda.cancha = "Seleccionar Cancha";

                          mensaje.nuevoMensaje =
                              "No tiene disponibilidad para esta fecha.";
                        } else {
                          mensaje.nuevoMensaje = "Hay disponibilidad";
                        }
                        Navigator.of(cb).pop();
                      },
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(cb).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ));
  }

  alertaGeneral(BuildContext context, String msj) {
    showDialog(
        context: context,
        builder: (cb) => AlertDialog(
              title: Text(
                "Alerta",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(msj),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(cb).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ));
  }

  alertaGuardarCancha(BuildContext context, String msj) {
    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
    showDialog(
        context: context,
        builder: (cb) => AlertDialog(
              title: Text(
                "Alerta",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(msj),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      await sqflitedata
                          .nuevaCanchaDb(nuvaagenda.agendaCanchaModel);
                      nuvaagenda.nuevoCancha = defaultCancha();
                      Navigator.of(cb).pop();
                      callInicio(context);
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.of(cb).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ));
  }

  alertaEliminarCancha(BuildContext context, String msj, int id) {
    var lista = Provider.of<ListaCanchas>(context, listen: false);
    showDialog(
        context: context,
        builder: (cb) => AlertDialog(
              title: Text(
                "Alerta",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(msj),
              actions: <Widget>[
                FlatButton(
                    onPressed: () async {
                      Navigator.of(cb).pop();
                      await sqflitedata.eliminarCanchaDb(id);

                      lista.cargaData = await sqflitedata.listaCanchaDb();
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.of(cb).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ));
  }

  callNuevaCancha(BuildContext context) async {
    var clima = Provider.of<ClimaProvi>(context);
    var estado = Provider.of<CargandoEstado>(context);
    estado.nuevoEstado = true;
    clima.nuevoClima = await climaApi.consultarTiempoLluvia(context);
    estado.nuevoEstado = false;
    if (clima.climamodel != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (bc) => NuevaCancha()));
    }
  }

  callInicio(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/", (Route<dynamic> route) => false);
  }

  selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      // picked.toUtc()
      print(picked.toUtc());
      nuvaagenda.fecha = picked;
      selectHumedy(context);
    }
  }

  Future<String> selectHumedy(BuildContext context) async {
    try {
      var nuvaagenda =
          Provider.of<NuevaCanchaViewModel>(context, listen: false);

      var clima = Provider.of<ClimaProvi>(context, listen: false);

      var data = clima.climamodel.list.firstWhere(
          (element) =>
              DateFormat('dd/MM/yyyy').format(element.dtTxt.toLocal()) ==
              DateFormat('dd/MM/yyyy')
                  .format(nuvaagenda.agendaCanchaModel.fecha.toLocal()),
          orElse: () => null);
      if (data != null) {
        nuvaagenda.agendaCanchaModel.lluviaPromedio =
            data.main.humidity.toString();
        return 'bien';
      } else {
        nuvaagenda.agendaCanchaModel.fecha = DateTime.now();
        var defaultData = clima.climamodel.list.firstWhere(
            (element) =>
                DateFormat('dd/MM/yyyy').format(element.dtTxt.toLocal()) ==
                DateFormat('dd/MM/yyyy')
                    .format(nuvaagenda.agendaCanchaModel.fecha.toLocal()),
            orElse: () => null);
        nuvaagenda.agendaCanchaModel.lluviaPromedio =
            defaultData.main.humidity.toString();
        alertaGeneral(context,
            "La fecha seleccionada esta fuera del rango de probabilidad de lluvia, solo puede consultar 5 dias a partir del dia actual");
        return 'bien';
      }
    } catch (e) {
      return 'error';
    }
  }

  defaultCancha() {
    return new AgendaCanchaModel(
        cancha: "Seleccionar Cancha",
        fecha: DateTime.now(),
        usuarioNombre: "Nombre Usuario",
        lluviaPromedio: "Promedio de lluvia");
  }

  Future<String> validar(BuildContext context) async {
    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
    var lista = Provider.of<ListaCanchas>(context);
    try {
      if (nuvaagenda.agendaCanchaModel.cancha == 'Seleccionar Cancha') {
        alertaGeneral(context, "Tiene que seleccionar una camcha valida");
        return "Tiene que seleccionar una camcha valida";
      }
      if (nuvaagenda.agendaCanchaModel.lluviaPromedio.trim() == "") {
        generales.alertaGeneral(
            context, "Verifique su internet y vuelva a seleccionar la fecha.");
        return "";
      }
      if (nuvaagenda.agendaCanchaModel.usuarioNombre.trim() == "") {
        alertaGeneral(context, "Tiene que digitar un nombre de usuario");
        return "Tiene que digitar un nombre de usuario";
      }

      var listavalida = lista.listaCanchas.where((element) =>
          element.cancha == nuvaagenda.agendaCanchaModel.cancha &&
          DateFormat('dd/MM/yyyy').format(element.fecha.toLocal()) ==
              DateFormat('dd/MM/yyyy')
                  .format(nuvaagenda.agendaCanchaModel.fecha.toLocal()));

      if (listavalida.length >= 3) {
        alertaGeneral(context, "Ya tiene esta cancha 3 veces el mismo dia");
        return "Ya tiene esta cancha 3 veces el mismo dia";
      }

      alertaGuardarCancha(context, 'Esta seguro que desea guardar.');
      return "Esta seguro que desea guardar.";
    } catch (e) {
      return "Error";
    }
  }
}
