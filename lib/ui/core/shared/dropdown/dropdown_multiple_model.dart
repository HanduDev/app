class DropdownMultipleModel {
  String id;
  String name;

  DropdownMultipleModel({required this.id, required this.name});

  static List<DropdownMultipleModel> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map(
          (e) => DropdownMultipleModel(
            id: e['id'] as String,
            name: e['name'] as String,
          ),
        )
        .toList();
  }

  static List<DropdownMultipleModel> fromArray(List<String> json) {
    return json.map((e) => DropdownMultipleModel(id: e, name: e)).toList();
  }
}
