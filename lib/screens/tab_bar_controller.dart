import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'tab_bar_controller.g.dart';

class TabBarController = _TabBarController with _$TabBarController;

abstract class _TabBarController with Store {
  @observable
  int tabIndex = 0;

  int _lastIndex = -1;

  @action
  void changeTabIndex(int newIndex) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    this._lastIndex = this.tabIndex;
    this.tabIndex = newIndex;
  }

  @action
  void backTabIndex() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (this.tabIndex == this._lastIndex && this._lastIndex == 0) {
      exit(0);
    } else if (this.tabIndex == this._lastIndex) {
      this._lastIndex = 0;
      this.tabIndex = 0;
    } else {
      this.tabIndex = this._lastIndex;
    }
  }

}
