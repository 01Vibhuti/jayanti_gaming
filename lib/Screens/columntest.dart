// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class TextHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test History'),
        centerTitle: true,
      ),
      body: LabReportsTable(),

    );
  }
}

class LabReport {
  final String date;
  final String batchNo;
  final String test;
  final String report;

  LabReport({required this.date, required this.batchNo, required this.test, required this.report});
}

class LabReportsTable extends StatefulWidget {
  @override
  _LabReportsTableState createState() => _LabReportsTableState();
}

class _LabReportsTableState extends State<LabReportsTable> {
  late List<LabReport> labReports;
  late List<LabReport> filteredReports;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    labReports = [
      LabReport(date: '2023-01-01', batchNo: 'B123', test: 'Hearing Test', report: 'Pending'),
      LabReport(date: '2023-02-15', batchNo: 'B124', test: 'Romberg', report: 'View'),
      // Add more lab reports as needed
    ];

    filteredReports = List.from(labReports);
    searchController = TextEditingController();
  }

  void searchReports(String query) {
    setState(() {
      filteredReports = labReports
          .where((report) =>
      report.batchNo.toLowerCase().contains(query.toLowerCase()) ||
          report.date.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchReports,
            decoration: InputDecoration(
              labelText: 'Search (Batch No or Date)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0, color: Colors.black)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Batch No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Test',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: List.generate(
                  filteredReports.length,
                      (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].date),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].batchNo),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].test),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].report),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ListViewWithApiData extends StatefulWidget {
//   @override
//   _ListViewWithApiDataState createState() => _ListViewWithApiDataState();
// }
//
// class _ListViewWithApiDataState extends State<ListViewWithApiData> {
//   List<dynamic> _data = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final response = await http.post(Uri.parse('https://qbacp.com/mediclear/api/test-result'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _data = jsonDecode(response.body)['data'];
//       });
//       print(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _data.isEmpty
//         ? Center(child: CircularProgressIndicator())
//         : ListView.builder(
//       itemCount: _data.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text('Name: ${_data[index]['name']}'),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Result: ${_data[index]['result']}'),
//               Text('Date: ${_data[index]['date']}'),
//               Text('Batch: ${_data[index]['batch']}'),
//               Text('Status: ${_data[index]['status']}'),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }