import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/fee_details_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_details_repo.dart';
import 'package:equatable/equatable.dart';

part 'fee_hostel_state.dart';

class FeeHostelCubit extends Cubit<FeeHostelState> {
  FeeHostelCubit() : super(FeeHostelInitial()) {
    getFeeHostel();
  }

  FeeDetailsRepo apiRepo = FeeDetailsRepo();

  getFeeHostel() async {
    emit(FeeHostelInitial());
    FeeDetailsModel response = await apiRepo.getFeeHostel();
    if (response.success == true) {
      if (response.data!.isNotEmpty) {
        emit(FeeHostelLoaded(response: response));
      } else {
        emit(FeeHostelEmpty());
      }
    } else {
      emit(FeeHostelError(errString: response.message ?? "Unable to get data"));
    }
  }
}
