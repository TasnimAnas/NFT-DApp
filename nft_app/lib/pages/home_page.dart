import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nft_app/pages/login_page.dart';

import '../utils/mint_nft.dart';

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
  DateTime? buyDate = DateTime.now(), WarrantyFinish = DateTime.now();
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
                            keyboardType: TextInputType.number,
                            controller: _idcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product ID';
                              }
                              if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                return "Only numeric values";
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
                                return 'Please enter product name';
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
                          controller: _buyingDatecontroller,
                          decoration: const InputDecoration(
                            hintText: "DD/MM/YYYY",
                            labelText: 'Buying Date',
                            labelStyle: TextStyle(
                              color: Color(0xFF979797),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66BF77)),
                            ),
                          ),
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            buyDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime.now());
                            if (buyDate == null) buyDate = DateTime.now();
                            _buyingDatecontroller.text =
                                '${buyDate!.day}/${buyDate!.month}/${buyDate!.year}';
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: _periodcontroller,
                          decoration: const InputDecoration(
                            hintText: "DD/MM/YYYY",
                            labelText: 'Warranty Till',
                            labelStyle: TextStyle(
                              color: Color(0xFF979797),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF66BF77)),
                            ),
                          ),
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            var WarrantyFinish = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030));
                            if (WarrantyFinish == null)
                              WarrantyFinish = DateTime.now();
                            _periodcontroller.text =
                                '${WarrantyFinish!.day}/${WarrantyFinish!.month}/${WarrantyFinish!.year}';
                          },
                        )),
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
                        final d1 =
                            (buyDate!.toUtc().millisecondsSinceEpoch / 1000)
                                .toInt();
                        final d2 =
                            (WarrantyFinish!.toUtc().millisecondsSinceEpoch /
                                    1000)
                                .toInt();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NFTPage(
                                      id: _idcontroller.text,
                                      productName: _namecontroller.text,
                                      modelName: _modelcontroller.text,
                                      buyingDate: d1.toString(),
                                      warrantyTill: d2.toString(),
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
