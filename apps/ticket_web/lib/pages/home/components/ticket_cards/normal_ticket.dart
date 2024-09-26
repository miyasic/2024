import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_web/gen/i18n/strings.g.dart';

/// 一般チケットのカード
class NormalTicketCard extends StatelessWidget {
  const NormalTicketCard({
    required this.isLoggedIn,
    this.onPurchasePressed,
    this.onSignInPressed,
    this.onApplyCodePressed,
    super.key,
  });

  final bool isLoggedIn;
  final VoidCallback? onPurchasePressed;
  final VoidCallback? onSignInPressed;
  final VoidCallback? onApplyCodePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final i18n = Translations.of(context);

    return Card.outlined(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(),
            Text(
              i18n.homePage.tickets.normal.name,
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              i18n.homePage.tickets.price(
                price: NumberFormat('#,###').format(3000),
              ),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${i18n.homePage.tickets.normal.description}\n',
                  ),
                  TextSpan(
                    text: '${i18n.homePage.tickets.invitation.description} ',
                  ),
                  TextSpan(
                    text: i18n.homePage.tickets.invitation.here,
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = onApplyCodePressed,
                  ),
                ],
              ),
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: isLoggedIn ? onPurchasePressed : null,
              icon: const Icon(Icons.shopping_cart),
              label: Text(i18n.homePage.tickets.buyTicket),
            ),
          ],
        ),
      ),
    );
  }
}
