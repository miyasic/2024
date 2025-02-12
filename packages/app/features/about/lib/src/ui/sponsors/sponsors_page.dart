import 'package:app_cores_designsystem/ui.dart';
import 'package:app_features_about/l10n.dart';
import 'package:app_features_about/src/ui/sponsors/sponsors_list_item.dart';
import 'package:common_data/sponsor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// スポンサー一覧ページ
class SponsorsPage extends HookConsumerWidget {
  const SponsorsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ScreenSizeProvider.of(context).isMobile;
    final l = L10nAbout.of(context);
    const padding = EdgeInsets.only(top: 16, left: 16, right: 16);
    const spacing = 8.0;
    const childAspectRatio = 16 / 9;

    final sponsorsAsyncValue = ref.watch(sponsorsProvider);

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: sponsorsAsyncValue.when(
          data: (sponsors) {
            final platinumSponsors = sponsors
                .where((element) => element.type == SponsorType.platinum)
                .toList();

            final goldSponsors = sponsors
                .where(
                  (element) => element.type == SponsorType.gold,
                )
                .toList();

            final silverSponsors = sponsors
                .where((element) => element.type == SponsorType.silver)
                .toList();

            final bronzeSponsors = sponsors
                .where((element) => element.type == SponsorType.bronze)
                .toList();

            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: Text(
                    l.sponsors,
                  ),
                ),
                if (platinumSponsors.isNotEmpty)
                  _sponsorsWidget(
                    padding: padding,
                    spacing: spacing,
                    childAspectRatio: childAspectRatio,
                    sponsors: platinumSponsors,
                    crossAxisCount: isMobile ? 1 : 2,
                  ),
                if (goldSponsors.isNotEmpty)
                  _sponsorsWidget(
                    padding: padding,
                    spacing: spacing,
                    childAspectRatio: childAspectRatio,
                    sponsors: goldSponsors,
                    crossAxisCount: isMobile ? 2 : 3,
                  ),
                if (silverSponsors.isNotEmpty)
                  _sponsorsWidget(
                    padding: padding,
                    spacing: spacing,
                    childAspectRatio: childAspectRatio,
                    sponsors: silverSponsors,
                    crossAxisCount: isMobile ? 3 : 4,
                  ),
                if (bronzeSponsors.isNotEmpty)
                  _sponsorsWidget(
                    padding: padding,
                    spacing: spacing,
                    childAspectRatio: childAspectRatio,
                    sponsors: bronzeSponsors,
                    crossAxisCount: isMobile ? 3 : 4,
                  ),
                SliverGap(16 + MediaQuery.paddingOf(context).bottom),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  SliverPadding _sponsorsWidget({
    required EdgeInsetsGeometry padding,
    required double spacing,
    required double childAspectRatio,
    required List<Sponsor> sponsors,
    required int crossAxisCount,
  }) {
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid.builder(
        itemBuilder: (context, index) => SponsorsListItem(
          sponsor: sponsors[index],
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: sponsors.length,
      ),
    );
  }
}
