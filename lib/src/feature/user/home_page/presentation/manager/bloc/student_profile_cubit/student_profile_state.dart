part of 'student_profile_cubit.dart';

sealed class StudentProfileState extends Equatable {
  const StudentProfileState();
  @override
  List<Object> get props => [];
}

final class StudentProfileInitial extends StudentProfileState {}

final class StudentProfileLoaded extends StudentProfileState {
  final SiblingModel response;
  const StudentProfileLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

final class StudentProfileError extends StudentProfileState {
  final String errString;
  const StudentProfileError({required this.errString});

  @override
  List<Object> get props => [errString];
}
