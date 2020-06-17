import 'package:amadeo/helpers/net_helper.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/core/utils/export.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> widgets;

  const BaseAppBarWidget({
    Key key,
    this.title,
    this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: widgets ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: PopupMenuButton<ChainNet>(
                onSelected: (ChainNet result) {
                  final commercioAccount =
                      RepositoryProvider.of<StatefulCommercioAccount>(context);

                  commercioAccount.networkInfo = sdk.NetworkInfo(
                    bech32Hrp: result.bech32Hrp,
                    lcdUrl: result.lcdUrl,
                  );

                  commercioAccount.httpHelper = HttpHelper(
                    faucetDomain: result.faucetDomain,
                    lcdUrl: result.lcdUrl,
                  );

                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Switched to ${result.name}. Please restore the wallet.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                itemBuilder: (_) => [
                  PopupMenuItem<ChainNet>(
                    value: ChainNet.test,
                    child: Text(ChainNet.test.name),
                  ),
                  PopupMenuItem<ChainNet>(
                    value: ChainNet.dev,
                    child: Text(ChainNet.dev.name),
                  ),
                ],
                offset: Offset(
                    10.0,
                    MediaQuery.of(context).padding.top * 2 +
                        preferredSize.height),
                initialValue: ChainNet.dev,
                child: const Icon(Icons.settings),
              ),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
