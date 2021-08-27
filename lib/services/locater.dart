import 'package:get_it/get_it.dart';
import 'package:prop_plus/services/auth_repo.dart';
import 'package:prop_plus/services/storage_repo.dart';
import 'package:prop_plus/services/user_controller.dart';

final locater = GetIt.instance;

Future<void> setupServices() async{
 locater.registerSingleton<AuthService>(AuthService());
 locater.registerSingleton<StorageRepo>(StorageRepo());
 locater.registerSingleton<UserController>(UserController());
 await locater.get<UserController>().InitializeUser();
}