import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';
import 'package:uuid/uuid.dart';

class MintCccPage extends SectionPageWidget {
  const MintCccPage({Key? key})
      : super('/5-mint/mint-ccc', 'MintCccPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: MintCccPageBody(),
    );
  }
}

class MintCccPageBody extends StatelessWidget {
  const MintCccPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioMintCCCBloc(
            commercioMint:
                RepositoryProvider.of<StatefulCommercioMint>(context),
          ),
          child: const MintCccWidget(),
        ),
      ],
    );
  }
}

class MintCccWidget extends StatefulWidget {
  const MintCccWidget({Key? key}) : super(key: key);

  @override
  _MintCccWidgetState createState() => _MintCccWidgetState();
}

class _MintCccWidgetState extends State<MintCccWidget> {
  final _amountTextController = TextEditingController(text: '100');
  final mintUuid = const Uuid().v4();
  late final TextEditingController _mintUuidController;
  late final StatefulCommercioAccount commAccount;

  @override
  void initState() {
    commAccount = context.read<StatefulCommercioAccount>();
    _mintUuidController = TextEditingController(text: mintUuid);
    super.initState();
  }

  @override
  void dispose() {
    _amountTextController.dispose();
    _mintUuidController.dispose();
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
            'Press the button to mint the specified amount of tokens.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: MintCccFlatButton(
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                event: () => CommercioMintCCCEvent(
                  derivedMintCCC: [
                    MintCcc(
                      depositAmount: [
                        StdCoin(
                          amount: _amountTextController.text,
                          denom: 'uccc',
                        ),
                      ],
                      signerDid: commAccount.walletAddress!,
                      id: _mintUuidController.text,
                    ),
                  ],
                ),
                child: (_) => const Text(
                  'Open Cdp',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          MintCccTextField(
            loading: (_) => 'Opening...',
            text: (_, state) => state.maybeWhen(
              (result) => txResultToString(result),
              orElse: () => '',
            ),
          ),
          const SizedBox(height: 20.0),
          const Text('Save the following Mint UUID:'),
          const SizedBox(height: 8.0),
          TextField(
            controller: _mintUuidController,
            readOnly: true,
            decoration: const InputDecoration(
              hintText: '090ca0c2-cf00-4119-8307-b51413a00cf4',
              labelText: 'Mint UUID',
            ),
          ),
        ],
      ),
    );
  }
}
