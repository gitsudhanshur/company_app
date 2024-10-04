import 'package:flutter/material.dart';

class AddTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Test'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Back arrow icon
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          backgroundColor: Colors.white, // White app bar background
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(
            color: Colors.black, // Black color for the back arrow icon
          ),
          elevation: 0, // Remove shadow under the AppBar
        ),
        backgroundColor: Colors.grey[100], // Light grey background
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0), // Adjust space from the top if necessary
              Container(
                width: double.infinity,
                height: 110,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the container
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Subtle shadow
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: Text(
                  'Add Test', // Title text
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold, // Bold text for title
                    color: Colors.black, // Black color for the text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}