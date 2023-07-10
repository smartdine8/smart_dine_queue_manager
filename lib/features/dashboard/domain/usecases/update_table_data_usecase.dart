
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';
import '../repositories/dashboard_repository.dart';

class UpdateTableDataUseCase {
  final DashBoardRepository repository;

  UpdateTableDataUseCase({required this.repository});

  Future<void> call(TableModel tableModel) {
    return repository.updateTableData(tableModel);
  }
}
