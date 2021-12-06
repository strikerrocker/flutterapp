import 'package:myapp/app/app.locator.dart';
import 'package:myapp/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final String _title = "Home View";

  String get title => _title;
}
