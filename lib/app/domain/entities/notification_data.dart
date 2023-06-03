class NotificationData {
  final String? title;
  final String? body;
  final String? payLoad;
  final DateTime dtScheduled;

  const NotificationData({
    this.title,
    this.body,
    this.payLoad,
    required this.dtScheduled,
  });
}
