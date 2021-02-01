

import 'package:mobx/mobx.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';
import 'package:tvmaze_app/util/local_storage_util.dart';

part 'favorites_controller.g.dart';

class FavoritesController = _FavoritesController with _$FavoritesController;

abstract class _FavoritesController with Store {

  @observable
  ObservableList<TvShowDto> favorites = ObservableList();

  _FavoritesController() {
    localStorageUtil.getFavoriteList().then((value) {
      favorites.clear();
      favorites.addAll(value);
    });
  }

  @action
  add(TvShowDto show, Function(bool) callback) {

    localStorageUtil.addFavorite(show).then((_) {
      localStorageUtil.getFavoriteList().then((value) {
        favorites.clear();
        favorites.addAll(value);
        callback.call(true);
      });
    });

  }

  @action
  remove(TvShowDto show, Function(bool) callback) {

    localStorageUtil.removeFavorite(show).then((_) {
      localStorageUtil.getFavoriteList().then((value) {
        favorites.clear();
        favorites.addAll(value);
        callback.call(false);
      });
    });

  }

}