import "package:avreen_bank/main.dart";
import "package:avreen_bank/view/pages/profile/profile_controller.dart";
import "package:avreen_bank/view/pages/splash/splash_page.dart";
import "package:u/utilities.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController c = ProfileController();

  @override
  Widget build(BuildContext context) => UScaffold(
    color: Theme.of(context).scaffoldBackgroundColor,
    body: SingleChildScrollView(
      child: UColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _header(context),
          const SizedBox(height: 24),
          UColumn(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            children: <Widget>[
              UListTile(
                icon: Icons.edit_outlined,
                title: U.s.editItem(U.s.userInformation),
                color: AppColors.brand,
                onTap: () => UToast.snackBar(message: U.s.comingSoon),
              ).pSymmetric(vertical: 4),
              UListTile(
                icon: Icons.description_outlined,
                title: U.s.termsAndConditions,
                color: AppColors.warning,
                onTap: () => UToast.snackBar(message: U.s.comingSoon),
              ).pSymmetric(vertical: 4),
              UListTile(
                icon: Icons.language,
                title: U.s.visitWebsite,
                color: AppColors.success,
                onTap: () => UToast.snackBar(message: U.s.comingSoon),
              ).pSymmetric(vertical: 4),
              UListTile(
                icon: Icons.logout,
                title: U.s.logout,
                color: Theme.of(context).colorScheme.error,
                textColor: Theme.of(context).colorScheme.error,
                onTap: () => logout(immediate: false),
              ).pSymmetric(vertical: 4),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _header(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 8, 20, 12),
    decoration: BoxDecoration(
      color: context.colorScheme.primary,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.onGradient.withAlpha(0x33),
        child: const Icon(Icons.person_rounded, color: AppColors.onGradient, size: 32),
      ),
      title: UTextTitleMedium(
        "${Core.fileInfo.value.firstName} ${Core.fileInfo.value.lastName}",
        color: AppColors.onGradient,
        fontWeight: FontWeight.bold,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  static Future<void> logout({bool immediate = true}) async {
    if (immediate) {
      await ULocalStorage.clear();
      await UFileStorage.clear();
      await UNavigator.offAll(const SplashPage());
    } else {
      UNavigator.confirm(
        title: U.s.logout,
        message: U.s.areYouSureYouWantToLogOut,
        onCancel: UNavigator.back,
        onConfirm: () async {
          await ULocalStorage.clear();
          await UFileStorage.clear();
          await UNavigator.offAll(const SplashPage());
        },
      );
    }
  }
}
