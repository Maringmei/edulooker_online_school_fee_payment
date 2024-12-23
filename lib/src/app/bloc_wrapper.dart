import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feature/user/home_page/presentation/manager/bloc/fee_details_cubit/fee_details_cubit.dart';
import '../feature/user/home_page/presentation/manager/bloc/fee_hostel_cubit/fee_hostel_cubit.dart';
import '../feature/user/home_page/presentation/manager/bloc/fee_transport_cubit/fee_transport_cubit.dart';
import '../feature/user/home_page/presentation/manager/bloc/student_profile_cubit/student_profile_cubit.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget app;

  const MultiBlocWrapper({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => StudentProfileCubit(),
      ),
      BlocProvider(
        create: (context) => FeeDetailsCubit(),
      ),
      BlocProvider(
        create: (context) => FeeTransportCubit(),
      ),
      BlocProvider(
        create: (context) => FeeHostelCubit(),
      ),
    ], child: app);
  }
}
