// import 'package:canchaflutter/Api/Clima.dart';
import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Methods/generales.dart';
import 'package:canchaflutter/Provider/Provider.dart';
import 'package:canchaflutter/Widget/Widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NuevaCancha extends StatefulWidget {
  @override
  _NuevaCanchaState createState() => _NuevaCanchaState();
}

class _NuevaCanchaState extends State<NuevaCancha> {
  Generales generales = new Generales();
  Sqflitedata sqflitedata = new Sqflitedata();
  TextEditingController txtuser = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
    var mensaje = Provider.of<MensajeDisponibilidad>(context);
    // var lista = Provider.of<ListaCanchas>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          floatingActionButton: FloatAccionButton(
            icon: Icons.done,
            function: () async {
              nuvaagenda.agendaCanchaModel.usuarioNombre = txtuser.text;
              await generales.validar(context);
            },
          ),
          appBar: AppBar(
              title: TitleAppbar(
            title: "Nueva Cancha",
          )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(children: [
              ButtonSelec(
                title: nuvaagenda.agendaCanchaModel.cancha,
                function: () {
                  generales.canchaAlerta(context);
                },
              ),
              ButtonSelec(
                title:
                    '${DateFormat('dd/MM/yyyy').format(nuvaagenda.agendaCanchaModel.fecha.toLocal())}',
                function: () async {
                  generales.selectDate(context);
                  //  selectHumedy();
                },
              ),
              CajaDeTexto(
                enable: false,
                plaholder: 'Probabildad de lluvia: ' +
                    nuvaagenda.agendaCanchaModel.lluviaPromedio +
                    '%',
              ),
              CajaDeTexto(
                enable: true,
                plaholder: nuvaagenda.agendaCanchaModel.usuarioNombre,
                txt: txtuser,
              ),
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TitleAppbar(
                    title: mensaje.mensaje == "" ? "" : mensaje.mensaje,
                  ),
                )),
              )
            ]),
          ),
        ),
        Cargando()
      ],
    );
  }
}
