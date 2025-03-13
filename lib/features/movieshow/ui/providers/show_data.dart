import 'package:flutter/foundation.dart';

import '../../domain/entities/show.dart';
import '../../domain/entities/watching_show.dart';

class TrendingShowProvider extends ChangeNotifier {
  List<Show> _shows = [];
  List<Show> get shows => _shows;

  static TrendingShowProvider? _instance;
  static TrendingShowProvider get instance {
    _instance ??= TrendingShowProvider._();
    return _instance!;
  }

  TrendingShowProvider._();


  void init() {
    if(shows.isNotEmpty) return;

    _shows = [
      Show(
        id: UniqueKey().toString(), 
        title: "Yes I Do", 
        overview: "", 
        posterPath: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjk5ZsRrqJ0w3MAN-2m2xiXMD0Ysw1onuesiuPPoJkzDy-hnfZ5l7YGcJlrAw7_z7-EWmZDsryHSyqQmcU_UMmFLI_Ppt_JfOrqY73LaPtlFTHUDDOdSBmhyLG6mXVW1h1AwDFBqnjwL-c5rk0aUQk6nCHG57lXYhDxKjoVuccLcaun0_C_XKaC-jNScY4/s320-rw/poster%20(5).jpg", 
        releaseDate: "",
        durationInSeconds: 2 * 60 * 60,
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Inside Out", 
        overview: "", 
        posterPath: "https://i.ebayimg.com/images/g/qHAAAOSwNr1mKbzO/s-l1200.jpg", 
        releaseDate: "June 14, 2024",
        durationInSeconds: 2 * 60 * 60,
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Babylon", 
        overview: "", 
        posterPath: "https://filmartgallery.com/cdn/shop/files/Babylon-Vintage-Movie-Poster-Original.jpg?v=1738913976", 
        releaseDate: "December 23, 2022", 
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Love Again", 
        overview: "", 
        posterPath: "https://i.ebayimg.com/images/g/9QwAAOSwgZ9kAUr6/s-l400.jpg", 
        releaseDate: "",
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Sunita", 
        overview: "", 
        posterPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4XfCuI4z1iYfwJBq-pufSDixrdgur9QWuKw&s", 
        releaseDate: "December 23, 2022",
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Pokemon: detective Pickachu", 
        overview: "", 
        posterPath: "https://images.fandango.com/ImageRenderer/820/0/redesign/static/img/default_poster.png/0/images/masterrepository/fandango/215720/PokemonDetectivePikachu-4K-1000x1000.jpg", 
        releaseDate: "June 14, 2024",
        durationInSeconds: 2 * 60 * 60
      ),
    ];
  }


}




class WatchingShowsProvider extends ChangeNotifier {
  List<WatchingShow> _shows = [];
  List<WatchingShow> get shows => _shows;

  static WatchingShowsProvider? _instance;
  static WatchingShowsProvider get instance {
    _instance ??= WatchingShowsProvider._();
    return _instance!;
  }

  WatchingShowsProvider._();


  void init() {
    if(shows.isNotEmpty) return;

    _shows = [

      WatchingShow(
        show: Show(
          id: UniqueKey().toString(), 
          title: "WednesDay | Season - 1 | Episode - 3", 
          overview: "", 
          posterPath: "https://i.ebayimg.com/images/g/4NQAAOSwyTpjk7dC/s-l400.jpg", 
          releaseDate: "",
          durationInSeconds: 2 * 60 * 60
        ),
        pausedAtTimeInSeconds: ((2 * 60 * 60) * .21).floor()
      ),

      WatchingShow(
        show: Show(
          id: UniqueKey().toString(), 
          title: "Emily In Paris | Season - 1 | Episode - 1", 
          overview: "", 
          posterPath: "https://m.media-amazon.com/images/I/71CccL8hGJL._AC_UF894,1000_QL80_.jpg", 
          releaseDate: "",
          durationInSeconds: 2 * 60 * 60
        ),
        pausedAtTimeInSeconds: ((2 * 60 * 60) * .8).floor()
      ),

      WatchingShow(
        show: Show(
          id: UniqueKey().toString(), 
          title: "Ne Zha 2", 
          overview: "", 
          posterPath: "https://i0.wp.com/themonkstudios.com/wp-content/uploads/2025/01/web_poster_Nezha2.webp?resize=1080%2C1200&ssl=1", 
          releaseDate: "",
          durationInSeconds: 2 * 60 * 60
        ),
        pausedAtTimeInSeconds: ((2 * 60 * 60) * .5).floor()
      ),
      
      
    ];
  }


}



class RecommendedShowProvider extends ChangeNotifier {
  List<Show> _shows = [];
  List<Show> get shows => _shows;

  static RecommendedShowProvider? _instance;
  static RecommendedShowProvider get instance {
    _instance ??= RecommendedShowProvider._();
    return _instance!;
  }

  RecommendedShowProvider._();


  void init() {
    if(shows.isNotEmpty) return;

    _shows = [
      Show(
        id: UniqueKey().toString(), 
        title: "Love Again", 
        overview: "", 
        posterPath: "https://i.ebayimg.com/images/g/9QwAAOSwgZ9kAUr6/s-l400.jpg", 
        releaseDate: "",
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Sunita", 
        overview: "", 
        posterPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4XfCuI4z1iYfwJBq-pufSDixrdgur9QWuKw&s", 
        releaseDate: "December 23, 2022",
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Pokemon: detective Pickachu", 
        overview: "", 
        posterPath: "https://images.fandango.com/ImageRenderer/820/0/redesign/static/img/default_poster.png/0/images/masterrepository/fandango/215720/PokemonDetectivePikachu-4K-1000x1000.jpg", 
        releaseDate: "June 14, 2024",
        durationInSeconds: 2 * 60 * 60
      ),

      Show(
        id: UniqueKey().toString(), 
        title: "Venom", 
        overview: "", 
        posterPath: "https://m.media-amazon.com/images/M/MV5BZDMyYWU4NzItZDY0MC00ODE2LTkyYTMtMzNkNDdmYmFhZDg0XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg", 
        releaseDate: "June 14, 2024",
        durationInSeconds: 2 * 60 * 60
      ),
    ];
  }


}