class Rung {
  String rungId;
  String name;
  bool done;
  bool boldTitle;
  String info;
  bool archive;

  Rung(
      {required this.name,
      required this.rungId,
      required this.done,
      required this.boldTitle,
      required this.info,
      required this.archive});

  // static const colId = 'id';
  // static const colTask = 'taskname';
  // static const colDone = 'false';
  // static const colBold = 'false';
  // static const colInfo = "info";
  static List<Rung> myList = [];
  static List<Rung> _removeditems = [];
  get index => int.parse(rungId);

  Map<String, Object?> toMap() {
    return {
      'id': rungId,
      'colTask': name,
      'colDone': done,
      'colBold': boldTitle,
      'colInfo': info,
      'colArchive': archive,
    };
  }

}
