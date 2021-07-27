import 'package:flutter/material.dart';

class RecipientAddressTextFieldWidget extends StatelessWidget {
  final TextEditingController recipientTextController;

  const RecipientAddressTextFieldWidget({
    required this.recipientTextController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
        labelText: 'Recipient address',
      ),
      controller: recipientTextController,
    );
  }
}
