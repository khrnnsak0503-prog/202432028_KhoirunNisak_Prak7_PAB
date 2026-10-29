import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_7/main.dart';

void main() {
  test('formatRupiah memberi titik ribuan', () {
    expect(formatRupiah(25000), 'Rp 25.000');
    expect(formatRupiah(1500000), 'Rp 1.500.000');
    expect(formatRupiah(500), 'Rp 500');
  });

  testWidgets('Tab dan tambah transaksi berjalan', (WidgetTester tester) async {
    await tester.pumpWidget(const DompetkuApp());

    // Tab Transaksi tampil pertama dengan total awal
    expect(find.text('Transaksi'), findsOneWidget);
    expect(find.text('Rp 193.000'), findsOneWidget);
    expect(find.text('Makan Siang'), findsOneWidget);

    // Tambah transaksi lewat form
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Bensin');
    await tester.enterText(find.byType(TextFormField).at(1), '20000');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Total ikut bertambah (item baru ada di bawah daftar)
    expect(find.text('Rp 213.000'), findsOneWidget);

    // Pindah ke tab Kategori
    await tester.tap(find.text('Kategori'));
    await tester.pumpAndSettle();
    expect(find.text('Transportasi'), findsWidgets);
    expect(find.text('3 transaksi'), findsOneWidget); // Makanan: 2 + Bensin

    // Tab Statistik menampilkan transaksi terbesar
    await tester.tap(find.text('Statistik'));
    await tester.pumpAndSettle();
    expect(find.text('Transaksi Terbesar'), findsOneWidget);
    expect(find.text('Beli Buku'), findsWidgets);
  });
}
