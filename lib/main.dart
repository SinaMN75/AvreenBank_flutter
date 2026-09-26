import "package:avreen_bank/data/data.dart";
import "package:avreen_bank/view/pages/splash/splash_page.dart";
import "package:u/utilities.dart";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
}

Future<void> main() async {
  if (kDebugMode) HttpOverrides.global = MyHttpOverrides();
  await initU(snackBarDuration: 6);
  String? locale = ULocalStorage.getString(UConstants.locale);
  if (locale == null) {
    ULocalStorage.setLocale("fa");
    locale = "fa";
  }
  runApp(
    Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: UMaterialApp(
          locale: Locale(locale),
          lightThemeData: Core.lightThemeData,
          darkThemeData: Core.darkThemeData,
          home: const SplashPage(),
        ),
      ),
    ),
  );
}

abstract class AppColors {
  static const Color brand = Color(0xFF1553A0);
  static const Color info = Color(0xFF38EBFF);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFDC2626);
  static const Color onGradient = Color(0xFFFFFFFF);
  static const Color qr = Color(0xFF000000);
  static const Color cardChip = Color(0xFFF4C95D);
  static const Color disabled = Color(0xFFC9CDD6);
  static const Color credit = Color(0xFF2563EB);
  static const Color wallet = Color(0xFF0D9488);
  static const Color voucher = Color(0xFFEA580C);
  static const Color discount = Color(0xFF16A34A);
  static const Color subsidy = Color(0xFFDB2777);
  static const Color sky = Color(0xFF0284C7);
  static const Color purple = Color(0xFF7C6FE0);
  static const Color orange = Color(0xFFEA580C);
  static const List<Color> gradient = <Color>[Color(0xFF3B39E5), Color.fromRGBO(226, 111, 55, 1)];
  static const List<Color> header = <Color>[Color(0xFF0B7BC9), Color(0xFF1553A0)];
  static const List<Color> card = <Color>[Color(0xFF7DB5E6), Color(0xFF1553A0), Color(0xFF5B4A8E)];
}

abstract class Core {
  static late URx<GetFileInfoResponse> fileInfo;
  static late URx<FileInfo> currentFile;

  static RemoteDataSource dataSource = RemoteDataSource();
  static final ThemeData lightThemeData = _buildTheme(
    background: const Color(0xFFF3F5F9),
    scheme: ColorScheme.fromSeed(
      seedColor: AppColors.brand,
      primary: AppColors.brand,
      surface: const Color(0xFFFFFFFF),
    ).copyWith(
      onSurface: const Color(0xFF1F2937),
      onSurfaceVariant: const Color(0xFF6B7280),
      outlineVariant: const Color(0xFFDDE2EA),
      onPrimary: const Color(0xFFFFFFFF),
      error: AppColors.danger,
    ),
  );
  static final ThemeData darkThemeData = _buildTheme(
    background: Colors.black,
    scheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.brand,
      primary: const Color(0xFFA5B4FC),
      surface: Colors.grey.shade900,
    ).copyWith(onSurface: Colors.grey.shade100, onSurfaceVariant: Colors.grey.shade400, outlineVariant: Colors.grey.shade700, onPrimary: Colors.grey.shade900, error: AppColors.danger),
  );

  static ThemeData _buildTheme({required ColorScheme scheme, required Color background}) => ThemeData(
    brightness: scheme.brightness,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: scheme.onSurface),
      titleTextStyle: TextStyle(fontFamily: U.vazir.fontFamily, color: scheme.onSurface, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 0, thickness: 1),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      surfaceTintColor: scheme.surface,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    colorScheme: scheme,
    fontFamily: U.vazir.fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: scheme.onSurface),
      displayMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: scheme.onSurface),
      displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: scheme.onSurface),
      headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: scheme.onSurface),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: scheme.onSurface),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: scheme.onSurface),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: scheme.onSurface),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: scheme.onSurface),
      titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: scheme.onSurface),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: scheme.onSurface),
      bodyMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: scheme.onSurface),
      bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: scheme.onSurfaceVariant),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: scheme.onSurface),
      labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: scheme.onSurface),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: scheme.onSurfaceVariant),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outlineVariant, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outlineVariant, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.error, width: 0.7),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.error, width: 0.7),
      ),
      outlineBorder: const BorderSide(color: Colors.transparent, width: 0.7),
      labelStyle: TextStyle(fontFamily: U.vazir.fontFamily, color: scheme.onSurfaceVariant, fontSize: 12),
      filled: true,
      fillColor: scheme.surface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: scheme.onPrimary,
        textStyle: TextStyle(fontFamily: U.vazir.fontFamily, color: scheme.primary, fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: scheme.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: scheme.primary,
      unselectedLabelColor: scheme.onSurfaceVariant,
      indicatorColor: scheme.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: scheme.outlineVariant,
      labelStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 15, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontFamily: U.vazir.fontFamily, fontSize: 15, fontWeight: FontWeight.w600),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: scheme.surface,
      dragHandleColor: scheme.outlineVariant,
      dragHandleSize: const Size(44, 5),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actionsPadding: EdgeInsets.zero,
    ),
  );
}

abstract class AppConstants {
  static const String baseUrl = kIsWeb ? "api/credit/mo" : "https://oa.avreenco.com:8080/api/credit/mo";
  // static const String baseUrl = kIsWeb ? "api/credit/mo" : "https://wpa.tj724.ir/api/credit/mo";
  static const String personId = "personId";
}

abstract class AppImages {
  static const String _base = "lib/assets/images";
  static const String logo = "$_base/logo.jpeg";
  static const String avreen = "$_base/avreen.png";
}

abstract class AppIcons {
  static const String _base = "lib/assets/icons";
  static const String home = "$_base/home.svg";
}
