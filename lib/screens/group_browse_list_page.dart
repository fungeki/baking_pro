import 'package:baking_pro/Utils/constants.dart';
import 'package:baking_pro/screens/group_details.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GroupBrowseListPage extends StatefulWidget {
  GroupBrowseListPage({Key? key}) : super(key: key);

  @override
  _GroupBrowseListPageState createState() => _GroupBrowseListPageState();
}

class _GroupBrowseListPageState extends State<GroupBrowseListPage>
    with TickerProviderStateMixin {
  List<bool> isGroupFollowed = [];
  List<AnimationController> _bellAnimationControllers = [];

  void _onCardTap(BuildContext context, int index) {
    Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (context, animation, _) {
      return GroupDetails(
        group: groups[index],
      );
    }));
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < groups.length; i++) {
      isGroupFollowed.add(false);
      _bellAnimationControllers.add(AnimationController(
          duration: const Duration(milliseconds: 80), vsync: this));
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < _bellAnimationControllers.length; i++) {
      _bellAnimationControllers[i].dispose();
    }
    ;
    super.dispose();
  }

  void _onBellTap(index) {
    isGroupFollowed[index] = !isGroupFollowed[index];
    _bellAnimationControllers[index].forward().whenComplete(() =>
        _bellAnimationControllers[index].reverse().whenComplete(() =>
            _bellAnimationControllers[index].forward().whenComplete(
                () => _bellAnimationControllers[index].reverse())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            itemCount: groups.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: MediaQuery.of(context).size.height * (1.0 / 3.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    _onCardTap(context, index);
                  },
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 8.0, top: 4.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            groups[index].title,
                                            style: kGroupHeadlineTextStyle,
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            groups[index].subTitle,
                                            style: kBodyTextStyle,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.monetization_on,
                                        size: 40.0,
                                        color: kBlueTextColor,
                                      ),
                                      Icon(
                                        Icons.timelapse_sharp,
                                        size: 40.0,
                                        color: kBlueTextColor,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 48.0),
                                    child: Hero(
                                      tag: groups[index].title,
                                      child: Image.asset(
                                        groups[index].imageURI,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8.0,
                                  left: 16.0,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _onBellTap(index);
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                            color: isGroupFollowed[index]
                                                ? kBakeZoneGreen
                                                : Colors.grey,
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 4.0),
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        duration: Duration(milliseconds: 500),
                                        child: RotationTransition(
                                          turns: Tween(
                                                  begin: 1.0 / 20.0,
                                                  end: -(2.0 / 20.0))
                                              .animate(
                                                  _bellAnimationControllers[
                                                      index]),
                                          child: Icon(
                                            isGroupFollowed[index]
                                                ? Icons.notifications_active
                                                : Icons.notifications,
                                            color: Colors.white,
                                            size: 36.0,
                                          ),
                                        ),
                                      )),
                                ),
                                Positioned(
                                  bottom: 4.0,
                                  right: 8.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        (2 / 3),
                                    child: Text(
                                      groups[index].description,
                                      maxLines: 2,
                                      style: kBodyTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
