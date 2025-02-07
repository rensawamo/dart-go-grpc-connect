import 'package:connectrpc/connect.dart';

class LoggingInterceptor {
  final void Function(Object? any) log;

  const LoggingInterceptor(this.log);

  AnyFn<I, O> call<I extends Object, O extends Object>(AnyFn<I, O> next) {
    return (req) async {
      final res = await next(req);
      print(req.headers['x-client']); // eliza
      switch (res) {
        case StreamResponse<I, O>():
          return StreamResponse(
            res.spec,
            res.headers,
            _logEach(res.message),
            res.trailers,
          );
        case UnaryResponse<I, O>(message: var message):
          log(message);
          return res;
      }
    };
  }

  Stream<T> _logEach<T>(Stream<T> stream) async* {
    await for (final next in stream) {
      log(next);
      yield next;
    }
  }
}

class MetadataInterceptor {
  const MetadataInterceptor();

  AnyFn<I, O> call<I extends Object, O extends Object>(AnyFn<I, O> next) {
    return (req) async {
      final headers = req.headers;
      headers.add('x-client', 'eliza');
      return next(req);
    };
  }
}
