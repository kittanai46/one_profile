// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';

/// Base template for displaying item cards with customizable sections
class BaseItemCard extends StatelessWidget {
  final double width;
  final double aspectRatio;
  final Widget imageWidget;
  final String title;
  final String? subtitle;
  final Widget? footer;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double borderRadius;
  final List<Widget>? actions;

  const BaseItemCard({
    Key? key,
    this.width = 140,
    this.aspectRatio = 1.02,
    required this.imageWidget,
    required this.title,
    this.subtitle,
    this.footer,
    required this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor = const Color(0xFF979797),
    this.borderRadius = 12,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            AspectRatio(
              aspectRatio: aspectRatio,
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: imageWidget,
              ),
            ),
            const SizedBox(height: 8),
            // Title Section
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Subtitle Section (Optional)
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // Footer Section (Optional) - for price, actions, etc.
            if (footer != null) ...[const SizedBox(height: 8), footer!],
            // Actions Section (Optional) - for buttons, icons
            if (actions != null) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Template for item list/grid display
class ItemGridTemplate extends StatelessWidget {
  final List<Widget> items;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;

  const ItemGridTemplate({
    Key? key,
    required this.items,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.7,
    this.mainAxisSpacing = 20,
    this.crossAxisSpacing = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        ),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}

/// Template for item horizontal list display
class ItemListTemplate extends StatelessWidget {
  final List<Widget> items;
  final Axis scrollDirection;
  final EdgeInsets padding;
  final double spacing;

  const ItemListTemplate({
    Key? key,
    required this.items,
    this.scrollDirection = Axis.horizontal,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      child: Padding(
        padding: padding,
        child: scrollDirection == Axis.horizontal
            ? Row(
                children: [
                  ...items,
                  SizedBox(width: spacing),
                ],
              )
            : Column(
                children: [
                  ...items,
                  SizedBox(height: spacing),
                ],
              ),
      ),
    );
  }
}

/// Template for banner/header display
class BannerTemplate extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsets padding;
  final double borderRadius;
  final Widget? trailing;

  const BannerTemplate({
    Key? key,
    required this.title,
    this.subtitle,
    this.backgroundColor = const Color(0xFF6C5CE7),
    this.textColor = Colors.white,
    this.titleStyle,
    this.subtitleStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.borderRadius = 20,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(color: textColor),
                children: [
                  TextSpan(
                    text: "$title\n",
                    style:
                        titleStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (subtitle != null)
                    TextSpan(
                      text: subtitle,
                      style:
                          subtitleStyle ??
                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                ],
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Template for section header with title and action
class SectionHeaderTemplate extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final TextStyle? titleStyle;
  final Color? actionForegroundColor;

  const SectionHeaderTemplate({
    Key? key,
    required this.title,
    this.actionLabel = "See more",
    this.onActionPressed,
    this.titleStyle,
    this.actionForegroundColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                titleStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          if (actionLabel != null && onActionPressed != null)
            TextButton(
              onPressed: onActionPressed,
              style: TextButton.styleFrom(
                foregroundColor: actionForegroundColor,
              ),
              child: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}

/// Template for displaying stats/metrics
class StatsTemplate extends StatelessWidget {
  final List<StatItem> stats;
  final Axis direction;
  final MainAxisAlignment mainAxisAlignment;

  const StatsTemplate({
    Key? key,
    required this.stats,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            children: stats
                .map((stat) => _buildStatItem(context, stat))
                .toList(),
          )
        : Column(
            mainAxisAlignment: mainAxisAlignment,
            children: stats
                .map((stat) => _buildStatItem(context, stat))
                .toList(),
          );
  }

  Widget _buildStatItem(BuildContext context, StatItem stat) {
    return Column(
      children: [
        Text(
          stat.value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(stat.label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

/// Model for stat data
class StatItem {
  final String value;
  final String label;

  StatItem({required this.value, required this.label});
}
