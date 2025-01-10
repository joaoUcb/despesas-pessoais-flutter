import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions,);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSom = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final trDate = recentTransactions[i].date;
        final sameDay = trDate.day == weekDay.day;
        final sameMonth = trDate.month == weekDay.month;
        final sameYear = trDate.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSom += recentTransactions[i].value;
        }
      }

      return {
        'day': DateFormat.E('pt_BR').format(weekDay)[0],
        'value': totalSom,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // O card pode aproveitar as cores e bordas definidas no seu cardTheme
      elevation: 6,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: tr['value'] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
