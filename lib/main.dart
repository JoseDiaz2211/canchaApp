import 'package:canchaflutter/Page/Home.dart';
import 'package:canchaflutter/Provider/Provider.dart';
// import 'package:canchaflutter/Provider/Provider.dart';
import 'package:canchaflutter/Style/Style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: null, builder: (bc) => NuevaCanchaViewModel()),
        ChangeNotifierProvider(
          create: null,
          builder: (bc) => ListaCanchas(),
        ),
        ChangeNotifierProvider(create: null, builder: (bc) => CargandoEstado()),
        ChangeNotifierProvider(create: null, builder: (bc) => ClimaProvi()),
        ChangeNotifierProvider(
            create: null, builder: (bc) => MensajeDisponibilidad())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CanchaApp',
        theme: ThemeData(
          primarySwatch: colorsPrimario, //Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
