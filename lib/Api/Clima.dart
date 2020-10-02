import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:canchaflutter/Methods/generales.dart';
import 'package:canchaflutter/Models/ClimaModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Generales generales = new Generales();

class ClimaApi {
  Future<ClimaModel> consultarTiempoLluvia(BuildContext context) async {
    try {
      var respuesta = await http
          .get(
            "https://api.openweathermap.org/data/2.5/forecast?q=santo domingo&appid=fa13fabed14041629b142b605228a350",
          )
          .timeout(Duration(seconds: 10));

      if (respuesta.statusCode == 200) {
        return ClimaModel.fromJson(json.decode(respuesta.body));
      } else if (respuesta.statusCode == 404) {
        generales.alertaGeneral(context, "Comunicarse con soporte");
          return null;
      } else if (respuesta.statusCode == 400) {
        generales.alertaGeneral(
            context, "Los datos suministrados son incorrectos");
              return null;
      } else if (respuesta.statusCode == 500) {
        generales.alertaGeneral(context, "Comunicarse con soporte");
          return null;
      }
    } on TimeoutException catch (e) {
      generales.alertaGeneral(context, 'Intentar mas tarde.');

      return null;
    } on SocketException catch (e) {
      generales.alertaGeneral(context, 'Verifique su internet');

      return null;
    } on Error catch (e) {
      generales.alertaGeneral(context, 'Verifique su internet');
      return null;
    }
  }
}
