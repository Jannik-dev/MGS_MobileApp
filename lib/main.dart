import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mgs/shared.dart';
import 'package:mgs/list.dart';
import 'package:mgs/settings.dart';

void main() => runApp(MGS());

Color navi = Color.fromRGBO(0, 0, 128, 1);

class MGS extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      home: MyHomePage(title: 'MGS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> courses = getCourses();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: getDrawer(context),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: navi),
      body: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Q2c", style: TextStyle(fontSize: 25)),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 7.75, right: 15),
                    child: Text(
                      DateTime.now().day.toString() +
                          "/" +
                          DateTime.now().month.toString() +
                          "/" +
                          DateTime.now().year.toString(),
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            )),
        Expanded(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, i) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: courses[i]);
            },
          ),
        )
      ]),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MySettings(title: "Einstellungen");
  }
}

List<String> courses = <String>[
  'Mathe',
  'Deutsch',
  'Physik',
  'Geschichte',
  'WiPo',
  'Englisch',
  'Sport',
];

class Option extends StatefulWidget {
  String title, value, dialogTitle;
  Option(this.title, this.value, this.dialogTitle);

  @override
  _OptionState createState() => _OptionState(title, value, dialogTitle);
}

class _OptionState extends State<Option> {
  String title, value, dialogTitle;
  _OptionState(this.title, this.value, this.dialogTitle);

  String convert(Color color){
    Map<String, int> map = {
      'red': color.red,
      'green': color.green,
      'blue': color.blue,
    };
    return jsonEncode(map);
  }

  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/data.json');
  }

  Future<File> write(String json) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(json);
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[600]),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      color: (identifier[title] != null) ? identifier[title] : Colors.white,
      child: ListTile(
          leading: Container(
              width: 95,
              child: Padding(
                  padding: EdgeInsets.only(top: 3.75),
                  child: Text(title, style: TextStyle(color: Colors.grey[600])))),
          title: Text(value),
          trailing: IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () {
              if (dialogTitle.startsWith("Wählen Sie eine Farbe")) {
                Color tempValue;
                showMaterialPalettePicker(
                  headerColor: navi,
                  context: context,
                  title: dialogTitle,
                  selectedColor: identifier[title],
                  onChanged: (inputValue) => tempValue = inputValue,
                  onConfirmed: () => setState(() {
                    identifier.update(title, (value) => tempValue);

                    String json = "[";
                    identifier.forEach((key, value) => json += '{"title":"' + key + '",' + convert(value).substring(1) + ",");

                    json = json.substring(0, json.length - 1);
                    json += "]";

                    write(json);

                    //read().then((String result) {
                      //Map<String, dynamic> map = jsonDecode(result);
                      //map.forEach((key, value) { print(value.toString()); });
                    //});
                  }),
                );
              }

              if (dialogTitle.startsWith("Wählen Sie einen Kurs")) {
                String tempValue;
                showMaterialRadioPicker(
                  headerColor: navi,
                  context: context,
                  title: dialogTitle,
                  items: courses,
                  selectedItem: value,
                  onChanged: (String inputValue) => tempValue = inputValue,
                  onConfirmed: () => setState(() => value = tempValue),
                );
              }

              if (dialogTitle.startsWith("Geben Sie")) {
                String tempValue;
                showMaterialResponsiveDialog(
                  headerColor: navi,
                  context: context,
                  title: dialogTitle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      autofocus: true,
                      decoration:
                          InputDecoration(labelText: title, hintText: dialogTitle.startsWith("Geben Sie ihren Namen") ? "Max Mustermann" : "8c"),
                      onChanged: (inputValue) => tempValue = inputValue,
                    ),
                  ),
                  onConfirmed: () => setState(() {
                    if (tempValue != null) {
                      value = tempValue;
                    }
                  }),
                );
              }
            },
          )),
    );
  }
}

var identifier = {
  "Vertretungen:": Colors.green[300],
  "Prüfungen:": Colors.yellow[300],
  "Ausfälle:": Colors.red[300],
  "Hausaufgaben:": Colors.blue[300]
};

List<PersonalColor> colors = <PersonalColor>[
  //new PersonalColor("Vertretungen:", red, green, blue),
  //new PersonalColor("Prüfungen:", red, green, blue),
  //new PersonalColor("Ausfälle:", red, green, blue),
  //new PersonalColor("Hausaufgaben:", red, green, blue)
];

class PersonalColor{
  PersonalColor(this.title, this.red, this.green, this.blue);

  final String title;
  final int red, green, blue;
}

class Course extends StatefulWidget {
  final int lessonNumber;
  final String courseName, teacherName, roomName;
  final bool isChanged, isTest, isCancelled, isHomework;

  const Course(
      this.lessonNumber,
      this.courseName,
      this.teacherName,
      this.roomName,
      this.isChanged,
      this.isTest,
      this.isCancelled,
      this.isHomework);

  @override
  _CourseState createState() => _CourseState(lessonNumber, courseName,
      teacherName, roomName, isChanged, isTest, isCancelled, isHomework);
}

class _CourseState extends State<Course> {
  var lessonNumber,
      courseName,
      teacherName,
      roomName,
      isChanged,
      isTest,
      isCancelled,
      isHomework;

  _CourseState(
      this.lessonNumber,
      this.courseName,
      this.teacherName,
      this.roomName,
      this.isChanged,
      this.isTest,
      this.isCancelled,
      this.isHomework);

  double height = 64;
  bool isVisible = false;
  bool isExpandable = true;
  String teacherNameGenitive;

  void addInfo() {
    setState(() {
      isVisible = !isVisible;

      isVisible ? height = 115 : height = 64;
    });
  }

  @override
  Widget build(BuildContext context) {
    List temp = teacherName.split(" ");
    temp[0] == "Herr"
        ? teacherNameGenitive = "Herrn " + temp[1]
        : teacherNameGenitive = teacherName;

    String info = courseName +
        " wird von " +
        teacherNameGenitive +
        " im Raum " +
        roomName +
        " unterrichtet.";

    Color backgroundColor = Colors.white;

    if (isChanged) backgroundColor = identifier["Vertretungen:"];

    if (isTest) {
      backgroundColor = identifier["Prüfungen:"];
      info += " Es gibt Hausaufgaben zu dieser Stunde.";
    }

    if (isHomework) {
      backgroundColor = identifier["Hausaufgaben:"];
      info += " Es gibt Hausaufgaben zu dieser Stunde.";
    }

    if (isCancelled) backgroundColor = identifier["Ausfälle:"];

    return GestureDetector(
        child: Container(
          // default is 64
          height: height,
          child: Card(
            child: Column(children: <Widget>[
              ListTile(
                leading: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(lessonNumber.toString() + ".")),
                title: Text(!isCancelled
                    ? courseName + " /" + teacherName
                    : "fällt aus"),
                trailing: Text(!isCancelled ? "[" + roomName + "]" : " "),
              ),
              Visibility(
                visible: isVisible,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(info),
                ),
              ),
            ]),
            color: backgroundColor,
            shape: RoundedRectangleBorder(
                //side: BorderSide(color: backgroundColor),
                borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            )),
          ),
        ),
        onTap: () {
          if (!isCancelled) {
            addInfo();
          }
        });
  }
}
