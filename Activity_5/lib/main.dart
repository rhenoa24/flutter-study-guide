// ## 🎯 Activity 5

// - Add welcome admin screen. Start button should navigate to your form screen.
// - Add a registration successful screen and failed screen. Back to home goes back to welcome admin.
// - Reuse the UI you already built earlier.
// - Reuse data model for details containing firstname middlename, lastname, suffix, gender, nationality
// - Create bloc class, bloc event and bloc state for storing details using sharedpreferences. Utilize the helper function you created in activity 4.
// - Refactor the next button. Pass the datamodel to bloc event when button is pressed.
// - Integrate the bloclistener to the details screen. If success,screen jumps to success page. If not, go to failed screen (try again).
// - Use navigator.pop for backbutton (goes back to welcome)

import 'package:activity_5/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity 5',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
