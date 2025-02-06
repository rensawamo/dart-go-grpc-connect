import 'package:connectrpc/connect.dart';

final Interceptor interceptor = <I extends Object, O extends Object>(next) {
  return (req) {
    print("sending message to ${req.url}");
    return next(req);
  };
};
