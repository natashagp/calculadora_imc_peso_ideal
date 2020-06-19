import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC e Peso Ideal",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";
  String _infoIdealMText = "";
  String _infoIdealHText = "";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _infoIdealMText = "";
      _infoIdealHText = "";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      double heightIdeal = height * 100;
      double idealM = (heightIdeal - 100) * 0.90;
      double idealH = (heightIdeal - 100) * 0.85;
      if (imc < 16) {
        _infoText = "Baixo peso muito grave (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 16 && imc <= 16.99) {
        _infoText = "Baixo peso grave (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 17 && imc <= 18.49) {
        _infoText = "Baixo peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.50 && imc <= 24.99) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc <= 29.99) {
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc <= 34.99) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc <= 39.99) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
      _infoIdealHText =
          "Peso ideal para homem ${idealH.toStringAsPrecision(3)}kg";
      _infoIdealMText =
          "Peso ideal para mulher ${idealM.toStringAsPrecision(3)}kg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC e Peso Ideal"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.help,
                color: Colors.deepOrange,
                size: 110.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle:
                        TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle:
                        TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: Colors.deepOrange,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  _infoIdealMText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                ),
              ),
              Text(
                _infoIdealHText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
