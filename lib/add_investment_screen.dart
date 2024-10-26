// lib/add_investment_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'investment_provider.dart';

class AddInvestmentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Investment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Investment Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter an investment name' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount Invested (USD)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter the amount invested' : null,
              ),
              TextFormField(
                controller: _currentValueController,
                decoration: InputDecoration(labelText: 'Current Value (USD)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter the current value' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final investment = Investment(
                      name: _nameController.text,
                      amountInvested: double.parse(_amountController.text),
                      currentValue: double.parse(_currentValueController.text),
                    );
                    Provider.of<InvestmentProvider>(context, listen: false)
                        .addInvestment(investment);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
