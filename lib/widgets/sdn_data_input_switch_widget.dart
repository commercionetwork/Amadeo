import 'package:amadeo/helpers/sdn_data_bloc/sdn_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerciosdk/export.dart' as sdk;

class SdnDataInputSwitchWidget extends StatelessWidget {
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final ImageProvider activeThumbImage;
  final ImageProvider inactiveThumbImage;
  final Widget Function(MapEntry<dynamic, bool> entry) title;
  final Widget subtitle;
  final Widget secondary;
  final bool isThreeLine;
  final bool dense;
  final EdgeInsetsGeometry contentPadding;
  final bool selected;

  const SdnDataInputSwitchWidget({
    Key key,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SdnDataBloc, SdnDataState>(builder: (_, state) {
      if (state is SdnDataStateWithData) {
        return Column(
          children: state.commercioSdnData.entries
              .map(
                (MapEntry<sdk.CommercioSdnData, bool> entry) => SwitchListTile(
                  activeColor: activeColor,
                  activeTrackColor: activeTrackColor,
                  inactiveThumbColor: inactiveThumbColor,
                  activeThumbImage: activeThumbImage,
                  inactiveThumbImage: inactiveThumbImage,
                  title: title != null
                      ? title(entry)
                      : Text(entry.key.toString().split('.')[1].toLowerCase()),
                  subtitle: subtitle,
                  isThreeLine: isThreeLine,
                  dense: dense,
                  contentPadding: contentPadding,
                  secondary: secondary,
                  selected: selected,
                  value: entry.value,
                  onChanged: (newValue) => BlocProvider.of<SdnDataBloc>(context)
                      .add(ChangeSdnDataEvent(
                    sdnDataKey: entry.key,
                    newValue: newValue,
                  )),
                ),
              )
              .toList(),
        );
      }

      return Container();
    });
  }
}
