import 'package:bloc_weeknd/feature/service/cats_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsGetsClass _catsGetsClass;
  CatsCubit(this._catsGetsClass) : super(CatsInitial());

  Future<void> getCats() async {
    try {
      emit(CatsLoading());
      await Future.delayed(Duration(milliseconds: 500));
      final response = await _catsGetsClass.getCats();
      emit(CatsCompleted(response));
    } on NetworError catch (e) {
      emit(CatsError(e.messsage));
    }
  }
}
