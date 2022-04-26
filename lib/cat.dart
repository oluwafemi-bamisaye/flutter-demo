import 'package:flutter/material.dart';
import 'package:jokes/network/cat_client.dart';
import 'model/cat.dart';

class CatPageWidget extends StatefulWidget {
  const CatPageWidget({Key? key}) : super(key: key);

  @override
  State<CatPageWidget> createState() => _CatPageWidgetState();
}

class _CatPageWidgetState extends State<CatPageWidget> {
  late Future<Cat> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = getRandomCat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Cat>(
        future: futureJoke,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8), // Border width
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(164), // Image radius
                    child: Image.network(
                      snapshot.data!.url,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
                  child: IconButton(
                    iconSize: 48,
                    icon: const Icon(Icons.refresh),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        futureJoke = getRandomCat();
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
            return const CircularProgressIndicator(color: Colors.red);
          }
        },
      ),
    );
  }
}
