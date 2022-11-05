import 'package:flutter/material.dart';
import 'package:nft_app/pages/home_page.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var address, chainId, sessionStatus;

  Future<void> connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'NFT DApp',
        description: 'NFT Builder App',
        url: 'https://walletconnect.org',
        icons: [
          'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );

    // Subscribe to events
    connector.on('connect', (session) {
      print('===================================');
      debugPrint("connect: " + session.toString());

      address = sessionStatus?.accounts[0];
      chainId = sessionStatus?.chainId;
      print('--------------------------------------------------');
      print(session);
      debugPrint("Address: " + address!);
      debugPrint("Chain Id: " + chainId.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });

    connector.on('session_request', (payload) {
      debugPrint("session request: " + payload.toString());
    });

    connector.on('disconnect', (session) {
      debugPrint("disconnect: " + session.toString());
    });

    // Create a new session
    if (!connector.connected) {
      sessionStatus = await connector.createSession(
        chainId: 137, //pass the chain id of a network. 137 is Polygon
        onDisplayUri: (uri) {
          launchUrlString(uri,
              mode: LaunchMode
                  .externalApplication); //call the launchUrl(uri) method
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            child: Image.asset(
              'assets/images/polygon.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await connectWallet();
              },
              child: const Text("Connect with Metamask")),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
