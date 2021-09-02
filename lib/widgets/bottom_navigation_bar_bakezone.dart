import 'package:flutter/material.dart';

class BottomNavigationBarBakezone extends StatefulWidget {
  int currentIndex;
  final Function(int) onPageTap;
  @override
  _BottomNavigationBarBakezoneState createState() =>
      _BottomNavigationBarBakezoneState(
          onPageTap: onPageTap, currentIndex: currentIndex);

  BottomNavigationBarBakezone(
      {required this.currentIndex, required this.onPageTap});
}

class _BottomNavigationBarBakezoneState
    extends State<BottomNavigationBarBakezone> {
  _BottomNavigationBarBakezoneState(
      {required this.currentIndex, required this.onPageTap});

  final Function(int) onPageTap;
  int currentIndex;
  void _onItemTapped(int index) {
    if (currentIndex == index) return;
    setState(() {
      currentIndex = index;
      onPageTap(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      enableFeedback: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'מועדפים',
            backgroundColor: Color(0xFF81B29A)),
        BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'קבוצות',
            backgroundColor: Color(0xFFEFBF7B)),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications),
            label: 'הודעות',
            backgroundColor: Color(0xFFE07A5F)),
      ],
      onTap: _onItemTapped,
      type: BottomNavigationBarType.shifting,
    );
  }
}
