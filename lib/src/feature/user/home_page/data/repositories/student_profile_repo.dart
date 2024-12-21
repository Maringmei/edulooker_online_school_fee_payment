import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/student_profile_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';

class StudentProfileRepo {
  StudentProfileAPI api = StudentProfileAPI();

  Future<StudentProfileModel> getStudentProfile() async {
    StudentProfileModel response = await api.getStudentProfile();
    if (response.success == true) {
      return response;
    } else {
      return response;
    }
  }
}
