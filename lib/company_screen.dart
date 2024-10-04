import 'package:flutter/material.dart';
import 'add_company_screen.dart';
import 'edit_company_screen.dart';
import 'model.dart';
import 'service.dart';

class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  late Future<List<Company>> futureCompanies;
  ScrollController _horizontalScrollController = ScrollController();
  List<Company> companyList = [];
  bool isAscending = true;
  int? sortColumnIndex;

  // Pagination variables
  int rowsPerPage = 10;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    futureCompanies = fetchCompanies();
    futureCompanies.then((data) {
      setState(() {
        companyList = data;
      });
    });
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // Function to scroll left
  void scrollLeft() {
    if (_horizontalScrollController.hasClients) {
      _horizontalScrollController.animateTo(
        (_horizontalScrollController.offset - 100).clamp(0.0, _horizontalScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to scroll right
  void scrollRight() {
    if (_horizontalScrollController.hasClients) {
      _horizontalScrollController.animateTo(
        (_horizontalScrollController.offset + 100).clamp(0.0, _horizontalScrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to sort the company list
  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;

      switch (columnIndex) {
        case 0:
          companyList.sort((a, b) => compareString(ascending, a.name, b.name));
          break;
        case 1:
          companyList.sort((a, b) {
            double aRate = double.tryParse(a.agentRate) ?? 0.0;
            double bRate = double.tryParse(b.agentRate) ?? 0.0;
            return compareDouble(ascending, aRate, bRate);
          });
          break;
        case 2:
          companyList.sort((a, b) => compareString(ascending, a.city, b.city));
          break;
      }
    });
  }

  int compareString(bool ascending, String a, String b) {
    return ascending ? a.compareTo(b) : b.compareTo(a);
  }

  int compareDouble(bool ascending, double a, double b) {
    return ascending ? a.compareTo(b) : b.compareTo(a);
  }

  // Pagination functions
  void goToFirstPage() {
    setState(() {
      currentPage = 0;
    });
  }

  void goToPreviousPage() {
    setState(() {
      if (currentPage > 0) currentPage--;
    });
  }

  void goToNextPage() {
    setState(() {
      if ((currentPage + 1) * rowsPerPage < companyList.length) currentPage++;
    });
  }

  void goToLastPage() {
    setState(() {
      currentPage = (companyList.length / rowsPerPage).ceil() - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Company', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints.maxHeight * 0.65;
            double columnWidth = screenWidth * 0.25; // Adjusted column width

            return Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Increased border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10, // Increased blur radius
                    offset: Offset(0, 4), // Adjusted offset for a softer shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<List<Company>>(
                  future: futureCompanies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Company',
                                style: TextStyle(
                                  fontSize: 28, // Increased font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddCompanyScreen()),
                                  );
                                  futureCompanies = fetchCompanies();
                                  futureCompanies.then((data) {
                                    setState(() {
                                      companyList = data;
                                    });
                                  });
                                },
                                icon: Icon(Icons.add),
                                label: Text('Add'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent, // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columnSpacing: screenWidth * 0.1, // Adjust column spacing
                                  sortColumnIndex: sortColumnIndex,
                                  sortAscending: isAscending,
                                  columns: [
                                    DataColumn(
                                      label: Container(
                                        width: columnWidth, // Adjust column width
                                        child: Text('Name'),
                                      ),
                                      onSort: (columnIndex, ascending) => onSort(columnIndex, ascending),
                                    ),
                                    DataColumn(
                                      label: Container(
                                        width: columnWidth, // Adjust column width
                                        child: Text('Agent Rate (%)'),
                                      ),
                                      onSort: (columnIndex, ascending) => onSort(columnIndex, ascending),
                                    ),
                                    DataColumn(
                                      label: Container(
                                        width: columnWidth, // Adjust column width
                                        child: Text('City'),
                                      ),
                                      onSort: (columnIndex, ascending) => onSort(columnIndex, ascending),
                                    ),
                                  ],
                                  rows: companyList
                                      .skip(currentPage * rowsPerPage)
                                      .take(rowsPerPage)
                                      .map((company) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(company.name),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditCompanyScreen(company: company),
                                              ),
                                            );
                                          },
                                        ),
                                        DataCell(
                                          Text(company.agentRate),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditCompanyScreen(company: company),
                                              ),
                                            );
                                          },
                                        ),
                                        DataCell(
                                          Text(company.city),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditCompanyScreen(company: company),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          MediaQuery.of(context).size.width < 650
                              ? Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.arrow_left),
                                        onPressed: scrollLeft,
                                      ),
                                      Expanded(
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Container(
                                              height: 10,
                                              color: Colors.grey[200],
                                              child: Stack(
                                                children: [
                                                  AnimatedBuilder(
                                                    animation: _horizontalScrollController,
                                                    builder: (context, child) {
                                                      if (!_horizontalScrollController.hasClients) {

                                                        double maxScrollExtent = _horizontalScrollController.position.maxScrollExtent;
                                                        double scrollFraction = maxScrollExtent > 0 ? _horizontalScrollController.offset / maxScrollExtent : 0.0;
                                                        double thumbWidth = constraints.maxWidth * scrollFraction;

                                                        return Positioned(
                                                          left: thumbWidth,
                                                          child: Container(
                                                            width: 100,
                                                            height: 10,
                                                            color: Colors.grey,
                                                          ),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.arrow_right),
                                        onPressed: scrollRight,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          SizedBox(height: 16),
                          // Pagination controls
                          buildPaginationControls(context),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Pagination controls
  Row buildPaginationControls(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for responsiveness
    double fontSize = screenWidth > 1000 ? 16 : 12;
    double iconSize = screenWidth > 1000 ? 24 : 18;
    double spacing = screenWidth > 1000 ? 16 : 8;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            "Rows per page:",
            style: TextStyle(fontSize: fontSize),
          ),
        ),
        // Dropdown for rows per page
        Flexible(
          flex: 2,
          child: DropdownButton<int>(
            value: rowsPerPage,
            items: <int>[10, 15, 20, 25, 30].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString(), style: TextStyle(fontSize: fontSize)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                rowsPerPage = value ?? 10;
              });
            },
          ),
        ),
        SizedBox(width: spacing),
        // Pagination Info
        Flexible(
          flex: 2,
          child: Text(
            '${(currentPage * rowsPerPage) + 1}-${((currentPage + 1) * rowsPerPage > companyList.length) ? companyList.length : (currentPage + 1) * rowsPerPage} of ${companyList.length}',
            style: TextStyle(fontSize: fontSize),
          ),
        ),
        // Pagination Icons
        IconButton(
          icon: Icon(Icons.first_page, size: iconSize),
          onPressed: currentPage > 0 ? goToFirstPage : null,
        ),
        IconButton(
          icon: Icon(Icons.chevron_left, size: iconSize),
          onPressed: currentPage > 0 ? goToPreviousPage : null,
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, size: iconSize),
          onPressed: currentPage < (companyList.length / rowsPerPage).ceil() - 1
              ? goToNextPage
              : null,
        ),
        IconButton(
          icon: Icon(Icons.last_page, size: iconSize),
          onPressed: currentPage < (companyList.length / rowsPerPage).ceil() - 1
              ? goToLastPage
              : null,
        ),
      ],
    );
  }
}
