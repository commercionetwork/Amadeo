part of 'warning_dialog_bloc.dart';

abstract class WarningDialogState extends Equatable {
  const WarningDialogState();
}

class WarningDialogInitialState extends WarningDialogState {
  const WarningDialogInitialState();

  @override
  List<Object> get props => [];
}

class ShowWebWarningDialogState extends WarningDialogState {
  const ShowWebWarningDialogState();

  @override
  List<Object> get props => [];
}

class AlreadyShownWebWarningDialogState extends WarningDialogState {
  const AlreadyShownWebWarningDialogState();

  @override
  List<Object> get props => [];
}

class KeysWarningDialogLoadingState extends WarningDialogState {
  const KeysWarningDialogLoadingState();

  @override
  List<Object> get props => [];
}

class KeysWarningDialogErrorState extends WarningDialogState {
  const KeysWarningDialogErrorState();

  @override
  List<Object> get props => [];
}

class ShowKeysWarningDialogState extends WarningDialogState {
  const ShowKeysWarningDialogState();

  @override
  List<Object> get props => [];
}

class AlreadyShownKeysWebWarningDialogState extends WarningDialogState {
  const AlreadyShownKeysWebWarningDialogState();

  @override
  List<Object> get props => [];
}
