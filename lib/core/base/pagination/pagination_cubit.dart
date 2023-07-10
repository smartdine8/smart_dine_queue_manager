import '../../core.dart';
import '../base_state.dart';

abstract class PaginationCubit extends Cubit<BaseState> {
  int index = 1;
  int limit = 5;

  bool isCustomHandling = false;

  PaginationCubit({this.isCustomHandling = false}) : super(StateInitial());

  paginationReset() {
    emit(StateInitial());
    index = 0;
  }

  paginationSuccess(dynamic response) {
    if (isCustomHandling) {
      callApi(response);
    } else {
      if (response != null) {
        List list = response;

        if (state is StatePaginationSuccess) {
          StatePaginationSuccess stateOnSuccess =
              state as StatePaginationSuccess;
          List data = stateOnSuccess.data;
          var newList = List.from(data)..addAll(list);
          index++;

          emit(StatePaginationSuccess(newList, index, limit));
        } else {
          if (list.isEmpty) {
            emit(StateNoData());
          } else {
            index++;

            emit(StatePaginationSuccess(list, index, limit));
          }
        }
      } else {}
    }
  }

  paginationServerError() {
    if (state is StatePaginationSuccess) {
      StatePaginationSuccess stateOnSuccess = state as StatePaginationSuccess;
      emit(
          stateOnSuccess.copyWith(isInternetError: false, isServerError: true));
    } else {
      emit(StateErrorServer());
    }
  }

  paginationInternetError() {
    if (state is StatePaginationSuccess) {
      StatePaginationSuccess stateOnSuccess = state as StatePaginationSuccess;
      emit(
          stateOnSuccess.copyWith(isInternetError: true, isServerError: false));
    } else {
      emit(StateInternetError());
    }
  }

  callApi(dynamic response);
}
