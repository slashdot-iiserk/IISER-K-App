import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iiserk_app/helpers/app_futures.dart';
import 'package:iiserk_app/models/lms_category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iiserk_app/models/base/EventObject.dart';
import 'package:iiserk_app/models/User.dart';
import 'package:iiserk_app/ui/courses_screen.dart';
import 'package:iiserk_app/ui/views/nav_drawer.dart';
import 'package:iiserk_app/utils/app_shared_preferences.dart';
import 'package:iiserk_app/utils/constants.dart';
import 'package:iiserk_app/utils/app_base.dart';
import 'package:iiserk_app/widgets/progress_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  User? user;
  String token = "";
  //BuildContext _context;
  List<LmsCategory> categories = [], levels1 = [], levels2 = [];
  ProgressWidget progressWidget = ProgressWidget();

  Future<void> initUserProfile() async {
    User _user = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    //_context = context;
    if (user == null) {
      initUserProfile();
      categories = List.empty(growable: true);
      _getCategories();
    }

    return Scaffold(
      key: globalKey,
      appBar: getAppBarWithBackBtn(
          ctx: context,
          title: Texts.APP_NAME, //bgColor: ColorConst.WHITE_BG_COLOR,
          icon: IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                globalKey.currentState?.openDrawer();
              })),
      drawer: NavDrawer(),
      body: Container(
        //decoration: BoxDecoration(color: Colors.grey),
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Choose Your Level",
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 55),
            child: mainBody(),
          ),
          progressWidget
        ]),
      ),
    );
  }

  AppBar getAppBarWithBackBtn(
      {required BuildContext ctx,
      String title = '',
      Color? bgColor,
      double? fontSize,
      String titleTag = '',
      Widget? icon}) {
    return AppBar(
      //backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
      leading: icon,
      centerTitle: true,
      title: Hero(tag: titleTag, child: new Text(title)),
    );
  }

  Widget mainBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //gridTitle("PRIMARY"),
            gridView(categories),
            //gridTitle("SECONDARY"),
            //gridView(levels2),
          ],
        ),
      ),
    );
  }

  Widget gridTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget gridView(List<LmsCategory> levels) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      childAspectRatio: MediaQuery.of(context).size.height / 600,
      children: List.generate(
        levels.length,
        (index) {
          final item = levels[index];
          return GestureDetector(
            onTap: () {
              navigateToCourses(item);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: new AssetImage("assets/images/" +
                                AppBase.getCartImage(item.name))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          item.name,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _getCategories() async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN) ??
            '';
    EventObject eventObject = await fetchCategories(token);
    switch (eventObject.id) {
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            progressWidget.hideProgress();
            categories = [];
            categories = eventObject.object;
            //_goToStartScreen();
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
            ));
            progressWidget.hideProgress();
          });
        }
        break;
    }
  }

  void navigateToCourses(LmsCategory category) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CoursesScreen(category);
    }));
  }
}
