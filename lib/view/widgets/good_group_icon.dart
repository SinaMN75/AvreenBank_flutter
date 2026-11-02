import "package:avreen_bank/main.dart";
import "package:u/utilities.dart";

class GoodGroupIcon extends StatelessWidget {
  const GoodGroupIcon({required this.groupId, this.size = 44, super.key});

  final String? groupId;
  final double size;

  @override
  Widget build(BuildContext context) {
    final String? asset = AppGoods.of(groupId);
    if (asset == null) return UIconBackground(Icons.inventory_2_outlined, color: AppColors.success, size: size);
    return UImage(asset, width: size, height: size);
  }
}
