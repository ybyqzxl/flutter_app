import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("classItemTest"),
          ),
          body: ListView(
            children: <Widget>[
              ClassCardItemWidget(
                model: ClassItemModel(
                    className: "双师测试课程",
                    classTime: "周六、周日",
                    classAddress: "海淀黄庄",
                    classDate: "2019-07-08",
                    classMajorTeacher: "周杰伦",
                    classType: 1,
                    classTeacher: [
                      "张三",
                      "李四",
                      "王五",
                      "张三",
                      "李四",
                      "王五",
                      "张三",
                      "李四",
                      "王五"
                    ],
                    classPrice: "2000",
//                    followPeople: "1",
                    classState: "已满"),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}

class ClassItemModel {
  String className;
  String classTime;
  String classAddress;
  String classDate;
  int classType;
  String classMajorTeacher;
  List<String> classTeacher;
  String classPrice;
  String followPeople;
  String classState;

  ClassItemModel(
      {this.className,
      this.classTime,
      this.classAddress,
      this.classDate,
      this.classMajorTeacher,
      this.classType,
      this.classTeacher,
      this.classPrice,
      this.followPeople,
      this.classState});
}

class ClassCardItemWidget extends StatelessWidget {
  final ClassItemModel model;

  ClassCardItemWidget({Key key, this.model, this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  String _getClassType() {
    switch (model.classType) {
      case 1:
        return "assets/online_label.png";
      case 2:
        return "assets/double_lable.png";
      case 4:
        return "assets/face_lable.png";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    //组合上下两部分
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(children: <Widget>[
            buildTopRow(context),
            Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              height: 1,
              color: Color(0xffe5e5e5),
            ),
            buildBottomRow(context),
          ]),
        ),
        Container(
          height: 10,
          color: Color(0xfff4f5f6),
        ),
      ],
    );
  }

  //创建上半部分
  Widget buildTopRow(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: <Widget>[
              Image.asset(
                _getClassType(),
                width: 28,
                height: 15,
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    model.className,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/icon_time.png",
                width: 12,
                height: 14,
                fit: BoxFit.fill,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    model.classTime,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff626b80),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              "assets/icon_address.png",
              width: 12,
              height: 14,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(
                  model.classAddress,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff626b80),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Text(
            "授课：${model.classMajorTeacher}",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12, color: Color(0xff666666)),
          ),
        ),
      ],
    );
  }

  //创建下半部分
  Widget buildBottomRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
          height: 60,
          width: 166,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: model.classTeacher.length,
            itemBuilder: itemView,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Offstage(
                      offstage: _followedPeople(),
                      child: Text("${model.followPeople}人以关注"),
                    ),
                    _classState(),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  bool _followedPeople() {
    if (model.followPeople == null) {
      return true;
    }
    return false;
  }

  Widget _classState() {
    if (model.classState != null) {
      if (model.classState == "已满") {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xffF5A623),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            model.classState,
            style: TextStyle(
              color: Color(0xfff5a623),
              fontSize: 12,
            ),
          ),
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xff62D45D),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "剩余${model.classState}",
            style: TextStyle(
              color: Color(0xff62D45D),
              fontSize: 12,
            ),
          ),
        );
      }
    }
  }

  /// ListView 中每一行的视图
  Widget itemView(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
      child: Column(
        children: <Widget>[
          Image.asset(
            "assets/icon_mine.png",
            width: 32,
            height: 32,
            fit: BoxFit.fill,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text(
              model.classTeacher[index],
              style: TextStyle(
                fontSize: 11,
                color: Color(0xff666666),
              ),
            ),
          )
        ],
      ),
    );
  }
}
