// BLoC responsible for persisting PersonalDetails via SharedPreferences
import 'package:activity_5/bloc/registration_event.dart';
import 'package:activity_5/bloc/registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_ui/helpers/shared_prefs_helper.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final SharedPrefsHelper _prefsHelper;
  static const String _key = 'personal_details';

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
      final jsonString = event.details.encode();
      final saved = await _prefsHelper.saveSharedPreference(_key, jsonString);

      if (saved) {
        emit(RegistrationSuccess());
      } else {
        emit(const RegistrationFailure('Could no save your details'));
      }
    } catch (e) {
      emit(RegistrationFailure('Something went wrong: $e'));
    }
  }
}
