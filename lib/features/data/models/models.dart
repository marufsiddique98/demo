class FormAttribute {
  final String id;
  final String title;
  final String type;
  final List<String> options;

  FormAttribute({
    required this.id,
    required this.title,
    required this.type,
    required this.options,
  });

  factory FormAttribute.fromJson(Map<String, dynamic> json) {
    return FormAttribute(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      options: json['options'] != null ? List<String>.from(json['options']) : [],
    );
  }
}

class FormModel {
  final List<FormAttribute> attributes;

  FormModel({required this.attributes});

  factory FormModel.fromJson(Map<String, dynamic> json) {
    var list = json['attributes'] as List;
    List<FormAttribute> attributesList = list.map((i) => FormAttribute.fromJson(i)).toList();
    return FormModel(attributes: attributesList);
  }
}
