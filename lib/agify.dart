import 'package:flutter/material.dart';
import 'package:jokes/network/age_client.dart';

import 'model/agify.dart';

class AgifyPage extends StatefulWidget {
  const AgifyPage({Key? key}) : super(key: key);

  @override
  State<AgifyPage> createState() => _AgifyPageState();
}

class _AgifyPageState extends State<AgifyPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  Future<User>? futureUser;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextField(
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.normal),
                controller: _controller,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enter name'),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  iconSize: 36,
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      futureUser = getAge(_controller.text);
                    });
                  },
                ))
          ],
        ),
        FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      "Age: ${snapshot.data!.age}",
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.normal),
                  ),
                )
              ]);
            } else if (snapshot.hasError) {
              return Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text('${snapshot.error}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal)));
            } else {
              return const Text("");
            }
          },
        )
      ],
    ));
  }
}
