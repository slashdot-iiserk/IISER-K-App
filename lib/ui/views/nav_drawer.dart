import 'package:flutter/material.dart';
import 'package:iiserk_app/widgets/oval-right-clipper.dart';

// ignore: must_be_immutable
class NavDrawer extends StatelessWidget {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return _buildDrawer();
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.of(_context).pop()),
                  ),
                  InkWell(
                    onTap: () => _navigateOnNextScreen('Profile'),
                    child: Container(
                      height: 128,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Colors.white, Colors.blue])),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("assets/images/user-default.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text("Deepak Sharma"),
                  Text("@webaddicted"),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.category, "LmsCategory"),
                  _buildDivider(),
                  _buildRow(Icons.local_movies, "Tranding Movie",
                      showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.movie_filter, "Popular Movie",
                      showBadge: false),
                  _buildDivider(),
                  _buildRow(Icons.movie, "Upcoming Movie", showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "About us"),
                  _buildDivider(),
                  _buildRow(Icons.exit_to_app, "Exit"),
                  _buildDivider(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.white,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () => _navigateOnNextScreen(title),
        child: Row(children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 10.0),
          Text(title),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.white,
              elevation: 2.0,
              shadowColor: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                width: 10,
                height: 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // child: Text(
                //   "10+",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
            )
        ]),
      ),
    );
  }

  void _navigateOnNextScreen(String title) {
    Navigator.of(_context).pop();
    switch (title) {
      case "Home":
        // navigationPush(_context, CategoryMovie());
        break;
      case "LmsCategory":
        //navigationPush(_context, MovieListScreen(apiName: ApiConstant.GENRES_LIST));
        break;
      case "Tranding Movie":
        //navigationPush(_context, MovieListScreen(apiName: ApiConstant.TRENDING_MOVIE_LIST));
        break;
      case "Popular Movie":
        //navigationPush(_context, MovieListScreen(apiName: ApiConstant.POPULAR_MOVIES));
        break;
      case "Upcoming Movie":
        //navigationPush(_context, MovieListScreen(apiName: ApiConstant.UPCOMING_MOVIE));
        break;
      case "Profile":
        //navigationStateLessPush(_context, ProfileScreen());
        break;
      case "Settings":
        //navigationPush(_context, SettingScreen());
        break;
      case "Contact us":
        break;
      case "About us":
        break;
      case "Exit":
        //onWillPop(_context);
        break;
    }
  }
}
