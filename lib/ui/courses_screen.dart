import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iiserk_app/models/lms_category.dart';
import 'package:iiserk_app/models/lms_course.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iiserk_app/models/User.dart';
import 'package:iiserk_app/ui/modules_screen.dart';
import 'package:iiserk_app/utils/app_shared_preferences.dart';

class CoursesScreen extends StatefulWidget {
  final LmsCategory category;

  CoursesScreen(this.category);

  @override
  State<StatefulWidget> createState() {
    return CourseScreenState(this.category);
  }
}

class CourseScreenState extends State<CoursesScreen> {
  CourseScreenState(this.category);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  User? user;
  List<LmsCourse>? courses;
  LmsCategory category;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    User _user = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = _user;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void requestData() {
    courses = [];
    //for (int i = 0; i < books.length; i++)
    //  bookList.add(BookItem<Book>(books[i]));
    courses?.add(LmsCourse(1, 1, "Primary 1", "MATHEMATICS CF", "", ""));
    courses?.add(LmsCourse(2, 1, "Primary 2", "ENGLISH LANGUAGE CF", "", ""));
    courses?.add(LmsCourse(
        3, 1, "Primary 3", "BASIC SCIENCE AND TECHNOLOGY CF", "", ""));
  }

  @override
  Widget build(BuildContext context) {
    if (courses == null) {
      courses = List.empty(growable: true);
      requestData();
    }

    return WillPopScope(
      onWillPop: () async {
        moveToLastScreen();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: getAppBarWithBackBtn(ctx: context, title: category.name),
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      courses!.length.toString() + " Subjects",
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
            )
          ]),
        ),
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
            gridView(courses!),
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

  Widget gridView(List<LmsCourse> items) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      childAspectRatio: MediaQuery.of(context).size.height / 675,
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              navigateToModules(item);
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
                                getCartImage(item.shortname))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          item.fullname,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
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

  String getCartImage(String title) {
    String imageStr = '';
    switch (title) {
      case "Primary 1":
        imageStr = "primary1.png";
        break;

      case "Primary 2":
        imageStr = "primary2.png";
        break;

      case "Primary 3":
        imageStr = "primary3.png";
        break;

      case "Primary 4":
        imageStr = "primary4.png";
        break;

      case "Primary 5":
        imageStr = "primary5.png";
        break;

      case "Primary 6":
        imageStr = "primary6.png";
        break;
    }
    return imageStr;
  }

  void navigateToModules(LmsCourse course) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ModulesScreen(course);
    }));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
