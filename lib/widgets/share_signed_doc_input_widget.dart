import 'package:flutter/material.dart';

class ShareSignedDocInputWidget extends StatelessWidget {
  final TextEditingController storageUriTextController;
  final TextEditingController signerIstanceTextController;
  final TextEditingController vcrIdTextController;
  final TextEditingController certificateProfileTextController;

  const ShareSignedDocInputWidget({
    @required this.storageUriTextController,
    @required this.signerIstanceTextController,
    @required this.vcrIdTextController,
    @required this.certificateProfileTextController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
              hintText: 'https://dsb-devnet.localhost',
              labelText: 'storage_uri'),
          controller: storageUriTextController,
          enabled: storageUriTextController.text.isEmpty,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: 'did:com:1u70n4eysyuf08wcckwrs2atcaqw5d025w39u33',
              labelText: 'Signer address'),
          controller: signerIstanceTextController,
          enabled: signerIstanceTextController.text.isEmpty,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'xxxxx',
            labelText: 'VCR id',
            enabled: vcrIdTextController.text.isEmpty,
          ),
          controller: vcrIdTextController,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'xxxxx',
            labelText: 'Certificate profile',
            enabled: certificateProfileTextController.text.isEmpty,
          ),
          controller: certificateProfileTextController,
        ),
      ],
    );
  }
}
