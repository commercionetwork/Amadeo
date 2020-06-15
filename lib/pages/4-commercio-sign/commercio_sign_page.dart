import 'package:amadeo_flutter/helpers/bloc/sign_bloc.dart';
import 'package:amadeo_flutter/pages/1-commercio-account/restore_wallet_from_mnemonic.dart';
import 'package:amadeo_flutter/pages/2-commercio-id/commercio_id_page.dart';
import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CommercioSignPage extends SectionPageWidget {
  const CommercioSignPage({Key key})
      : super('/4-sign', 'CommercioSignPage', key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => SignBloc(
                  dsbUrl: '192.168.1.13',
                  didComAuthUrl: '192.168.1.13',
                )),
        BlocProvider(
          create: (_) => CommercioIdBloc(
              commercioAccount:
                  Provider.of<CommercioAccountBloc>(context).commercioAccount),
        ),
      ],
      child: BaseScaffoldWidget(bodyWidget: CommercioSignBody()),
    );
  }
}

class CommercioSignBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                RestoreWalletFromMnemonicWidget(),
                RestoreKeysWidget(),
                LoadDocumentWidget(),
                SignDocumentWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoadDocumentWidget extends StatelessWidget {
  const LoadDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          BlocBuilder<SignBloc, SignState>(builder: (context, state) {
            if (state is SignLoadDocumentLoading) {
              return FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: null,
                  child: const Text(
                    'Load document',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ));
            }

            return FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => BlocProvider.of<SignBloc>(context)
                    .add(const SignLoadDocumentEvent()),
                child: const Text(
                  'Load document',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ));
          }),
          BlocBuilder<SignBloc, SignState>(
            builder: (context, state) {
              if (state is SignInitial) {
                return const Text('');
              }

              if (state is SignLoadDocumentLoading) {
                return const Text(
                  'Loading',
                  style: TextStyle(color: Colors.grey),
                );
              }

              if (state is SignDocumentLoaded) {
                return Text(state.content);
              }

              if (state is SignLoadDocumentError) {
                return Text('Error: ${state.error}');
              }

              return const Text('');
            },
          ),
        ],
      ),
    );
  }
}

class SignDocumentWidget extends StatelessWidget {
  const SignDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          BlocBuilder<SignBloc, SignState>(builder: (context, state) {
            if (state is SignDocumentLoading) {
              return FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: null,
                  child: const Text(
                    'Sign document',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ));
            }

            return FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () =>
                    BlocProvider.of<SignBloc>(context).add(SignDocumentEvent(
                      walletAddress:
                          BlocProvider.of<CommercioAccountBloc>(context)
                              .commercioAccount
                              .walletAddress,
                      signingKey: BlocProvider.of<CommercioIdBloc>(context)
                          .commercioId
                          .commercioIdKeys
                          .rsaSignatureKeyPair
                          .privateKey,
                    )),
                child: const Text(
                  'Sign document',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ));
          }),
          BlocBuilder<SignBloc, SignState>(
            builder: (context, state) {
              if (state is SignInitial) {
                return const Text('');
              }

              if (state is SignDocumentLoading) {
                return const Text(
                  'Loading',
                  style: TextStyle(color: Colors.grey),
                );
              }

              if (state is SignedDocument) {
                return Text(state.result);
              }

              if (state is SignDocumentError) {
                return Text('Error: ${state.error}');
              }

              return const Text('');
            },
          ),
        ],
      ),
    );
  }
}
