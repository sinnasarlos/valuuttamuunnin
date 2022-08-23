import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

main() {
  final sovellusrunko = Scaffold(body: Valuuttamuunnin());
  final sovellus = MaterialApp(
      home: SafeArea(child: sovellusrunko),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 165, 110, 211),
      ));
  runApp(sovellus);
}

class Valuuttamuunnin extends StatefulWidget {
  @override
  ValuuttamuunninState createState() => ValuuttamuunninState();
}

class ValuuttamuunninState extends State {
  final textEditingController = TextEditingController();
  var dollarimaara = '';

  hae() async {
    var url = Uri.parse('https://api.frankfurter.app/latest?from=EUR&to=USD');
    var response = await get(url);
    var sanakirja = jsonDecode(response.body);
    var euroteksti = textEditingController.text;
    var euromaara = int.parse(euroteksti);
    var kerroin = sanakirja['rates']['USD'];
    var dollareina = await euromaara * kerroin;

    setState(() {
      dollarimaara = '$dollareina';
    });
  }

  @override
  Widget build(BuildContext context) {
    final numerokentta = TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly]);

    final nappi =
        ElevatedButton(child: Text('Muunna eurot dollareiksi'), onPressed: hae);
    final dollars = Text(dollarimaara);
    return Column(children: [numerokentta, nappi, dollars]);
  }
}
