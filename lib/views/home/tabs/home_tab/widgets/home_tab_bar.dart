import 'package:evently/views/home/provider/bottom_nav_provider.dart';
import 'package:evently/views/onboarding/provider/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTebBar extends StatelessWidget {
  final ToggleProvider provider;
  final ThemeData theme;

  const HomeTebBar({super.key, required this.provider, required this.theme});

  @override
  Widget build(BuildContext context) {
    var providerC = Provider.of<BottomNavProvider>(context);
    final selected =
        providerC.selectedCategory ?? providerC.categoriesList.first;

    return DefaultTabController(
      length: providerC.categoriesList.length,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelPadding: const EdgeInsets.only(right: 16),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        onTap: (index) {
          providerC.changeSelected(index);
        },
        tabs:
            providerC.categoriesList
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:
                          selected.id == e.id
                              ? (provider.isDark(context)
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onPrimary)
                              : Colors.transparent,
                      border: Border.all(
                        color:
                            provider.isDark(context)
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onPrimary,
                      ),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(
                          e.iconData,
                          color:
                              selected.id == e.id
                                  ? (provider.isDark(context)
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.primary)
                                  : theme.colorScheme.onPrimary,
                        ),
                        Text(
                          provider.isEn(context) ? e.enName : e.arName,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color:
                                selected.id == e.id
                                    ? (provider.isDark(context)
                                        ? theme.colorScheme.onPrimary
                                        : theme.colorScheme.primary)
                                    : theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
