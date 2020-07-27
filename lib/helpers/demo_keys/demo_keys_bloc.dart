import 'dart:async';

import 'package:amadeo/repositories/keys_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'demo_keys_event.dart';
part 'demo_keys_state.dart';

class DemoKeysBloc extends Bloc<DemoKeysEvent, DemoKeysState> {
  final KeysRepository keysRepository;
  final StatefulCommercioId commercioIdKeys;

  DemoKeysBloc({
    @required this.keysRepository,
    @required this.commercioIdKeys,
  }) : super(const DemoKeysInitial());

  @override
  Stream<DemoKeysState> mapEventToState(
    DemoKeysEvent event,
  ) async* {
    if (event is LoadDemoKeysEvent) {
      yield* _mapLoadDemoKeysEventToState(event);
    }
  }

  Stream<DemoKeysState> _mapLoadDemoKeysEventToState(
    LoadDemoKeysEvent event,
  ) async* {
    try {
      yield const DemoKeysLoading();

      final demoKeys = await keysRepository.fetchDemoKeys();
      commercioIdKeys.commercioIdKeys = demoKeys;

      yield DemoKeysData(commercioIdKeys: demoKeys);
    } catch (e) {
      yield DemoKeysError(e.toString());
    }
  }
}
