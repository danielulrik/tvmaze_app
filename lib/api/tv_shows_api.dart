
import 'package:tvmaze_app/services/network_service.dart';

import 'base_api.dart';

class TvShowsApi extends ApiBase {

  Future<dynamic> getShows(num page) {
    return this.request(HttpMethod.GET, 'shows?page=$page').then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> getShowsByQuery(String query) {
    return this.request(HttpMethod.GET, 'search/shows?q=$query').then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> getSeasonsByShowId(int showId) {
    return this.request(HttpMethod.GET, 'shows/$showId/seasons').then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

  Future<dynamic> getEpisodesBySeasonId(int seasonId) {
    return this.request(HttpMethod.GET, 'seasons/$seasonId/episodes').then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }

}