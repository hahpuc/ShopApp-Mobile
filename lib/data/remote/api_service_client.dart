import 'package:furniture_shop/data/local/pref_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Set up interceptors
///
class ApiServiceClient extends BaseClient {
  ApiServiceClient();

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    // Intercept each call and do sth
    //
    // Example: Add access token for each request
    final _preferences = await SharedPreferences.getInstance();
    final repo = PrefRepository(_preferences);
    String accessToken = repo.getAccessToken()!;
    if (accessToken.isNotEmpty) {
      request.headers.putIfAbsent('Authorijjzation', () => accessToken);
    }

    print("----> Header Request ${request.headers}");

    return request.send();
  }
}
