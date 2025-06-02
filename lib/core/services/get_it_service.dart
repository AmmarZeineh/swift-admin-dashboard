import 'package:get_it/get_it.dart';
import 'package:swift_web_admin_dashboard/core/services/database_service.dart';
import 'package:swift_web_admin_dashboard/core/services/supabase_database_service.dart';
import 'package:swift_web_admin_dashboard/features/home/data/repos/home_repo_impl.dart';
import 'package:swift_web_admin_dashboard/features/home/domain/repos/home_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<DataBaseService>(SupabaseDatabaseService());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt.get<DataBaseService>()));
}
