import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalcScreen();
}

class _CalcScreen extends State<CalcScreen> {
  final principalInput = TextEditingController();
  var roiInput = 7.5;
  late final tenureInput = TextEditingController();
  double tenureYearOpac = 0.1;
  String yearsText = 'years';
  final List<String> currencyList = [
    "Rupees",
    'Dollar',
    'Rubble',
    'Euro',
    'Pound'
  ];
  late String selectedCurrency = currencyList[0];
  var selectedCurrencyIcon = Icons.currency_rupee;
  Color resetBtnColor = const Color(0xffe5e5e5);
  bool resultVisibility = false;
  double resultValue = 0.0;
  double totalPayable = 0.0;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff252525),
      statusBarColor: Color(0xff252525),
    ));

    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        backgroundColor: const Color(0xff252525),
        title: const Text(
          'Interest Calculator',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Principal Amount",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Domine',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    TextField(
                        maxLines: 1,
                        maxLength: 9,
                        controller: principalInput,
                        cursorColor: const Color(0xffffffff),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontFamily: 'Domine',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          icon: Icon(selectedCurrencyIcon),
                          iconColor: const Color(0xffe5e5e5),
                          hintText: '999999',
                          border: InputBorder.none,
                          hintStyle: const TextStyle(
                            fontFamily: 'Domine',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xff363636),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rate of Interest",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Domine',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(children: [
                        const Icon(
                          Icons.percent_rounded,
                          color: Color(0xffe5e5e5),
                          size: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            roiInput.toString(),
                            style: const TextStyle(
                              color: Color(0xffffffff),
                              fontFamily: 'Domine',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Slider(
                            min: 1,
                            max: 24,
                            value: roiInput,
                            divisions: 46,
                            label: roiInput.toString(),
                            activeColor: const Color(0xffffffff),
                            inactiveColor: const Color(0xff363636),
                            onChanged: (value) {
                              setState(() {
                                roiInput =
                                    double.parse(value.toStringAsFixed(1));
                              });
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tenure",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontFamily: 'Domine',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: TextField(
                                    controller: tenureInput,
                                    maxLines: 1,
                                    maxLength: 2,
                                    cursorColor: const Color(0xffffffff),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "" || value == " " || int.parse(value) < 1){
                                          tenureYearOpac = 0.1;
                                          yearsText = "years";
                                        }
                                        else {
                                          if (int.parse(value) == 1 || int.parse(value) == 01){
                                            yearsText = "year";
                                          }
                                          else{
                                            yearsText = "years";
                                          }
                                          tenureYearOpac = 1.0;
                                        }
                                      }); //setState
                                    }, //onChanged
                                    style: const TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: 'Domine',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      icon: Icon(Icons.date_range),
                                      iconColor: Color(0xffe5e5e5),
                                      hintText: '12',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'Domine',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Color(0xff363636),
                                      ),
                                    )),
                              ),
                              Opacity(
                                opacity: tenureYearOpac,
                                child: Text(
                                  yearsText,
                                  style: const TextStyle(
                                    color: Color(0xffffffff),
                                    fontFamily: 'Domine',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Currency",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontFamily: 'Domine',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                              elevation: 2,
                              icon: Icon(selectedCurrencyIcon),
                              dropdownColor: const Color(0xff252525),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontFamily: 'Domine',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              value: selectedCurrency,
                              items: currencyList
                                  .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (String? value) => setState(
                                    () {
                                  changeCurrency(value);
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        foregroundColor: const Color(0xff191919),
                        backgroundColor: const Color(0xff252525),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xff191919)),
                        )),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      calculate();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Domine'),
                      ),
                    ),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.only(left: 20, right: 20)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff252525)),
                      overlayColor: MaterialStateProperty.all<Color>(
                          const Color(0xff212121)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Set the border radius to 0
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.settings_backup_restore,
                        size: 16,
                        color: Colors.white), // Set icon color to white
                    label: const Text(
                      "Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white), // Set label text color to white
                    ),
                    onPressed: () {
                      resetInputs();
                    },
                  )),
              Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 40),
                child: Visibility(
                  visible: resultVisibility,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Simple Interest - ',
                        style: TextStyle(
                            fontFamily: 'Domine',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14),
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          selectedCurrencyIcon,
                          color: Colors.white,
                        ),
                        Text(
                          ' $resultValue',
                          style: const TextStyle(
                              fontFamily: 'Domine',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 28),
                        ),
                      ]),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(
                        'Total Payable - ',
                        style: TextStyle(
                            fontFamily: 'Domine',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14),
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Icon(
                          selectedCurrencyIcon,
                          color: Colors.white,
                        ),
                        Text(
                          ' $totalPayable',
                          style: const TextStyle(
                              fontFamily: 'Domine',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 28),
                        ),
                      ]),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeCurrency(String? value) {
    setState(() {
      selectedCurrency = value!;
      switch (value) {
        case 'Rupees':
          {
            selectedCurrencyIcon = Icons.currency_rupee;
          }
          break;

        case "Dollar":
          {
            selectedCurrencyIcon = Icons.attach_money;
          }
          break;

        case "Rubble":
          {
            selectedCurrencyIcon = Icons.currency_ruble;
          }
          break;

        case "Euro":
          {
            selectedCurrencyIcon = Icons.euro;
          }
          break;

        case "Pound":
          {
            selectedCurrencyIcon = Icons.currency_pound;
          }
          break;

        default:
          {
            selectedCurrencyIcon = Icons.currency_rupee;
          }
          break;
      }
    });
  }

  void resetInputs() {
    setState(() {
      roiInput = 7.5;
      principalInput.clear();
      tenureInput.clear();
      selectedCurrency = currencyList.first;
      selectedCurrencyIcon = Icons.currency_rupee;
      resultVisibility = false;
      tenureYearOpac = 0.1;
    });
  }

  void calculate() {
    setState(() {
      if (principalInput.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter Principal Amount.")));
      } else if (tenureInput.text == "") {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Enter Tenure.")));
      } else if (int.parse(tenureInput.text) < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tenure should be at least 1")));
      } else {
        resultValue = (double.parse(principalInput.text) *
                roiInput *
                double.parse(tenureInput.text)) /
            100.0;
        totalPayable = double.parse(principalInput.text) + resultValue;
        resultVisibility = true;
      }
    });
  }
}
