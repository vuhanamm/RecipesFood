import 'package:project_pilot/networking/joke_request.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

class JokeViewModel {
  BehaviorSubject<String> jokeSubject = BehaviorSubject();
  BehaviorSubject<String> dateTimeSubject =
      BehaviorSubject.seeded('01/01/2021');
  JokeRequest _req;

  JokeViewModel(this._req);

  Future<String> getJoke() async {
    String joke = await _req.getJoke();
    jokeSubject.sink.add(joke);
    final String dateTime = '${DateTime.now().year}'
        '/${DateTime.now().month >= 10 ? DateTime.now().month : '0' + DateTime.now().month.toString()}/${DateTime.now().day >= 10 ? DateTime.now().day : '0' + DateTime.now().day.toString()}';
    dateTimeSubject.sink.add(dateTime);
    return joke;
  }

  void shareJoke() {
    Share.share(jokeSubject.value);
  }

  void dispose() {
    jokeSubject.close();
    dateTimeSubject.close();
  }
}
