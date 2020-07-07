import 'package:amadeo/helpers/net_helper.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/core/utils/utils.dart';
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
    final commercioAccount =
        RepositoryProvider.of<StatefulCommercioAccount>(context);

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28.0,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      backgroundColor: Colors.transparent,
      elevation: .0,
      actions: widgets ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: PopupMenuButton<ChainNet>(
                onSelected: (ChainNet result) {
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
                        'Switched to ${result.name}. Please restore the wallet.',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<ChainNet>(
                      enabled: commercioAccount.networkInfo.lcdUrl !=
                          ChainNet.test.lcdUrl,
                      value: ChainNet.test,
                      child: Text(ChainNet.test.name),
                    ),
                    PopupMenuItem<ChainNet>(
                      enabled: commercioAccount.networkInfo.lcdUrl !=
                          ChainNet.dev.lcdUrl,
                      value: ChainNet.dev,
                      child: Text(ChainNet.dev.name),
                    ),
                  ];
                },
                child: const Icon(Icons.settings),
              ),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
