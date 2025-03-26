part of 'fee_type_cubit.dart';

sealed class FeeTypeState extends Equatable {
  final String feeType;
  const FeeTypeState({required this.feeType});
  @override
  List<Object> get props => [feeType];
}

final class FeeTypeInitial extends FeeTypeState {
  FeeTypeInitial({required super.feeType});
}
