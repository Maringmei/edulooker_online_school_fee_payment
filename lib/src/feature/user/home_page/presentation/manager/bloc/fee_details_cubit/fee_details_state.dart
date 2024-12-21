part of 'fee_details_cubit.dart';

sealed class FeeDetailsState extends Equatable {
  const FeeDetailsState();
  @override
  List<Object> get props => [];
}

final class FeeDetailsInitial extends FeeDetailsState {}

final class FeeDetailsLoaded extends FeeDetailsState {
  final FeeDetailsModel response;
  const FeeDetailsLoaded({required this.response});
  @override
  List<Object> get props => [response];
}

final class FeeDetailsEmpty extends FeeDetailsState {}

final class FeeDetailsError extends FeeDetailsState {
  String errString;
  FeeDetailsError({required this.errString});
  @override
  List<Object> get props => [errString];
}
