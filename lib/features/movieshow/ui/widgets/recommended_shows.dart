import 'package:flutter/material.dart';
import '../providers/home_ui_provider.dart';

import '../../../../core/common/widgets/ui_button.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../domain/entities/show.dart';

class _Structure{
  static double scale = 1;
  static Size baseSize = Size(407, 178);
  double listHeight = 178 * scale;
  double tileHeight = 162 * scale;
  double tileImageHeight = 127 * scale;

  double tileWidth = 99 * scale;
  double tileImageWidth =  162 * scale;

  BorderRadius tileImageBorderRadius = BorderRadius.circular(10);

  TextStyle showTitleStyle = TextStyle(color: Colors.white, fontSize: 12, fontFamily: "Roboto");
  TextStyle titleTextStyle = TextStyle(color: Colors.white, fontFamily: "Akatab", fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle seeMoreTextStyle = TextStyle(color: Colors.white, fontFamily: "Roboto", fontSize: 14, fontWeight: FontWeight.w300);

  /// Gap between the section title and show list
  SizedBox titleContentGap = SizedBox(height: 16,);
  /// Gap between the tile' show image and show title
  SizedBox imageToShowTitleGap = SizedBox(height: 2,);

  _Structure(Size size) {
    
    scale = _area(size) / _area(baseSize);
  }

  double _area(Size size) {
    return size.height * size.width;
  }
  
}


class RecommendedShows extends StatelessWidget {
  const RecommendedShows({super.key});

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
                Text("Recommended For You", style: structure.titleTextStyle,),
                UiButton(
                  borderRadius: null,
                  onTap: () {  },
                  child: Text('See More', style: structure.seeMoreTextStyle),
                ),
              ],
            ),

            structure.titleContentGap,

            SizedBox(
              height: structure.listHeight,
              width: constraints.maxWidth,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HomeUiProvider.instance.recommendedShows.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: _RecommendedShowTile(
                      key: UniqueKey(), 
                      show: HomeUiProvider.instance.recommendedShows[index],
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


class _RecommendedShowTile extends StatefulWidget {
  final _Structure structure;
  final Show show;
  const _RecommendedShowTile({super.key, required this.show, required this.structure, });

  @override
  State<_RecommendedShowTile> createState() => _RecommendedShowTileState();
}

class _RecommendedShowTileState extends State<_RecommendedShowTile> {
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
                    height: 165,
                    width: 343,
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
          
              widget.structure.imageToShowTitleGap,
          
              Text(widget.show.title, maxLines: 2, style: widget.structure.showTitleStyle,)
            ],
          ),
        );
      },
    );
  }
}