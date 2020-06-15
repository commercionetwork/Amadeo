import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioIdPage extends SectionPageWidget {
  const CommercioIdPage({Key key})
      : super('/2-id', 'CommercioIdPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: CommercioIdBody());
  }
}

class CommercioIdBody extends StatelessWidget {
  const CommercioIdBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/2-id/create-ddo'),
                  child: const Text(
                    '2.1 Create a Ddo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/2-id/request-powerup'),
                  child: const Text(
                    '2.2 Request Powerup',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
