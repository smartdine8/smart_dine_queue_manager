import 'package:cloud_firestore/cloud_firestore.dart';

import '../repositories/dashboard_repository.dart';

class GetAllCustomersUseCase {
  final DashBoardRepository repository;

  GetAllCustomersUseCase({required this.repository});

  Stream<QuerySnapshot> call() {
    return repository.getAllCustomers();
  }
}