import 'package:get_it/get_it.dart';
import 'NavigationService.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  print('setupLocator');
}