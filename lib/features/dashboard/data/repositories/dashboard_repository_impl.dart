import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';

import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_data_source.dart';

class DashBoardRepositoryImpl implements DashBoardRepository {
  final DashBoardDataSource datasource;

  DashBoardRepositoryImpl({required this.datasource});

  @override
  Stream<QuerySnapshot<Object?>> getAllTables() {
    return datasource.getAllTables();
  }

  @override
  Future<void> addNewCustomer(CustomerModel customerModel) {
    return datasource.createNewCustomer(customerModel);
  }

  @override
  Future<void> deleteCustomer(CustomerModel customerModel) {
    return datasource.deleteCustomer(customerModel);
  }

  @override
  Stream<QuerySnapshot> getAllCustomers() {
   return datasource.getAllCustomers();
  }

  @override
  Future<void> updateTableData(TableModel tableModel) {
   return datasource.updateTableData(tableModel);
  }
}
