import 'package:flutter/material.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/settings/presentation/settings_page.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/weekday_box.dart';

class ReminderAppBar extends StatefulWidget {
  final AppSettingsState settingsState;
  final Weekday today;

  const ReminderAppBar({
    super.key,
    required this.settingsState,
    required this.today,
  });

  @override
  _ReminderAppBarState createState() => _ReminderAppBarState();
}

class _ReminderAppBarState extends State<ReminderAppBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'RemindMe',
                  style: TextStyle(
                    color: Color(widget.settingsState.settings.secondaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SettingsPage(widget.settingsState),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings_sharp,
                    color: Color(widget.settingsState.settings.secondaryColor),
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      centerTitle: true,
      toolbarHeight: 40,
      expandedHeight: size.height * 0.26,
      collapsedHeight: 50,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Material(
          color: Color(widget.settingsState.settings.backgroundColor),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                constraints: BoxConstraints.expand(height: size.height * 0.2),
                decoration: BoxDecoration(
                  color: Color(widget.settingsState.settings.primaryColor),
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: Color(widget.settingsState.settings.primaryColor),
                      width: 2,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Color(settingsState.settings.backgroundColor),
                    ),
                    constraints: BoxConstraints.expand(
                      height: size.height * 0.12,
                    ),
                  ),
                  WeekdayBox(widget.today, widget.settingsState),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(widget.settingsState.settings.primaryColor),
    );
  }
}
