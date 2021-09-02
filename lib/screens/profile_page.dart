import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/screens/image_deatils.dart';
import 'package:baking_pro/widgets/ProfileImageWidget.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final tabBar = ProfileActivityTabBar();
  List<String> images = [
    'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
    // 'images/cover.jpg',
  ];
  final tabsColor = Colors.black;
  final profileInfoCard = ProfileInfoCard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BakeZoneAppbar(
        isProfilePage: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: images.length > 6
              ? TabControllerForMultipleActivities(
                  images: images,
                  profileInfoCard: profileInfoCard,
                  tabBar: tabBar,
                )
              : NoScrollingActivityProfile(
                  tabBar: tabBar,
                  images: images,
                  profileInfoCard: profileInfoCard,
                ),
        ),
      ),
    );
  }
}

class NoScrollingActivityProfile extends StatefulWidget {
  const NoScrollingActivityProfile({
    Key? key,
    required this.tabBar,
    required this.images,
    required this.profileInfoCard,
  }) : super(key: key);

  final ProfileActivityTabBar tabBar;
  final List<String> images;
  final ProfileInfoCard profileInfoCard;

  @override
  _NoScrollingActivityProfileState createState() =>
      _NoScrollingActivityProfileState();
}

class _NoScrollingActivityProfileState
    extends State<NoScrollingActivityProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileInfoCard(),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: widget.tabBar,
              body: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: [1, 2, 3]
                        .map((e) => GridView.count(
                              physics: BouncingScrollPhysics(),
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              children: widget.images
                                  .map((e) => InkResponse(
                                        enableFeedback: true,
                                        onTap: () => coverToDetails(context),
                                        child: Image(
                                          image: AssetImage(e),
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  .toList(),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TabControllerForMultipleActivities extends StatelessWidget {
  const TabControllerForMultipleActivities({
    Key? key,
    required this.images,
    required this.profileInfoCard,
    required this.tabBar,
  }) : super(key: key);

  final List<String> images;
  final ProfileInfoCard profileInfoCard;
  final ProfileActivityTabBar tabBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        body: TabBarView(
          children: [1, 2, 3]
              .map((e) => GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    children: images
                        .take(21)
                        .map((e) => GridTile(
                              child: InkWell(
                                enableFeedback: true,
                                onTap: () {
                                  coverToDetails(context);
                                },
                                child: Image(
                                  image: AssetImage(e),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: profileInfoCard,
              expandedHeight: 384.0,
              toolbarHeight: 384.0,
              leading: Container(),
            ),
            SliverPersistentHeader(
              delegate: ActivityTabsDelegate(tabBar),
              floating: true,
              pinned: true,
            ),
          ];
        },
      ),
    );
  }
}

class ProfileActivityTabs extends StatelessWidget {
  const ProfileActivityTabs({
    Key? key,
    required this.tabsColor,
  }) : super(key: key);

  final Color tabsColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kProfileCardElevation,
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: ProfileActivityTabBar(),
                body: TabBarView(
                  children: [
                    Icon(
                      Icons.directions_car,
                    ),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileActivityTabBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _ProfileActivityTabBarState createState() => _ProfileActivityTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ProfileActivityTabBarState extends State<ProfileActivityTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      tabs: [
        Tab(
          icon: Icon(
            Icons.image,
          ),
        ),
        Tab(
          icon: Icon(
            kIconForRecipes,
          ),
        ),
        Tab(
          icon: Icon(
            Icons.comment,
          ),
        ),
      ],
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kProfileCardElevation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  coverToDetails(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: (kProfileImageSize / 5) * 3.5),
                  child: Hero(
                    tag: 'image_details_images/cover.jpg',
                    child: Image.asset(
                      'images/cover.jpg',
                      fit: BoxFit.fitWidth,
                      height: kCoverHeight,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ImageDetails(
                              imageURI: 'images/bakeoff_winners_cropped.jpeg');
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Hero(
                          tag:
                              'image_details_images/bakeoff_winners_cropped.jpeg',
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2.5, color: Colors.white),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kProfileImageSize / 4.0)),
                            ),
                            child: ProfileImageWidget(
                              imageURI: 'images/bakeoff_winners_cropped.jpeg',
                              radius: kProfileImageSize / 4.0,
                              size: kProfileImageSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ImpactAmount(text: "מתכונים", number: '100K'),
                    ImpactAmount(text: 'עוקבים', number: '532M'),
                    ImpactAmount(text: 'לייקים', number: '8.1B'),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Text(
              'ניצן קריבין',
              style: GoogleFonts.assistant(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: kBlackTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Text(
              'זוכת בייקאוף | מתאמנת מספר אחת בארץ | מעצבת אפליקציות שחבלז | מכינה לרן עוגות גבינה',
              style: GoogleFonts.assistant(
                fontSize: 16.0,
                color: kBlackTextColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 32.0,
                    ),
                    child: Text(
                      'עריכת פרופיל',
                      style: GoogleFonts.assistant(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

void coverToDetails(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) {
    return ImageDetails(imageURI: 'images/cover.jpg');
  }));
}

class ImpactAmount extends StatelessWidget {
  final String text;
  final String number;

  ImpactAmount({required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.assistant(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              color: kBlackTextColor,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.assistant(
              fontSize: 16.0,
              color: kBlackTextColor,
            ),
          )
        ],
      ),
    );
  }
}

class ActivityTabsDelegate extends SliverPersistentHeaderDelegate {
  final ProfileActivityTabBar tabBar;
  ActivityTabsDelegate(this.tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
