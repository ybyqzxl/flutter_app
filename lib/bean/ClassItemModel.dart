class ClassItemModel {
  String classId;
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
  bool classChecked;

  ClassItemModel(this.classId,
      {this.className,
      this.classTime,
      this.classAddress,
      this.classDate,
      this.classMajorTeacher,
      this.classType,
      this.classTeacher,
      this.classPrice,
      this.followPeople,
      this.classState,
      this.classChecked});
}
