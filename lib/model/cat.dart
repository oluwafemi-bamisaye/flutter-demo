class Cat {
  final String url;

  Cat(this.url);

  factory Cat.fromJson(String baseUrl, Map<String, dynamic> json) =>
      Cat(baseUrl + json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}
