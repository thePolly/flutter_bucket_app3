import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

enum BucketPriority { low, medium, high, critical }

class Bucket {

  static String table = 'bucket_items';

  String userName;
  String name;
  String description;
  String priority;
  File attachment;
  DateTime date;

  Icon icon = Icon(Icons.album_rounded, color: Colors.green, size: 24);

  Bucket(
      { this.userName,
        this.name,
      this.description,
      this.attachment,
      this.priority = "medium",
      this.date});

  factory Bucket.fromJson(Map<String, dynamic> json) => new Bucket(
    userName: json["user_name"],
    name: json["name"],
    description: json["description"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "name": name,
    "description": description,
    "priority": priority,
  };


  setIcon() {
    switch (priority) {
      case ("low"):
        icon = Icon(
          Icons.transit_enterexit_rounded,
          color: Colors.green,
          size: 24,
        );
        break;
      case ("medium"):
        icon = Icon(
          Icons.album_rounded,
          color: Colors.green,
          size: 24,
        );
        break;
      case ("high"):
        icon = Icon(
          Icons.priority_high_outlined,
          color: Colors.red,
          size: 24,
        );
        break;
      case ("critical"):
        icon = Icon(
          Icons.block_rounded,
          color: Colors.red,
          size: 24,
        );
        break;
    }
  }

  Widget showIcon(BuildContext) {
    return Icon(
      icon.icon,
      color: icon.color,
    );
  }

  String myToString(DateTime dateTime) {
    if (this.date == null) {
      this.date = DateTime.now();
    }
    return (this.date.day).toString() +
        "-" +
        (this.date.month).toString() +
        "-" +
        (this.date.year).toString();
  }

  String getDate() {
    if (date == null) {
      date = DateTime.now();
    }
    return (date.day).toString() + "/" + (date.month).toString();
  }

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) => Text("df");
}
