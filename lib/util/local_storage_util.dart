
import 'dart:convert';

import 'package:flutter_plus/flutter_plus.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';

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

  Future<bool> removeFavorite(TvShowDto show) async {
    try {

      List<TvShowDto> savedFavorites = await getFavoriteList();
      List<TvShowDto> favorites = savedFavorites.where((item) => item.id != show.id,).toList();
      var encodedData = json.encode(favorites);
      localStoragePlus.write("FAVORITE_LIST", encodedData);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavorite(num showId) async {
    List<TvShowDto> savedFavorites = await getFavoriteList();
    var favorite = savedFavorites.firstWhere((item) => item.id == showId,
      orElse: () => null,
    );
    return favorite != null;
  }

  Future<bool> addFavorite(TvShowDto show) async {
    try {
      List<TvShowDto> savedFavorites = await getFavoriteList();

      var favorite = savedFavorites.firstWhere((item) => item.id == show.id,
        orElse: () => null,
      );

      if (favorite == null) {
        savedFavorites.add(show);
        var encodedData = json.encode(savedFavorites);
        localStoragePlus.write("FAVORITE_LIST", encodedData);
      }

      return true;

    } catch (e) {
      return false;
    }
  }

  Future<List<TvShowDto>> getFavoriteList() async {
    var str = await localStoragePlus.read("FAVORITE_LIST");
    if (str == null) return List();

    var decoded = json.decode(str);
    if (decoded == null) return List();

    var list = decoded as List;
    var shows = list.map((i) => TvShowDto.fromJson(i)).toList();

    shows.sort((a,b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return shows;
  }

}
