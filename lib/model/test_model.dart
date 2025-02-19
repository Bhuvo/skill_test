
class TestListModel{
  List<TestModel>? testList;
  TestListModel({this.testList});
  @override
  String toString() {
    return '' ;
  }
}

class TestModel{
  String? title;
  String? description;
  List<String>? instruction;
  String? videoUrl;
  TestModel({this.title,this.description,this.instruction,this.videoUrl});

  static TestModel fromJson(Map<String, dynamic> json) {
    return TestModel(
      title: json['title'],
      description: json['description'],
      instruction: (json['instruction'] as List<dynamic>?)?.map((e) => e.toString()).toList(), // Explicitly casting
      videoUrl: json['videoUrl'],
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['instruction'] = this.instruction;
    data['videoUrl'] = this.videoUrl;
    return data;
  }

  @override
  String toString() {
    return '$title';
  }
}