
import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:tvmaze_app/api/api_request.dart';
import 'package:tvmaze_app/api/tv_shows_api.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';

part 'tv_shows_controller.g.dart';

class TvShowsController = _TvShowsController with _$TvShowsController;

abstract class _TvShowsController with Store {

  TvShowsApi _tvShowsApi = TvShowsApi();
  ApiRequest<List<TvShowDto>> showsRequest = new ApiRequest<List<TvShowDto>>();
  List<TvShowDto> showsLoaded = List();

  Timer _debounceSearch;

  @action
  getShows({num page = 0}) {
    var currentPage = page ?? this.showsRequest.currentPage;

    if (currentPage == 0) {
      this.showsLoaded.clear();
      this.showsRequest.setPending();
    } else {
      this.showsRequest.setFetching();
    }
    _tvShowsApi.getShows(currentPage).then((response) async {

      int nextPage = response.length > 0 ? currentPage + 1 : -1;
      var list = response as List;
      var shows = list.map((showJson) => TvShowDto.fromJson(showJson)).toList();

      showsLoaded.addAll(shows);
      showsRequest.setDone(showsLoaded, currentPage: nextPage);

    }).catchError((error) {
      showsRequest.setError(error);
    });

  }

  @action
  debouncedSearch(String query) {
    if (_debounceSearch?.isActive ?? false) _debounceSearch.cancel();

    _debounceSearch = Timer(const Duration(seconds: 1), () {
      getShowsByQuery(query);
    });
  }


  @action
  getShowsByQuery(String query) {
    this.showsRequest.setPending();
    _tvShowsApi.getShowsByQuery(query).then((response) async {

      var list = response as List;
      var shows = list.map((showJson) {
        var json = showJson['show'];
        return TvShowDto.fromJson(json);
      }).toList();

      showsLoaded.clear();
      showsRequest.setDone(shows);

    }).catchError((error) {
      showsRequest.setError(error);
    });

  }

}