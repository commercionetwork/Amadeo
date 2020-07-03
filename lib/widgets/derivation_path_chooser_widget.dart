import 'package:flutter/material.dart';

class DerivationPathChooserWidget extends StatefulWidget {
  final void Function(int) onChanged;

  const DerivationPathChooserWidget({
    Key key,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _DerivationPathChooserWidgetState createState() =>
      _DerivationPathChooserWidgetState();
}

class _DerivationPathChooserWidgetState
    extends State<DerivationPathChooserWidget> {
  double lastDerivationPathSegment = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                '0',
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white70,
                    inactiveTrackColor: Colors.white30,
                    trackShape: const RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: Colors.white,
                    overlayColor: Colors.grey.withAlpha(32),
                    overlayShape: const RoundSliderOverlayShape(),
                    tickMarkShape: const RoundSliderTickMarkShape(),
                    activeTickMarkColor: Colors.black87,
                    inactiveTickMarkColor: Colors.black45,
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.black87,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    max: 10.0,
                    divisions: 10,
                    value: lastDerivationPathSegment,
                    label: '${lastDerivationPathSegment.toInt()}',
                    onChanged: (value) {
                      lastDerivationPathSegment = value;
                      widget.onChanged(value.toInt());
                    },
                  ),
                ),
              ),
              const Text(
                '10',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
