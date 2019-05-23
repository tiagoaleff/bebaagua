import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mini_curso_flutter/repositorio/Repositorio.dart';
import 'package:mini_curso_flutter/ui/configuracao.dart';
import 'package:mini_curso_flutter/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lembrete de beber água',
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();

    Repositorio.getData().then((value) {
      if (value == null || value.isEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfiguracaoPage()));
      } else {
        var decode = json.decode(value);
        var media = decode['media'];
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(media: media)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
