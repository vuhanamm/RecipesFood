import 'package:rxdart/rxdart.dart';

class HomeViewModel {
  BehaviorSubject<int> indexSubject = BehaviorSubject();

  HomeViewModel() {
    indexSubject.sink.add(0);
  }

  void changeIndex(int index) {
    indexSubject.sink.add(index);
  }

  void dispose() {
    indexSubject.close();
  }
}
