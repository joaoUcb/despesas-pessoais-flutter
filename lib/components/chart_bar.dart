import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            // Valor (acima da barra)
            SizedBox(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  value.toStringAsFixed(2),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04),
            // Barra
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 12,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Fundo cinza claro
                  Container(
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? const Color.fromRGBO(220, 220, 220, 1)
                          : Colors.grey[700],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  // Parte preenchida (usando gradiente como exemplo)
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.7),
                            theme.colorScheme.primary,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04),
            // Label (abaixo da barra)
            SizedBox(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
