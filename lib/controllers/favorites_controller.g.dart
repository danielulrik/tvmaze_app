// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesController on _FavoritesController, Store {
  final _$favoritesAtom = Atom(name: '_FavoritesController.favorites');

  @override
  ObservableList<TvShowDto> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<TvShowDto> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  final _$_FavoritesControllerActionController =
      ActionController(name: '_FavoritesController');

  @override
  dynamic add(TvShowDto show, dynamic Function(bool) callback) {
    final _$actionInfo = _$_FavoritesControllerActionController.startAction(
        name: '_FavoritesController.add');
    try {
      return super.add(show, callback);
    } finally {
      _$_FavoritesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remove(TvShowDto show, dynamic Function(bool) callback) {
    final _$actionInfo = _$_FavoritesControllerActionController.startAction(
        name: '_FavoritesController.remove');
    try {
      return super.remove(show, callback);
    } finally {
      _$_FavoritesControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorites: ${favorites}
    ''';
  }
}
