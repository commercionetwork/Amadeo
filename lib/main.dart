import 'package:amadeo/helpers/net_helper.dart';
import 'package:amadeo/my_app.dart';
import 'package:amadeo/repositories/document_repository.dart';
import 'package:amadeo/repositories/sdn_selected_repository.dart';
import 'package:amadeo/simple_bloc_delegate.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/core/utils/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kReleaseMode) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }

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

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: commercioAccount),
        RepositoryProvider(
          create: (_) =>
              StatefulCommercioDocs(commercioAccount: commercioAccount),
        ),
        RepositoryProvider(
          create: (_) =>
              StatefulCommercioId(commercioAccount: commercioAccount),
        ),
        RepositoryProvider(
          create: (_) =>
              StatefulCommercioMint(commercioAccount: commercioAccount),
        ),
        RepositoryProvider(
          create: (_) =>
              StatefulCommercioKyc(commercioAccount: commercioAccount),
        ),
        RepositoryProvider(create: (_) => DocumentRepository()),
        RepositoryProvider(create: (_) => SdnSelectedDataRepository()),
      ],
      child: const MyApp(),
    ),
  );
}
