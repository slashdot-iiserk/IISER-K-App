class AppBase {
  static String getCartImage(String title) {
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

      case "JSS 1":
        imageStr = "jss1.png";
        break;

      case "JSS 2":
        imageStr = "jss2.png";
        break;

      case "JSS 3":
        imageStr = "jss3.png";
        break;

      case "SSS 1":
        imageStr = "sss1.png";
        break;

      case "SSS 2":
        imageStr = "sss2.png";
        break;

      case "SSS 3":
        imageStr = "sss3.png";
        break;
    }
    return imageStr;
  }
}
