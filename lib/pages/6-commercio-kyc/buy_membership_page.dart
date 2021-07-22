import 'package:amadeo/helpers/net_helper.dart';
import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class BuyMembershipPage extends SectionPageWidget {
  const BuyMembershipPage({Key? key})
      : super('/6-kyc/buy-membership', 'BuyMembershipPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioKycDeriveBuyMembershipBloc(
          commercioKyc: context.read<StatefulCommercioKyc>(),
        ),
        child: const BuyMembershipPageBody(),
      ),
    );
  }
}

class BuyMembershipPageBody extends StatelessWidget {
  const BuyMembershipPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CommercioKycBuyMembershipsBloc(
                commercioKyc: context.read<StatefulCommercioKyc>(),
              ),
            ),
            BlocProvider(
              create: (_) => CommercioKycMembershipTypeChooserBloc(),
            ),
          ],
          child: const BuyMembershipWidget(),
        ),
      ],
    );
  }
}

class BuyMembershipWidget extends StatelessWidget {
  final MembershipType membershipType = MembershipType.BRONZE;

  const BuyMembershipWidget({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final commAccount = context.read<StatefulCommercioAccount>();
    final membershipBloc =
        context.read<CommercioKycMembershipTypeChooserBloc>();

    final button = BuyMembershipsFlatButton(
      event: commAccount.hasWalletAddress
          ? () => CommercioKycBuyMembershipsEvent(
                buyMemberships: [
                  BuyMembership(
                    membershipType: membershipBloc.membershipType.value,
                    buyerDid: commAccount.walletAddress!,
                    tsp: commAccount.networkInfo?.lcdUrl == ChainNet.dev.lcdUrl
                        ? ChainNet.dev.defaultTsp
                        : ChainNet.test.defaultTsp,
                  ),
                ],
              )
          : null,
      buttonStyle: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: (_) => const Text(
        'Buy membership',
        style: TextStyle(color: Colors.white),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Buy a membership for the current account.',
          ),
          const CommercioMembershipTypeChooser(
            listViewStyle: CommercioListViewStyle(
              shrinkWrap: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: (commAccount.hasWalletAddress)
                  ? button
                  : Tooltip(
                      message: 'Must have a wallet',
                      child: button,
                    ),
            ),
          ),
          BuyMembershipsTextField(
            loading: (_) => 'Buying...',
            text: (_, state) => state.maybeWhen(
              (result) => txResultToString(result),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
