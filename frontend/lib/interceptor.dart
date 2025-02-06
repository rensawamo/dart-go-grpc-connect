import 'package:connectrpc/connect.dart';

final Interceptor interceptor = <I extends Object, O extends Object>(next) { // 戻り値も見れる
  return (req) async {
    print("sending message to ${req.url}");
    final res = await next(req);
    if (res is UnaryResponse<I, O>) {
      print(res.message);
    }
    return res;
  };
};
