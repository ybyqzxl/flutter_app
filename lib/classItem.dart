import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        primarySwatch: Colors.blue,
      ),
      home: ClassCardItemWidget(
        model: ClassItemModel(
            className: "assets/icon.png",
            classTime:
                "Thanks for using Google Maps! This release brings bug fixes "
                "that improve our product to help you discover new places and navigate to them.",
            classAddress: "Google Maps - Transit & Fond",
            classDate: "137.2",
            classType: "2019年6月5日"),
        onPressed: () {},
      ),
    );
  }
}

class ClassItemModel {
  String className;
  String classTime;
  String classAddress;
  String classDate;
  String classType;
  List<String> classTeacher;
  String classPrice;

  ClassItemModel(
      {this.className,
      this.classTime,
      this.classAddress,
      this.classDate,
      this.classType,
      this.classTeacher,
      this.classPrice});
}

class ClassCardItemWidget extends StatelessWidget {
  final ClassItemModel model;

  ClassCardItemWidget({Key key, this.model, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    //组合上下两部分
    return Container(
      child: Column(
          children: <Widget>[buildTopRow(context), buildBottomRow(context)]),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(15, 17, 0, 0),
      height: 190,
      width: double.maxFinite,
    );
  }

  //创建上半部分
  Widget buildTopRow(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Text(
              model.className,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0x1C234B),
              ),
            ),
          ),
          Image.asset("assets/icon.png"),
        ]),
        Row(
          children: <Widget>[
            Image.asset("assets/icon.png"),
            Expanded(
              child: Text(
                model.classTime,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x1C234B),
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Image.asset("assets/icon.png"),
            Expanded(
              child: Text(
                model.classAddress,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x1C234B),
                ),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Text(model.classDate),
        ),
      ],
    );
  }

  //创建下半部分
  Widget buildBottomRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Row(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: model.classTeacher.length,
              itemExtent: 35,
              itemBuilder: itemView,
            ),
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "\$",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.red),
              ),
              TextSpan(
                text: "${model.classPrice}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
            ]),
          ),
        ]));
  }

  /// ListView 中每一行的视图
  Widget itemView(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Image.asset("assets/icon.png"),
        Container(
          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
          child: Text(
            model.classTeacher[index],
            style: TextStyle(
              fontSize: 14,
              color: Color(0x1C234B),
            ),
          ),
        )
      ],
    );
  }
}
