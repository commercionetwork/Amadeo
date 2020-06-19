const commercioDsbDevUrl = 'dsb-devnet.commercio.network';
const commercioDsbDevPort = '80';
const commercioDsbDevSigner = 'did:com:1u70n4eysyuf08wcckwrs2atcaqw5d025w39u33';

enum DsbEndpoint {
  add,
  get,
  upload,
}

extension DsbEndpointExt on DsbEndpoint {
  String get value {
    switch (this) {
      case DsbEndpoint.add:
        return '/add';
      case DsbEndpoint.get:
        return '/get';
      case DsbEndpoint.upload:
        return '/protected/upload';
      default:
        return null;
    }
  }
}

enum DsbHeader {
  xDid,
  xResource,
}

extension DsbHeaderExt on DsbHeader {
  String get value {
    switch (this) {
      case DsbHeader.xDid:
        return 'X-DID';
      case DsbHeader.xResource:
        return 'X-Resource';
      default:
        return null;
    }
  }
}
