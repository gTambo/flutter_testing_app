import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/home.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group('Home page widget tests', () {
    testWidgets('Testing if ListView shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing scrolling', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.text('Item 0'), findsOneWidget);
      await widgetTester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );
      await widgetTester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });
  });
}
