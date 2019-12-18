import 'package:flutter/material.dart';

import 'bean/ClassItemModel.dart';

class ContentWidget extends StatefulWidget {
  final bool _isShowCheckedAll;

  final ValueChanged<bool> checkedAllChange;

  final List<ClassItemModel> classItems;

  ContentWidget(this.classItems, this._isShowCheckedAll, this.checkedAllChange);

  @override
  State<StatefulWidget> createState() {
    return ContentWidgetState();
  }
}

class ContentWidgetState extends State<ContentWidget> {
  bool _allChecked = false;

  bool _isHaveClassChecked = false;
  final List<ClassItemModel> mList = List();

  void _isAllChecked() {
    if (widget.classItems.isEmpty) {
      return;
    }
    _allChecked = true;
    for (var value in widget.classItems) {
      if (!value.classChecked) {
        _allChecked = false;
        break;
      }
    }
    if (widget._isShowCheckedAll) {
      _isHaveClassChecked = false;
      mList.clear();
    }
  }

  void _onChecked(ClassItemModel model) {
    if (model.classChecked) {
      if (!mList.contains(model)) {
        mList.add(model);
      }
    } else {
      mList.remove(model);
    }
    setState(() {
      _isHaveClassChecked = mList.isNotEmpty;
      print(_isHaveClassChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    _isAllChecked();
    return Container(
      color: Color(0xFFF4F5F6),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 1,
            color: Color(0xffe5e5e5),
          ),
          Offstage(
            offstage: widget._isShowCheckedAll,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      for (var value in widget.classItems) {
                        value.classChecked = !_allChecked;
                      }
                      if (!_allChecked) {
                        mList.clear();
                        mList.addAll(widget.classItems);
                      } else {
                        mList.clear();
                      }
                      setState(() {
                        _isHaveClassChecked = mList.isNotEmpty;
                        _isAllChecked();
                      });
                    },
                    child: Image.asset(
                      _allChecked
                          ? "assets/icon_checked.webp"
                          : "assets/icon_uncheck.webp",
                      width: 18,
                      height: 18,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        "全选",
                        style:
                            TextStyle(color: Color(0xff333333), fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:
                  widget.classItems == null ? 0 : widget.classItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ClassCardItemWidget(
                  model: widget.classItems[index],
                  isShowCheckedAll: widget._isShowCheckedAll,
                  onChecked: _onChecked,
                );
              },
            ),
          ),
          Offstage(
            offstage: widget._isShowCheckedAll,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  for (var value in mList) {
                    widget.classItems.remove(value);
                  }
                  _isHaveClassChecked = false;
                  mList.clear();
                  widget.checkedAllChange(true);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  color:
                      _isHaveClassChecked ? (Colors.blue) : Color(0xffcccccc),
                  padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
                  child: Text(
                    "取消关注",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassCardItemWidget extends StatelessWidget {
  final ClassItemModel model;

  final bool isShowCheckedAll;
  final ValueChanged<ClassItemModel> onChecked;

  ClassCardItemWidget(
      {Key key, this.model, @required this.isShowCheckedAll, this.onChecked})
      : super(key: key);

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
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _buildSelect(context),
              Expanded(
                child: Column(
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
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 10,
            color: Color(0xfff4f5f6),
          ),
        ],
      ),
    );
  }

  Widget _buildSelect(BuildContext context) {
    return Offstage(
      offstage: isShowCheckedAll,
      child: GestureDetector(
        onTap: () {
          model.classChecked = !model.classChecked;
          onChecked(model);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Image.asset(
            _getChecked(),
            width: 18,
            height: 18,
          ),
        ),
      ),
    );
  }

  String _getChecked() {
    if (model.classChecked) {
      return "assets/icon_checked.webp";
    }
    return "assets/icon_uncheck.webp";
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
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 4, 8, 0),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: model.classTeacher.length,
              itemBuilder: itemView,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "\$",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Offstage(
                      offstage: _followedPeople(),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: Text(
                          "${model.followPeople}人以关注",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff999999),
                          ),
                        ),
                      ),
                    ),
                    _classState(),
                  ],
                ),
              ),
            ],
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
          padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffF5A623), width: 1),
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
          padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff62D45D), width: 1),
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
    return Offstage(
      offstage: true,
      child: Container(
        width: 0,
        height: 0,
      ),
    );
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
