import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:myapp/db/tables.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  final User user;

  const HomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Items",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: getItems(model),
                  ),
                ),
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.logout),label:'Logout'),
          ],
          onTap: (value) => model.onNavigationBarTap(value),
        ),
      ),
      onModelReady: (model) => model.load(user),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  List<Widget> getItems(HomeViewModel model) {
    List<Widget> cards = List.empty(growable: true);
    for (var item in items) {
      String imagePath = "assets/" + item.id + ".png";
      Image image = Image.asset(
        imagePath,
        width: 75,
        height: 75,
      );
      cards.add(GFCard(
        image: image,
        showImage: true,
        title: GFListTile(
          title: Center(
            child: Text(
              item.name,
              style: const TextStyle(fontSize: 25),
            ),
          ),
          description: Center(
            child: Text(
              item.description,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        buttonBar: GFButtonBar(
          children: [
            IconButton(
                onPressed: () => model.onItemCountChanged(item.id, true),
                icon: const Icon(Icons.add)),
            Text(
              model.getItemCount(item.id),
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
            IconButton(
                onPressed: () => model.onItemCountChanged(item.id, false),
                icon: const Icon(Icons.remove)),
          ],
        ),
      ));
    }
    return cards;
  }
}
