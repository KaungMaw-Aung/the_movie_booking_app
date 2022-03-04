import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'cinema_list_for_hive_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_CINEMA_LIST_FOR_HIVE_VO, adapterName: "CinemaListForHiveVOAdapter")
class CinemaListForHiveVO {

  @HiveField(0)
  List<CinemaVO> cinemas;

  CinemaListForHiveVO(this.cinemas);

}