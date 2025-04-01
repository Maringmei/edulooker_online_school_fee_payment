import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/data_sources/student_profile_api.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/sibling_list_model.dart';
import 'package:edulooker_online_school_fee_payment/src/feature/user/home_page/data/models/student_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/storage/storage.dart';
import '../../presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';

class StudentProfileRepo {
  StudentProfileAPI api = StudentProfileAPI();

  Future<SiblingModel> getStudentProfile(context) async {
    SiblingModel response = await api.getSiblings();
    if (response.success == true) {
      Store.setBaseUrlSiblings(response.data![0].baseUrl!);
      Store.setTokenSibling(response.data![0].accessToken!);
      await Future.delayed(Duration(seconds: 1));
      BlocProvider.of<FeeDetailsCubit>(context).getFeeDetails(context);
      return response;
    } else {
      return response;
    }
  }
}
