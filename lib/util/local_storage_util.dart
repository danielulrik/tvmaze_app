
import 'package:flutter_plus/flutter_plus.dart';

final localStorageUtil = LocalStorageUtil._instance;

class LocalStorageUtil {

  static final _instance = LocalStorageUtil._();
  LocalStorageUtil._();

  Future storePin(String pin) async {
    localStoragePlus.write("PIN", pin);
  }

  Future<String> retrievePin() async {
    return localStoragePlus.read("PIN");
  }

  Future addToFavorites(num showId) async {
    try {
      dynamic savedFavorites = await getFavorites();

      List<String> favorites = List.from(savedFavorites);
      favorites.add(showId.toString());

      localStoragePlus.write("FAVORITES", favorites);
    } catch (e) {
      print(e);
    }
  }

  Future removeFavorite(num showId) async {
    try {
      dynamic savedFavorites = await getFavorites();
      List<String> favorites = List.from(savedFavorites);
      favorites.remove(showId.toString());
      localStoragePlus.write("FAVORITES", favorites);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFavorites() async {
    if (await localStoragePlus.containsKey('FAVORITES')) {
      return localStoragePlus.read("FAVORITES");
    }
    return List();
  }

  Future<bool> isFavorite(num showId) async {
    List favorites = await getFavorites();
    return favorites.contains(showId.toString());
  }

}
