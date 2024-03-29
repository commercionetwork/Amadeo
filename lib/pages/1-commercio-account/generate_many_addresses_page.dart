import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/derivation_path_chooser_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class GenerateManyAddressesPage extends SectionPageWidget {
  const GenerateManyAddressesPage({Key? key})
      : super('/1-account/generate-many-addresses', 'GenerateManyAddressesPage',
            key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
        bodyWidget: GenerateManyAddressesPageBody());
  }
}

class GenerateManyAddressesPageBody extends StatelessWidget {
  const GenerateManyAddressesPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        Column(
          children: [
            BlocProvider(
              create: (_) => CommercioAccountGeneratePairwiseWalletBloc(
                commercioAccount:
                    RepositoryProvider.of<StatefulCommercioAccount>(
                  context,
                ),
              ),
              child: const GeneratePairwiseWalletWidget(),
            ),
          ],
        ),
      ],
    );
  }
}

class GeneratePairwiseWalletWidget extends StatefulWidget {
  const GeneratePairwiseWalletWidget({Key? key}) : super(key: key);

  @override
  _GeneratePairwiseWalletWidgetState createState() =>
      _GeneratePairwiseWalletWidgetState();
}

class _GeneratePairwiseWalletWidgetState
    extends State<GeneratePairwiseWalletWidget> {
  int derivationPathValue = 0;
  static const String baseDerivationPath = "m/44'/118'/0'/0";
  String derivationPath = '$baseDerivationPath/0';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Choose a derivation path value',
          ),
          Center(
            child: DerivationPathChooserWidget(
              onChanged: (selectedValue) {
                derivationPathValue = selectedValue;

                setState(() {
                  derivationPath =
                      '$baseDerivationPath/${derivationPathValue.toInt()}';
                });
              },
            ),
          ),
          Text('Derivation path: $derivationPath'),
          const ParagraphWidget(
            'Press the button to generate a pairwise wallet.',
          ),
          Center(
            child: GeneratePairwiseWalletFlatButton(
              child: (_) => const Text(
                'Generate pairwise wallet',
                style: TextStyle(color: Colors.white),
              ),
              event: () => CommercioAccountGeneratePairwiseWalletEvent(
                lastDerivationPath: derivationPathValue.toString(),
              ),
              buttonStyle: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GeneratePairwiseWalletTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.maybeWhen(
              (wallet, walletAddress) => walletAddress,
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
