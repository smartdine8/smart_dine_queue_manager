import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/dashboard_repository.dart';

class GetAllTablesUseCase {
  final DashBoardRepository repository;

  GetAllTablesUseCase({required this.repository});

  Stream<QuerySnapshot> call() {
    return repository.getAllTables();
  }
}
