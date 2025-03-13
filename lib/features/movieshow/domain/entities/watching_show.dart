import 'show.dart';

class WatchingShow {
  final Show show;
  /// In second
  /// ****
  /// e.g.
  /// 
  /// 2min, 30sec => 90 (sec),
  /// 
  /// 1hr, 2min, 12sec => 3732 (sec)
  final int pausedAtTimeInSeconds;

  WatchingShow({required this.show, required this.pausedAtTimeInSeconds});
}