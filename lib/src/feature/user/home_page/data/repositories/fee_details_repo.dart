import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import '../data_sources/fee_details_api.dart';
import '../models/fee_details_model.dart';

class FeeDetailsRepo {
  FeeDetailsAPI api = FeeDetailsAPI();

  Future<FeeDetailsModel> getFeeDetails() async {
    FeeDetailsModel response = await api.getFeeDetails(id: "1");
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }

  Future<FeeDetailsModel> getFeeTransport() async {
    FeeDetailsModel response = await api.getFeeDetails(id: "0");
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }

  Future<FeeDetailsModel> getFeeHostel() async {
    FeeDetailsModel response = await api.getFeeDetails(id: "2");
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }
}
