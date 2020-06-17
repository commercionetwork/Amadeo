enum ChainNet { dev, test }

extension ChainNetExt on ChainNet {
  String get name {
    switch (this) {
      case ChainNet.dev:
        return 'Dev-Net';
      case ChainNet.test:
        return 'Test-Net';
      default:
        return null;
    }
  }

  String get lcdUrl {
    switch (this) {
      case ChainNet.dev:
        return 'https://lcd-demo.commercio.network';
      case ChainNet.test:
        return 'https://lcd-testnet.commercio.network';
      default:
        return null;
    }
  }

  String get faucetDomain {
    switch (this) {
      case ChainNet.dev:
        return 'faucet-devnet.commercio.network';
      case ChainNet.test:
        return 'faucet-testnet.commercio.network';
      default:
        return null;
    }
  }

  String get bech32Hrp => 'did:com:';
}
