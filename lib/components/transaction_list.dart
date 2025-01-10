import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nenhuma Transação Cadastrada',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: constraints.maxHeight * 0.5,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.contain, // Ajuste para evitar distorções
              ),
            ),
          ],
        );
      },
    )
        : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];

        // Você pode usar o Dismissible para animar a remoção do item arrastando.
        // Caso não queira, basta usar o Card diretamente.
        return Dismissible(
          key: ValueKey(tr.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => onRemove(tr.id),
          background: Container(
            color: theme.colorScheme.error.withOpacity(0.2),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
              color: theme.colorScheme.error,
              size: 30,
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                foregroundColor: theme.colorScheme.primary,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      'R\$${tr.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              title: Text(
                tr.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                DateFormat('dd/MM/y').format(tr.date),
                style: TextStyle(
                  color: theme.colorScheme.primary,
                ),
              ),
              trailing: MediaQuery.of(context).size.width > 400
                  ? TextButton.icon(
                onPressed: () => onRemove(tr.id),
                icon: Icon(
                  Icons.delete,
                  color: theme.colorScheme.error,
                ),
                label: Text(
                  'Excluir',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              )
                  : IconButton(
                onPressed: () => onRemove(tr.id),
                icon: const Icon(Icons.delete),
                color: theme.colorScheme.error,
              ),
            ),
          ),
        );
      },
    );
  }
}
