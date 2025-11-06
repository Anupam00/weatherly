part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class keyChange extends AuthenticationEvent{
  final String apiKeyFetch;
  const keyChange({
    required this.apiKeyFetch,
});

  List<Object?> get props => [apiKeyFetch];
}
class keyAuthentication extends AuthenticationEvent{}
class clearMessage extends AuthenticationEvent{}

