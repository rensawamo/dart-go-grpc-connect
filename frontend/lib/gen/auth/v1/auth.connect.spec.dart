//
//  Generated code. Do not modify.
//  source: auth/v1/auth.proto
//

import "package:connectrpc/connect.dart" as connect;
import "auth.pb.dart" as authv1auth;

abstract final class AuthService {
  /// Fully-qualified name of the AuthService service.
  static const name = 'auth.v1.AuthService';

  static const login = connect.Spec(
    '/$name/Login',
    connect.StreamType.unary,
    authv1auth.LoginRequest.new,
    authv1auth.LoginResponse.new,
  );
}
