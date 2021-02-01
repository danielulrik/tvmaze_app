

import 'package:mobx/mobx.dart';
import 'package:tvmaze_app/api/api_request.dart';
import 'package:tvmaze_app/api/tv_shows_api.dart';
import 'package:tvmaze_app/dtos/episode_dto.dart';
import 'package:tvmaze_app/dtos/season_dto.dart';
import 'package:tvmaze_app/dtos/tv_show_dto.dart';

part 'episodes_controller.g.dart';

class EpisodesController = _EpisodesController with _$EpisodesController;

abstract class _EpisodesController with Store {

  TvShowsApi _tvShowsApi = TvShowsApi();
  ApiRequest<List<EpisodeDto>> episodesRequest = new ApiRequest<List<EpisodeDto>>();

  getEpisodes(int seasonId) {
    this.episodesRequest.setPending();
    _tvShowsApi.getEpisodesBySeasonId(seasonId).then((response) async {

      var list = response as List;
      var episodes = list.map((season) {
        var json = season;
        return EpisodeDto.fromJson(json);
      }).toList();

      episodesRequest.setDone(episodes);
    }).catchError((error) {
      episodesRequest.setError(error);
    });
  }

}