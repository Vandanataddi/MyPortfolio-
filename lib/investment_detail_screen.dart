// lib/investment_detail_screen.dart
import 'package:flutter/material.dart';
import 'investment_provider.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final Investment investment;

  InvestmentDetailScreen({required this.investment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(investment.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount Invested: \$${investment.amountInvested}'),
            Text('Current Value: \$${investment.currentValue}'),
            Text(
              'Percentage Growth: ${investment.percentageGrowth.toStringAsFixed(2)}%',
            ),
          ],
        ),
      ),
    );
  }
}
