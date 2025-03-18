import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'navbar_screen.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  _SimulationScreenState createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  String? selectedCarModel;
  String? selectedPeriod;
  final TextEditingController initialPriceController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController depositController = TextEditingController();

  List<Map<String, dynamic>> carData = [];
  List<String> carModels = [];
  List<Map<String, dynamic>> periodsData = [];
  List<String> periods = [];

  @override
  void initState() {
    super.initState();
    fetchCarModels();
    fetchPeriods();
  }

  Future<void> fetchCarModels() async {
    final response = await http.get(
      Uri.parse('https://41c0-210-210-144-170.ngrok-free.app/cars'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        carData =
            data
                .map(
                  (item) => {
                    'id': item['id'],
                    'model': item['model'],
                    'price': item['price'],
                  },
                )
                .toList();
        carModels = carData.map((item) => item['model'].toString()).toList();
      });
    }
  }

  void onCarModelSelected(String model) {
    setState(() {
      selectedCarModel = model;
      final selectedCar = carData.firstWhere(
        (item) => item['model'] == model,
        orElse: () => {},
      );
      initialPriceController.text =
          selectedCar.isNotEmpty ? selectedCar['price'].toString() : '';
    });
  }

  Future<void> fetchPeriods() async {
    final response = await http.get(
      Uri.parse('https://41c0-210-210-144-170.ngrok-free.app/interest-tenors'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        periodsData =
            data
                .map(
                  (item) => {
                    'id': item['id'],
                    'tenor': item['tenor'],
                    'interest': item['interest'],
                  },
                )
                .toList();
        periods = data.map((item) => (int.parse(item['tenor'].toString()) ~/ 12).toString()).toList();
        if (periods.isNotEmpty) {
          selectedPeriod = null;
          interestRateController.text ='';
        }
      });
    }
  }

  void onTenorSelected(String period) {
    setState(() {
      selectedPeriod = period;
      final selectedTenor = periodsData.firstWhere(
        (item) => (int.parse(item['tenor'].toString()) ~/ 12).toString() == period,
        orElse: () => {},
      );
      interestRateController.text =
          selectedTenor.isNotEmpty ? selectedTenor['interest'].toString() : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavbarScreen(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Car Model",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  hintText: "Choose Here", hintStyle: TextStyle(fontSize: 10),
                ),
                value: selectedCarModel,
                onChanged: (value) {
                  onCarModelSelected(value as String);
                },
                items:
                    carModels.map((model) {
                      return DropdownMenuItem(value: model, child: Text(model));
                    }).toList(),
              ),
              SizedBox(height: 8),
              Text(
                "Initial Price",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              TextField(
                controller: initialPriceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                ),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Period",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            hintText: "Choose Here", hintStyle: TextStyle(fontSize: 12),
                          ),
                          value: selectedPeriod,
                          onChanged: (value) {
                            onTenorSelected(value as String);
                          },
                          items:
                              periods.map((period) {
                                return DropdownMenuItem(
                                  value: period,
                                  child: Text(period),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Year", style: TextStyle(fontSize: 12),),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                "Interest Rate",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              TextField(
                controller: interestRateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  suffixText: "%",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              Text(
                "Deposit",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              TextField(
                controller: depositController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  hintText: "Your Deposit", hintStyle: TextStyle(fontSize: 12)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 155,
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Apply", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
