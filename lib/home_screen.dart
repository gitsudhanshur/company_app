import 'package:flutter/material.dart';

import 'company_screen.dart';
import 'test_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default selected index for the ListTile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 11, 7, 52),
        child: Column(
          children: [
            SizedBox(height: 45),
            Row(
              children: [
                SizedBox(width: 20),
                CircleAvatar(
                    backgroundImage: AssetImage('assets/images/crm.png'),
                    radius: 30),
                SizedBox(width: 20),
                Text(
                  'Custom-5',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ],
            ),
            SizedBox(height: 40),
            // First ListTile: Test
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0), // Shift more to the right
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? const Color.fromARGB(75, 205, 204, 204) : null, // Light blue background when selected
                  border: _selectedIndex == 0
                      ? Border.all(color: Colors.transparent, width: 2.0) // Add border if selected
                      : null,
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: ListTile(
                  leading: Icon(Icons.warning,
                      color: _selectedIndex == 0
                          ? Colors.blue
                          : Colors.white), // Change icon color based on selection
                  title: Text('Test',
                      style: TextStyle(
                          color: _selectedIndex == 0
                              ? Colors.blue
                              : Colors.white)), // Color change based on selection
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    // Navigate to Test Screen or action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Second ListTile: Company
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0), // Shift more to the right
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 ? const Color.fromARGB(75, 205, 204, 204) : null, // Light blue background when selected
                  border: _selectedIndex == 1
                      ? Border.all(color: Colors.transparent, width: 2.0) // Add border if selected
                      : null,
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: ListTile(
                  leading: Icon(Icons.person,
                      color: _selectedIndex == 1
                          ? Colors.blue
                          : Colors.white), // Change icon color based on selection
                  title: Text('Company',
                      style: TextStyle(
                          color: _selectedIndex == 1
                              ? Colors.blue
                              : Colors.white)), // Color change based on selection
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    // Navigate to Company Screen or action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            // Third ListTile: Logout
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0), // Shift more to the right
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? const Color.fromARGB(75, 205, 204, 204) : null, // Light blue background when selected
                  border: _selectedIndex == 2
                      ? Border.all(color: Colors.transparent, width: 2.0) // Add border if selected
                      : null,
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: ListTile(
                  leading: Icon(Icons.logout,
                      color: _selectedIndex == 2
                          ? Colors.blue
                          : Colors.white), // Change icon color based on selection
                  title: Text('Logout',
                      style: TextStyle(
                          color: _selectedIndex == 2
                              ? Colors.blue
                              : Colors.white)), // Color change based on selection
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    // Logout action
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

