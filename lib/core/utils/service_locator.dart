import 'package:get_it/get_it.dart';
import 'package:team_app/features/RecordsScreen/data/repo/records_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/homepage/data/repos/home_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AppointementsRepoImpl>(
    AppointementsRepoImpl(),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(),
  );
  getIt.registerSingleton<RecordsRepoImpl>(
    RecordsRepoImpl(),
  );
  // getIt.registerSingleton<ProfileRepoImpl>(
  //   ProfileRepoImpl(),
  // );
  // getIt.registerSingleton<users_repo_impl>(
  //   users_repo_impl(),
  // );
}
