import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_pilot/viewmodel/joke_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JokeScreen extends StatelessWidget {
  final JokeViewModel jokeViewModel;

  JokeScreen(this.jokeViewModel);

  @override
  Widget build(BuildContext context) {
    jokeViewModel.getJoke();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)?.foodJoke ?? '',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              jokeViewModel.shareJoke();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen_2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: StreamBuilder(
            stream: jokeViewModel.jokeSubject,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.active) {
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Error ${snap.error}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                } else if (snap.hasData) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              jokeViewModel.jokeSubject.value,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(top: 16),
                            child: Text(
                              jokeViewModel.dateTimeSubject.value,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(AppLocalizations.of(context)?.hasError ?? ''),
                  );
                }
              } else if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text(AppLocalizations.of(context)?.hasError ?? ''),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
