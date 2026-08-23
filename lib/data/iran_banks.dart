import "package:u/utilities.dart";

abstract class IranBanks {
  static const String _dir = "lib/assets/banks";

  static const Set<String> _assetBins = <String>{
    "502229", "502908", "502938", "504172", "504706", "505416", "505785", "585947",
    "589210", "589463", "603769", "603770", "603799", "606373", "610433", "621986",
    "622106", "627353", "627381", "627412", "627488", "627760", "627961", "628023",
    "636214", "639346", "639599", "639607",
  };

  static const List<Color> _fallback = <Color>[Color(0xFF3A3F58), Color(0xFF20232F)];

  static const Map<String, List<Color>> _gradients = <String, List<Color>>{
    "610433": <Color>[Color(0xFFE4004B), Color(0xFF8A0033)],
    "991975": <Color>[Color(0xFFE4004B), Color(0xFF8A0033)],
    "621986": <Color>[Color(0xFF1D63C4), Color(0xFF0C2E6E)],
    "603799": <Color>[Color(0xFF1E8FA8), Color(0xFF0C5666)],
    "170019": <Color>[Color(0xFF1E8FA8), Color(0xFF0C5666)],
    "627353": <Color>[Color(0xFF1466B8), Color(0xFF0B3E75)],
    "585983": <Color>[Color(0xFF1466B8), Color(0xFF0B3E75)],
    "589210": <Color>[Color(0xFF12617A), Color(0xFF0A3A49)],
    "622106": <Color>[Color(0xFFB0122B), Color(0xFF6E0B1B)],
    "627884": <Color>[Color(0xFFB0122B), Color(0xFF6E0B1B)],
    "502229": <Color>[Color(0xFFC79A3B), Color(0xFF7A5D1E)],
    "639347": <Color>[Color(0xFFC79A3B), Color(0xFF7A5D1E)],
    "627412": <Color>[Color(0xFF4B2E83), Color(0xFF2C1A50)],
    "628023": <Color>[Color(0xFF175E3E), Color(0xFF0C3A26)],
    "603770": <Color>[Color(0xFF157347), Color(0xFF0C4A2E)],
    "639217": <Color>[Color(0xFF157347), Color(0xFF0C4A2E)],
    "603769": <Color>[Color(0xFF1F7A3D), Color(0xFF0C4A24)],
    "589463": <Color>[Color(0xFF2B6CB0), Color(0xFF1A4A7A)],
    "636214": <Color>[Color(0xFF6D28D9), Color(0xFF3F1A80)],
    "639346": <Color>[Color(0xFF0E7490), Color(0xFF083F4E)],
    "505416": <Color>[Color(0xFF0EA5A5), Color(0xFF085E5E)],
    "606373": <Color>[Color(0xFF166534), Color(0xFF0B3D1F)],
    "627488": <Color>[Color(0xFF9A3412), Color(0xFF5C1F0B)],
    "627961": <Color>[Color(0xFF334155), Color(0xFF1E293B)],
    "627760": <Color>[Color(0xFFB45309), Color(0xFF6E3306)],
    "502938": <Color>[Color(0xFF166D67), Color(0xFF0A3E3A)],
    "504706": <Color>[Color(0xFF7C2D8B), Color(0xFF471A50)],
    "505785": <Color>[Color(0xFF2563EB), Color(0xFF163F99)],
    "636949": <Color>[Color(0xFF0F766E), Color(0xFF0A443F)],
  };

  static bool isIranianCard(String number) => number.length == 16 && PersianTools.getBankNameFromCard(number) != null;

  static String? nameOf(String number) => number.length == 16 ? PersianTools.getBankNameFromCard(number) : null;

  static List<Color> gradientOf(String bin) => _gradients[bin] ?? _fallback;

  static String? assetOf(String bin) => _assetBins.contains(bin) ? "$_dir/b_$bin.png" : null;
}
