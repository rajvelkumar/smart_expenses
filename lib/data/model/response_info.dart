import 'package:smart_expenses/data/model/response_data.dart';

class ResponseInfo {
  bool? status;
  String? message;
  List<ResponseData>? responseData;

  ResponseInfo({this.status, this.message, this.responseData});

  ResponseInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['responseData'] != null) {
      responseData = <ResponseData>[];
      json['responseData'].forEach((v) {
        responseData!.add(ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (responseData != null) {
      data['responseData'] = responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
