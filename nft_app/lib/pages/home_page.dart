import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nft_app/pages/login_page.dart';
import 'package:nft_app/utils/mint_nft.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _modelcontroller = TextEditingController();
  TextEditingController _buyingDatecontroller = TextEditingController();
  TextEditingController _periodcontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                child: Image.asset(
                  'assets/images/polygon.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                            controller: _idcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product ID';
                              }

                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Product ID',
                              labelStyle: TextStyle(
                                color: Color(0xFF979797),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF66BF77)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                            controller: _namecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Product Name',
                              labelStyle: TextStyle(
                                color: Color(0xFF979797),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF66BF77)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                            controller: _modelcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product model';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Model',
                              labelStyle: TextStyle(
                                color: Color(0xFF979797),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF66BF77)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                            enabled: false,
                            controller: _buyingDatecontroller,
                            decoration: InputDecoration(
                              hintText: "DD/MM/YYYY",
                              labelText:
                                  'Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                              labelStyle: const TextStyle(
                                color: Color(0xFF979797),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF66BF77)),
                              ),
                            ))),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                            controller: _periodcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Warranty Period';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Warranty Period (in months)',
                              labelStyle: TextStyle(
                                color: Color(0xFF979797),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF66BF77)),
                              ),
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 1,
                        controller: _descriptioncontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Color(0xFF979797),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF66BF77)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('object');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NFTPage(
                                      id: _idcontroller.text,
                                      productName: _namecontroller.text,
                                      modelName: _modelcontroller.text,
                                      buyingDate:
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  DateTime.now().day)
                                              .toString(),
                                      warrantyTill:
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  DateTime.now().day +
                                                      (30 *
                                                          24 *
                                                          60 *
                                                          60 *
                                                          1000))
                                              .toString(),
                                      description: _descriptioncontroller.text,
                                    )));
                      }
                    },
                    child: const Text("Mint NFT")),
              ),
              const SizedBox(
                height: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
