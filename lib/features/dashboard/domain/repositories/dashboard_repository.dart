import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';

abstract class DashBoardRepository {
  Stream<QuerySnapshot> getAllTables();
  Stream<QuerySnapshot> getAllCustomers();
 Future<void> addNewCustomer(CustomerModel customerModel);
 Future<void> deleteCustomer(CustomerModel customerModel);
 Future<void> updateTableData(TableModel tableModel);
}
