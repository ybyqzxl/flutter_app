import 'package:flutter/material.dart';
import 'classItemView.dart';

import 'bean/ClassItemModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFocusScreen(),
    );
  }
}

final List<ClassItemModel> classItems = [
  ClassItemModel("1",
      className: "双师测试课程",
      classTime: "周六、周日",
      classAddress: "海淀黄庄",
      classDate: "2019-07-08",
      classMajorTeacher: "周杰伦",
      classType: 1,
      classTeacher: ["张三", "李四", "王五", "张三", "李四", "王五", "张三", "李四", "王五"],
      classPrice: "2000",
      followPeople: "1",
      classState: "增开",
      classChecked: false),
  ClassItemModel("2",
      className: "双师测试课程",
      classTime: "周六、周日",
      classAddress: "海淀黄庄",
      classDate: "2019-07-08",
      classMajorTeacher: "周杰伦",
      classType: 1,
      classTeacher: ["张三", "李四", "王五", "张三", "李四", "王五", "张三", "李四", "王五"],
      classPrice: "2000",
      followPeople: "1",
      classState: "增开",
      classChecked: false),
  ClassItemModel("3",
      className: "双师测试课程",
      classTime: "周六、周日",
      classAddress: "海淀黄庄",
      classDate: "2019-07-08",
      classMajorTeacher: "周杰伦",
      classType: 1,
      classTeacher: ["张三", "李四", "王五", "张三", "李四", "王五", "张三", "李四", "王五"],
      classPrice: "2000",
      followPeople: "1",
      classState: "增开",
      classChecked: false),
  ClassItemModel("4",
      className: "双师测试课程",
      classTime: "周六、周日",
      classAddress: "海淀黄庄",
      classDate: "2019-07-08",
      classMajorTeacher: "周杰伦",
      classType: 1,
      classTeacher: ["张三", "李四", "王五", "张三", "李四", "王五", "张三", "李四", "王五"],
      classPrice: "2000",
      followPeople: "1",
      classState: "增开",
      classChecked: false)
];

class MyFocusScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyFocusState();
  }
}

class MyFocusState extends State<MyFocusScreen> {
  String _menu = "编辑";
  bool _isShowCheckedAll = true;

  void changeCheckedAll(bool changeChecked) {
    setState(() {
//      _isShowCheckedAll = changeChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {},
            padding: EdgeInsets.all(18),
            icon: Image.asset("assets/icon_back.png"),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              onTap: () => setState(() {
                if (_menu == "编辑") {
                  _isShowCheckedAll = false;
                  _menu = "完成";
                } else {
                  _isShowCheckedAll = true;
                  _menu = "编辑";
                }
                for (var value in classItems) {
                  value.classChecked = false;
                }
              }),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  _menu,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            "关注的班级",
            style: TextStyle(color: Color(0xff132c4b), fontSize: 18),
          ),
        ),
        body: ContentWidget(classItems, _isShowCheckedAll, changeCheckedAll));
  }
}
