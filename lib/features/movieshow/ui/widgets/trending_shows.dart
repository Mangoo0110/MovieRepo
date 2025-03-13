import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movie_repo/core/utils/constants/app_colors.dart';
import 'package:movie_repo/features/movieshow/ui/providers/home_ui_provider.dart';

import '../../../../core/common/widgets/ui_button.dart';
import '../../domain/entities/show.dart';

class _Structure{
  static double scale = 1;
  static Size baseSize = Size(407, 178);
  double listHeight = 178 * scale;
  double tileHeight = 160 * scale;
  double tileWidth = 99 * scale;
  double tileImageHeight = 127 * scale;
  double tileImageWidth = 99 * scale;

  BorderRadius tileImageBorderRadius = BorderRadius.circular(10);

  TextStyle showTitleStyle = TextStyle(color: Colors.white, fontSize: 12, fontFamily: "Roboto");
  TextStyle titleTextStyle = TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle seeMoreTextStyle = TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 14, fontWeight: FontWeight.w300);

  double titleContentGap = 32;
  double imageShowTitleGap = 12;

  _Structure(Size size) {
    
    scale = _area(size) / _area(baseSize);
  }

  double _area(Size size) {
    return size.height * size.width;
  }
  
}


class TrendingShows extends StatelessWidget {


  const TrendingShows({super.key,});

  

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
                Text("Trending Movies", style: structure.titleTextStyle,),
                UiButton(
                  borderRadius: null,
                  onTap: () {  },
                  child: Text('See More', style: structure.seeMoreTextStyle),
                ),
              ],
            ),

            SizedBox(
              height: structure.titleContentGap,
            ),

            SizedBox(
              height: structure.listHeight,
              width: constraints.maxWidth,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeUiProvider.instance.trendingShows.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: _TrendingShowTile(
                      key: UniqueKey(), 
                      show: HomeUiProvider.instance.trendingShows[index], 
                      index: index,
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


class _TrendingShowTile extends StatefulWidget {
  final int index;
  final Show show;
  final _Structure structure;
  const _TrendingShowTile({required super.key, required this.show, required this.index, required this.structure, });

  @override
  State<_TrendingShowTile> createState() => _TrendingShowTileState();
}

class _TrendingShowTileState extends State<_TrendingShowTile> {
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
                  child: Image.network(
                    height: widget.structure.tileImageHeight,
                    width: widget.structure.tileImageWidth,
                    fit: BoxFit.cover,
                    widget.show.posterPath,
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
                ),
              ),
          
              SizedBox(height: widget.structure.imageShowTitleGap,),
          
              Text(widget.show.title, style: widget.structure.showTitleStyle,)
            ],
          ),
        )
        .animate().slideY(
          begin: 
            (widget.index % 2 != 0) 
            // if odd
            ? 0 
            // if even
            : .1, 
          end: 
            (widget.index % 2 != 0) 
            // if odd
            ? 0.1 
            // if even
            : 0, 
          duration: Duration(milliseconds: 700), delay: Duration(milliseconds: 200 + 100 * widget.index)
        )
        ;
      },
    );
  }
}