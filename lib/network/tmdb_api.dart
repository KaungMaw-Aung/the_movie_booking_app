import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/responses/credit_response.dart';
import 'package:the_movie_booking_app/network/responses/movie_list_response.dart';

import 'api_constants.dart';

part 'tmdb_api.g.dart';

@RestApi(baseUrl: TMDB_BASE_URL_DIO)
abstract class TmdbApi {
  factory TmdbApi(Dio dio) = _TmdbApi;

  @GET(ENDPOINT_NOW_PLAYING_MOVIES)
  Future<MovieListResponse?> getNowPlayingMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET(ENDPOINT_COMING_SOON_MOVIES)
  Future<MovieListResponse?> getComingSoonMovies(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
    @Query(PARAM_PAGE) String page,
  );

  @GET("$ENDPOINT_MOVIE_DETAIL/{movie_id}")
  Future<MovieVO?> getMovieDetail(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

  @GET("/3/movie/{movie_id}/credits")
  Future<CreditResponse> getMovieCredit(
    @Path("movie_id") String movieId,
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LANGUAGE) String language,
  );

}
