import 'package:activity_5/models/registrant_details.dart';
import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

// Fired when user taps "Next" on the FormScreen.
// Carries the completed data model to persist

class SubmitRegistrationEvent extends RegistrationEvent {
  final PersonalDetails details;
  const SubmitRegistrationEvent(this.details);

  @override
  List<Object?> get props => [details];
}
