import 'package:app/data/services/secure_storage.dart';
import 'package:app/providers/languages_provider.dart';
import 'package:app/providers/locale_provider.dart';
import 'package:app/ui/core/themes/app_colors.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class LanguageSelectorDialog extends StatelessWidget {
  const LanguageSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.select<LocaleProvider, Locale>(
      (value) => value.locale,
    );

    final supportedLocales = context.select<LocaleProvider, List<Locale>>(
      (value) => value.supportedLocales,
    );

    final onLocaleChange = context.read<LocaleProvider>().setLocale;

    final secureStorage = context.read<SecureStorageImpl>();

    final languagesProvider = context.read<LanguagesProvider>();

    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text('account.options.language'.i18n()),
      content: DropdownButton<String>(
        value: locale.toLanguageTag(),
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (value) async {
          final split = value!.split('-');


          onLocaleChange(Locale(split[0], split[1]));
          await secureStorage.write('locale', value.toString());
          await languagesProvider.getAllLanguages();
        },
        items:
            supportedLocales
                .map(
                  (e) => DropdownMenuItem(
                    value: e.toLanguageTag(),
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          e.countryCode!,
                          height: 20,
                          width: 30,
                          shape: const RoundedRectangle(4),
                        ),
                        const SizedBox(width: 10),
                        Text(e.toLanguageTag().toUpperCase()),
                      ],
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
