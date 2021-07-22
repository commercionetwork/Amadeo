import 'dart:async';

import 'package:amadeo/repositories/sdn_selected_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';

part 'sdn_data_event.dart';
part 'sdn_data_state.dart';

class SdnDataBloc extends Bloc<SdnDataEvent, SdnDataState> {
  final SdnSelectedDataRepository sdnSelectedDataRepository;

  SdnDataBloc({required this.sdnSelectedDataRepository})
      : super(
          SdnDataInitial(
            commercioSdnData:
                sdnSelectedDataRepository.selectedCommercioSdnData,
          ),
        );

  @override
  Stream<SdnDataState> mapEventToState(
    SdnDataEvent event,
  ) async* {
    if (event is ChangeSdnDataEvent) {
      yield* _mapSdnDataEventToState(event);
    }
  }

  Stream<SdnDataState> _mapSdnDataEventToState(
      ChangeSdnDataEvent event) async* {
    yield const SdnDataLoading();

    try {
      final newCommercioSdnData = Map<CommercioSdnData, bool>.from(
        sdnSelectedDataRepository.selectedCommercioSdnData,
      );

      newCommercioSdnData[event.sdnDataKey] = event.newValue;

      sdnSelectedDataRepository.selectedCommercioSdnData = newCommercioSdnData;

      yield SdnDataChanged(commercioSdnData: newCommercioSdnData);
    } catch (e) {
      yield SdnDataError(e.toString());
    }
  }
}
