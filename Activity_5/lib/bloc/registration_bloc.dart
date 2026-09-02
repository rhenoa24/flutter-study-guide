// BLoC responsible for persisting PersonalDetails via SharedPreferences
import 'dart:math';

import 'package:activity_5/bloc/registration_event.dart';
import 'package:activity_5/bloc/registration_state.dart';
import 'package:activity_5/constants/storage_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_core/helpers/shared_prefs_helper.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SharedPrefsHelper _prefsHelper;
  static const String _key = StorageKeys.personalDetails;

  RegistrationBloc({SharedPrefsHelper? prefsHelper})
    : _prefsHelper = prefsHelper ?? SharedPrefsHelper(),
      super(RegistrationInitial()) {
    on<SubmitRegistrationEvent>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(
    SubmitRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      final randomNumber = Random().nextInt(100);

      print('RNG: $randomNumber');

      if (randomNumber.isEven) {
        final jsonString = event.details.encode();
        final saved = await _prefsHelper.saveSharedPreference(_key, jsonString);

        if (saved) {
          print('Saved details: $jsonString');
          emit(RegistrationSuccess());
        }
      } else {
        emit(const RegistrationFailure('Could not save your details'));
      }
    } catch (e) {
      emit(RegistrationFailure('Something went wrong: $e'));
    }
  }
}
