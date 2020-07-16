import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenCdpPage extends SectionPageWidget {
  const OpenCdpPage({Key key})
      : super('/5-mint/open-cdp', 'OpenCdpPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: OpenCdpPageBody(),
    );
  }
}

class OpenCdpPageBody extends StatelessWidget {
  const OpenCdpPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioMintOpenCdpBloc(
            commercioMint:
                RepositoryProvider.of<StatefulCommercioMint>(context),
          ),
          child: const OpenCdpWidget(),
        ),
      ],
    );
  }
}

class OpenCdpWidget extends StatefulWidget {
  const OpenCdpWidget();

  @override
  _OpenCdpWidgetState createState() => _OpenCdpWidgetState();
}

class _OpenCdpWidgetState extends State<OpenCdpWidget> {
  final _amountTextController = TextEditingController();

  @override
  void dispose() {
    _amountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _amountTextController,
            decoration: const InputDecoration(
              hintText: '100',
              labelText: 'Amount of tokens',
            ),
          ),
          const ParagraphWidget(
            'Press the button to open a Cdp with the specified.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: OpenCdpFlatButton(
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
                event: () => CommercioMintOpenCdpEvent(
                  amount: int.tryParse(_amountTextController.text),
                ),
                child: (_) => const Text(
                  'Open Cdp',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          OpenCdpTextField(
            loading: (_) => 'Opening...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
