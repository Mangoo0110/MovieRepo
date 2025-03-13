import '../../domain/entities/watching_show.dart';

class WatchingShowModel extends WatchingShow {
  WatchingShowModel({
    required super.show,
    required super.pausedAtTimeInSeconds,
  });

  factory WatchingShowModel.fromMap(Map<String, dynamic> map) {
    return WatchingShowModel(
      show: map['show'],
      pausedAtTimeInSeconds: map['pausedAtTimeInSeconds'],
    );
  }
}
