import 'package:flutter/material.dart';
import 'package:imc_app/imc.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ImcApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

List calculaIMC(double valor) {
  List valores = [
    IMC(
        min: 0,
        max: 18.4,
        nombre: "Bajo Peso",
        descripcion: "Se encuentra dentro del rango de peso insuficiente",
        url: "assets/images/img1.png"),
    IMC(
        min: 18.5,
        max: 24.9,
        nombre: "Normal",
        descripcion: "Se encuentra dentro del rango de peso normal o saludable",
        url: "assets/images/img2.png"),
    IMC(
        min: 25,
        max: 29.9,
        nombre: "Sobrepeso",
        descripcion: "Se encuentra dentro del rango de sobrepeso",
        url: "assets/images/img3.png"),
    IMC(
        min: 30,
        max: 1000,
        nombre: "Obesidad",
        descripcion: "Se encuentra dentro del rango de obesidad",
        url: "assets/images/img4.png"),
  ];

  int sel = -1;
  int n = 0;
  for (IMC item in valores) {
    if (item.min <= valor && valor <= item.max) {
      sel = n;
      break;
    }
    n++;
  }

  return [valores[sel].nombre, valores[sel].descripcion, valores[sel].url];
}

class ImcApp extends StatefulWidget {
  const ImcApp({super.key});

  @override
  State<ImcApp> createState() => _ImcAppState();
}

class _ImcAppState extends State<ImcApp> {
  double altura = 0;
  double peso = 0;
  double imc = -1;
  List val = ["", "", ""];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calcular IMC"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Altura:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    altura.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "cm",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                  min: 0,
                  max: 300,
                  value: altura,
                  onChanged: (value) {
                    altura = value;
                    setState(() {});
                  }),
              Text(
                "Peso:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    peso.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "kg",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Slider(
                min: 0,
                max: 300,
                value: peso,
                onChanged: (value) {
                  peso = value;
                  setState(() {});
                },
              ),
              Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    imc = peso / (altura / 100 * altura / 100);
                    val = calculaIMC(imc);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blueAccent,
                  ),
                ),
              ),
              Text(
                imc < 0 ? '0.0' : imc.toStringAsFixed(1),
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                imc < 0 ? '' : val[0].toString(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              Text(
                imc < 0 ? '' : val[1].toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Expanded(
                child: imc < 0
                    ? Container()
                    : Image.asset(
                        val[2].toString(),
                        fit: BoxFit.scaleDown,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
