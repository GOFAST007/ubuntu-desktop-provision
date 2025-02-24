import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ubuntu_provision/flavor.dart';
import 'package:ubuntu_provision/services.dart';
import 'package:ubuntu_provision/src/locale/locale_l10n.dart';
import 'package:ubuntu_provision/src/locale/locale_model.dart';
import 'package:ubuntu_provision/widgets.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:ubuntu_widgets/ubuntu_widgets.dart';
import 'package:ubuntu_wizard/ubuntu_wizard.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class LocalePage extends ConsumerWidget {
  const LocalePage({super.key});

  static Future<bool> load(BuildContext context, WidgetRef ref) {
    final model = ref.read(localeModelProvider);
    return model.init().then((_) => model.playWelcomeSound()).then((_) => true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = ref.watch(flavorProvider);
    final model = ref.watch(localeModelProvider);
    final lang = LocaleLocalizations.of(context);
    return WizardPage(
      title: YaruWindowTitleBar(
        title: Text(lang.localePageTitle(flavor.name)),
      ),
      content: FractionallySizedBox(
        widthFactor: 0.5,
        child: Column(
          children: [
            const SizedBox(height: kWizardSpacing / 2),
            const MascotAvatar(),
            const SizedBox(height: kWizardSpacing),
            Text(lang.localeHeader),
            const SizedBox(height: kWizardSpacing / 2),
            Expanded(
              child: ListWidget.builder(
                selectedIndex: model.selectedIndex,
                itemCount: model.languageCount,
                itemBuilder: (context, index) => ListTile(
                  key: ValueKey(index),
                  title: Text(model.language(index)),
                  selected: index == model.selectedIndex,
                  onTap: () => model.selectLanguage(index),
                ),
                onKeySearch: (value) {
                  final index = model.searchLanguage(value);
                  if (index != -1) {
                    model.selectLanguage(index);
                  }
                },
              ),
            ),
            const SizedBox(height: kWizardSpacing),
          ],
        ),
      ),
      bottomBar: WizardBar(
        leading: WizardButton.previous(context),
        trailing: [
          WizardButton.next(
            context,
            onNext: () async {
              final locale = model.locale(model.selectedIndex);
              await model.applyLocale(locale);
              await tryGetService<TelemetryService>()
                  ?.addMetric('Language', locale.languageCode);
            },
          ),
        ],
      ),
    );
  }
}
