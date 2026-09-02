import 'package:shared_preferences/shared_preferences.dart';

// Helper class to save and retrieve a value from SharedPreferences
class SharedPrefsHelper {
  // Saves [value] to local SharedPreferences storage
  // I assume this is like how localStorage works?
  Future<bool> saveSharedPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  // Reads the saved value, return null if nothing is saved
  Future<String?> readSharedPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

// The thing inside the <> is what the method returns
// so readSharedPreference() returns either a String or null
