import 'package:flutter/material.dart';

class BaseDrawerWidget extends StatelessWidget {
  const BaseDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Amadeo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.0),
                  child: Text(
                    'Starter/cookbook Flutter projec for Commercio.network.',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Account'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/1-account'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Id'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/2-id'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Docs'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/3-docs'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Sign'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/4-sign'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Mint'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/5-mint'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Kyc'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/6-kyc'),
          ),
          const Divider(),
          const AboutListTile(
            applicationName: 'Amadeo',
            applicationVersion: '0.2.0',
          )
        ],
      ),
    );
  }
}
