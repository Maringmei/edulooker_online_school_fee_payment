part of 'fee_hostel_cubit.dart';

sealed class FeeHostelState extends Equatable {
  const FeeHostelState();
  @override
  List<Object> get props => [];
}

final class FeeHostelInitial extends FeeHostelState {}

final class FeeHostelLoaded extends FeeHostelState {
  final FeeDetailsModel response;
  const FeeHostelLoaded({required this.response});
  @override
  List<Object> get props => [response];
}

final class FeeHostelEmpty extends FeeHostelState {}

final class FeeHostelError extends FeeHostelState {
  final String errString;
  const FeeHostelError({required this.errString});
  @override
  List<Object> get props => [errString];
}
