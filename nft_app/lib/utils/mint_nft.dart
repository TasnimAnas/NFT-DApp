import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nft_app/pages/home_page.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';

class NFTPage extends StatefulWidget {
  final productName;
  final id;
  final modelName;
  final buyingDate;
  final warrantyTill;
  final description;

  NFTPage(
      {Key? key,
      required this.id,
      required this.productName,
      required this.modelName,
      required this.buyingDate,
      required this.warrantyTill,
      required this.description})
      : super(
          key: key,
        );
  @override
  _NFTPageState createState() => _NFTPageState();
}

class _NFTPageState extends State<NFTPage> {
  final CONTRACT_NAME = dotenv.env['CONTRACT_NAME'];
  final CONTRACT_ADDRESS =
      dotenv.env['CONTRACT_ADDRESS']; // or shownfts or mint
  http.Client httpClient = http.Client();
  late Web3Client polygonClient;

  @override
  void initState() {
    final ALCHEMY_KEY = dotenv.env['ALCHEMY_KEY_TEST'];
    super.initState();
    httpClient = http.Client();
    polygonClient = Web3Client(ALCHEMY_KEY!, httpClient);
    mintNFT();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  mintNFT() async {
    final metadata = '[{"trait_type": "Product ID","value": "' +
        widget.id +
        '"},{"trait_type": "Serial","value": "' +
        widget.modelName +
        '"},{"display_type": "date","trait_type": "Created","value": "' +
        widget.buyingDate +
        '"},{"display_type": "date","trait_type": "Warranty Till","value": "' +
        widget.warrantyTill +
        '"}]';
    mintStream(widget.productName, metadata, widget.description);
  }

  Future<DeployedContract> getContract() async {
    final CONTRACT_NAME = dotenv.env['CONTRACT_NAME'];
    final CONTRACT_ADDRESS = dotenv.env['CONTRACT_ADDRESS'];
    String abi = await rootBundle.loadString("assets/WarrantyCard.json");
    var jsonabi = jsonDecode(abi);
    var abicode = jsonEncode(jsonabi['abi']); //TODO update
    final contract = DeployedContract(
        ContractAbi.fromJson(abicode, CONTRACT_NAME!),
        EthereumAddress.fromHex(CONTRACT_ADDRESS!));
    return contract;
  }

  mintStream(String productName, String attribute, String description) async {
    print('object');
    final WALLET_PRIVATE_KEY = dotenv.env['WALLET_PRIVATE_KEY'];
    EthPrivateKey credential = EthPrivateKey.fromHex(WALLET_PRIVATE_KEY!);
    DeployedContract contract = await getContract();
    ContractFunction function = contract.function('makeAProductNFT');
    print('object2');
    var results = await Future.wait([
      polygonClient.sendTransaction(
        credential,
        Transaction.callContract(
          contract: contract,
          function: function,
          parameters: [productName, attribute, description],
        ),
        fetchChainIdFromNetworkId: true,
        chainId: null,
      ),
    ]);
    await gettokenCounter();
  }

  gettokenCounter() async {
    String id = 'k';
    DeployedContract contract = await getContract();
    final auctionEvent = contract.event('NewProductNFTMinted');
    final subscription = polygonClient
        .events(FilterOptions.events(contract: contract, event: auctionEvent))
        .take(1)
        .listen((event) async {
      id = event.data!;
      final decoded =
          await auctionEvent.decodeResults(event.topics!, event.data!);
      if (decoded != []) {
        print(decoded[1]);
        launchUrlString(
            'https://opensea.io/assets/matic/0x68cbed2faae2b84119b3ce52844c37532651f5cf/${decoded[1]}',
            mode: LaunchMode.externalApplication);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    return id;
  }
}
