// import 'package:canchaflutter/Api/Clima.dart';
import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Methods/generales.dart';
import 'package:canchaflutter/Provider/Provider.dart';
// import 'package:canchaflutter/Page/NuevaCancha.dart';
import 'package:canchaflutter/Widget/Widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Generales generales = new Generales();
  ListaCanchas listaCanchas = new ListaCanchas();
  Sqflitedata sqflitedata = new Sqflitedata();
  @override
  void initState() {
    
    var lista = Provider.of<ListaCanchas>(context, listen: false);
    var estado = Provider.of<CargandoEstado>(context, listen: false);
    sqflitedata.listaCanchaDb().then((value) {
      estado.nuevoEstado = false;
      lista.cargaData = value;
    }).catchError((onError){
          estado.nuevoEstado =false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nuvaagenda = Provider.of<NuevaCanchaViewModel>(context);
     var mensaje = Provider.of<MensajeDisponibilidad>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          floatingActionButton: FloatAccionButton(
            icon: Icons.add,
            function: () async {
              mensaje.nuevoMensaje ="";
              nuvaagenda.nuevoCancha = generales.defaultCancha();
              
             await generales.callNuevaCancha(context);
            generales.selectHumedy(context);
            },
          ),
          appBar: AppBar(
            title: TitleAppbar(
              title: "CanchaApp",
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.calendar_today),
              )
            ],
          ),
          body: ListaCanchaWidget(),
        ),
        Cargando()
      ],
    );
  }
}
