import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LetterBoxScreen(
        fakeEnvelopes: [
          LetterEnvelope(date: '2023-10-15', sender: '지지진'),
          LetterEnvelope(date: '2023-10-14', sender: '진지지'),
          //추가 편지봉투를 여기에 추가
        ],
      ),
    );
  }
}

class LetterEnvelope {
  final String date;
  final String sender;

  LetterEnvelope({required this.date, required this.sender});
}

class LetterBoxScreen extends StatelessWidget {
  final List<LetterEnvelope> fakeEnvelopes;

  const LetterBoxScreen({Key? key, required this.fakeEnvelopes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('편지함'),
      ),
      body: ListView.builder(
        itemCount: fakeEnvelopes.length,
        itemBuilder: (context, index) {
          final envelope = fakeEnvelopes[index];
          return Card(
            elevation: 4, // 그림자 효과 추가
            margin: const EdgeInsets.all(8.0), // 여백 추가
            child: Container(
              padding: const EdgeInsets.all(16.0), // 내용 여백 추가
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(envelope.date,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Icon(Icons.mail_outline), // 편지 아이콘
                    ],
                  ),
                  const SizedBox(height: 8), // 간격 추가
                  Text('보낸 사람: ${envelope.sender}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
