/// {@category Model}
/// Value Object for data transfer (Server API developer knows this data)
class HomeGetVO {
  String? message;
  int? status;
  Data? data;

  HomeGetVO({this.message, this.status, this.data});

  HomeGetVO.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  String? contents;

  Data({this.title, this.contents});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['contents'] = this.contents;
    return data;
  }
}
