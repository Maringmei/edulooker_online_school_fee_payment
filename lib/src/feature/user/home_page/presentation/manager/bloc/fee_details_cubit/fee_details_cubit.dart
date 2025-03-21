import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/fee_details_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_details_repo.dart';
import 'package:equatable/equatable.dart';

part 'fee_details_state.dart';

class FeeDetailsCubit extends Cubit<FeeDetailsState> {
  FeeDetailsCubit() : super(FeeDetailsInitial());

  FeeDetailsRepo apiRepo = FeeDetailsRepo();

  getFeeDetails() async {
    emit(FeeDetailsInitial());
    FeeDetailsModel response = await apiRepo.getFeeDetails();
    if (response.success == true) {
      if (response.data!.isNotEmpty) {
        emit(FeeDetailsLoaded(response: response));
      } else {
        emit(FeeDetailsEmpty());
      }
    } else {
      emit(
          FeeDetailsError(errString: response.message ?? "Unable to get data"));
    }
  }
}
