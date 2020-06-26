import 'package:amadeo/pages/section_page.dart';
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioKycBuyMembershipBloc>(
                  create: (_) => CommercioKycBuyMembershipBloc(
                    commercioKyc:
                        RepositoryProvider.of<StatefulCommercioKyc>(context),
                  ),
                  child: const BuyMembershipWidget(),
                ),
              ],
            ),
          ),
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
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Buy a membership for the current account.',
            padding: EdgeInsets.all(5.0),
          ),
          BuyMembershipFlatButton(
            accountEventCallback: () => CommercioKycBuyMembershipEvent(
              membershipType: membershipType,
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Buying...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Buy membership',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: BuyMembershipTextField(
              readOnly: true,
              loadingTextCallback: () => 'Buying...',
              textCallback: (state) => state.result.success
                  ? 'Success! Hash: ${state.result.hash}'
                  : 'Error: ${state.result.error.errorMessage}',
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
