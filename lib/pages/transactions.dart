import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:veebank/models/transactions/transaction_model.dart';
import 'package:veebank/services/api_services/api_services.dart';
import 'package:veebank/utilities/services.dart';
import 'package:veebank/widget/transaction_items.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Transactions extends StatefulWidget {
  final int? index;
  const Transactions({Key? key, this.index}) : super(key: key);
  static const String id = "main-page";

  @override
  State<Transactions> createState() => _Transaction();
}

class _Transaction extends State<Transactions> {
  late int bed,
      bath,
      sqftLiving,
      sqftLot,
      floors,
      sqftLot15;
  late double lat, long;

//METHOD TO PREDICT PRICE
  Future<String> predictPrice(var body) async {
    var client = new http.Client();
    var uri = Uri.parse("http://192.168.1.101:5000/predict");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);
    var resp = await client.post(uri, headers: headers, body: jsonString);
    //var resp=await http.get(Uri.parse("http://192.168.1.101:5000"));

      print("DATA FETCHED SUCCESSFULLY");
      var result = json.decode(resp.body);
      print(result["prediction"]);
      return result["prediction"];




  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(


      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: ' Enter Time',
                  ),
                  onChanged: (val) {
                    bed = int.parse(val);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Amount ',
                  ),
                  onChanged: (val) {
                    bath = int.parse(val);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Transaction method',
                  ),
                  onChanged: (val) {
                    sqftLiving = int.parse(val);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Transaction ID',
                  ),
                  onChanged: (val) {
                    sqftLot = int.parse(val);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Card Type',
                  ),
                  onChanged: (val) {
                    floors = int.parse(val);
                  },
                ),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Location',
                  ),
                  onChanged: (val) {
                    lat = double.parse(val);
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter long',
                  ),
                  onChanged: (val) {
                    long = double.parse(val);
                  },
                ),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Bank name',
                  ),
                  onChanged: (val) {
                    sqftLot15 = int.parse(val);
                  },
                ),
                TextButton(

                  onPressed: () async {
                    var body = [
                      {
                        "bedrooms": bed,
                        "bathrooms": bath,
                        "sqft_living": sqftLiving,
                        "sqft_lot": sqftLot,
                        "floors": floors,

                      }
                    ];
                    /*body=[
                    {"bedrooms": 3, "bathrooms": 1, "sqft_living": 1180, "sqft_lot": 5650, "floors": 1, "waterfront": 0, "view": 0, "condition": 3, "grade": 7, "sqft_above": 1180, "sqft_basement": 0, "lat": 47.5112, "long": -122.257, "sqft_living15": 1340, "sqft_lot15": 5650}
                  ];*/
                    print(body);
                    var resp = await predictPrice(body);
                    // _onBasicAlertPressed(context, resp);
                  },
                  child: Text("Verify "),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

//function from rflutter pkg to display alert
// _onBasicAlertPressed(context, resp) {
//   Alert(context: context, title: "Predicted price", desc: resp).show();
