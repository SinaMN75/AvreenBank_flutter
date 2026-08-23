import "package:avreen_bank/model/account_model.dart";
import "package:avreen_bank/model/card_model.dart";
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
      short: "شخصی",
      meta: "۳ حساب · ۳ کارت",
      accounts: <AccountModel>[
        AccountModel(badge: "ج", title: "حساب جاری", number: "120-8145672-001", balance: 48250000, chips: <String>["حساب اصلی", "برداشت آزاد"]),
        AccountModel(badge: "ک", title: "سپرده کوتاه‌مدت", number: "120-9932104-002", balance: 132400000, chips: <String>["سود ماهانه"]),
        AccountModel(badge: "ب", title: "سپرده بلندمدت یک‌ساله", number: "120-4567890-005", balance: 620000000, chips: <String>["مسدود تا ۱۴۰۵/۰۳"]),
      ],
      cards: <CardModel>[
        CardModel(
          id: "p-main",
          label: "کارت اصلی",
          title: "کارت اصلی — مریم رضایی",
          pan: "6104 •••• •••• 3419",
          expiry: "07/29",
          balance: 48250000,
          connectedAccount: "حساب جاری ۱۲۰-۸۱۴۵۶۷۲-۰۰۱",
          transactions: <TransactionModel>[
            TransactionModel(icon: Icons.point_of_sale, title: "کافه ونک", subtitle: "امروز ۱۱:۲۰ · POS", amount: 185000, direction: TransactionDirection.debit),
            TransactionModel(icon: Icons.north_east, title: "انتقال به سارا کریمی", subtitle: "امروز ۱۰:۰۲ · کارت به کارت", amount: 1200000, direction: TransactionDirection.debit),
            TransactionModel(icon: Icons.south_west, title: "واریز از سپرده کوتاه‌مدت", subtitle: "دیروز ۱۹:۴۵", amount: 5000000, direction: TransactionDirection.credit),
            TransactionModel(icon: Icons.receipt_long_outlined, title: "قبض موبایل", subtitle: "۱۴۰۴/۰۵/۲۹", amount: 320000, direction: TransactionDirection.debit),
          ],
        ),
        CardModel(
          id: "p-save",
          label: "کارت پس‌انداز",
          title: "کارت پس‌انداز",
          pan: "6104 •••• •••• 8872",
          expiry: "02/28",
          balance: 132400000,
          connectedAccount: "سپرده کوتاه‌مدت ۱۲۰-۹۹۳۲۱۰۴-۰۰۲",
          transactions: <TransactionModel>[
            TransactionModel(icon: Icons.south_west, title: "واریز سود ماهانه", subtitle: "۱۴۰۴/۰۵/۲۸", amount: 1840000, direction: TransactionDirection.credit),
            TransactionModel(icon: Icons.north_east, title: "برداشت به حساب جاری", subtitle: "۱۴۰۴/۰۵/۲۰", amount: 5000000, direction: TransactionDirection.debit),
          ],
        ),
        CardModel(
          id: "p-gift",
          label: "کارت هدیه",
          title: "کارت هدیه",
          pan: "6104 •••• •••• 1250",
          expiry: "11/26",
          balance: 2000000,
          connectedAccount: "بدون حساب متصل",
          status: CardStatus.expiringSoon,
        ),
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
      short: "کسب‌وکار",
      meta: "۲ حساب · ۱ کارت",
      accounts: <AccountModel>[
        AccountModel(badge: "ت", title: "حساب تجاری کافه ونک", number: "120-3311998-010", balance: 214700000, chips: <String>["درگاه پرداخت متصل", "تسویه روزانه"]),
        AccountModel(badge: "م", title: "حساب مالیات و بیمه", number: "120-7788221-011", balance: 36900000, chips: <String>["برداشت با تأیید دو نفره"]),
      ],
      cards: <CardModel>[
        CardModel(
          id: "b-main",
          label: "کارت تجاری",
          title: "کارت تجاری کافه ونک",
          pan: "6104 •••• •••• 5502",
          expiry: "05/30",
          balance: 214700000,
          connectedAccount: "حساب تجاری ۱۲۰-۳۳۱۱۹۹۸-۰۱۰",
          transactions: <TransactionModel>[
            TransactionModel(icon: Icons.point_of_sale, title: "خرید لوازم مصرفی", subtitle: "امروز ۰۹:۵۰ · POS", amount: 2450000, direction: TransactionDirection.debit),
            TransactionModel(icon: Icons.south_west, title: "واریز از درگاه", subtitle: "دیروز ۲۳:۵۹", amount: 18420000, direction: TransactionDirection.credit),
          ],
        ),
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
      short: "ورثه",
      meta: "در انتظار تکمیل مدارک",
    ),
  ];
}
