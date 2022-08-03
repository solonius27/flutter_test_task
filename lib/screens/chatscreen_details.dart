import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test_task/helpers/app_provider.dart';
import 'package:flutter_test_task/helpers/constants.dart';
import 'package:flutter_test_task/models/messagemodel.dart';
import 'package:provider/provider.dart';

import '../models/usermodel.dart';

class ChatScreendetails extends StatefulWidget {
  //const ChatScreendetails({Key? key}) : super(key: key);
  static const routeName = '/chatdetails';

  @override
  State<ChatScreendetails> createState() => _ChatScreendetailsState();
}

class _ChatScreendetailsState extends State<ChatScreendetails> {
  var controller = TextEditingController();
  User? args;
  List<MessageModel> messages = [];
  bool pageloading = true;

  var faker = Faker();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      args = ModalRoute.of(context)!.settings.arguments as User;
      await Provider.of<AppProvider>(context, listen: false)
          .querymessagetable(args!.id);
      setState(() {
        pageloading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as User;
    messages = Provider.of<AppProvider>(context).getmessagelist;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Color.fromRGBO(163, 168, 180, 0.25),
          iconTheme: IconThemeData(color: Color(0xff121213)),
          title: Row(
            children: [
              CircleAvatar(
                radius: calculateSize(21),
                backgroundImage: AssetImage(args!.image!),
              ),
              Expanded(
                child: appText(args!.name!, 16,
                    weight: FontWeight.w500,
                    align: TextAlign.start,
                    color: Color(0xff121213),
                    leftmargin: 8.0),
              ),
            ],
          ),
          actions: [
            Icon(
              Icons.call,
              size: calculateSize(35),
              color: Color(0xff2A87FF),
            ),
            SizedBox(
              width: calculateSize(26),
            ),
            Icon(
              Icons.video_call,
              size: calculateSize(35),
              color: Color(0xff2A87FF),
            ),
          ],
        ),
        body: pageloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    margin: pageMargin,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: calculateSize(11),
                                  horizontal: calculateSize(37)),
                              decoration: BoxDecoration(
                                color: Color(0xffE9F0FB),
                                borderRadius:
                                    BorderRadius.circular(calculateSize(12)),
                              ),
                              child: appText(
                                "Message to this chat and calls are now\nsecured with End to End encryption.",
                                12,
                                color: Color(0xff919BBF),
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, i) => ChatwidgetView(
                                  messages[i].message,
                                  messages[i].senderid == "0",
                                )),
                          ),
                          SizedBox(
                            height: calculateSize(100),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //height: calculateSize(50),
                      padding: EdgeInsets.symmetric(
                          horizontal: calculateSize(20),
                          vertical: calculateSize(12)),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/Group 3.png",
                            height: calculateSize(32),
                            width: calculateSize(32),
                          ),
                          SizedBox(
                            width: calculateSize(20),
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Color(0xff2A87FF),
                                ),
                                onPressed: doinsert,
                              ),
                              prefixIcon: Icon(
                                Icons.face,
                                color: Color(0xff2A87FF),
                              ),
                              fillColor: Color(0xffE9F0FB).withOpacity(0.85),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(calculateSize(18))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(calculateSize(18))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(calculateSize(18))),
                            ),
                          )),
                          SizedBox(
                            width: calculateSize(20),
                          ),
                          Icon(
                            Icons.mic,
                            color: Color(0xff2A87FF),
                            size: calculateSize(32),
                          ),
                          SizedBox(
                            width: calculateSize(20),
                          ),
                          Icon(
                            Icons.thumb_up,
                            color: Color(0xff2A87FF),
                            size: calculateSize(32),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  doinsert() {
    if (controller.text.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    Provider.of<AppProvider>(context, listen: false)
        .insertintoMessagedb(controller.text, "0", args!.id, args!.id);
    controller.clear();

    sendautomatedMessage();
  }

  void sendautomatedMessage() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      var message = faker.lorem.sentence();

      Provider.of<AppProvider>(context, listen: false)
          .insertintoMessagedb(message, args!.id, "0", args!.id);
      controller.clear();
    });
  }
}

class ChatwidgetView extends StatelessWidget {
  final text;
  final isMe;

  const ChatwidgetView(this.text, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: calculateSize(25)),
            padding: EdgeInsets.symmetric(
                vertical: calculateSize(8), horizontal: calculateSize(12)),
            constraints: BoxConstraints(maxWidth: calculateSize(200)),
            decoration: BoxDecoration(
              color: isMe
                  ? Color(0xff0061FF)
                  : Color(0xff000000).withOpacity(0.06),
              borderRadius: BorderRadius.only(
                topRight: isMe
                    ? Radius.circular(calculateSize(4))
                    : Radius.circular(calculateSize(18)),
                topLeft: Radius.circular(calculateSize(18)),
                bottomLeft: isMe
                    ? Radius.circular(calculateSize(18))
                    : Radius.circular(calculateSize(4)),
                bottomRight: Radius.circular(calculateSize(18)),
              ),
            ),
            child: appText(text, 17,
                weight: FontWeight.w400,
                align: TextAlign.start,
                color: isMe ? Colors.white : Color(0xff19232C)),
          ),
        ]);
  }
}
