import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_state.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_state.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/confirmation.dart';
import 'package:reminders_app/features/reminder_form/reminder_form.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/weekday_box/presentation/weekday_box.dart';

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
                        child: buildListTile(
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

  Widget buildListTile(
    ReminderModel reminder,
    BuildContext buildContext,
    BuildContext innerContext,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: currentTheme.secondaryColor,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Theme(
          data: Theme.of(buildContext).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ExpansionTile(
            initiallyExpanded: false,
            shape: const Border(),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check_circle,
                size: 30,
                color: currentTheme.primaryColorAccent,
              ),
            ),
            title: Text(reminder.title),
            trailing: Text(
              '${reminder.time.hour}:${(reminder.time.minute).toString().padLeft(2, '0')}',
              style: TextStyle(color: currentTheme.textColor, fontSize: 14),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      reminder.description ?? '',
                      style: TextStyle(
                        color: currentTheme.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: buildContext,
                              showDragHandle: true,
                              builder: (context) {
                                return ReminderForm(
                                  ReminderFormType.edit,
                                  'Editing',
                                  buildContext,
                                  (newReminder) {
                                    innerContext.read<ReminderBloc>().add(
                                      EditReminderEvent(
                                        id: newReminder.id!,
                                        title: newReminder.title,
                                        description:
                                            newReminder.description ?? '',
                                        time: newReminder.time,
                                        reminderDays: newReminder.reminderDays,
                                      ),
                                    );
                                  },
                                  reminderModel: reminder,
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit_note_rounded),
                          color: Colors.green,
                        ),
                        IconButton(
                          onPressed: () async {
                            print(1);
                            GestureDetector(
                              onTapDown: (details) {
                                print('qwe');
                                final tapPosition = details.globalPosition;
                                showMenu(
                                  // deletion
                                  position: RelativeRect.fromLTRB(
                                    tapPosition.dx,
                                    tapPosition.dy,
                                    0,
                                    0,
                                  ), // position near tap
                                  context: buildContext,
                                  items: [
                                    PopupMenuItem(
                                      child: Text("Delete?"),
                                      value: true,
                                    ),
                                  ],
                                  // builder: (context) {
                                  //   return TextButton(
                                  //     onPressed: () => {},
                                  //     child: Text('data'),
                                  //   );
                                  //   // return Confirmation(
                                  //   //   () async {
                                  //   //     // BlocListener()
                                  //   //     print('confirm');
                                  //   //     innerContext.read<ReminderBloc>().add(
                                  //   //       DeleteReminderEvent(reminder: reminder),
                                  //   //     );
                                  //   //     print('after event');
                                  //   //     buildContext.read<RemindersListBloc>().add(
                                  //   //       GetRemindersListEvent(),
                                  //   //     );
                                  //   //   },
                                  //   //   () async {
                                  //   //     print('cancel');
                                  //   //   },
                                  //   // );
                                  // },
                                );
                              },
                              child: Icon(Icons.delete, color: Colors.blue),
                            );
                          },
                          color: Colors.redAccent,
                          icon: Icon(Icons.delete_outline_sharp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
