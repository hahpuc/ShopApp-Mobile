import 'package:furniture_shop/data/model/response/base/base_response.dart';

class UserResponse extends BaseResponseData<UserResponseData> {}

class UserResponseData {
  final int? userId;
  final String? name;
  final String? phoneNumber;

  UserResponseData({this.userId, this.name, this.phoneNumber});

  factory UserResponseData.fromMap(Map<String, dynamic> map) {
    return UserResponseData(
        userId: map["userId"] as int,
        name: map["name"] as String,
        phoneNumber: map["phoneNumber"] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": this.userId,
      "id": this.name,
      "phoneNumber": this.phoneNumber
    };
  }
}
