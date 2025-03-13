import 'package:flutter/material.dart';
import '../../../../core/common/widgets/ui_button.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';

import '../providers/home_ui_provider.dart';

class _HomeCategoriesStructure{
  static TextStyle titleTextStyle = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle seeMoreTextStyle = TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300);
  
  static double titleContentGap = 7;
}

class HomeCategories extends StatefulWidget {
  const HomeCategories({super.key});
  
  @override
  State<HomeCategories> createState() => _HomeCategoriesState();
}

class _HomeCategoriesState extends State<HomeCategories> {

  
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories', style: _HomeCategoriesStructure.titleTextStyle),
                UiButton(
                  borderRadius: null,
                  onTap: () {  },
                  child: Text('See More', style: _HomeCategoriesStructure.seeMoreTextStyle),
                ),
              ],
            ),

            SizedBox(
              height: _HomeCategoriesStructure.titleContentGap,
            ),

            Wrap(
              spacing: 10,
              children: HomeUiProvider.instance.categories
                  .asMap()
                  .entries.map((e) => CategoryChip(key: UniqueKey(), category: e.value, index: e.key))
                  .toList(),
            ),
          ],
        );
      },
    );
  }

}


class _CategoryChipStructure {

  static Color inactiveButtonColor = Color.fromARGB(255, 34, 24, 33);
  static Color activeButtonColor = Color.fromARGB(248, 255, 255, 255);
  static Color activeTextColor = Colors.black;
  static Color inActiveTextColor = Color.fromARGB(255, 150, 150, 150);

  static TextStyle activeTextStyle = TextStyle(color: activeTextColor, fontSize: 14,);
  static TextStyle inActiveTextStyle = TextStyle(color: inActiveTextColor, fontSize: 14,);

  static BorderRadius activeBorderRadius = BorderRadius.circular(7);
  static BorderRadius inActiveBorderRadius = BorderRadius.circular(5);
}

class CategoryChip extends StatefulWidget {

  final String category;
  final int index;
  const CategoryChip({required super.key, required this.category, required this.index});

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {

  late int selectedCategoryIndex;
  bool isSelected = false;

  HomeUiProvider homeUiProvider = HomeUiProvider.instance;

  @override
  void initState() {
    // TODO: implement initState
    selectedCategoryIndex = homeUiProvider.selectedCategoryIndex;

    homeUiProvider.addListener((){
      if(selectedCategoryIndex != homeUiProvider.selectedCategoryIndex){
        selectedCategoryIndex = homeUiProvider.selectedCategoryIndex;
        setState(() {
            
        });
      }
    });
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {

    dekhao("Given catg(${widget.category}) index is ${widget.index}");

    isSelected = selectedCategoryIndex == widget.index;
    
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          height: 34,
          width: 68,
          duration: Duration(milliseconds: 550),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: isSelected
            ? _CategoryChipStructure.activeButtonColor
            : _CategoryChipStructure.inactiveButtonColor,

            borderRadius: isSelected
            ? _CategoryChipStructure.activeBorderRadius
            : _CategoryChipStructure.inActiveBorderRadius,
          ),
          child: InkWell(
            borderRadius: isSelected
            ? _CategoryChipStructure.activeBorderRadius
            : _CategoryChipStructure.inActiveBorderRadius,
            splashColor: AppColors.context(context).textColor,
            onTap: () {
              homeUiProvider.selectedCategoryIndex = widget.index;
            },
            child: Center(
              child: FittedBox(
                child: Text(
                  widget.category, 
                  style: isSelected
                  ? _CategoryChipStructure.activeTextStyle
                  : _CategoryChipStructure.inActiveTextStyle),
              ),
            ),
          ),
        );
      },
    );
  }
}