import 'package:mobx/mobx.dart';

part 'api_request.g.dart';

enum ApiRequestEnum { IDLE, DONE, PENDING, FETCHING, ERROR }

class ApiRequest<T> = _ApiRequest<T> with _$ApiRequest<T>;

abstract class _ApiRequest<T> with Store {
  @observable
  ApiRequestEnum _status = ApiRequestEnum.IDLE;

  @observable
  T _data;

  @observable
  dynamic _error;

  @observable
  int _page;

  @computed
  bool get isDone => this._status == ApiRequestEnum.DONE;

  @computed
  bool get isPending => this._status == ApiRequestEnum.PENDING;

  @computed
  bool get isFetching => this._status == ApiRequestEnum.FETCHING;

  @computed
  bool get isError => this._status == ApiRequestEnum.ERROR;

  @computed
  bool get isIdle => this._status == ApiRequestEnum.IDLE;

  @computed
  bool get isEmpty {
    if (this._status == ApiRequestEnum.DONE) {
      if (this._data == null)
        return true;
      else if (this._data is List) {
        var tempList = this._data as List;
        if (tempList.isEmpty)
          return true;
        else
          return false;
      } else
        return false;
    } else
      return false;
  }

  @computed
  ApiRequestEnum get getStatus => this._status;

  @computed
  T get getData => this._data;

  @computed
  int get currentPage => this._page ?? 0;

  @computed
  bool get hasNextPage {
    if (this._page != null && this._page >= 0)
      return true;
    else
      return false;
  }

  @computed
  dynamic get getError => this._error;

  @action
  setPending() {
    this._error = null;
    this._status = ApiRequestEnum.PENDING;
    return this;
  }

  @action
  setFetching() {
    this._error = null;
    this._status = ApiRequestEnum.FETCHING;
    return this;
  }

  @action
  setDone(T data, {int currentPage}) {
    this._error = null;
    this._data = data;
    if (currentPage != null) this._page = currentPage;
    this._status = ApiRequestEnum.DONE;
    return this;
  }

  @action
  setError(dynamic error) {
    if (_page == null) this._data = null;
    this._error = error;
    this._status = ApiRequestEnum.ERROR;
    this._page = -1;
    return this;
  }

  @action
  setIdle() {
    this._data = null;
    this._error = null;
    this._status = ApiRequestEnum.IDLE;
    this._page = 0;
    return this;
  }
}
