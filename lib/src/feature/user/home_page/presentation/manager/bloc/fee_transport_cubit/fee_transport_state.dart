part of 'fee_transport_cubit.dart';

sealed class FeeTransportState extends Equatable {
  const FeeTransportState();
  @override
  List<Object> get props => [];
}

final class FeeTransportInitial extends FeeTransportState {}

final class FeeTransportLoaded extends FeeTransportState {
  FeeDetailsModel response;
  FeeTransportLoaded({required this.response});
  @override
  List<Object> get props => [response];
}

final class FeeTransportEmpty extends FeeTransportState {}

final class FeeTransportError extends FeeTransportState {
  final String errString;
  const FeeTransportError({required this.errString});
  @override
  List<Object> get props => [errString];
}
