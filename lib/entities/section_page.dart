import 'package:amadeo/pages/export.dart';

class SectionPage {
  final SectionPageWidget sectionPageWidget;
  final String title;
  final String description;
  final bool enabled;

  const SectionPage({
    required this.sectionPageWidget,
    required this.title,
    this.description = '',
    this.enabled = true,
  });
}
