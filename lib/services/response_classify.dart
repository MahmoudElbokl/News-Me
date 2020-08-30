class ResponseClassify<T> {
  Status status;
  T data;
  String message;

  ResponseClassify.completed(this.data) : status = Status.COMPLETED;

  ResponseClassify.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { COMPLETED, ERROR }
