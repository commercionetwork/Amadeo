enum ChainNet { dev, test }

extension ChainNetExt on ChainNet {
  String get name {
    switch (this) {
      case ChainNet.dev:
        return 'Dev-Net';
      case ChainNet.test:
        return 'Test-Net';
    }
  }

  Uri get lcdUrl {
    switch (this) {
      case ChainNet.dev:
        return Uri.https('lcd-demo.commercio.network', '');
      case ChainNet.test:
        return Uri.https('lcd-testnet.commercio.network', '');
    }
  }

  String get faucetDomain {
    switch (this) {
      case ChainNet.dev:
        return 'faucet-devnet.commercio.network';
      case ChainNet.test:
        return 'faucet-testnet.commercio.network';
    }
  }

  String get defaultTsp {
    switch (this) {
      case ChainNet.dev:
        return 'did:com:1359sz8w4k86cuew7jelr9exlvjlurglphz8x9d';
      case ChainNet.test:
        return 'did:com:1ejuvfc2ydcq7ym4ks052lu45kg5xk6us0srwdu';
    }
  }

  String get bech32Hrp => 'did:com:';
}
