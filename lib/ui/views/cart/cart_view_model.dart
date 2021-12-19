import 'package:myapp/app/app.locator.dart';
import 'package:myapp/app/app.router.dart';
import 'package:myapp/db/tables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartViewModel extends BaseViewModel {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _navigationService = locator<NavigationService>();
  User? user;
  Cart? userCart;

  void load(User user) async {
    this.user = user;
    List<Cart> carts = await getCarts();
    for (Cart cart in carts) {
      if (cart.userId == user.id) {
        userCart = cart;
      }
    }
    userCart ??= Cart(userId: user.id);
    notifyListeners();
  }

  void onNavigationBarTap(int index) async{
    User currentUser = user!;
    switch(index){
      case 0:
        _navigationService.navigateTo(Routes.homeView, arguments: HomeViewArguments(user: currentUser));
        break;
      case 2:
        final SharedPreferences prefs = await _prefs;
        prefs.setString("myappUser", "");
        _navigationService.navigateTo(Routes.startupView);
        break;
    }
  }

  void onItemCountChanged(String id, bool increase) {
    int count = userCart!.getItemCount(id);
    int modifiedCount = count;
    if (increase) {
      modifiedCount += 1;
    } else {
      if (!(modifiedCount <= 0)) modifiedCount -= 1;
    }
    if (count != modifiedCount) {
      userCart!.addOrUpdateItem(id, modifiedCount);
      insertCart(userCart!);
      notifyListeners();
    }
  }

  String getItemCount(String id) {
    String x = "1";
    if (userCart != null) x = userCart!.getItemCount(id).toString();
    return x;
  }
}
