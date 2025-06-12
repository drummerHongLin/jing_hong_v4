// 定义成功和失败的数据请求
sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, dynamic error) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Failure<T>(:final message, :final error) => failure(message, error),
    };
  }
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final dynamic error;

  const Failure(this.message, [this.error]);

  @override
  String toString() =>
      'Failure: $message${error != null ? '\nError: $error' : ''}';
}
