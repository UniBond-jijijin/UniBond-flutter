import 'package:flutter/material.dart';
import 'package:unibond/resources/toast.dart';

void showBlockBottomSheet(
    BuildContext context, int id, Function(int) onBlockTap) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('신고하기'),
              onTap: () {
                Navigator.of(context).pop();
                showToastMessage('신고가 완료되었습니다.');
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('차단하기'),
              onTap: () {
                onBlockTap(id);
                Navigator.of(context).pop();
                showToastMessage('차단이 완료되었습니다.');
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('취소'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void showDeleteBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('삭제하기'),
              onTap: () {
                // 삭제 로직 구현
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('취소'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
