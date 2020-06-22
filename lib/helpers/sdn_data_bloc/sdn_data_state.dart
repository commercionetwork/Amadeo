part of 'sdn_data_bloc.dart';

abstract class SdnDataState extends Equatable {
  const SdnDataState();
}

abstract class SdnDataStateWithData extends SdnDataState {
  final Map<CommercioSdnData, bool> commercioSdnData;

  const SdnDataStateWithData({@required this.commercioSdnData});

  @override
  List<Object> get props => [commercioSdnData];
}

class SdnDataInitial extends SdnDataStateWithData {
  const SdnDataInitial({@required Map<CommercioSdnData, bool> commercioSdnData})
      : super(commercioSdnData: commercioSdnData);
}

class SdnDataChanged extends SdnDataStateWithData {
  const SdnDataChanged({@required Map<CommercioSdnData, bool> commercioSdnData})
      : super(commercioSdnData: commercioSdnData);
}

class SdnDataLoading extends SdnDataState {
  const SdnDataLoading();

  @override
  List<Object> get props => [];
}

class SdnDataError extends SdnDataState {
  final String message;

  const SdnDataError(this.message);

  @override
  List<Object> get props => [message];
}
