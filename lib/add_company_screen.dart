import 'package:flutter/material.dart';

class AddCompanyScreen extends StatefulWidget {
  @override
  _AddCompanyScreenState createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  TextEditingController _agentRateController = TextEditingController();
  int _agentRate = 0;

  // Increment function
  void _incrementAgentRate() {
    setState(() {
      _agentRate++;  // Increment agentRate
      _agentRateController.text = _agentRate.toString();  // Update controller text
    });
  }

  // Decrement function
  void _decrementAgentRate() {
    setState(() {
      if (_agentRate > 0) {  // Ensure it doesn't go below 0
        _agentRate--;  // Decrement agentRate
        _agentRateController.text = _agentRate.toString();  // Update controller text
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _agentRateController.text = _agentRate.toString();  // Set initial value in controller
  }

  @override
  void dispose() {
    _agentRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 600,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agent Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Row for Name and Agent Rate
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Agent Rate(%)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  // TextField for Agent Rate
                                  Expanded(
                                    child: TextField(
                                      controller: _agentRateController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      textAlign: TextAlign.center,
                                      readOnly: true, // Prevent manual input
                                    ),
                                  ),
                                  // Vertical Arrows for Increment/Decrement
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: _incrementAgentRate, // Function to increase agent rate
                                        child: Icon(Icons.arrow_drop_up, size: 24), // Up arrow icon
                                      ),
                                      GestureDetector(
                                        onTap: _decrementAgentRate, // Function to decrease agent rate
                                        child: Icon(Icons.arrow_drop_down, size: 24), // Down arrow icon
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Row for City
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 175),
                    ],
                  ),

                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Navigate to the previous screen on save
                      },
                      icon: Icon(Icons.save, color: Colors.white), // Save icon
                      label: Text(
                        'Save and Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}