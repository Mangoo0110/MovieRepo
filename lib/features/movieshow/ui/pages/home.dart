import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../widgets/continue_watching_shows.dart';
import '../widgets/recommended_shows.dart';
import '../widgets/search_box.dart';
import '../providers/home_ui_provider.dart';
import '../widgets/home_categories.dart';
import '../widgets/show_card.dart';
import '../widgets/trending_shows.dart';

class _Structure{
  static double scale = 1;
  //static double listHeight = 178 * scale;


  //static BorderRadius tileImageBorderRadius = BorderRadius.circular(6);

  static TextStyle welcomeTextStyle1 = TextStyle(color: const Color.from(alpha: 0.504, red: 1, green: 1, blue: 1), fontSize: 20, fontFamily: "Roboto", fontWeight: FontWeight.w500);
  static TextStyle welcomeTextStyle2 = TextStyle(color: const Color.from(alpha: 0.504, red: 1, green: 1, blue: 1), fontSize: 14, fontFamily: "Roboto", fontWeight: FontWeight.w400);

  /// Gap between the section title and show list
  static SizedBox appBarToBodyGap = SizedBox(height: 23,);
  /// Gap between the tile' show image and show title
  static SizedBox sectionGap = SizedBox(height: 10,);


  
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final ScrollController _scrollController = ScrollController();
  
  void _initialize() {
    HomeUiProvider.instance.init();
  }
  @override
  Widget build(BuildContext context) {

    // Inintialize home movie-shows ui provider.
    _initialize();

    return Scaffold(
      backgroundColor: AppColors.context(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              titleSpacing: 0,
              backgroundColor: AppColors.context(context).backgroundColor,
              //stretch: true,
              centerTitle: false,
              expandedHeight: 150,
              //pinned: true,
              floating: true,
              snap: true,
              elevation: 20,
              shadowColor: AppColors.context(context).shadowColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(top: 30, bottom: 4),
                expandedTitleScale: 1,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: SearchBoxWidget(
                    height: 50,
                    width: 290,
                  ),
                ),
                
                background: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Hello Rafsan', style: _Structure.welcomeTextStyle1,),
                          SizedBox(height: 1,),
                          Text("Let’s watch today", style: _Structure.welcomeTextStyle2,),
                          
                        ],
                      ),
                  
                      _profileAvatar(),
                    ],
                  ),
                ),
              ),
              
            ),

            SliverToBoxAdapter(child: _Structure.appBarToBodyGap),

            SliverToBoxAdapter(child: HomeCategories()),
        
            SliverToBoxAdapter(child: _Structure.sectionGap),
        
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MovieCard()
                  .animate().fadeIn(duration: Duration(milliseconds: 300), curve: Curves.fastOutSlowIn),
              )
            ),
        
            SliverToBoxAdapter(child: _Structure.sectionGap),
        
            SliverToBoxAdapter(
              child: TrendingShows()
                .animate().fadeIn(duration: Duration(milliseconds: 300), delay: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn),
            ),
        
            SliverToBoxAdapter(child: _Structure.sectionGap),
        
            SliverToBoxAdapter(
              child: ContinueWatchingShows()
                .animate().fadeIn(duration: Duration(milliseconds: 300), delay: Duration(milliseconds: 2 * 200), curve: Curves.fastOutSlowIn),
            ),
        
            SliverToBoxAdapter(child: _Structure.sectionGap),
            
            SliverToBoxAdapter(
              child: RecommendedShows()
                .animate().fadeIn(duration: Duration(milliseconds: 300), delay: Duration(milliseconds: 3 * 200), curve: Curves.fastOutSlowIn),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileAvatar() {
    double radius = 46;
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipOval(
          child: Container(
            height: radius,
            width: radius,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 0, 140),
                  Color.fromARGB(255, 0, 255, 213),
                ]
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: ClipOval(
                child: Image.network(
                  height: radius - 2,
                  width: radius - 2,
                  "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: radius,
                      width: radius,
                      decoration: BoxDecoration(
                        color: AppColors.context(context).contentBoxGreyColor
                      ),
                      child: Center(child: Icon(Icons.person, size: 30,)),
                    );
                  },
                  // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    
                  //   return Container(
                  //     height: radius,
                  //     width: radius,
                  //     decoration: BoxDecoration(
                  //       color: AppColors.context(context).contentBoxGreyColor
                  //     ),
                  //     child: Center(child: Icon(Icons.person, size: 30,)),
                  //   );
                  // },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}