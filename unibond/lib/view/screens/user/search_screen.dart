import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  Timer? debouncer;
  List<dynamic> searchResults = []; // 검색 결과를 저장할 리스트

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    editingController.dispose();
    super.dispose();
  }

  // 질병 검색 API 호출
  Future<void> searchDisease(String query) async {
    debouncer?.cancel();
    debouncer = Timer(const Duration(milliseconds: 1000), () async {
      try {
        final dio = Dio();
        var response = await dio.get(
            'http://3.35.110.214/api/v1/diseases/search',
            queryParameters: {'lan': 'kor', 'query': query, 'page': 0});
        if (response.statusCode == 200 && response.data['isSuccess']) {
          setState(() {
            searchResults = response.data['result']['diseaseDataList'];
          });
        }
      } catch (err) {
        print(err);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('질환 검색'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: editingController,
              onChanged: searchDisease,
              decoration: InputDecoration(
                hintText: '진단받은 병명',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchDisease(editingController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var disease = searchResults[index];
                return ListTile(
                  title: Text(disease['diseaseNameKor']),
                  subtitle: Text(disease['diseaseNameEng']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
