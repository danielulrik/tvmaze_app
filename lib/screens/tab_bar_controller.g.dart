// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_bar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabBarController on _TabBarController, Store {
  final _$tabIndexAtom = Atom(name: '_TabBarController.tabIndex');

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  final _$_TabBarControllerActionController =
      ActionController(name: '_TabBarController');

  @override
  void changeTabIndex(int newIndex) {
    final _$actionInfo = _$_TabBarControllerActionController.startAction(
        name: '_TabBarController.changeTabIndex');
    try {
      return super.changeTabIndex(newIndex);
    } finally {
      _$_TabBarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void backTabIndex() {
    final _$actionInfo = _$_TabBarControllerActionController.startAction(
        name: '_TabBarController.backTabIndex');
    try {
      return super.backTabIndex();
    } finally {
      _$_TabBarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex}
    ''';
  }
}
