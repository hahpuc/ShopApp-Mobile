import 'package:furniture_shop/data/model/response/base/base_response.dart';

class DemoResponse extends BaseResponseData<DemoResponseData> {
  final int userId;
  final int id;
  final String title;

  DemoResponse({required this.userId, required this.id, required this.title});

  factory DemoResponse.tryParse(Map<String, dynamic> map) {
    return DemoResponse(
        userId: map["userId"] as int,
        id: map["id"] as int,
        title: map["title"] as String);
  }

  Map<String, dynamic> toMap() {
    return {"userId": this.userId, "id": this.id, "title": this.title};
  }

  @override
  DemoResponseData parseData(dynamic data) {
    // TODO: implement fromMapData
    throw UnimplementedError();
  }
}

class DemoResponseData {}
