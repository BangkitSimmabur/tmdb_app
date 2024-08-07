class HandlingServerLog {
  int? status;
  dynamic data;
  String? message;
  bool? success;

  HandlingServerLog(
    this.status,
    this.data,
    this.message,
    this.success,
  );

  HandlingServerLog.success(
    this.success,
    this.data,
  );

  HandlingServerLog.failed(
    this.success,
    this.status,
    this.message,
  );
}
