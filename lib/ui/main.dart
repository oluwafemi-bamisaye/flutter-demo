import 'package:flutter/material.dart';
import 'package:pokemon/model/agify.dart';
import 'package:pokemon/network/data_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agify',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const AgifyScreen(),
    );
  }
}

class AgifyScreen extends StatefulWidget {
  const AgifyScreen({Key? key}) : super(key: key);

  @override
  State<AgifyScreen> createState() => _AgifyScreenState();
}

class _AgifyScreenState extends State<AgifyScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final RemoteDataSource _dataSource = RemoteDataSource();
  var shouldLoadAge = false;
  User _user = User(name: "", age: 0, count: 0);
  late String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predict Age"),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextField(
                  controller: _controller,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Enter name'),
                  focusNode: _focusNode,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => fetchAge(_controller.text),
                ),
              )
            ],
          ),
          Card(
            child: userCard(_user),
          )
        ],
      ),
    );
  }

  void fetchAge(String name) {

    shouldLoadAge = true;
    FutureBuilder<User>(
        future: _dataSource.userAge(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            setState(() {
              _user = snapshot.data!;
              errorMsg = "";
            });
          } else {
            setState(() {
              errorMsg = snapshot.error.toString();
            });
          }
          shouldLoadAge = false;
          throw Exception("Unable to load age");
        });
  }

  Widget userCard(User user) {
    if (shouldLoadAge) {
      return const CircularProgressIndicator();
    } else if (user.name.isNotEmpty){
      return Column(
        children: [
          Text("Name: ${user.name}"),
          Text("Age: ${user.age}"),
          Text("Count: ${user.count}"),
        ],
      );
    } else {
      return Text(errorMsg);
    }

  }
}
