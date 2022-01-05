import 'app.dart';
import 'configs/flavor.dart';

void main() async {
  var flavorConfig = FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: "https://7926-171-242-121-53.ngrok.io",
      ));
  return MyApp.appRunner(flavorConfig);
}
