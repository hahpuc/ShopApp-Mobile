import 'package:furniture_shop/data/local/pref_repository.dart';
import 'package:furniture_shop/data/remote/api_service.dart';

class AppRepository {
  // Remote
  final ApiService apiService;

  // Local: Pref & Database
  final PrefRepository prefRepository;

  AppRepository({required this.apiService, required this.prefRepository});
}
