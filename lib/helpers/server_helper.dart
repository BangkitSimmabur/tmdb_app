class HandlingServerLog {
  int? status;
  dynamic data;
  String? message;

  HandlingServerLog(this.status, this.data, this.message);

  HandlingServerLog.success(this.status, this.data);

  HandlingServerLog.failed(this.status, this.message);
}