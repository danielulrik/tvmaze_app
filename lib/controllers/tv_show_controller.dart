

import 'package:mobx/mobx.dart';
import 'package:tvmaze_app/api/api_request.dart';
import 'package:tvmaze_app/api/tv_shows_api.dart';
import 'package:tvmaze_app/dtos/episode_dto.dart';
import 'package:tvmaze_app/dtos/season_dto.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';

part 'tv_show_controller.g.dart';

class TvShowController = _TvShowController with _$TvShowController;

abstract class _TvShowController with Store {

  TvShowsApi _tvShowsApi = TvShowsApi();
  ApiRequest<List<SeasonDto>> seasonsRequest = new ApiRequest<List<SeasonDto>>();

  getSeasons(int showId) {
    this.seasonsRequest.setPending();
    _tvShowsApi.getSeasonsByShowId(showId).then((response) async {

      var list = response as List;
      var seasons = list.map((season) {
        var json = season;
        return SeasonDto.fromJson(json);
      }).toList();

      seasonsRequest.setDone(seasons);
    }).catchError((error) {
      seasonsRequest.setError(error);
    });
  }

}