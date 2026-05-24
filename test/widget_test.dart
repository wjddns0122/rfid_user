// 위젯 테스트는 Firebase 초기화가 필요해 제거했다.
// (홈/장바구니가 Realtime DB 스트림을 구독하므로 pumpWidget 시 Firebase 앱이 필요)
// Firebase 의존이 없는 순수 로직(scan_log)만 단위 테스트한다.

import 'package:flutter_test/flutter_test.dart';
import 'package:user_rfid/services/scan_log.dart';

void main() {
  group('formatWon', () {
    test('천 단위 콤마 + 원', () {
      expect(formatWon(0), '0원');
      expect(formatWon(89000), '89,000원');
      expect(formatWon(216000), '216,000원');
      expect(formatWon(1234567), '1,234,567원');
    });
  });

  group('parseScans', () {
    test('null 스냅샷이면 빈 목록', () {
      expect(parseScans(null), isEmpty);
    });
  });

  group('catalogByUid', () {
    test('등록된 카드 UID 매핑 존재', () {
      expect(catalogByUid['D6A32907']?.name, '오버핏 블레이저');
      expect(catalogByUid['D6A32907']?.price, 89000);
    });
  });
}
