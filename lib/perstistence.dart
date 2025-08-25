import "package:shared_preferences/shared_preferences.dart";

SharedPreferences? _prefs;

Future<void> initializePerstistence() async {
  _prefs = await SharedPreferences.getInstance();
}

// name (String)
Future<bool> saveUserName(String name) async {
  try {
    return _prefs!.setString("user_name", name);
  } catch (e) {
    print("Error saving user_name $e");
    return false;
  }
}

String loadUserName() {
  return _prefs?.getString("user_name") ?? "";
}

// dark/light mode (Bool)
Future<bool> saveDarkMode(bool enabled) async {
  try {
    return _prefs!.setBool("dark_mode_enabled", enabled);
  } catch (e) {
    print("Error saving dark_mode_enabled $e");
    return false;
  }
}

bool loadDarkMode() {
  return _prefs?.getBool("dark_mode_enabled") ?? false;
}
