class TableData {
  final String username;
  final String timeAt;
  final String action;
  final String uid;
  final String message;
  final String? roomNo;

  TableData({
    this.roomNo,
    required this.username,
    required this.timeAt,
    required this.action,
    required this.uid,
    required this.message
  });
}
