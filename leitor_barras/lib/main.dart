import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Código de Barras',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _codigo = "";

  Future<void> _lerCodigoBarras() async {
    try {
      var lerCodigo = await FlutterBarcodeScanner.scanBarcode("Red", "Cancelar", true);
      setState(() {
        _codigo = lerCodigo;
      });
    }
    catch (e) {
      if (e.code != 0) {
        setState(() {
          _codigo = "Não foi possível ler o código!";
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Código de Barras"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Ler Código de Barras"),
              onPressed: _lerCodigoBarras,
              color: Colors.red,
            ),
            Text(
              _codigo,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
