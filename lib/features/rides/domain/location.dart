class Location {
  final int id;
  final int? parentId;
  final String name;

  Location({required this.id, this.parentId, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'parent_id': parentId, 'name': name};
  }

  // copyWith method
  Location copyWith({int? id, int? parentId, String? name}) {
    return Location(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode => Object.hash(id, parentId, name);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Location &&
            other.id == id &&
            other.parentId == parentId &&
            other.name == name);
  }
}
