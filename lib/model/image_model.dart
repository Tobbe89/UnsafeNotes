final String tableImage = 'image';

class ImageFields {
  static final List<String> values = [id, imagePath, noteId, createdTime];

  static final String id = '_id';
  static final String imagePath = '_header';
  static final String noteId = '_content';
  static final createdTime = '_createdTime';
}

class ImageModel {
  final int? id;
  final String imagePath;
  final int noteId;
  final DateTime createdTime;

  ImageModel(
      {this.id,
      required this.imagePath,
      required this.noteId,
      required this.createdTime});

  Map<String, Object?> toJson() => {
        ImageFields.id: id,
        ImageFields.imagePath: imagePath,
        ImageFields.noteId: noteId,
        ImageFields.createdTime: createdTime.toIso8601String()
      };

  ImageModel copy(
          {int? id, String? imagePath, int? noteId, DateTime? createdTime}) =>
      ImageModel(
          id: id ?? this.id,
          imagePath: imagePath ?? this.imagePath,
          noteId: noteId ?? this.noteId,
          createdTime: createdTime ?? this.createdTime);

  static ImageModel fromJson(Map<String, Object?> json) => ImageModel(
      id: json[ImageFields.id] as int?,
      imagePath: json[ImageFields.imagePath] as String,
      noteId: json[ImageFields.noteId] as int,
      createdTime: DateTime.parse(json[ImageFields.createdTime] as String));
}
