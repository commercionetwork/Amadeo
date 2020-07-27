import 'dart:async';
import 'dart:io';

import 'package:amadeo/repositories/dialog_warnings_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'warning_dialog_event.dart';
part 'warning_dialog_state.dart';

class WarningDialogBloc extends Bloc<WarningDialogEvent, WarningDialogState> {
  final DialogWarningsRepository dialogWarningsRepository;

  WarningDialogBloc({@required this.dialogWarningsRepository})
      : super(const WarningDialogInitialState());

  @override
  Stream<WarningDialogState> mapEventToState(
    WarningDialogEvent event,
  ) async* {
    if (event is MaybeShowWebWarningDialogEvent) {
      yield* _mapMaybeShowWebWarningDialogEventToState(event);
    }

    if (event is MaybeShowKeysWarningDialogEvent) {
      yield* _mapMaybeShowKeysWarningDialogEventToState(event);
    }
  }

  Stream<WarningDialogState> _mapMaybeShowWebWarningDialogEventToState(
    MaybeShowWebWarningDialogEvent event,
  ) async* {
    if (kIsWeb && !dialogWarningsRepository.webWarningDialogShown) {
      dialogWarningsRepository.webWarningDialogShown = true;

      yield const ShowWebWarningDialogState();
    } else if (Platform.isLinux &&
        !dialogWarningsRepository.desktopWarningDialogShown) {
      dialogWarningsRepository.desktopWarningDialogShown = true;

      yield const ShowDesktopWarningDialogState();
    } else {
      yield const AlreadyShownWarningDialogState();
    }
  }

  Stream<WarningDialogState> _mapMaybeShowKeysWarningDialogEventToState(
    MaybeShowKeysWarningDialogEvent event,
  ) async* {
    if (dialogWarningsRepository.keysWarningDialogShown == false) {
      dialogWarningsRepository.keysWarningDialogShown = true;

      yield const ShowKeysWarningDialogState();
    } else {
      yield const AlreadyShownKeysWebWarningDialogState();
    }
  }
}
