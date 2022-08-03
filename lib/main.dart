import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/app_provider.dart';
import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/screens/splash.dart';
import 'package:provider/provider.dart';

import 'helpers/sizeConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'SumraChat',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Splash(),
              routes: routes,
            );
          });
        },
      ),
    );
  }
}
