// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:user_rfid/main.dart';

void main() {
  testWidgets('App renders main screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('김아론님'), findsOneWidget);
    expect(find.text('라이브 카트'), findsOneWidget);
  });

  testWidgets('Store info tab opens the store map page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('매장 정보'));
    await tester.pumpAndSettle();

    expect(find.text('매장 정보'), findsWidgets);
    expect(find.text('매장 지도'), findsOneWidget);
    expect(find.text('스테이션 게이트 홍대점'), findsOneWidget);
    expect(find.text('3F 남성 캐주얼존 인기 상품'), findsOneWidget);
  });

  testWidgets('Cart tab opens the recognized cart page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();

    expect(find.text('장바구니'), findsWidgets);
    expect(find.text('RFID가 인식한 상품이 장바구니에 담겼습니다.'), findsOneWidget);
    expect(find.text('인식된 상품 (4)'), findsOneWidget);
    expect(find.text('결제하기 (216,000원)'), findsOneWidget);
  });

  testWidgets('Cart checkbox selection updates selected total', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('cart-item-0-checkbox')));
    await tester.pumpAndSettle();

    expect(find.text('전체 3개 상품'), findsOneWidget);
    expect(find.text('127,000원'), findsOneWidget);
    expect(find.text('결제하기 (127,000원)'), findsOneWidget);
  });

  testWidgets('Checkout button opens the payment method page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('결제하기 (216,000원)'));
    await tester.pumpAndSettle();

    expect(find.text('결제 방법 선택'), findsOneWidget);
    expect(find.text('결제 방법을 선택해주세요.'), findsOneWidget);
    expect(find.text('간편결제'), findsOneWidget);
    expect(find.text('계좌/카드 결제'), findsOneWidget);
  });

  testWidgets('Payment next button opens pickup and delivery page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('결제하기 (216,000원)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('픽업/배송 선택'), findsOneWidget);
    expect(find.text('픽업 또는 배송 방법을 선택해주세요.'), findsOneWidget);
    expect(find.text('스테이션 게이트 홍대점'), findsOneWidget);
    expect(find.text('픽업 준비 시간'), findsOneWidget);
  });

  testWidgets('Pickup delivery next button opens order confirmation page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('결제하기 (216,000원)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('주문 확인'), findsOneWidget);
    expect(find.text('주문 상품'), findsOneWidget);
    expect(find.text('총 결제 금액'), findsOneWidget);
    expect(find.text('주문하기'), findsOneWidget);
  });

  testWidgets('Order button opens order complete page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('장바구니'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('결제하기 (216,000원)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('주문하기'));
    await tester.pumpAndSettle();

    expect(find.text('주문 완료'), findsOneWidget);
    expect(find.text('주문이 완료되었습니다!'), findsOneWidget);
    expect(find.text('SG250508172941'), findsOneWidget);
    expect(find.text('홈으로 이동'), findsOneWidget);
  });

  testWidgets('Profile tab opens the profile page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('내정보'));
    await tester.pumpAndSettle();

    expect(find.text('내정보'), findsWidgets);
    expect(find.text('문영우'), findsOneWidget);
    expect(find.text('RFID 연결됨'), findsOneWidget);
    expect(find.text('주문/이용 관리'), findsOneWidget);
    expect(find.text('고객지원'), findsOneWidget);
  });
}
