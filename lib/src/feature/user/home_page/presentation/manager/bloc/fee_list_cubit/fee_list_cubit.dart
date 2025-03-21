import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fee_list_state.dart';

class FeeListCubit extends Cubit<FeeListState> {
  FeeListCubit() : super(FeeListInitial(checkedFeeList: []));

  void setFeeList(String id) {
    final updatedList = List<String>.from(state.checkedFeeList)..add(id);
    emit(FeeListInitial(checkedFeeList: updatedList));
  }

  void clear() {
    emit(FeeListInitial(checkedFeeList: []));
  }
}
