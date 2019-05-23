import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'configuracao.dart';
import 'historico.dart';

class Home extends StatelessWidget {
  final int media;

  Home({this.media}) : super();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "Lembrete de beber água",
            style: TextStyle(color: Colors.white, fontFamily: 'Nunito', letterSpacing: 1.0, fontSize: 20),
          ),
          bottom: TabBar(
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Início',
                ),
                Tab(
                  text: 'Histórico',
                ),
              ]),
        ),
        body: TabBarView(
          children: [HomeContent(media: media), HistoricoPage()],
        ),
        floatingActionButton: ButtonTheme(
          minWidth: 100,
          height: 70,
          child: RaisedButton(
              shape: CircleBorder(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConfiguracaoPage()));
              },
              child: Icon(Icons.edit)),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  int media;

  HomeContent({this.media});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  FlutterLocalNotificationsPlugin notificationPlugin;
  double percentage;
  double acrecentar;
  double quantidadeDividida;
  double quantidadeIngerida = 0.0;

  @override
  void initState() {
    super.initState();

    setState(() {
      quantidadeDividida = widget.media / 12.0;
      acrecentar = quantidadeDividida * 100 / widget.media;
      percentage = 0.0;
    });

    var initialSettingsAndroid = AndroidInitializationSettings("app");
    var iosInitializationSettings = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(initialSettingsAndroid, iosInitializationSettings);

    notificationPlugin = FlutterLocalNotificationsPlugin();
    notificationPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 320,
          width: 320,
          child: CustomPaint(
            foregroundPainter: Desenhador(
                lineColor: Colors.black12,
                completeColor: Colors.lightBlueAccent[400],
                completePercent: percentage,
                width: 18,
                media: widget.media.toDouble()),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${quantidadeIngerida.round()}',
                              style: TextStyle(fontSize: 40, color: Colors.lightBlueAccent[400]),
                            ),
                            Text('/${widget.media}', style: TextStyle(fontSize: 40)),
                          ],
                        ),
                        Text(
                          'Meta diária de Bebida',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                        elevation: 2,
                        color: Colors.white,
                        shape: CircleBorder(),
                        child: Image.asset(
                          'images/copo-agua300x200.png',
                          fit: BoxFit.fill,
                          width: 100,
                        ),
                        onPressed: calculaPorcentagem),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  calculaPorcentagem() {
    setState(() {
      percentage += acrecentar;
      quantidadeIngerida += quantidadeDividida;

      if (percentage > 100) {
        percentage = 0.0;
        quantidadeIngerida = 0.0;
      }
    });
  }

  Future onSelectNotification(String payload) async {
    showDialog(context: context, builder: (_) => AlertDialog(title: Text('Beba Água')));
  }

  // TODO: notificação: ver documentação: https://github.com/MaikuB/flutter_local_notifications
  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails('TODO', 'TODO_TODO', 'alo mundo', importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await notificationPlugin.show(
      0, 'Watter', 'Beba aguá', platformChannelSpecifics, //      payload: 'Default_Sound',
    );
  }
}

class Desenhador extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  double media;

  Desenhador({this.lineColor, this.completeColor, this.completePercent, this.width, this.media});

  @override
  void paint(Canvas canvas, Size size) {
    // circulo cinza não preenxido
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    // circulo cinza de progresso completo
    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
