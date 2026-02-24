import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_3/main.dart';

void main() {
  testWidgets('Dashboard loads correctly', (WidgetTester tester) async {
    // Construye la app real
    await tester.pumpWidget(const AdaptableDashboardApp());

    // Verifica que el dashboard se muestre
    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.text('Balance total'), findsOneWidget);
    expect(find.text('Últimas transacciones'), findsOneWidget);
  });
}
