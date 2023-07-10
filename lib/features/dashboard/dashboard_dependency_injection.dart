import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:smartdine_queue_manager/features/dashboard/domain/usecases/get_all_customers_usecase.dart';
import 'package:smartdine_queue_manager/features/dashboard/domain/usecases/update_table_data_usecase.dart';

import 'data/datasources/dashboard_data_source.dart';
import 'data/datasources/dashboard_data_source_impl.dart';
import 'data/repositories/dashboard_repository_impl.dart';
import 'domain/repositories/dashboard_repository.dart';
import 'domain/usecases/add_new_customer_in_queue_usecase.dart';
import 'domain/usecases/delete_customer_from_queue_usecase.dart';
import 'domain/usecases/get_all_tables_usecase.dart';
import 'presentation/cubit/dashboard_cubit.dart';

final slDashBoard = GetIt.instance;

Future<void> dashBoardInit() async {
  ///cubit
  slDashBoard.registerFactory<DashBoardCubit>(
      () => DashBoardCubit());

  /// useCases

  slDashBoard.registerLazySingleton<GetAllTablesUseCase>(
      () => GetAllTablesUseCase(repository: slDashBoard.call()));
  slDashBoard.registerLazySingleton<AddCustomerInQueueUseCase>(
          () => AddCustomerInQueueUseCase(repository: slDashBoard.call()));
  slDashBoard.registerLazySingleton<DeleteCustomerFromQueueUseCase>(
          () => DeleteCustomerFromQueueUseCase(repository: slDashBoard.call()));
  slDashBoard.registerLazySingleton<GetAllCustomersUseCase>(
          () => GetAllCustomersUseCase(repository: slDashBoard.call()));
  slDashBoard.registerLazySingleton<UpdateTableDataUseCase>(
          () => UpdateTableDataUseCase(repository: slDashBoard.call()));

  /// repository

  slDashBoard.registerLazySingleton<DashBoardRepository>(
      () => DashBoardRepositoryImpl(datasource: slDashBoard.call()));

  /// datasource

  slDashBoard.registerLazySingleton<DashBoardDataSource>(() => DashBoardDataSourceImpl(slDashBoard.call()));

slDashBoard.registerLazySingleton(() => FirebaseFirestore.instance);
}
