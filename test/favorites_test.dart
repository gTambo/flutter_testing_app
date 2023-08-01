import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (int i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page widget tests', () {
    testWidgets('Test if List View shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });
    testWidgets('Testing remove button', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      var totalItems = widgetTester.widgetList(find.byIcon(Icons.close)).length;
      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pumpAndSettle();
      expect(widgetTester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
