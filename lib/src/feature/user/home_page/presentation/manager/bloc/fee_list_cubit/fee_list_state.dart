part of 'fee_list_cubit.dart';

sealed class FeeListState extends Equatable {
  final List<String> checkedFeeList;
  const FeeListState({required this.checkedFeeList});
  @override
  List<Object> get props => [checkedFeeList];
}

final class FeeListInitial extends FeeListState {
  FeeListInitial({required super.checkedFeeList});
}
