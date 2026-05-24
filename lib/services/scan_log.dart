import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

/// 카드 UID → 상품 정보 매핑. 새 태그 추가 시 여기에 등록.
/// ESP32가 UID를 대문자로 전송하므로 키도 대문자로 둔다.
const Map<String, CatalogEntry> catalogByUid = {
  'D6A32907': CatalogEntry('오버핏 블레이저', 89000, Icons.checkroom_outlined),
  'E9920207': CatalogEntry('후드 스웨트셔츠', 49000, Icons.dry_cleaning_outlined),
  '57E02107': CatalogEntry('와이드 데님 팬츠', 59000, Icons.texture_outlined),
  '3D06CC06': CatalogEntry('볼캡', 19000, Icons.sports_baseball_outlined),
};

const CatalogEntry unknownEntry = CatalogEntry(
  '미등록 태그',
  0,
  Icons.help_outline,
);

/// RFID 스캔 로그가 쌓이는 Realtime DB 경로.
DatabaseReference get logsRef => FirebaseDatabase.instance.ref('logs');

/// logs/ 스냅샷 → 같은 UID는 수량으로 합산. 최초 스캔 timestamp 오름차순 정렬.
List<ScanItem> parseScans(DataSnapshot? snapshot) {
  if (snapshot == null || snapshot.value == null) {
    return const [];
  }
  final byUid = <String, ScanItem>{};
  for (final child in snapshot.children) {
    final value = child.value;
    if (value is! Map) {
      continue;
    }
    final uid = (value['uid'] ?? '').toString().toUpperCase();
    final timestamp = (value['timestamp'] as num?)?.toInt() ?? 0;
    final existing = byUid[uid];
    if (existing != null) {
      byUid[uid] = existing.copyWith(
        quantity: existing.quantity + 1,
        timestamp:
            timestamp < existing.timestamp ? timestamp : existing.timestamp,
      );
      continue;
    }
    final entry = catalogByUid[uid] ?? unknownEntry;
    byUid[uid] = ScanItem(
      key: uid,
      uid: uid,
      name: entry.name,
      price: entry.price,
      icon: entry.icon,
      quantity: 1,
      timestamp: timestamp,
    );
  }
  final items = byUid.values.toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  return items;
}

class CatalogEntry {
  final String name;
  final int price;
  final IconData icon;

  const CatalogEntry(this.name, this.price, this.icon);
}

class ScanItem {
  final String key;
  final String uid;
  final String name;
  final int price;
  final IconData icon;
  final int quantity;
  final int timestamp;

  const ScanItem({
    required this.key,
    required this.uid,
    required this.name,
    required this.price,
    required this.icon,
    required this.quantity,
    required this.timestamp,
  });

  /// 단가 × 수량.
  int get lineTotal => price * quantity;

  ScanItem copyWith({int? quantity, int? timestamp}) {
    return ScanItem(
      key: key,
      uid: uid,
      name: name,
      price: price,
      icon: icon,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// 천 단위 콤마 + '원'.
String formatWon(int value) {
  final raw = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < raw.length; index += 1) {
    final reverseIndex = raw.length - index;
    buffer.write(raw[index]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) {
      buffer.write(',');
    }
  }
  return '$buffer원';
}
