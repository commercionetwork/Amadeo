part of 'demo_keys_bloc.dart';

@immutable
abstract class DemoKeysState extends Equatable {
  const DemoKeysState();
}

class DemoKeysInitial extends DemoKeysState {
  const DemoKeysInitial();

  @override
  List<Object> get props => [];
}

class DemoKeysLoading extends DemoKeysState {
  const DemoKeysLoading();

  @override
  List<Object> get props => [];
}

class DemoKeysError extends DemoKeysState {
  final String message;

  const DemoKeysError(this.message);

  @override
  List<Object> get props => [message];
}

class DemoKeysData extends DemoKeysState {
  final CommercioIdKeys commercioIdKeys;

  const DemoKeysData({@required this.commercioIdKeys});

  @override
  List<Object> get props => [commercioIdKeys];
}
