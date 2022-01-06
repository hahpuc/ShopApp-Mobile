import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "https://hahpuc-test-shop-app.herokuapp.com",
      ));
  return MyApp.appRunner(flavorConfig);
}
