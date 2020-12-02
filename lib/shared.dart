import 'package:flutter/material.dart';

import 'package:mgs/main.dart';
import 'package:mgs/settings.dart';

Widget getDrawer(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          //child: Text('Drawer Header'),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 128, 1)
          ),
        ),
        ListTile(
          title: Text("Studenplan", style: TextStyle(fontSize: 25)),
          onTap: () {
            // Update the state of the app.
            // ...
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pop(context);
            /*Navigator.push<Widget>(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) =>
                    MyHomePage(title: "Stundenplan"))
            );*/
          },
        ),
        ListTile(
          title: Text("Einstellungen", style: TextStyle(fontSize: 25)),
          trailing: Icon(Icons.settings),
          onTap: () {
            // Update the state of the app.
            // ...
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.push<Widget>(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) =>
                    MySettings(title: "Einstellungen"))
            );
          },
        ),
      ],
    ),
  );
}