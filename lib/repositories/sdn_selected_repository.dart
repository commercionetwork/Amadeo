import 'package:commerciosdk/export.dart';

class SdnSelectedDataRepository {
  Map<CommercioSdnData, bool> selectedCommercioSdnData;

  SdnSelectedDataRepository({
    Map<CommercioSdnData, bool> selectedCommercioSdnData,
  }) : selectedCommercioSdnData = selectedCommercioSdnData ??
            {for (var k in CommercioSdnData.values) k: false};

  List<CommercioSdnData> get sdnDataList => selectedCommercioSdnData.entries
      .where((element) => element.value)
      .map((e) => e.key)
      .toList();
}
