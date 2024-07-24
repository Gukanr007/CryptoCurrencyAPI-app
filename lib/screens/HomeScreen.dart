import 'dart:convert';
// import 'dart:math';

import 'package:cryptofont/cryptofont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List users = [];
  void _fetchCoins() async {
    print("Fetching");
    var url = "https://api.coinlore.net/api/tickers/?start=20&limit=20";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      users = json["data"];
    });
    print("fetched");
  }

  @override
  Widget build(BuildContext context) {
    // final code = cryptoFontIconMapping[symbol.toLowerCase()];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crypto Currency List",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchCoins,
        child: Icon(
          Icons.refresh,
          size: 30,
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Name",
                  // textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Symbol",
                  // textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Price",
                  // textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(users.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Container(
                        width: 360,
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CryptoFontIcons.fromSymbol((users[index]
                                            ["symbol"]
                                        .toString()
                                        .toUpperCase())),
                                    size: 18,
                                    color: CupertinoDynamicColor.withBrightness(
                                        color: Colors.amber,
                                        darkColor: Colors.purple),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      users[index]["name"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(users[index]["symbol"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "\$${users[index]["price_usd"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
