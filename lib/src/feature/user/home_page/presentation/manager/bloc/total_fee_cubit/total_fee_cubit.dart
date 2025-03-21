import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/core/constants/widgets/top_snack_bar.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/fee_total_report_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/fee_total_multiple_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import 'package:equatable/equatable.dart';

part 'total_fee_state.dart';

class TotalFeeCubit extends Cubit<TotalFeeState> {
  TotalFeeCubit() : super(TotalFeeInitial());

  FeeTotalReportAPI apiRepo = FeeTotalReportAPI();

  getFeeTotalMultiple(List<String> ids) async {
    await apiRepo.getTotalFeeReport(ids).then((value) {
      if (value.success == true) {
        emit(TotalFeeLoaded(response: value));
      } else {
        emit(TotalFeeError(
            errString: value.message ?? "Unable to fetch total fees"));
      }
    });
  }
}
