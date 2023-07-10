import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import '../repositories/dashboard_repository.dart';

class AddCustomerInQueueUseCase {
  final DashBoardRepository repository;

  AddCustomerInQueueUseCase({required this.repository});

  Future<void> call(CustomerModel customerModel) {
    return repository.addNewCustomer(customerModel);
  }
}
