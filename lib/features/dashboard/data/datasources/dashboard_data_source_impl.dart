import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';

import 'dashboard_data_source.dart';

class DashBoardDataSourceImpl implements DashBoardDataSource {
  DashBoardDataSourceImpl(this.fireStore);

  final FirebaseFirestore fireStore;

  @override
  Stream<QuerySnapshot<Object?>> getAllTables() {
    return fireStore.collection("tables").snapshots();
  }

  @override
  Future<void> createNewCustomer(CustomerModel customerModel) async {
    await fireStore
        .collection("queue")
        .doc(customerModel.customerId)
        .set(customerModel.toJson());
  }

  @override
  Future<void> deleteCustomer(CustomerModel customerModel) async {
    /// soft delete from queue
    customerModel.isVisiting = false;
    await fireStore
        .collection("queue")
        .doc(customerModel.customerId)
        .update(customerModel.toJson());
  }

  @override
  Stream<QuerySnapshot> getAllCustomers() {
    return fireStore
        .collection("queue")
        .where("is_visiting", isEqualTo: true)
        .snapshots();
  }

  @override
  Future<void> updateTableData(TableModel tableModel) async {
    await fireStore
        .collection("tables")
        .doc(tableModel.tableId)
        .update(tableModel.toJson());
  }
}
