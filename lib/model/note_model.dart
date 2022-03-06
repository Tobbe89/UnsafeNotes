final String tableNote = 'note';

class NoteFields {
  static final List<String> values = [id, header, content, createdTime];

  static final String id = '_id';
  static final String header = '_header';
  static final String content = '_content';
  static final createdTime = '_createdTime';
}

class NoteModel {
  final int? id;
  final String? header;
  final String content;
  final DateTime createdTime;

  NoteModel(
      {this.id, this.header, required this.content, required this.createdTime});

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.header: header,
        NoteFields.content: content,
        NoteFields.createdTime: createdTime.toIso8601String()
      };

  NoteModel copy(
          {int? id, String? header, String? content, DateTime? createdTime}) =>
      NoteModel(
          id: id ?? this.id,
          header: header ?? this.header,
          content: content ?? this.content,
          createdTime: createdTime ?? this.createdTime);

  static NoteModel fromJson(Map<String, Object?> json) => NoteModel(
      id: json[NoteFields.id] as int?,
      header: json[NoteFields.header] as String?,
      content: json[NoteFields.content] as String,
      createdTime: DateTime.parse(json[NoteFields.createdTime] as String));
}
