import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() {
    return new _ConverterState();
  }
}

class _ConverterState extends State<Converter> {
  final EdgeInsets insets =
      EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0);
  final TextEditingController hex = TextEditingController();
  final TextEditingController bin = TextEditingController();
  final TextEditingController dec = TextEditingController();
  final TextEditingController oct = TextEditingController();

  @override
  void dispose() {
    dec.dispose();
    hex.dispose();
    bin.dispose();
    oct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Base Converter".toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            // form decimal
            SizedBox(height: 25.0),
            TextField(
              cursorRadius: Radius.circular(2.0),
              keyboardType: TextInputType.number,
              controller: dec,
              onChanged: (s) => convert(0, s),
              cursorColor: Theme.of(context).primaryColor,
              decoration:
                  InputDecoration(labelText: "Decimal", contentPadding: insets),
              inputFormatters: [
                LengthLimitingTextInputFormatter(19),
                WhitelistingTextInputFormatter(RegExp("[0-9]"))
              ],
            ),

            // form Hexadecimal
            SizedBox(height: 25.0),
            TextField(
              cursorRadius: Radius.circular(2.0),
              controller: hex,
              onChanged: (s) => convert(1, s),
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  labelText: "Hexadecimal (16)", contentPadding: insets),
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                WhitelistingTextInputFormatter(RegExp("[0-9A-Fa-f]"))
              ],
            ),

            // form Binary
            SizedBox(height: 25.0),
            TextField(
              cursorRadius: Radius.circular(2.0),
              controller: bin,
              keyboardType: TextInputType.number,
              onChanged: (s) => convert(2, s),
              cursorColor: Theme.of(context).primaryColor,
              decoration:
                  InputDecoration(labelText: "Binary (2)", contentPadding: insets),
              inputFormatters: [
                LengthLimitingTextInputFormatter(63),
                WhitelistingTextInputFormatter(RegExp("[01]"))
              ],
            ),

            // form Octal
            SizedBox(height: 25.0),
            TextField(
              cursorRadius: Radius.circular(2.0),
              controller: oct,
              keyboardType: TextInputType.number,
              onChanged: (s) => convert(3, s),
              cursorColor: Theme.of(context).primaryColor,
              decoration:
                  InputDecoration(labelText: "Octal (8)", contentPadding: insets),
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
                WhitelistingTextInputFormatter(RegExp("[0-9]"))
              ],
            ),

            SizedBox(height: 100.0),
            Text("Agis R Herdiana", textScaleFactor: 1.5, style: new TextStyle(color: Colors.deepPurple)),
            SizedBox(height: 5.0),
            Text("Teknik Informatika", style: new TextStyle(color: Colors.deepPurple)),
            SizedBox(height: 5.0),
            Text("STT Duta Bangsa", style: new TextStyle(color: Colors.deepPurple))
          ],
        ),
      ),
    );
  }

  void convert(int options, String val) {
    /*
    * 0 = Decimal
    * 1 = Hexadecimal
    * 2 = Binary
    * 3 = Octal
    */

    if (val == "") {
      dec.text = "";
      hex.text = "";
      bin.text = "";
      oct.text = "";
      return;
    }

    int convNumber;
    switch (options) {
      case 0:
        convNumber = int.tryParse(val);
        if (convNumber == null) {
          convNumber = 9223372036854775807;
          dec.text = convNumber.toString();
        }

        hex.text = convNumber.toRadixString(16).toUpperCase();
        bin.text = convNumber.toRadixString(2);
        oct.text = convNumber.toRadixString(8);
        break;

      case 1:
        convNumber = int.tryParse(val, radix: 16);
        if (convNumber == null) {
          convNumber = 9223372036854775807;
          hex.text = convNumber.toRadixString(16).toString();
        }

        dec.text = convNumber.toString();
        bin.text = convNumber.toRadixString(2);
        oct.text = convNumber.toRadixString(8);
        break;

      case 2:
        convNumber = int.tryParse(val, radix: 2);
        if (convNumber == null) {
          convNumber = 9223372036854775807;
          bin.text = convNumber.toRadixString(2).toString();
        }
        dec.text = convNumber.toString();
        hex.text = convNumber.toRadixString(16).toUpperCase();
        oct.text = convNumber.toRadixString(8);
        break;

      case 3:
        convNumber = int.tryParse(val, radix: 8);
        dec.text = convNumber.toString();
        hex.text = convNumber.toRadixString(16).toUpperCase();
        bin.text = convNumber.toRadixString(8);
        break;

      default:
        debugPrint("Base Converter");
        break;
    }
  }
}
