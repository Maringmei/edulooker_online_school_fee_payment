import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/fee_type.dart';
import '../data_sources/fee_details_api.dart';
import '../models/fee_details_model.dart';

class FeeDetailsRepo {
  FeeDetailsAPI api = FeeDetailsAPI();

  Future<FeeDetailsModel> getFeeDetails() async {
    FeeDetailsModel response = await api.getFeeDetails(id: FeeType.tuitionFee);
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }

  Future<FeeDetailsModel> getFeeHostel() async {
    FeeDetailsModel response = await api.getFeeDetails(id: FeeType.hostelFee);
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }

  Future<FeeDetailsModel> getFeeTransport() async {
    FeeDetailsModel response =
        await api.getFeeDetails(id: FeeType.transportFee);
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }
}
