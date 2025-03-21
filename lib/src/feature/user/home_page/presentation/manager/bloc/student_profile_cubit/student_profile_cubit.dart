import 'package:bloc/bloc.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/repositories/student_profile_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/sibling_list_model.dart';

part 'student_profile_state.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileInitial());

  StudentProfileRepo apiRepo = StudentProfileRepo();

  getStudentProfile(context) async {
    emit(StudentProfileInitial());
    SiblingModel response = await apiRepo.getStudentProfile(context);
    if (response.success == true) {
      emit(StudentProfileLoaded(response: response));
    } else {
      emit(StudentProfileError(
          errString: response.message ?? "Unable to get data"));
    }
  }
}
