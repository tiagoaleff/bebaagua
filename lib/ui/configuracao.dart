import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_curso_flutter/repositorio/Repositorio.dart';

import 'home.dart';

class ConfiguracaoPage extends StatefulWidget {
  @override
  _ConfiguracaoPageState createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  final TextEditingController pesoCtrl = TextEditingController();
  final TextEditingController idadeCtrl = TextEditingController();

  Future<int> _saveData() async {
//    Adultos	Quantidade de água por kg
//    Jovem ativo até os 17 anos	40 ml por cada kg
//    18 a 55 anos	35 ml por cada kg
//    55 a 65 anos	30 ml por cada kg
//    Mais de 65 anos	25 ml  por cada kg
    int peso = int.parse(pesoCtrl.text);
    int idade = int.parse(idadeCtrl.text);
    int media = 0;

    if (idade < 18) {
      media = peso * 40;
    } else if (idade < 56) {
      media = peso * 35;
    } else if (idade < 66) {
      media = peso * 30;
    } else {
      media = peso * 35;
    }

    await Repositorio.saveData(media);
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro dados básicos'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: _buildTextField('Idade:', idadeCtrl),
            ),
            _buildTextField('Peso:', pesoCtrl),
            Container(
              width: 250,
              child: RaisedButton(
                color: Colors.lightBlue,
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  var media = await _saveData();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(media: media)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildTextField(String label, TextEditingController ctrl) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black26),
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.black26,
      fontSize: 25.0,
    ),
    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
    maxLength: 3,
    controller: ctrl,
  );
}
