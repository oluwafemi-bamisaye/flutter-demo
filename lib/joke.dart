import 'package:flutter/material.dart';
import 'package:jokes/model/Joke.dart';
import 'network/joke_client.dart';

class JokePageWidget extends StatefulWidget {
  const JokePageWidget({Key? key}) : super(key: key);

  @override
  State<JokePageWidget> createState() => _JokePageWidgetState();
}

class _JokePageWidgetState extends State<JokePageWidget> {
  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = getJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Joke>(
        future: futureJoke,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(snapshot.data!.joke,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal))),
              Container(
                  margin: const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
                  child: IconButton(
                    iconSize: 48,
                    icon: const Icon(Icons.refresh),
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        futureJoke = getJoke();
                      });
                    },
                  ))
            ]);
          } else if (snapshot.hasError) {
            return Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text('${snapshot.error}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal)));
          } else {
            return const CircularProgressIndicator(color: Colors.blue);
          }
        },
      ),
    );
  }
}
