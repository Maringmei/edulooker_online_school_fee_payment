import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/fee_details_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_details_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../fee_type.dart';
import '../../transaction_status.dart';
import '../fee_list_cubit/fee_list_cubit.dart';

part 'fee_details_state.dart';

class FeeDetailsCubit extends Cubit<FeeDetailsState> {
  FeeDetailsCubit() : super(FeeDetailsInitial());

  FeeDetailsRepo apiRepo = FeeDetailsRepo();

  getFeeDetails(context) async {
    int counter = 0;
    emit(FeeDetailsInitial());
    FeeDetailsModel response = await apiRepo.getFeeDetails();
    if (response.success == true) {
      if (response.data!.isNotEmpty) {
        // pre select fee
        // for (int i = 0; i < response.data!.length; i++) {
        //   if (response.data![i].feeExempted == FeePaymentType.feeNotExempted &&
        //       response.data![i].status == TransactionStatus.upPaid) {
        //     counter++;
        //     BlocProvider.of<FeeListCubit>(context)
        //         .setFeeList(response.data![i].feeId.toString());
        //     if (counter == 3) {
        //       break;
        //     }
        //   }
        // }
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
