import 'package:http/http.dart' show post;

class MoodleHelper {
  static String moodleHost = "https://welearn.iiserkol.ac.in/login/token.php";

  login(String username, String password) {
    Uri url = Uri.parse(moodleHost +
        "?username=$username&password=$password&service=moodle_mobile_app");
    fetchData(url);
  }

  fetchData(Uri url) async {
    var result = await post(url);
    print(result);
  }
}
