
typedef void PressCallback();

class Utils {

  static String formatStudyDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    return "${duration.inHours.remainder(60)}:${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}";
  }


  /// Validation section
  static bool isValidEmail(String email) {
    RegExp regExp = RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
    return regExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    RegExp regExp = RegExp(r"^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$");
    return regExp.hasMatch(password);
  }

}