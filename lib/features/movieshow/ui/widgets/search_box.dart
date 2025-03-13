import 'package:flutter/material.dart';

import '../../../../core/structure/widget_structure.dart';

class _Structure extends WidgetStructure{
  static final Size _baseSize = Size(290, 50);

  static double scale = 1;

  double height = 50 * scale;
  double width = 290 * scale;

  BorderRadius searchBarBorderRad = BorderRadius.circular(35.0 * scale);

  /// Trailing "Search" icon size
  double iconSize = 20 * scale;

  TextStyle hintStyle = TextStyle(fontFamily: 'Akatab', color: Color.fromARGB(127, 255, 255, 255), fontWeight: FontWeight.w400, fontSize: 14 * scale);


  _Structure._(Size size) : super(currentSize: size, baseSize: _baseSize);

  static _Structure? _instance;

  factory _Structure.instanceFor(Size size) {
    _instance ??= _Structure._(size);
    return _instance!;
  }
  
}

class SearchBoxWidget extends StatelessWidget {
  final double height;
  final double width;
  const SearchBoxWidget({super.key, required this.height, required this.width});

  static final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    
    return LayoutBuilder(
      builder: (context, constraints) {

        _Structure structure = _Structure.instanceFor(Size(width, height));

        return SizedBox(
          height: height,
          width: width,
          child: SearchBar(
            focusNode: _focusNode,
            onTap: () {
            },
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
            hintText: "Search",
            hintStyle: WidgetStatePropertyAll(structure.hintStyle),
            trailing: [
              Icon(
                Icons.search, 
                size: structure.iconSize, 
                color: Color.fromARGB(255, 142, 143, 146),
              ),
            ],
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: structure.searchBarBorderRad, 
              side: BorderSide(color: Color(0xFF888A8F))
            )),
          ),
        );
      }
    );
  }
}