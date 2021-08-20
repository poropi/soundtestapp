import 'package:flutter/material.dart';
import 'package:soundtestapp/SeSound.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

SeSound se = SeSound();

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              // ボタン押下のタイミングで効果音を再生
              se.playSe(SeSoundIds.Button1);
              }, child: Text("Button1の効果音")),
            ElevatedButton(onPressed: (){
              se.playSe(SeSoundIds.Button2);
              }, child: Text("Button2の効果音")),
            ElevatedButton(onPressed: (){
              se.playSe(SeSoundIds.Button3);
              }, child: Text("Button3の効果音")),
            ElevatedButton(onPressed: (){
              se.playSe(SeSoundIds.Button4);
              }, child: Text("Button4の効果音")),
            ElevatedButton(onPressed: (){
              se.playSe(SeSoundIds.Button5);
              }, child: Text("Button5の効果音")),
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
