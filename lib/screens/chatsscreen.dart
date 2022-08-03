import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test_task/helpers/app_provider.dart';
import 'package:flutter_test_task/helpers/constants.dart';
import 'package:flutter_test_task/screens/chatscreen_details.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helpers/database_helper.dart';
import '../models/usermodel.dart';

class ChatsScreen extends StatefulWidget {
  //const ChatsScreen({Key? key}) : super(key: key);
  static const routeName = '/chatscreen';

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<User> users = [];
  bool firstload = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    users = Provider.of<AppProvider>(context).getuserlist;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: pageMargin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: calculateSize(20),
                      backgroundImage: AssetImage("assets/images/51.jpeg"),
                    ),
                    appText(
                      "Charts",
                      30,
                      weight: FontWeight.w700,
                      color: textcolor323B4B,
                      leftmargin: 10.0,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/Take a Photo.png",
                      height: calculateSize(40),
                      width: calculateSize(40),
                    ),
                    SizedBox(
                      width: calculateSize(16),
                    ),
                    Image.asset(
                      "assets/images/New Message.png",
                      height: calculateSize(40),
                      width: calculateSize(40),
                    ),
                  ],
                ),
                SizedBox(
                  height: calculateSize(20),
                ),
                SearchWidget(
                  labeltext: appText("Search", 15,
                      color: Color(0xffB0B7C3), weight: FontWeight.w500),
                  trailingButton: Icon(
                    Icons.search,
                    color: Color(0xffB0B7C3),
                  ),
                ),
                SizedBox(
                  height: calculateSize(10),
                ),
                Divider(
                  color: Color(0xffE9F0FB),
                  thickness: 1.5,
                ),
                users.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                              'assets/images/92807-conference-call.json',
                              repeat: true,
                              reverse: false,
                              animate: true,
                              width: calculateSize(100),
                              height: calculateSize(100)),
                          appText("Add Users\nClick the float button", 15,
                              topmargin: 20.0, color: Color(0xff121213))
                        ],
                      )
                    : ListView.builder(
                        itemCount: users.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              ChatScreendetails.routeName,
                              arguments: users[i]),
                          child: ChatView(
                              users[i].id, users[i].image, users[i].name),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doInsert,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void doInsert() {
    Provider.of<AppProvider>(context, listen: false).insertintoUsersdb();
  }
}

class ChatView extends StatelessWidget {
  final id;
  final image;
  final name;

  const ChatView(this.id, this.image, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: calculateSize(20)),
      child: Row(
        children: [
          CircleAvatar(
            radius: calculateSize(33),
            backgroundImage: AssetImage(image),
          ),
          SizedBox(
            width: calculateSize(13),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(name, 17,
                  weight: FontWeight.w500,
                  color: Color(0xff121213),
                  bottommargin: 8.0),
              appText(
                "You sent a sticker",
                14,
                weight: FontWeight.w400,
                color: Color(0xff7B87A5),
              ),
            ],
          ),
          Spacer(),
          appText(
            "22 Aug",
            12,
            weight: FontWeight.w400,
            color: Color(0xff7B87A5),
          )
        ],
      ),
    );
  }
}
