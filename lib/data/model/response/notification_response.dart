import 'package:furniture_shop/data/model/response/base/base_response.dart';

class NotificationResponse extends BaseResponseData<NotificationResponseData> {}

class NotificationResponseData {
  final int? userId;
  final String? title;
  final String? image;
  final String? message;
  final bool? seen;

  NotificationResponseData(
      {this.userId, this.title, this.image, this.message, this.seen});

  factory NotificationResponseData.fromMap(Map<String, dynamic> map) {
    return NotificationResponseData(
        userId: map["userId"] as int,
        title: map["title"] as String,
        image: map["image"] as String,
        message: map["message"] as String,
        seen: map["seen"] as bool);
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": this.userId,
      "title": this.title,
      "image": this.image,
      "message": this.message,
      "seen": this.seen
    };
  }
}
