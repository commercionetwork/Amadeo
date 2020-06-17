import 'package:amadeo/helpers/net_helper.dart';
import 'package:amadeo/home_screen.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/utils/style.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/core/utils/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final commercioAccount = StatefulCommercioAccount(
    networkInfo: NetworkInfo(
      bech32Hrp: ChainNet.dev.bech32Hrp,
      lcdUrl: ChainNet.dev.lcdUrl,
    ),
    httpHelper: HttpHelper(
      faucetDomain: ChainNet.dev.faucetDomain,
      lcdUrl: ChainNet.dev.lcdUrl,
    ),
  );
  final commercioDocs =
      StatefulCommercioDocs(commercioAccount: commercioAccount);
  final commercioId = StatefulCommercioId(commercioAccount: commercioAccount);
  final commercioMint =
      StatefulCommercioMint(commercioAccount: commercioAccount);
  final commercioMembership =
      StatefulCommercioMembership(commercioAccount: commercioAccount);

  final providers = [
    BlocProvider(
      create: (_) => CommercioAccountBloc(commercioAccount: commercioAccount),
    ),
    BlocProvider(
      create: (_) => CommercioIdBloc(commercioId: commercioId),
    ),
    BlocProvider(
      create: (_) => CommercioDocsBloc(
        commercioDocs: commercioDocs,
        commercioId: commercioId,
      ),
    ),
    BlocProvider(
      create: (_) => CommercioMintBloc(commercioMint: commercioMint),
    ),
    BlocProvider(
      create: (_) =>
          CommercioMembershipBloc(commercioMembership: commercioMembership),
    ),
    BlocProvider<CommercioDocsEncDataBloc>(
      create: (_) => CommercioDocsEncDataBloc(),
    ),
  ];

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: RepositoryProvider<StatefulCommercioAccount>.value(
        value: commercioAccount,
        child: MyApp(),
      ),
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
        '/5-mint': (_) => const CommercioMintPage(),
        '/5-mint/open-cdp': (_) => const OpenCdpPage(),
        '/5-mint/close-cdp': (_) => const CloseCdpPage(),
        '/6-kyc': (_) => const CommercioKYCPage(),
        '/6-kyc/buy-membership': (_) => const BuyMembershipPage(),
        '/6-kyc/invite-member': (_) => const InviteMemberPage(),
      },
    );
  }
}
