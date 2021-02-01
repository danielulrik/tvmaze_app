// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TvShowsController on _TvShowsController, Store {
  final _$_TvShowsControllerActionController =
      ActionController(name: '_TvShowsController');

  @override
  dynamic getShows({num page = 0}) {
    final _$actionInfo = _$_TvShowsControllerActionController.startAction(
        name: '_TvShowsController.getShows');
    try {
      return super.getShows(page: page);
    } finally {
      _$_TvShowsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic debouncedSearch(String query) {
    final _$actionInfo = _$_TvShowsControllerActionController.startAction(
        name: '_TvShowsController.debouncedSearch');
    try {
      return super.debouncedSearch(query);
    } finally {
      _$_TvShowsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getShowsByQuery(String query) {
    final _$actionInfo = _$_TvShowsControllerActionController.startAction(
        name: '_TvShowsController.getShowsByQuery');
    try {
      return super.getShowsByQuery(query);
    } finally {
      _$_TvShowsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
