import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  String name;
  String email;
  String password;
  DateTime dob;
  int id;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.dob,
      required this.id});

  factory User.fromMap(Map<String, dynamic> map) => User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      dob: DateTime.parse(map['dob']));

  factory User.fromString(String string) => User.fromMap(jsonDecode(string));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'dob': dob.toString()
    };
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'dob': dob.toString()
  };

  @override
  String toString() {
    return 'User{id: $id, name : $name, email : $email, password : $password, dob:$dob}';
  }
}

class Item {
  final String id;
  final String name;
  final String description;

  Item({required this.id, required this.name, required this.description});

  @override
  String toString() {
    return 'Item{id:$id,name:$name,description:$description}';
  }
}

class Cart {
  int userId;
  Map<String, int> items = Map.identity();

  Cart({required this.userId});

  Cart.fromString({required this.userId, required String itemString}) {
    Map<String, dynamic> x = jsonDecode(itemString);
    items = x.map((key, value) {
      return MapEntry(key, value);
    });
  }

  factory Cart.fromMap(Map<String, dynamic> map) =>
      Cart.fromString(userId: map['userId'], itemString: map['items']);

  void addOrUpdateItem(String itemId, int count) {
    items.update(itemId, (value) => count, ifAbsent: () => count);
  }

  int getItemCount(String itemId) {
    int count = 0;
    items.forEach((key, value) {
      if (key == itemId) {
        count = value;
      }
    });
    return count;
  }

  String itemsToString() {
    return jsonEncode(items);
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'items': itemsToString()};
  }

  @override
  String toString() {
    String itemString = itemsToString();
    return 'Cart{userId:$userId,items:$itemString}';
  }
}

var database;
List<Item> items = List.empty(growable: true);

void initDatabase() async {
  items.add(Item(
      id: "banana",
      name: "Banana",
      description: "A kilogram of fresh bananas."));
  items.add(Item(
      id: "apple", name: "Apple", description: "A kilogram of fresh apples"));
  String path = join(await getDatabasesPath(), 'test-app.db');
  await deleteDatabase(path);
  database = openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY,email TEXT,name TEXT,password TEXT,dob TEXT)');
      db.execute('CREATE TABLE carts(userId INTEGER PRIMARY KEY,items TEXT)');
    },
  );
}

Future<void> insertUser(User user) async {
  final db = await database;

  await db.insert('users', user.toMap());
}

Future<void> insertCart(Cart cart) async {
  final db = await database;
  await db.insert(
    'carts',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Cart>> getCarts() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('carts');
  return List.generate(maps.length, (i) {
    return Cart.fromMap(maps[i]);
  });
}

Future<List<User>> getUsers() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('users');
  return List.generate(maps.length, (i) {
    return User.fromMap(maps[i]);
  });
}
