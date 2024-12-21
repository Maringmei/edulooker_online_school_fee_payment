import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import '../data_sources/fee_details_api.dart';
import '../models/fee_details_model.dart';

class FeeDetailsRepo {
  FeeDetailsAPI api = FeeDetailsAPI();

  Future<FeeDetailsModel> getFeeDetails() async {
    FeeDetailsModel response = await api.getFeeDetails();
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }
}
