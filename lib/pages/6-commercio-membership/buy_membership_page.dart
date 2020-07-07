import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commerciosdk/export.dart' hide Key, Padding;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyMembershipPage extends SectionPageWidget {
  const BuyMembershipPage({Key key})
      : super('/6-kyc/buy-membership', 'BuyMembershipPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: BuyMembershipPageBody(),
    );
  }
}

class BuyMembershipPageBody extends StatelessWidget {
  const BuyMembershipPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioKycBuyMembershipBloc(
            commercioKyc: RepositoryProvider.of<StatefulCommercioKyc>(context),
          ),
          child: const BuyMembershipWidget(),
        ),
      ],
    );
  }
}

class BuyMembershipWidget extends StatelessWidget {
  final MembershipType membershipType = MembershipType.BRONZE;

  const BuyMembershipWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Buy a membership for the current account.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: BuyMembershipFlatButton(
                event: () => CommercioKycBuyMembershipEvent(
                  membershipType: membershipType,
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Buy membership',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          BuyMembershipTextField(
            loading: (_) => 'Buying...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
