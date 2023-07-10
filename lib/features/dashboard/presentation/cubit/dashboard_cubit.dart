import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartdine_queue_manager/features/dashboard/dashboard_dependency_injection.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/order_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/domain/usecases/delete_customer_from_queue_usecase.dart';
import 'package:smartdine_queue_manager/features/dashboard/domain/usecases/get_all_customers_usecase.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/core.dart';
import '../../domain/usecases/add_new_customer_in_queue_usecase.dart';
import '../../domain/usecases/get_all_tables_usecase.dart';
import '../../domain/usecases/update_table_data_usecase.dart';

class DashBoardCubit extends Cubit<BaseState> {
  final GetAllTablesUseCase getAllTablesUseCase =
      slDashBoard<GetAllTablesUseCase>();
  final GetAllCustomersUseCase getAllCustomersUseCase =
      slDashBoard<GetAllCustomersUseCase>();
  final AddCustomerInQueueUseCase addCustomerInQueueUseCase =
      slDashBoard<AddCustomerInQueueUseCase>();
  final DeleteCustomerFromQueueUseCase deleteCustomerFromQueueUseCase =
      slDashBoard<DeleteCustomerFromQueueUseCase>();
  final UpdateTableDataUseCase updateTableDataUseCase =
      slDashBoard<UpdateTableDataUseCase>();

  DashBoardCubit() : super(StateInitial());

  Stream<QuerySnapshot> getAllTables() => getAllTablesUseCase.call();

  Stream<QuerySnapshot> getAllCustomers() => getAllCustomersUseCase.call();

  Future<int> getPredictionTimeToEmptyTable(
      {required TableModel model, required int personCount}) async {
    final tableStream = getAllCustomersUseCase.call();
    var time =0;
   try{
     tableStream.listen((data) {
       final tables = data.docs.map((e) => TableModel.fromJson(e)).toList();
       var temp1 = tables
           .where((element) =>
       int.parse(element.totalCapacity!) <=
           int.parse(model.totalCapacity!))
           .toList();
       if (temp1.isNotEmpty) {
         var temp2 = temp1.where((element) =>
         element.isOrderPlaced == true && element.isBillPaid == false);
         if (temp2.isNotEmpty) {
           final orderStream =
           FirebaseFirestore.instance.collection("orders").snapshots();
           orderStream.listen((order) {
             final orderOfTable = order.docs
                 .map((e) => OrderModel.fromMap(e))
                 .toList()
                 .where((element) => element.table_id == model.tableId)
                 .toList();
             final chefStream =
             FirebaseFirestore.instance.collection("orders").snapshots();
             chefStream.listen((chefData) {
               List mapItems = chefData.docs.map((e) => e.get('items')).toList();
               orderOfTable.forEach((order) {
                 order.items?.forEach((item) {
                   var tmp=  (mapItems[int.parse(item.order_item_name)]??1);
                   time = time+ personCount + 30 + 10;
                 });
               });
             });
           });

         }
       }

     });
   }catch(e){
     debugPrint('getPredictionTimeToEmptyTable Error=> ${e.toString()}');
   }
    return time;
  }

  Future<void> createNewCustomer(CustomerModel customerModel) async {
    try {
      await addCustomerInQueueUseCase.call(customerModel);
    } catch (e) {
      debugPrint('createNewCustomer Error=> ${e.toString()}');
    }
  }

  Future<void> deleteCustomer(CustomerModel customerModel) async {
    try {
      await deleteCustomerFromQueueUseCase.call(customerModel);
    } catch (e) {
      debugPrint('deleteCustomer Error=> ${e.toString()}');
    }
  }

  Future<void> updateTableData(
      TableModel tableModel, CustomerModel? customerModel) async {
    try {
      tableModel.isOccupied = true;
      if (customerModel != null) {
        tableModel.customerName = customerModel.customerName;
        tableModel.customerPeopleCount = customerModel.customerPeopleCount;
      }

      await updateTableDataUseCase.call(tableModel);
    } catch (e) {
      debugPrint('updateTableData Error=> ${e.toString()}');
    }
  }

  void resetTableData(List<TableModel> tableList) {
    final tablesWithPreviousData =
        tableList.where((element) => !element.isOccupied!).toList();
    for (var element in tablesWithPreviousData) {
      element.customerName = '';
      element.customerPeopleCount = '';
    }
  }
}
