import 'package:shared_preferences/shared_preferences.dart';

// Helper class to save and retrieve a value from SharedPreferences
class SharedPrefsHelper {
  static const String _key = 'saved_value';

  // Saves [value] to local SharedPreferences storage
  // I assume this is like how localStorage works?
  static Future<void> saveSharedPreference(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value);
  }

  // Reads the saved value, return null if nothing is saved
  static Future<String?> readSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}

// The thing inside the <> is what the method returns
// so readSharedPreference() returns either a String or null
