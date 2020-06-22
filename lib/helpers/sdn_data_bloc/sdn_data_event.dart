part of 'sdn_data_bloc.dart';

abstract class SdnDataEvent extends Equatable {
  const SdnDataEvent();
}

class ChangeSdnDataEvent extends SdnDataEvent {
  final CommercioSdnData sdnDataKey;
  final bool newValue;

  const ChangeSdnDataEvent({
    @required this.sdnDataKey,
    @required this.newValue,
  });

  @override
  List<Object> get props => [sdnDataKey, newValue];
}
