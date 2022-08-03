import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/models/messagemodel.dart';
import 'package:flutter_test_task/models/usermodel.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class AppProvider with ChangeNotifier {
  List<User> userlist = [];
  List<MessageModel> messagelist = [];

  List<User> get getuserlist {
    return [...userlist];
  }

  List<MessageModel> get getmessagelist {
    return [...messagelist];
  }

  List<String> userdp = [
    "assets/images/27.jpeg",
    "assets/images/33.jpeg",
    "assets/images/51.jpeg",
    "assets/images/58.jpeg",
    "assets/images/74.jpeg",
    "assets/images/11.jpeg",
    "assets/images/15.jpeg",
    "assets/images/24.jpeg",
    "assets/images/49.jpeg",
    "assets/images/77.jpeg"
  ];

  final dbHelper = DatabaseHelper.instance;
  var faker = Faker();

  Future<void> insertintoUsersdb() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: faker.person.name(),
      DatabaseHelper.columnImage: userdp[randomimage()]
    };
    final id = await dbHelper.insert(row, DatabaseHelper.usertable);
    //print('inserted row id: $id');

    queryUsertable();
  }

  Future<void> insertintoMessagedb(message, sender, receiver, userid) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnmessage: message,
      DatabaseHelper.columnsenderid: sender,
      DatabaseHelper.columnreceiverid: receiver,
      DatabaseHelper.columnuserid: userid,
    };

    final id = await dbHelper.insert(row, DatabaseHelper.messagetable);
    //print('inserted row id: $id');

    querymessagetable(userid);
  }

  Future<void> querymessagetable(id) async {
    final allRows = await dbHelper.queryAllRows(DatabaseHelper.messagetable);
    //print('query all rows:');
    //allRows.forEach(print);

    if (messagelist.isNotEmpty) {
      messagelist.clear();
    }

    for (var v in allRows) {
      if (id.toString() == v["userid"].toString()) {
        messagelist.add(MessageModel(
          id: v["_id"].toString(),
          message: v["message"],
          senderid: v["senderid"].toString(),
          receiverid: v["receiverid"].toString(),
          userid: v["userid"].toString(),
        ));
      }
    }

    notifyListeners();
  }

  Future<void> queryUsertable() async {
    final allRows = await dbHelper.queryAllRows(DatabaseHelper.usertable);
    //print('query all rows:');
    //allRows.forEach(print);

    if (userlist.isNotEmpty) {
      userlist.clear();
    }

    for (var v in allRows) {
      userlist.add(User(
        id: v["_id"].toString(),
        name: v["name"],
        image: v["image"],
      ));
    }

    notifyListeners();
  }

  int randomimage() {
    var ran = Random();
    return ran.nextInt(9);
  }
}
