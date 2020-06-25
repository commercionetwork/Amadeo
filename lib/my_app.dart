import 'package:amadeo/helpers/sdn_data_bloc/sdn_data_bloc.dart';
import 'package:amadeo/helpers/sign_bloc/sign_bloc.dart';
import 'package:amadeo/helpers/sign_constants.dart';
import 'package:amadeo/home_screen.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/repositories/document_repository.dart';
import 'package:amadeo/repositories/sdn_selected_repository.dart';
import 'package:amadeo/utils/style.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final commercioAccount =
        RepositoryProvider.of<StatefulCommercioAccount>(context);
    final commercioId = RepositoryProvider.of<StatefulCommercioId>(context);
    final commercioDocs = RepositoryProvider.of<StatefulCommercioDocs>(context);
    final documentRepository =
        RepositoryProvider.of<DocumentRepository>(context);
    final sdnSelectedDataRepository =
        RepositoryProvider.of<SdnSelectedDataRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignBloc(
            commercioDocs: commercioDocs,
            commercioId: commercioId,
            documentRepository: documentRepository,
            dsbPort: commercioDsbDevPort,
            dsbSignerAddress: commercioDsbDevSigner,
            dsbUrl: commercioDsbDevUrl,
          ),
        ),
        BlocProvider<CommercioDocsEncDataBloc>(
            create: (_) => CommercioDocsEncDataBloc()),
        BlocProvider<SdnDataBloc>(
          create: (_) =>
              SdnDataBloc(sdnSelectedDataRepository: sdnSelectedDataRepository),
        ),
      ],
      child: RepositoryProvider<StatefulCommercioAccount>.value(
        value: commercioAccount,
        child: MyAppBody(),
      ),
    );
  }
}

class MyAppBody extends StatelessWidget {
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
        '/5-mint/open-cdp': (_) => const OpenCdpPage(),
        '/5-mint/close-cdp': (_) => const CloseCdpPage(),
        '/6-kyc': (_) => const CommercioKYCPage(),
        '/6-kyc/buy-membership': (_) => const BuyMembershipPage(),
        '/6-kyc/invite-member': (_) => const InviteMemberPage(),
      },
    );
  }
}
