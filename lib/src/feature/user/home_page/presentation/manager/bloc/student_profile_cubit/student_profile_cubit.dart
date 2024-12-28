import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/student_profile_repo.dart';
import 'package:equatable/equatable.dart';

part 'student_profile_state.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileInitial()){
    getStudentProfile();
  }

  StudentProfileRepo apiRepo = StudentProfileRepo();

  getStudentProfile() async {
    emit(StudentProfileInitial());
    StudentProfileModel response = await apiRepo.getStudentProfile();
    if (response.success == true) {
      emit(StudentProfileLoaded(response: response));
    } else {
      emit(StudentProfileError(
          errString: response.message ?? "Unable to get data"));
    }
  }
}
