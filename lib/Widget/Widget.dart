import 'package:canchaflutter/Models/AgendaCanchaModel.dart';
import 'package:canchaflutter/Provider/Provider.dart';
import 'package:canchaflutter/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:canchaflutter/Methods/generales.dart';

class FloatAccionButton extends StatefulWidget {
  final IconData icon;
  final Function function;
  FloatAccionButton({this.icon, this.function});

  @override
  _FloatAccionButtonState createState() => _FloatAccionButtonState();
}

class _FloatAccionButtonState extends State<FloatAccionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(widget.icon),
      onPressed: widget.function,
    );
  }
}

class TitleAppbar extends StatefulWidget {
  final String title;
  TitleAppbar({@required this.title});

  @override
  _TitleAppbarState createState() => _TitleAppbarState();
}

class _TitleAppbarState extends State<TitleAppbar> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }
}

class CajaDeTexto extends StatefulWidget {
  final bool enable;
  final String plaholder;
  final TextEditingController txt;
  CajaDeTexto({this.enable = true, this.plaholder, this.txt});

  @override
  _CajaDeTextoState createState() => _CajaDeTextoState();
}

class _CajaDeTextoState extends State<CajaDeTexto> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 16,
      enabled: widget.enable,
      controller: widget.txt,
      textAlign: TextAlign.center,
      decoration: InputDecoration(hintText: widget.plaholder),
    );
  }
}

class LisTitleCancha extends StatefulWidget {
  final String label;
  final Function function;
  LisTitleCancha({this.label, this.function});
  @override
  _LisTitleCanchaState createState() => _LisTitleCanchaState();
}

class _LisTitleCanchaState extends State<LisTitleCancha> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: widget.function,
        title: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}

class ButtonSelec extends StatefulWidget {
  final String title;
  final Function function;
  ButtonSelec({this.title, this.function});

  @override
  _ButtonSelecState createState() => _ButtonSelecState();
}

class _ButtonSelecState extends State<ButtonSelec> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          color: colorsPrimario,
          onPressed: widget.function),
    );
  }
}

class ListaCanchaWidget extends StatefulWidget {
  @override
  _ListaCanchaWidgetState createState() => _ListaCanchaWidgetState();
}

class _ListaCanchaWidgetState extends State<ListaCanchaWidget> {
  
  @override
  Widget build(BuildContext context) {
    var lista = Provider.of<ListaCanchas>(context);
    var estado = Provider.of<CargandoEstado>(context);
    return lista.listaCanchas.length == 0
        ? Container(
            child: Center(
            child:
                Text(estado.estado == true ? "" : "No tiene cancha registrada"),
          ))
        : ListView.builder(
            itemCount: lista.listaCanchas.length,
            itemBuilder: (bc, index) {
              return CartaCancha(
                agendaCanchaModel: lista.listaCanchas[index],
              );
            },
          );
  }
}

class CartaCancha extends StatefulWidget {
  final AgendaCanchaModel agendaCanchaModel;
  CartaCancha({this.agendaCanchaModel});

  @override
  _CartaCanchaState createState() => _CartaCanchaState();
}

class _CartaCanchaState extends State<CartaCancha> {
  Generales generales = new Generales();
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            ListTile(
              leading: Text('Cancha: ' + widget.agendaCanchaModel.cancha),
              title: Text(
                  '${DateFormat('dd/MM/yyyy').format(widget.agendaCanchaModel.fecha.toLocal())}'),
              trailing: Text(
                widget.agendaCanchaModel.usuarioNombre,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        ExpansionTile(
          leading:  FlatButton(
                onPressed: () {
                   generales.alertaEliminarCancha(
                      context,
                      "Esta seguro que desea eliminar",
                     widget.agendaCanchaModel.id);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
        
          title: Text("Detalle"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Probabildad de lluvia: ' +
                  widget.agendaCanchaModel.lluviaPromedio +
                  '%'),
            )
          ],
        )
      ],
    ));
  }
}

class Cargando extends StatefulWidget {
  @override
  _CargandoState createState() => _CargandoState();
}

class _CargandoState extends State<Cargando> {
  @override
  Widget build(BuildContext context) {
    var estado = Provider.of<CargandoEstado>(context);
    return estado.estado == true
        ? Center(
            child: new Align(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorsPrimario)),
                ),
                color: Colors.white.withOpacity(0.8),
              ),
              alignment: FractionalOffset.center,
            ),
          )
        : Container();
  }
}
