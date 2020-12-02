import 'package:flutter/material.dart';
import 'package:mgs/main.dart';

List<Widget> getCourses() {
  List<Widget> courses = new List<Widget>();
  List<Widget> listDisplay = new List<Widget>();

  courses.add(
      new Course(1, "Mathe", "Frau W", "300", true, false, false, false));
  courses.add(
      new Course(2, "Mathe", "Frau W", "300", false, false, false, false));
  courses.add(
      new Course(3, "Deutsch", "Herr B", "097", false, true, false, false));
  courses.add(new Course(
      4, "Deutsch", "Herr B", "097", false, false, false, false));
  courses.add(new Course(
      5, "Geschichte", "Herr P", "245", false, false, true, false));
  courses.add(new Course(
      6, "Geschichte", "Herr P", "245", false, false, false, true));
  courses.add(new Course(
      7, "Geschichte", "Herr P", "245", false, false, false, false));

  listDisplay = courses;
  Widget dividerBreak(String s) {
    return Row(children: <Widget>[
      Expanded(child: Divider()),
      Text(" " + s + " ",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
      Expanded(child: Divider()),
    ]);
  }

  listDisplay.insert(2, dividerBreak("Pause: 15 min"));
  listDisplay.insert(5, dividerBreak("Pause: 20 min"));
  if (listDisplay.length > 7) {
    listDisplay.insert(8, dividerBreak("Pause: 40 min"));
  }

  return courses;
}
