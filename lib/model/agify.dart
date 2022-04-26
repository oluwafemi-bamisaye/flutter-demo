
class User {
  late final String name;
  late final String age;
  late final int count;

  User({required this.name, required this.age, required this.count});

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      age: json["age"],
      count: json["count"]
  );

}