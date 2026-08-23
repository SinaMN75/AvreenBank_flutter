import "package:avreen_bank/model/account_model.dart";
import "package:avreen_bank/model/profile_model.dart";
import "package:avreen_bank/model/transaction_model.dart";
import "package:u/utilities.dart";

/// Fake API layer: every method waits, then returns canned data — mimicking a
/// network round-trip. Swap the bodies for UServices.* calls once the backend
/// endpoints exist; the controller and UI stay the same.
class HomeApi {
  const HomeApi();

  Future<List<ProfileModel>> getProfiles() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return _profiles;
  }

  static const List<ProfileModel> _profiles = <ProfileModel>[
    ProfileModel(
      id: "personal",
      badge: "م‌ر",
      name: "مریم رضایی — پروندهٔ شخصی",
      meta: "۳ حساب · ۳ کارت",
      accounts: <AccountModel>[
        AccountModel(badge: "ج", title: "حساب جاری", number: "120-8145672-001", balance: 48250000, chips: <String>["حساب اصلی", "برداشت آزاد"]),
        AccountModel(badge: "ک", title: "سپرده کوتاه‌مدت", number: "120-9932104-002", balance: 132400000, chips: <String>["سود ماهانه"]),
        AccountModel(badge: "ب", title: "سپرده بلندمدت یک‌ساله", number: "120-4567890-005", balance: 620000000, chips: <String>["مسدود تا ۱۴۰۵/۰۳"]),
      ],
      transactions: <TransactionModel>[
        TransactionModel(icon: Icons.south_west, title: "واریز حقوق — شرکت آرمان", subtitle: "امروز ۰۹:۱۲ · پایا", amount: 42000000, direction: TransactionDirection.credit),
        TransactionModel(icon: Icons.north_east, title: "انتقال به علی مرادی", subtitle: "امروز ۰۸:۴۰ · کارت به کارت", amount: 3500000, direction: TransactionDirection.debit),
        TransactionModel(icon: Icons.receipt_long_outlined, title: "قبض برق — شناسه ۸۸۲۱", subtitle: "دیروز ۲۱:۰۵", amount: 486000, direction: TransactionDirection.debit),
        TransactionModel(icon: Icons.shopping_bag_outlined, title: "خرید اینترنتی دیجی‌فروش", subtitle: "دیروز ۱۷:۳۳ · درگاه", amount: 1290000, direction: TransactionDirection.debit),
        TransactionModel(icon: Icons.savings_outlined, title: "سود سپرده کوتاه‌مدت", subtitle: "۱۴۰۴/۰۵/۲۸", amount: 1840000, direction: TransactionDirection.credit),
      ],
    ),
    ProfileModel(
      id: "business",
      badge: "ک",
      name: "کافه ونک — پروندهٔ کسب‌وکار",
      meta: "۲ حساب · ۱ کارت",
      accounts: <AccountModel>[
        AccountModel(badge: "ت", title: "حساب تجاری کافه ونک", number: "120-3311998-010", balance: 214700000, chips: <String>["درگاه پرداخت متصل", "تسویه روزانه"]),
        AccountModel(badge: "م", title: "حساب مالیات و بیمه", number: "120-7788221-011", balance: 36900000, chips: <String>["برداشت با تأیید دو نفره"]),
      ],
      transactions: <TransactionModel>[
        TransactionModel(icon: Icons.south_west, title: "تسویه درگاه پرداخت", subtitle: "امروز ۰۰:۳۰ · روزانه", amount: 18420000, direction: TransactionDirection.credit),
        TransactionModel(icon: Icons.north_east, title: "پرداخت به تأمین‌کننده قهوه", subtitle: "دیروز ۱۴:۱۰ · ساتنا", amount: 62000000, direction: TransactionDirection.debit),
        TransactionModel(icon: Icons.north_east, title: "حقوق کارکنان — مرداد", subtitle: "۱۴۰۴/۰۵/۳۰ · پایا گروهی", amount: 48000000, direction: TransactionDirection.debit),
        TransactionModel(icon: Icons.home_outlined, title: "اجارهٔ محل", subtitle: "۱۴۰۴/۰۵/۲۵", amount: 35000000, direction: TransactionDirection.debit),
      ],
    ),
    ProfileModel(
      id: "heir",
      badge: "و",
      name: "پروندهٔ ورثه — مرحوم رضایی",
      meta: "در انتظار تکمیل مدارک",
    ),
  ];
}
