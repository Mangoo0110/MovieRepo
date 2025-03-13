import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/watching_show.dart';
import '../providers/home_ui_provider.dart';

import '../../../../core/common/widgets/ui_button.dart';
import '../../../../core/utils/constants/app_colors.dart';

class _Structure{
  static double scale = 1;
  static Size baseSize = Size(407, 178);
  double listHeight = 178 * scale;
  double tileHeight = 165 * scale;
  double tileWidth = 167 * scale;
  double tileImageHeight = 109.26 * scale;
  double tileImageWidth = 167 * scale;
  double watchedTimeIndicatorHeight = min(8, 5.57 * scale);

  double watchedTimeIndicatorWidth({required int watchedTimeInSeconds, required int fullShowTimeInSeconds}) {
    if(watchedTimeInSeconds > fullShowTimeInSeconds) return 0;
    return 167 * (watchedTimeInSeconds / fullShowTimeInSeconds);
  }

  BorderRadius tileImageBorderRadius = BorderRadius.circular(6);

  double titleToListGap = 12;
  double imageToShowTitleGap = 10;

  TextStyle showTitleStyle = TextStyle(color: Colors.white, fontSize: 14, fontFamily: "Akatab");
  TextStyle titleTextStyle = TextStyle(color: Colors.white, fontFamily: "Akatab", fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle seeMoreTextStyle = TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 14, fontWeight: FontWeight.w300);

  Color watchedShowIndicatorColor = Color.fromARGB(255, 219, 32, 44);

  _Structure(Size size) {
    
    scale = _area(size) / _area(baseSize);
  }

  double _area(Size size) {
    return size.height * size.width;
  }

  
}


class ContinueWatchingShows extends StatelessWidget {
  const ContinueWatchingShows({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final _Structure structure = _Structure(Size(constraints.maxWidth, _Structure.baseSize.height));
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Continue Watching", style: structure.titleTextStyle,),
                UiButton(
                  borderRadius: null,
                  onTap: () {  },
                  child: Text('See More', style: structure.seeMoreTextStyle),
                ),
              ],
            ),

            SizedBox(
              height: structure.titleToListGap,
            ),

            SizedBox(
              height: structure.listHeight,
              width: constraints.maxWidth,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeUiProvider.instance.watchingShow.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: _ContinueWatchingShowTile(
                      key: UniqueKey(), 
                      watchingShow: HomeUiProvider.instance.watchingShow[index],
                      structure: structure,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}



class _ContinueWatchingShowTile extends StatefulWidget {
  final _Structure structure;
  final WatchingShow watchingShow;
  const _ContinueWatchingShowTile({super.key, required this.watchingShow, required this.structure, });

  @override
  State<_ContinueWatchingShowTile> createState() => _ContinueWatchingShowTileState();
}

class _ContinueWatchingShowTileState extends State<_ContinueWatchingShowTile> {
  
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(

          height: widget.structure.tileHeight,
          width: widget.structure.tileWidth,
          child: Column(

            children: [
              SizedBox(
                height: widget.structure.tileImageHeight,
                width: widget.structure.tileImageWidth,
                child: ClipRRect(
                  borderRadius: widget.structure.tileImageBorderRadius,
                  child: Stack(
                    children: [

                      Image.network(
                        height: widget.structure.tileImageHeight,
                        width: widget.structure.tileImageWidth,
                        fit: BoxFit.cover,
                        widget.watchingShow.show.posterPath,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: widget.structure.tileImageHeight,
                            width: widget.structure.tileImageWidth,
                            decoration: BoxDecoration(
                              color: AppColors.context(context).contentBoxGreyColor
                            ),
                            child: Center(child: Icon(Icons.image, size: 30,)),
                          );
                        },
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: widget.structure.watchedTimeIndicatorHeight,
                          width: widget.structure.watchedTimeIndicatorWidth(
                            watchedTimeInSeconds: widget.watchingShow.pausedAtTimeInSeconds, 
                            fullShowTimeInSeconds: widget.watchingShow.show.durationInSeconds
                          ),
          
                          decoration: BoxDecoration(
                            color: widget.structure.watchedShowIndicatorColor
                          ),
          
                        ),
                      )
                    ],
                  ),
                ),
              ),
          
              SizedBox(height: widget.structure.imageToShowTitleGap,),
          
              Text(widget.watchingShow.show.title, maxLines: 2, style: widget.structure.showTitleStyle,)
            ],
          ),
        );
      },
    );
  }
}