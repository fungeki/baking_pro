import 'package:baking_pro/Utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class InputRecipeDefineHeadlines extends StatefulWidget {
  const InputRecipeDefineHeadlines(
      {Key? key,
      required this.backPressed,
      required this.nextPressed,
      required this.deleteItem,
      required this.pageTitle,
      required this.cardHeadline,
      required this.hint})
      : super(key: key);

  final VoidCallback backPressed;
  final Function nextPressed;
  final Function deleteItem;
  final String pageTitle;
  final String cardHeadline;
  final String hint;
  @override
  _InputRecipeDefineHeadlinesState createState() =>
      _InputRecipeDefineHeadlinesState();
}

class _InputRecipeDefineHeadlinesState extends State<InputRecipeDefineHeadlines>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final _listScrollController = ScrollController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<String> titles = [''];
  List<TextEditingController> _textControllerList = [TextEditingController()];

  void _nextPressed() {
    if (titles.length == 1) {
      if (titles[0].trim().length < 1) titles.removeAt(0);
    }
    widget.nextPressed(titles);
  }

  void _onDeletePressed(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (index == titles.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("כותרת אחרונה נשארת ריקה, אין צורך במחיקה"),
      ));
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('מחיקת כותרת'),
              content: Text('האם למחוק את הכותרת מהרשימה?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'ביטול',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    listKey.currentState?.removeItem(
                        index,
                        (context, animation) => SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.vertical,
                            child: buildCardForList(index)),
                        duration: Duration(milliseconds: 300));
                    _textControllerList.removeAt(index);
                    titles.removeAt(index);
                    widget.deleteItem(index);
                    setState(() {
                      int currentIndex = 0;
                      _textControllerList.forEach((element) {
                        element.text = titles[currentIndex];
                        currentIndex++;
                      });
                    });
                  },
                  child: const Text(
                    'מחיקה',
                    style: TextStyle(color: kBakeZoneOrange),
                  ),
                ),
              ],
            ));
  }

  void _onTextChanged({required String value, required int index}) {
    if (titles.length <= index) {
      titles.add('');
    }
    if (index == titles.length - 1) {
      titles.add('');
      _textControllerList.add(TextEditingController());
      listKey.currentState
          ?.insertItem(index + 1, duration: Duration(milliseconds: 300));
      Future.delayed(const Duration(milliseconds: 350), () {
        setState(() {
          _listScrollController.animateTo(
            _listScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
          );
        });
      });
    }

    titles[index] = value.trim();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: TextButton(
                      onPressed: widget.backPressed,
                      child: Text(
                        'הקודם',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.pageTitle,
                        style: kGroupHeadlineTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: TextButton(
                      onPressed: () {
                        _nextPressed();
                      },
                      child: Text(
                        'הבא',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: AnimatedList(
                key: listKey,
                initialItemCount: 1,
                controller: _listScrollController,
                itemBuilder: (BuildContext context, int index,
                    Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset(0, 0),
                    ).animate(animation),
                    child: buildCardForList(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardForList(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cardHeadline + " " + (index + 1).toString(),
              style: kGroupHeadlineTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 30,
                      controller: _textControllerList[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: widget.hint,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: kBakeZoneGreen)),
                        labelStyle: GoogleFonts.assistant(
                          color: kBakeZoneGreen,
                        ),
                      ),
                      onChanged: (value) =>
                          _onTextChanged(value: value, index: index),
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _onDeletePressed(index);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: kBakeZoneOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
