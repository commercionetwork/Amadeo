part of 'warning_dialog_bloc.dart';

abstract class WarningDialogEvent extends Equatable {
  const WarningDialogEvent();
}

class MaybeShowWebWarningDialogEvent extends WarningDialogEvent {
  const MaybeShowWebWarningDialogEvent();

  @override
  List<Object> get props => [];
}

class MaybeShowKeysWarningDialogEvent extends WarningDialogEvent {
  const MaybeShowKeysWarningDialogEvent();

  @override
  List<Object> get props => [];
}
