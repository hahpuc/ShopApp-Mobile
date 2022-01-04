import 'base/base_response.dart';

class CodeMessageResponse extends BaseResponseData<CodeMessageResponseData> {
  @override
  CodeMessageResponseData parseData(dynamic mapData) {
    return CodeMessageResponseData.fromJson(mapData);
  }
}

class CodeMessageResponseData {
  int? code;
  String? message;

  CodeMessageResponseData({
    this.code,
    this.message,
  });

  CodeMessageResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
