import 'package:amadeo/pages/section_page.dart';
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioMintOpenCdpBloc>(
                  create: (_) => CommercioMintOpenCdpBloc(
                    commercioMint:
                        RepositoryProvider.of<StatefulCommercioMint>(context),
                  ),
                  child: OpenCdpWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OpenCdpWidget extends StatelessWidget {
  final TextEditingController amountTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: amountTextController,
            decoration: const InputDecoration(
              hintText: '100',
              labelText: 'Amount of tokens',
            ),
          ),
          const ParagraphWidget(
            'Press the button to open a Cdp with the specified.',
            padding: EdgeInsets.all(5.0),
          ),
          OpenCdpFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Opening...',
              style: TextStyle(color: Colors.white),
            ),
            accountEventCallback: () => CommercioMintOpenCdpEvent(
              amount: int.tryParse(amountTextController.text),
            ),
            child: () => const Text(
              'Open Cdp',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: OpenCdpTextField(
              readOnly: true,
              loadingTextCallback: () => 'Opening...',
              textCallback: (state) => state.result.success
                  ? 'Success! Hash: ${state.result.hash}'
                  : 'Error: ${state.result.error.errorMessage}',
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
