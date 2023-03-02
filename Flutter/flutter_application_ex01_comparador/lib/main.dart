import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _info = "informe os preços dos combustíveis.";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinalController = TextEditingController();

  void _resetFields() {
    etanolController.text = '';
    gasolinalController.text = '';
    setState(() {
      _info = "informe os preços dos combustíveis.";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double etanol = double.parse(etanolController.text);
      double gasolina = double.parse(gasolinalController.text);
      if (etanol <= (gasolina * 0.7)) {
        _info = 'Etanol é mais vantajoso';
      } else {
        _info = 'Gasolina é mais vantajoso';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Comparador de combustíveis"),
            centerTitle: true,
            backgroundColor: Colors.red,
            actions: <Widget>[
              IconButton(
                  onPressed: _resetFields, icon: const Icon(Icons.refresh))
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Icon(Icons.car_repair,
                      size: 120.0, color: Colors.black),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Etanol (BRL)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: etanolController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira o preço do Etanol!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Gasolina (BRL)",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                    controller: gasolinalController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira o preço da gasolina!";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calcular();
                        }
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                        
                      ),
                    ),
                  ),
                  Text(_info,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 25.0))
                ],
              ),
            ),
          )),
    );
  }
}