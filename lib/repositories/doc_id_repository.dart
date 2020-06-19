import 'package:uuid/uuid.dart';

class DocIdRepository {
  String docId;

  DocIdRepository() : docId = '';

  String generateNewDocId() {
    return docId = Uuid().v4();
  }
}
