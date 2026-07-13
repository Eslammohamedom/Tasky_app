
class AllTasksModel {
  List<Data>? data;

  AllTasksModel({this.data});

  // This factory constructor automatically detects if your JSON is a List or a Map
  factory AllTasksModel.fromJson(dynamic json) {
    if (json is List){
      // If the response is a direct array: [...]
      return AllTasksModel(
        data: json.map((v) => Data.fromJson(v as Map<String, dynamic>)).toList(),
      );
    }
    else if (json is Map<String, dynamic> && json['data'] != null) {
      // If the response is an object with a 'data' key: {"data": [...]}
      return AllTasksModel(
        data: (json['data'] as List)
            .map((v) => Data.fromJson(v as Map<String, dynamic>))
            .toList(),
      );
    }
    return AllTasksModel(data: []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = <String, dynamic>{};
    if (this.data != null) {
      dataMap['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Data {
  String? sId;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['title'] = title;
    data['desc'] = desc;
    data['priority'] = priority;
    data['status'] = status;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

