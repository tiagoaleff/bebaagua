import 'package:flutter/material.dart';

class HistoricoPage extends StatefulWidget {
  @override
  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  List<HistoricoModel> historicos = List<HistoricoModel>.generate(12, (i) => HistoricoModel(hora: "${i}:00", quantidade: '200ml'));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: historicos.length,
        itemBuilder: (context, index) {
          HistoricoModel item = historicos[index];

          return Dismissible(
            key: Key((item.hora)),
            onDismissed: (DismissDirection dir) {
              setState(() {
                historicos.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerLeft,
            ),
            secondaryBackground: Container(
              color: Colors.green,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: ListTile(
              leading: Icon(Icons.arrow_forward),
//              title: Text(item.hora),
              title: Text(historicos[index].hora),
              subtitle: Text(historicos[index].quantidade),
//              subtitle: Text(item.quantidade),
            ),
          );
        });
  }
}

class HistoricoModel {
  String hora;
  String quantidade;

  HistoricoModel({this.hora, this.quantidade});
}
