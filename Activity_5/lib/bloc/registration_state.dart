import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

// Initial State
class RegistrationInitial extends RegistrationState {}

// Emitted while save-to-SharedPreferences call is in flights
class RegistrationLoading extends RegistrationState {}

// Emitted when save succeeds. BlocListener will use this to navigate to SuccessScreen
class RegistrationSuccess extends RegistrationState {}

// Emitted when save fails. BlocListerner navigates to FailedScreen
class RegistrationFailure extends RegistrationState {
  final String message;

  const RegistrationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
