import 'package:flutter/material.dart';
import 'package:greendzine2/home/data/data_sources/api_services.dart';
import 'package:greendzine2/home/data/models/data_model.dart';
import 'package:greendzine2/home/presentation/widgets/custom_list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data>? dataList;
  List<Data>? filteredList;

  @override
  void initState() {
    super.initState();
    // Fetch initial data
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final List<Data>? data = await getData();
      setState(() {
        dataList = data;
        filteredList = dataList; // Initially set filtered list to all data
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {

        filteredList = dataList;
      } else {
        filteredList = dataList
            ?.where((data) => data.firstName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        print(filteredList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity task"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: updateSearch,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child:
                 FutureBuilder<List<Data>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<Data>? dataList = snapshot.data;
                  return ListView.builder(
                    itemCount: filteredList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final Data? data = filteredList?[index];
                      return CustomListCard(data: data,);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
