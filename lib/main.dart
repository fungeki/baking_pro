import 'package:baking_pro/screens/group_browse.dart';
import 'package:baking_pro/screens/group_browse_list_page.dart';
import 'package:baking_pro/screens/zift_page.dart';
import 'package:baking_pro/widgets/bakezone_app_bar.dart';
import 'package:baking_pro/widgets/bottom_navigation_bar_bakezone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPage = 1;

  final _mainPages = [ZiftPage(), GroupBrowseListPage(), ZiftPage()];
  void _changePage(int switchToPage) {
    setState(() {
      //     Navigator.of(context).popUntil((route) => route.isFirst);
      _currentPage = switchToPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFF3d405b),
        appBarTheme: AppBarTheme(color: Color(0xFF3d406b)),
        scaffoldBackgroundColor: Color(0xFFF4F1DE),
        textTheme: GoogleFonts.assistantTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('he', 'IL')],
      home: Scaffold(
        appBar: BakeZoneAppbar(
          isProfileImageLeading: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: IndexedStack(
            children: _mainPages,
            index: _currentPage,
          ),
        ),
        bottomNavigationBar: BottomNavigationBarBakezone(
          currentIndex: _currentPage,
          onPageTap: _changePage,
        ),
      ),
    );
  }
}
