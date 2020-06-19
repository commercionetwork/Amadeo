part of 'sign_bloc.dart';

abstract class SignState extends Equatable {
  const SignState();
}

class SignInitial extends SignState {
  const SignInitial();

  @override
  List<Object> get props => [];
}

class SignDocumentLoaded extends SignState {
  final String content;
  final String hash;

  const SignDocumentLoaded({@required this.content, @required this.hash});

  @override
  List<Object> get props => [content, hash];
}

// Load document

class SignLoadDocumentLoading extends SignState {
  const SignLoadDocumentLoading();

  @override
  List<Object> get props => [];
}

class SignLoadDocumentError extends SignState {
  final String error;

  const SignLoadDocumentError(this.error);

  @override
  List<Object> get props => [error];
}

// Sign document

class SignedDocument extends SignState {
  final String result;

  const SignedDocument({@required this.result});

  @override
  List<Object> get props => [result];
}

class SignDocumentLoading extends SignState {
  const SignDocumentLoading();

  @override
  List<Object> get props => [];
}

class SignDocumentError extends SignState {
  final String error;

  const SignDocumentError(this.error);

  @override
  List<Object> get props => [error];
}

// Generate new uuid

class NewDocUuid extends SignState {
  final String docId;

  const NewDocUuid({@required this.docId});

  @override
  List<Object> get props => [docId];
}

class SignNewDocUuidLoading extends SignState {
  const SignNewDocUuidLoading();

  @override
  List<Object> get props => [];
}

class SignNewDocUuidError extends SignState {
  final String error;

  const SignNewDocUuidError(this.error);

  @override
  List<Object> get props => [error];
}
