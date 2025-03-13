import 'package:flutter/foundation.dart';
import '../../domain/entities/watching_show.dart';
import 'show_data.dart';

import '../../domain/entities/show.dart';

class HomeUiProvider extends ChangeNotifier{

  HomeUiProvider._();

  static HomeUiProvider? _instance;
  static HomeUiProvider get instance {
    _instance ??= HomeUiProvider._();
    return _instance!;
  }

  List<String> _categories = [];
  List<String> get categories => _categories;

  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  set selectedCategoryIndex(int newIndex){
    if(newIndex > _categories.length || newIndex < 0) return;
    _selectedCategoryIndex = newIndex;
    notifyListeners();
  }

  final TrendingShowProvider _trendingShowProvider = TrendingShowProvider.instance;
  final WatchingShowsProvider _watchingShowsProvider = WatchingShowsProvider.instance;
  final RecommendedShowProvider _recommendedShowProvider = RecommendedShowProvider.instance;

  List<Show> get trendingShows => _trendingShowProvider.shows;
  List<WatchingShow> get watchingShow => _watchingShowsProvider.shows;
  List<Show> get recommendedShows => _recommendedShowProvider.shows;
  

  void init() {
    _categories = ['All', 'Action', 'Anime', 'Sci-fi', 'Thriller'];
    _trendingShowProvider.init();
    _watchingShowsProvider.init();
    _recommendedShowProvider.init();
  }

  
}

