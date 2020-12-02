import 'package:flutter/material.dart';
import 'package:mgs/main.dart';
import 'package:mgs/shared.dart';

class MySettings extends StatefulWidget {
  final String title;

  MySettings({Key key, this.title}) : super(key: key);

  @override
  _MySettingsState createState() => _MySettingsState(title);
}

class _MySettingsState extends State<MySettings> {
  final String title;

  _MySettingsState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text(title),
          backgroundColor: Color.fromRGBO(0, 0, 128, 1)),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(3, 0, 10, 8),
              child: Text(
                "Profil",
                style: TextStyle(fontSize: 25),
              )),
          Option("Name:", "J S", "Geben Sie ihren Namen an"),
          Option("Klasse:", "Q2c", "Geben Sie ihre Klasse an"),
          Padding(
              padding: EdgeInsets.fromLTRB(3, 20, 10, 8),
              child: Text(
                "Design",
                style: TextStyle(fontSize: 25),
              )),
          Option("Ausfälle:", "", "Wählen Sie eine Farbe"),
          Option("Vertretungen:", "",
              "Wählen Sie eine Farbe"),
          Option("Prüfungen:", "", "Wählen Sie eine Farbe für Prüfungen"),
          Option("Hausaufgaben:", "",
              "Wählen Sie eine Farbe"),
          Padding(
              padding: EdgeInsets.fromLTRB(3, 20, 10, 8),
              child: Text(
                "Kurse",
                style: TextStyle(fontSize: 25),
              )),
          Option("Wahlkurs:", "Deutsch", "Wählen Sie einen Kurs"),
          Option("Wahlkurs:", "Mathe", "Wählen Sie einen Kurs"),
          Option("Wahlkurs:", "Englisch", "Wählen Sie einen Kurs"),
        ],
      ),
    );
  }
}
