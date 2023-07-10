import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customer_model.dart';
import '../models/table_model.dart';

abstract class DashBoardDataSource {
  Stream<QuerySnapshot> getAllTables();
  Stream<QuerySnapshot> getAllCustomers();
  Future<void> createNewCustomer(CustomerModel customerModel);
  Future<void> deleteCustomer(CustomerModel customerModel);
  Future<void> updateTableData(TableModel tableModel);

}

