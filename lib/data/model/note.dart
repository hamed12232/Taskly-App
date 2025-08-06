class Note {
  int? id;
  String title;
  String subTitle;
  String date;
  int color;

  Note({
    this.id,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.color,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      subTitle: map['subtitle'],
      date: map['date'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subTitle,
      'date': date,
      'color': color,
    };
  }

  //@override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   return other is Note &&
  //       title == other.title &&
  //       subTitle == other.subTitle &&
  //       date == other.date &&
  //       color == other.color;
  // }


}
