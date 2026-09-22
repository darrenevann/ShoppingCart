// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_cart/main.dart';

void main() {
  testWidgets('menampilkan produk dan total keranjang', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Wireless Headphone'), findsOneWidget);
    expect(find.text('Laptop ASUS Vivobook'), findsOneWidget);
    expect(find.text('Wireless Mouse'), findsOneWidget);
    expect(find.text('Total (3 produk)'), findsOneWidget);
    expect(find.text('Rp 8.100.000'), findsOneWidget);
  });

  testWidgets('tap memilih produk dan double tap menambah like', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final product = find.text('Wireless Headphone');

    await tester.tap(product);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(product);
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    expect(find.text('13'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(product);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(product);
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('12'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(3));
  });

  testWidgets('long press menampilkan pesan produk dipilih', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.longPress(find.text('Wireless Headphone'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Produk dipilih!'), findsOneWidget);
    expect(find.textContaining('Wireless Headphone telah dipilih'), findsOneWidget);
  });

  testWidgets('minus mengurangi produk dari total keranjang', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final removeButton = find.ancestor(
      of: find.byIcon(Icons.remove).first,
      matching: find.byType(IconButton),
    );
    tester.widget<IconButton>(removeButton).onPressed!();
    await tester.pump();
    await tester.pump();

    expect(find.text('Total (2 produk)'), findsOneWidget);
    expect(find.text('Rp 7.750.000'), findsOneWidget);
  });
}
