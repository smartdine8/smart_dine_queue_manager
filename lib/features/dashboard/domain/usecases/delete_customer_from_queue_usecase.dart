import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import '../repositories/dashboard_repository.dart';

class DeleteCustomerFromQueueUseCase {
  final DashBoardRepository repository;

  DeleteCustomerFromQueueUseCase({required this.repository});

  Future<void> call(CustomerModel customerModel) {
    return repository.deleteCustomer(customerModel);
  }
}
