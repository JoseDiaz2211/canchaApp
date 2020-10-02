// import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Data/SqfliteData.dart';
import 'package:canchaflutter/Methods/generales.dart';
// import 'package:canchaflutter/Methods/generales.dart';
import 'package:flutter/material.dart';
// import 'package:canchaflutter/main.dart';

import 'package:flutter_test/flutter_test.dart';
// import 'package:path/path.dart';

void main() {
  Generales sqflitedata = new Generales();
  testWidgets("Validar selectHumedy", (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          sqflitedata
              .selectHumedy(context)
              .then((value) => {expect(value.toString(), 'error')});

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );

    // var data = await sqflitedata.validar(null);

    // expect(data.toString(), '1');
  });
}
