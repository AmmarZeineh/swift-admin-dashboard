import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_web_admin_dashboard/core/helper_functions/on_generate_routes.dart';
import 'package:swift_web_admin_dashboard/core/services/custom_bloc_observer.dart';
import 'package:swift_web_admin_dashboard/core/services/get_it_service.dart';
import 'package:swift_web_admin_dashboard/features/home/presentation/views/home_view.dart';

import 'app_keys.dart';

void main() async {
  await Supabase.initialize(url: AppKeys.url, anonKey: AppKeys.annon);
  setupLocator();
  Bloc.observer = CustomBlocObserver();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const SwiftWebAdminDashboard();
      },
    ),
  );
}

class SwiftWebAdminDashboard extends StatelessWidget {
  const SwiftWebAdminDashboard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.routeName,
    );
  }
}
