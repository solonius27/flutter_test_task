import 'package:flutter_test_task/models/usermodel.dart';

class MessageModel {
  String? id;
  String? message;
  String? senderid;
  String? receiverid;
  String? userid;

  MessageModel(
      {this.id, this.message, this.senderid, this.receiverid, this.userid});
}
