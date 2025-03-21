part of 'total_fee_cubit.dart';

sealed class TotalFeeState extends Equatable {
  const TotalFeeState();
  @override
  List<Object> get props => [];
}

final class TotalFeeInitial extends TotalFeeState {}

final class TotalFeeLoaded extends TotalFeeState {
  FeeTotalMultipleModel response;
  TotalFeeLoaded({required this.response});
  @override
  List<Object> get props => [response];
}

final class TotalFeeError extends TotalFeeState {
  String errString;
  TotalFeeError({required this.errString});
  @override
  List<Object> get props => [errString];
}
