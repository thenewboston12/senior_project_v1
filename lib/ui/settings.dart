import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_japan_v3/ui/main_page.dart';
import 'package:flutter_japan_v3/ui/navbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsState {
  bool showCigarette = true;
  bool showMask = true;
  bool showCellPhone = true;

  SettingsState copyWith({
    bool? showCigarette,
    bool? showMask,
    bool? showCellPhone,
  }) {
    return SettingsState()
      ..showCigarette = showCigarette ?? this.showCigarette
      ..showMask = showMask ?? this.showMask
      ..showCellPhone = showCellPhone ?? this.showCellPhone;
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  void setShowCigarette(bool value) {
    state = state.copyWith(showCigarette: value);
  }

  void setShowMask(bool value) {
    state = state.copyWith(showMask: value);
  }

  void setShowCellPhone(bool value) {
    state = state.copyWith(showCellPhone: value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
    (ref) => SettingsNotifier());

class Settings extends HookConsumerWidget {
  const Settings({Key? key}) : super(key: key);
  static String routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                        title: "Cigarette Detection",
                        icon: CupertinoIcons.smoke,
                        trailing:
                        CupertinoSwitch(value: settings.showCigarette, onChanged: (bool value) {
                          ref
                              .read(settingsProvider.notifier)
                              .setShowCigarette(value);
                        })),
                    _CustomListTile(
                        title: "Cell phone Detection",
                        icon: CupertinoIcons.device_phone_portrait,
                        trailing:
                        CupertinoSwitch(value: settings.showCellPhone, onChanged: (bool value) {
                          ref
                              .read(settingsProvider.notifier)
                              .setShowCellPhone(value);
                        })),
                    _CustomListTile(
                        title: "Face Mask Detection",
                        icon: CupertinoIcons.shield,
                        trailing:
                        CupertinoSwitch(value: settings.showMask, onChanged: (bool value) {
                          ref
                              .read(settingsProvider.notifier)
                              .setShowMask(value);
                        })),
                  ],
                ),
                const _SingleSection(
                  title: "Organization",
                  children: [
                    _CustomListTile(
                        title: "Profile",
                        icon: Icons.manage_accounts_outlined),
                    _CustomListTile(
                      title: "Other",
                      icon: Icons.more_horiz,
                    )
                  ],
                ),
                const _SingleSection(
                  title: "",
                  children: [
                    _CustomListTile(
                        title: "Help & Feedback", icon: CupertinoIcons.question_circle),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBarFb1(),
      ),
    );
  }
}


class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
            Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}