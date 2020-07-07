import 'package:flutter/material.dart';

class DocMetadataWidget extends StatelessWidget {
  final TextEditingController contentUriController;
  final TextEditingController metadataSchemaUriController;
  final TextEditingController metadataSchemaVersionController;
  final TextEditingController metadataContentUriController;
  final TextEditingController metadataSchemaTypeController;

  const DocMetadataWidget({
    @required this.contentUriController,
    @required this.metadataSchemaUriController,
    @required this.metadataSchemaVersionController,
    @required this.metadataContentUriController,
    @required this.metadataSchemaTypeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'https://example.com/document',
            labelText: 'Content uri',
          ),
          controller: contentUriController,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'https://example.com/document/metadata',
            labelText: 'Metadata content uri',
          ),
          controller: metadataContentUriController,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'https://example.com/custom/metadata/schema',
            labelText: 'Metadata schema uri',
          ),
          controller: metadataSchemaUriController,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: '1.0.0',
            labelText: 'Metadata schema version',
          ),
          controller: metadataSchemaVersionController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Metadata schema type'),
          controller: metadataSchemaTypeController,
        ),
      ],
    );
  }
}
