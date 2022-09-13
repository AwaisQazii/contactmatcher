class Contacts {
  int? id;
  String? name;
  int? number;

  Contacts({
    this.id,
    this.name,
    this.number,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['Number'] = number;
    return data;
  }

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    number = json['Number'];
  }
}
