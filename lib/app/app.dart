import 'package:hrbrotest/services/user_service.dart';
import 'package:hrbrotest/ui/screens/Cart/cart_view.dart';
import 'package:hrbrotest/ui/screens/add/add_view.dart';
import 'package:hrbrotest/ui/screens/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';
import '../services/databasehelper.dart';
import '../services/location_service.dart';
import '../ui/screens/home/home_view.dart';
import '../ui/screens/homeadmin/homeadmin_view.dart';
import '../ui/screens/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: CartView),
    MaterialRoute(page:HomeAdminView),
    MaterialRoute(page:AddView),

  ],
  dependencies: [
    LazySingleton(classType: ApiService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: DBManager),
  ],
)
class AppSetup {}
