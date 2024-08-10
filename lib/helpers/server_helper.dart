/// A class created to hale the api call responses
class HandlingServerLog {
  /// Variable containing api call status from tmdb
  int? status;

  /// Variable containing the whole response from api calls
  dynamic data;

  /// Variable containing response message from api calls
  String? message;

  /// Variable containing the api call status either success or fail
  bool? success;

  HandlingServerLog(
    this.status,
    this.data,
    this.message,
    this.success,
  );
}
