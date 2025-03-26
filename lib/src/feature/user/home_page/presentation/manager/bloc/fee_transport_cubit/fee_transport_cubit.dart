import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/fee_details_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_details_repo.dart';
import 'package:equatable/equatable.dart';

part 'fee_transport_state.dart';

class FeeTransportCubit extends Cubit<FeeTransportState> {
  FeeTransportCubit() : super(FeeTransportInitial()) {
    getFeeTransport();
  }

  FeeDetailsRepo apiRepo = FeeDetailsRepo();

  getFeeTransport() async {
    emit(FeeTransportInitial());
    FeeDetailsModel response = await apiRepo.getFeeTransport();
    if (response.success == true) {
      if (response.data!.isNotEmpty) {
        emit(FeeTransportLoaded(response: response));
      } else {
        emit(FeeTransportEmpty());
      }
    } else {
      emit(FeeTransportError(
          errString: response.message ?? "Unable to get data"));
    }
  }
}
