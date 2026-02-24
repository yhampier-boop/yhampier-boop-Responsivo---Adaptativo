import 'package:flutter/material.dart';

void main() {
  runApp(const AdaptableDashboardApp());
}

class AdaptableDashboardApp extends StatelessWidget {
  const AdaptableDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Camaleón',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const DashboardScreen(),
    );
  }
}

// =============================================================
// DASHBOARD PRINCIPAL
// =============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildTabletLayout(context);
              } else {
                return _buildMobileLayout(context, screenWidth);
              }
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================
// DISEÑO MÓVIL
// =============================================================

Widget _buildMobileLayout(BuildContext context, double screenWidth) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CustomHeader(),
        SizedBox(height: 24),
        BalanceCard(),
        SizedBox(height: 24),
        QuickActions(),
        SizedBox(height: 24),
        TransactionsList(),
      ],
    ),
  );
}

// =============================================================
// DISEÑO TABLET / WEB
// =============================================================

Widget _buildTabletLayout(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Expanded(
        flex: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(),
            SizedBox(height: 24),
            BalanceCard(),
            SizedBox(height: 24),
            QuickActions(),
          ],
        ),
      ),
      SizedBox(width: 40),
      Expanded(
        flex: 6,
        child: TransactionsList(),
      ),
    ],
  );
}

// =============================================================
// COMPONENTES
// =============================================================

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Mi Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.person,
            color:
                Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance Total',
              style: TextStyle(
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$ 12,450.00',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.spaceEvenly,
      children: const [
        ActionButton(
          iconPath: 'assets/send.svg',
          label: 'Enviar',
          fallbackIcon: Icons.send,
        ),
        ActionButton(
          iconPath: 'assets/pay.svg',
          label: 'Pagar',
          fallbackIcon: Icons.payment,
        ),
        ActionButton(
          iconPath: 'assets/stats.svg',
          label: 'Estadísticas',
          fallbackIcon: Icons.bar_chart,
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final IconData fallbackIcon;

  const ActionButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            fallbackIcon,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Transacciones',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        TransactionItem(),
        TransactionItem(),
        TransactionItem(),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Compra en tienda'),
          Text(
            '-\$ 45.00',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}