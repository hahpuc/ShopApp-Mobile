abstract class BaseResponseData<T> {
  String? errorCode;
  String? errorMsg;
  T? data;

  ///
  /// Parse T
  ///
  T parseData(dynamic data);

  ///
  /// Parse all response data
  ///
  BaseResponseData<T> tryParse(dynamic data) {
    if (data is Map && data.containsKey("error")) {
      // Error
      if (data["error"].containsKey("code")) {
        errorCode = data["error"]["code"];
      }
      if (data["error"].containsKey("code")) {
        errorMsg = data["error"]["message"];
      }
      data = null;
    } else {
      // Success, try parsing data
      this.data = parseData(data);
    }
    return this;
  }
}

class Result<T extends BaseResponseData, V extends Exception> {
  T? response;
  V? exception;
  Result({required this.response, required this.exception});

  bool isSuccessful() {
    if (exception == null && response?.data != null) {
      return true;
    }
    return false;
  }
}
