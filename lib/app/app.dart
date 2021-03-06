import 'package:myapp/ui/views/cart/cart_view.dart';
import 'package:myapp/ui/views/home/home_view.dart';
import 'package:myapp/ui/views/login/login_view.dart';
import 'package:myapp/ui/views/signup/signup_view.dart';
import 'package:myapp/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView,initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: CartView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService)
  ]
)
class AppSetup{
  
}