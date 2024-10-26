// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'investment_provider.dart';
import 'add_investment_screen.dart';
import 'investment_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InvestmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('My Portfolio')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.investments.length,
              itemBuilder: (context, index) {
                final investment = provider.investments[index];
                return ListTile(
                  title: Text(investment.name),
                  subtitle: Text('Invested: \$${investment.amountInvested}'),
                  trailing: Text('Current: \$${investment.currentValue}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InvestmentDetailScreen(investment: investment),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Portfolio Value: \$${provider.totalPortfolioValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddInvestmentScreen()),
        ),
      ),
    );
  }
}
