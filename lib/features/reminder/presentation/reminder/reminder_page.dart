import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_state.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_state.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/reminder_list_tile.dart';
import 'package:reminders_app/features/reminder_form/reminder_form.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/weekday_box.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<RemindersListBloc>()..add(GetRemindersListEvent()),
      child: Builder(
        builder: (innerContext) {
          return buildRemindersPage(innerContext);
        },
      ),
    );
  }

  Scaffold buildRemindersPage(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          buildAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () async {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: parentContext,
                    builder: (builderContext) {
                      return BlocProvider(
                        create: (builderContext) => getIt<ReminderBloc>(),
                        child: Builder(
                          builder: (innerContext) {
                            return BlocListener<ReminderBloc, ReminderState>(
                              listener: (context, state) {
                                if (state is ReminderSuccess) {
                                  Navigator.pop(innerContext);
                                  parentContext.read<RemindersListBloc>().add(
                                    GetRemindersListEvent(),
                                  );
                                }
                                // TODO cover fail state here
                              },
                              child: ReminderForm(
                                ReminderFormType.add,
                                'Add',
                                innerContext,
                                (newReminder) async {
                                  innerContext.read<ReminderBloc>().add(
                                    AddReminderEvent(
                                      title: newReminder.title,
                                      description:
                                          newReminder.description ?? '',
                                      time: newReminder.time,
                                      reminderDays: newReminder.reminderDays,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add reminder',
                        style: TextStyle(
                          color: currentTheme.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.add,
                        color: currentTheme.textColor,
                        fontWeight: FontWeight.bold,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          buildBloc(parentContext),
          // add some space at the bottom
          SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      title: Text(
        'RemindMe',
        style: TextStyle(
          color: currentTheme.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      toolbarHeight: 40,
      expandedHeight: 170,
      collapsedHeight: 50,
      pinned: true,
      flexibleSpace: buildFlexibleSpace(),
      backgroundColor: currentTheme.primaryColor,
    );
  }

  FlexibleSpaceBar buildFlexibleSpace() {
    return FlexibleSpaceBar(
      background: Material(
        color: currentTheme.backgroundColor,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 200),
              decoration: BoxDecoration(
                color: currentTheme.primaryColor,
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.transparent, width: 2),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            WeekdayBox(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<RemindersListBloc, RemindersListState> buildBloc(
    BuildContext parentContext,
  ) {
    return BlocBuilder<RemindersListBloc, RemindersListState>(
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == RequestStatus.error) {
          return Center(
            child: SliverToBoxAdapter(
              child: Text(state.errorMessage ?? 'Unknown error'),
            ),
          );
        } else if (state.status == RequestStatus.done) {
          final today = DateTime.now().weekday - 1;
          final todayReminders = state.reminders
              ?.where(
                (element) =>
                    element.reminderDays.contains(Weekday.values[today]),
              )
              .toList();
          todayReminders?.clear();
          todayReminders?.addAll(state.reminders ?? {});
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return BlocProvider(
                create: (context) => getIt<ReminderBloc>(),
                child: BlocListener<ReminderBloc, ReminderState>(
                  listener: (context, state) {
                    if (state is ReminderSuccess ||
                        state is ReminderDeleted ||
                        state is ReminderEdited) {
                      parentContext.read<RemindersListBloc>().add(
                        GetRemindersListEvent(),
                      );
                      // Navigator.pop(context);
                    }
                  },
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (innderContext, innderState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: ReminderListTile(
                          todayReminders![index],
                          context,
                          innderContext,
                        ),
                      );
                    },
                  ),
                ),
              );
            }, childCount: todayReminders?.length ?? 0),
          );
        }

        return SliverToBoxAdapter(child: Text("Unknown error"));
      },
    );
  }
}
