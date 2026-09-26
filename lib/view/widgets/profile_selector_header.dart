import "package:avreen_bank/view/widgets/gradient_header.dart";
import "package:avreen_bank/view/widgets/profile_selector_tile.dart";
import "package:u/utilities.dart";

class ProfileSelectorHeader extends StatelessWidget {
  const ProfileSelectorHeader({required this.onProfileChanged, super.key});

  final VoidCallback onProfileChanged;

  @override
  Widget build(BuildContext context) => GradientHeader(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
    child: ProfileSelectorTile(onProfileChange: onProfileChanged),
  );
}
