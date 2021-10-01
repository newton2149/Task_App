import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:task_app/provider/authenticationService.dart';

class SettingsScreen extends StatelessWidget {
  static const routName = "/app-settings";
  static Color bgColour = Colors.blue.shade200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColour,
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: 'General',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Light/Dark',
                  leading: Icon(Icons.color_lens),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Phone Number',
                  leading: Icon(Icons.phone_android_outlined),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Email Id',
                  leading: Icon(Icons.email_outlined),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Sign Out',
                  leading: Icon(Icons.logout_outlined),
                  onPressed: (BuildContext context) {
                    Provider.of<AuthenticationService>(context, listen: false)
                  .signOut();
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Security',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Lock app in background',
                  leading: Icon(Icons.local_activity_outlined),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
                SettingsTile(
                  title: 'Change Password',
                  leading: Icon(Icons.password_outlined),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Misc',
              tiles: [
                SettingsTile(
                  title: 'Terms and Services',
                  leading: Icon(Icons.text_format_sharp),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
