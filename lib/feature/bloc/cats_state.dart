import 'package:bloc_weeknd/feature/model/cats_http.dart';

abstract class CatsState {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompleted extends CatsState {
  final List<CatsModel> response;
  const CatsCompleted(this.response);
}

class CatsError extends CatsState {
  final String message;
  const CatsError(this.message);
}
