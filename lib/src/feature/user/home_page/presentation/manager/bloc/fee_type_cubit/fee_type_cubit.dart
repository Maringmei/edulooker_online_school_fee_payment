import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_type.dart';
import 'package:equatable/equatable.dart';

part 'fee_type_state.dart';

class FeeTypeCubit extends Cubit<FeeTypeState> {
  FeeTypeCubit() : super(FeeTypeInitial(feeType: FeeType.tuitionFee));

  setFeeType(String type) {
    emit(FeeTypeInitial(feeType: type));
  }
}
