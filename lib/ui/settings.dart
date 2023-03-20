import 'package:flutter/material.dart';
import 'package:flutter_japan_v3/ui/main_page.dart';
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
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Cigarette detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: settings.showCigarette,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      ref
                          .read(settingsProvider.notifier)
                          .setShowCigarette(value);
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Cell phone detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: settings.showCellPhone,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      ref
                          .read(settingsProvider.notifier)
                          .setShowCellPhone(value);
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Mask detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: settings.showMask,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      ref.read(settingsProvider.notifier).setShowMask(value);
                    }),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Save changes",
                  style: TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }
}
