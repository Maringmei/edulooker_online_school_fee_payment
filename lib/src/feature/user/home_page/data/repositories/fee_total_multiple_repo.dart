import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/student_profile_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/sibling_list_model.dart';

import '../data_sources/fee_total_report_api.dart';
import '../models/fee_total_multiple_model.dart';

class FeeTotalMultipleRepo {
  FeeTotalReportAPI api = FeeTotalReportAPI();

  Future<FeeTotalMultipleModel> getFeeTotalMultiple(List<String> ids) async {
    FeeTotalMultipleModel response = await api.getTotalFeeReport( ids);
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }
}
