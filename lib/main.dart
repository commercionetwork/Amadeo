import 'package:amadeo_flutter/home_screen.dart';
import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/utils/style.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final commercioAccount = StatefulCommercioAccount();

  final providers = [
    BlocProvider(
      create: (_) => CommercioAccountBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider(
      create: (_) => CommercioIdBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider(
      create: (_) => CommercioDocsBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider(
      create: (_) => CommercioMintBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider(
      create: (_) =>
          CommercioMembershipBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider<CommercioDocsEncDataBloc>(
      create: (_) => CommercioDocsEncDataBloc(),
    ),
  ];

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amadeo',
      theme: companyTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/1-account': (_) => const CommercioAccountPage(),
        '/1-account/generate-new-wallet': (_) => const GenerateNewWalletPage(),
        '/1-account/restore-wallet-from-mnemonic': (_) =>
            const RestoreWalletFromMnemonicPage(),
        '/1-account/restore-wallet-from-secure-storage': (_) =>
            const RestoreWalletFromSecureStoragePage(),
        '/1-account/share-qr-code': (_) => const ShareQRCodePage(),
        '/1-account/request-invite-free-tokens': (_) =>
            const RequestInviteFreeTokensPage(),
        '/1-account/check-account-balance': (_) =>
            const CheckAccountBalancePage(),
        '/1-account/send-tokens': (_) => const SendTokensPage(),
        '/1-account/generate-many-addresses': (_) =>
            const GenerateManyAddressesPage(),
        '/2-id': (_) => const CommercioIdPage(),
        '/2-id/create-ddo': (_) => const CreateDDOPage(),
        '/2-id/request-powerup': (_) => const RequestPowerupPage(),
        '/3-docs': (_) => const CommercioDocsPage(),
        '/3-docs/share-doc': (_) => const ShareDocPage(),
        '/3-docs/send-receipt': (_) => const SendReceiptPage(),
        '/3-docs/document-list': (_) => const DocumentListPage(),
        '/3-docs/receipt-list': (_) => const ReceiptListPage(),
        '/4-sign': (_) => const CommercioSignPage(),
        '/5-mint': (_) => const CommercioMintPage(),
        '/6-membership': (_) => const CommercioMembershipPage(),
      },
    );
  }
}
