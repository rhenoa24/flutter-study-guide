import 'package:flutter/material.dart';
import 'package:shared_core/helpers/shared_prefs_helper.dart';
import 'package:shared_core/widgets/app_bar.dart';
import 'package:shared_core/widgets/form_button.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _prefsHelper = SharedPrefsHelper();
  static const _key = 'test_value';

  String? _savedValue;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final value = await _prefsHelper.readSharedPreference(_key);
    setState(() {
      _savedValue = value;
    });
  }

  Future<void> _onSavePressed() async {
    await _prefsHelper.saveSharedPreference(
      _key,
      'Hello! This value was saved via [SharedPreference].',
    );
    await _loadValue();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasValue = _savedValue != null && _savedValue!.isNotEmpty;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Nav + Banner
            Padding(
              padding: EdgeInsets.all(10),
              child: TopAppBar(label: 'Shared Preferences Test'),
            ),
            Expanded(
              child: Center(
                child: hasValue
                    ? Text(
                        _savedValue!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: FormButton(onPressed: _onSavePressed, label: 'Save Value'),
            ),
          ],
        ),
      ),
    );
  }
}
