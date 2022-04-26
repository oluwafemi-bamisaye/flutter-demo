class Joke {

  final String joke;

  Joke(this.joke);

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(json["joke"]);

  Map<String, dynamic> toJson() => {"joke": joke};
}