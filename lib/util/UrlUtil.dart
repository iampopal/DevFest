import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  static void launchFacebook(String id) async {
    launchURL("https://www.fb.me/$id");
  }

  static void launchInstagram(String id) async {
    launchURL("https://www.instagram.com/$id");
  }

  static void launchTwitter(String id) async {
    launchURL("https://www.twitter.com/$id");
  }

  static void launchGitHub(String id) async {
    launchURL("https://www.twitter.com/$id");
  }

  static void launchMeetUp() async {
    launchURL("https://www.meetup.com/GDG-Kabul");
  }

  static void launchEmail(String email) async {
    launchURL("mailto:$email?subject=&body=");
  }

  static void launchTel(String tel) async {
    launchURL("tel:$tel");
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
