class Country {
  String name, flag;

  Country({this.name, this.flag});

  static Country fromJson(Map<String, dynamic> json) =>
      Country(name: json["name"], flag: json["flag"]);
}

// @override
// String toString() {
//   return 'Country{name: $name, flag : $flag}';
// }
