

class Conference {
  final String confId;
  String name;
  String category;
  String district;
  String website;
  String description;
  DateTime beginDate;
  DateTime endDate;
  int rating;

  Conference({this.confId, this.name, this.category, this.district, this.description, this.beginDate, this.endDate, this.website, this.rating});

  Conference.onlyId({this.confId});

  @override
  bool operator == (covariant Conference other) => other.confId == this.confId;

}
