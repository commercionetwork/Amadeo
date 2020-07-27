part of 'demo_keys_bloc.dart';

@immutable
abstract class DemoKeysEvent extends Equatable {
  const DemoKeysEvent();
}

class LoadDemoKeysEvent extends DemoKeysEvent {
  const LoadDemoKeysEvent();

  @override
  List<Object> get props => [];
}
