import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Tip Calculator", style: TextStyle(
            color: _purple,
          ),),
        ),
        backgroundColor: Colors.purple.shade50,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        // Putting UI/children inside of a ListView makes them scrollable
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade400,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      labelText: "Total Bill Amount: ",
                      //prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip", style: TextStyle(
                          color: Colors.grey.shade700,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                            color: _purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("$_tipPercentage%", style: TextStyle(
                        color: _purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      Slider(
                          min: 0,
                          max: 40,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 8, // Optional
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          }
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split how many ways",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(_personCounter > 1){
                                  _personCounter--;
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text("-", style: TextStyle(
                                  color: _purple,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                          Text("$_personCounter", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: _purple,
                          ),),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text("+", style: TextStyle(
                                  color: _purple,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total per person", style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0,
                      color: _purple,
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: _purple,
                        ),
                      ),
                    ),
                    Text("(Bill amount: \$${(_billAmount / _personCounter).toStringAsFixed(2)}  + Tip amount: \$${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage) / _personCounter).toStringAsFixed(2)})",
                      style: TextStyle(
                        color: _purple,
                      ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty){
      // no go!

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }


}
