import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class GradientHeader extends StatelessWidget {
  const GradientHeader({required this.child, this.padding = const EdgeInsets.fromLTRB(20, 16, 20, 24), super.key});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding.copyWith(top: padding.top + MediaQuery.paddingOf(context).top),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: AppColors.header, begin: Alignment.topCenter, end: Alignment.bottomCenter),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
    ),
    child: child,
  );
}

class PageHeader extends StatelessWidget {
  const PageHeader({required this.title, this.subtitle, this.trailing, super.key});

  final String title;
  final String? subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) => GradientHeader(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
    child: Row(
      children: <Widget>[
        UContainer(
          width: 44,
          height: 44,
          radius: 14,
          alignment: Alignment.center,
          color: AppColors.onGradient.withValues(alpha: 0.15),
          onTap: UNavigator.back,
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.onGradient, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UTextTitleLarge(title, color: AppColors.onGradient, fontWeight: FontWeight.bold, maxLines: 1, overflow: TextOverflow.ellipsis),
              if (subtitle != null) UTextBodySmall(subtitle!, color: AppColors.onGradient.withValues(alpha: 0.8), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        if (trailing != null)
          UContainer(
            radius: 14,
            color: AppColors.onGradient.withValues(alpha: 0.15),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: UTextLabelLarge(trailing!, color: AppColors.onGradient, fontWeight: FontWeight.bold),
          ),
      ],
    ),
  );
}
