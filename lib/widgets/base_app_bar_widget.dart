import 'package:amadeo/helpers/net_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? widgets;

  const BaseAppBarWidget({
    required this.title,
    this.widgets,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccount = context.read<StatefulCommercioAccount>();

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: .0,
      actions: widgets ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: PopupMenuButton<ChainNet>(
                onSelected: (ChainNet result) {
                  commercioAccount.networkInfo = NetworkInfo(
                    bech32Hrp: result.bech32Hrp,
                    lcdUrl: result.lcdUrl,
                  );

                  commercioAccount.httpHelper = HttpHelper(
                    faucetDomain: result.faucetDomain,
                    lcdUrl: result.lcdUrl,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
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
                      enabled: commercioAccount.networkInfo?.lcdUrl !=
                          ChainNet.test.lcdUrl,
                      value: ChainNet.test,
                      child: Text(ChainNet.test.name),
                    ),
                    PopupMenuItem<ChainNet>(
                      enabled: commercioAccount.networkInfo?.lcdUrl !=
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
