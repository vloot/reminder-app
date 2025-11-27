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
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/weekday_box_page.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  Weekday today = Weekday.monday;

  @override
  void initState() {
    super.initState();
    today = Weekday.values[DateTime.now().weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<RemindersListBloc>()
                ..add(GetRemindersDayListEvent({today})),
        ),
        BlocProvider(create: (_) => SelectedDaysCubit(today)),
        BlocProvider(create: (_) => ReminderModeCubit()),
      ],

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
          buildAppBar(parentContext),
          buildListMenu(parentContext),
          buildBloc(parentContext),
          // add some space at the bottom
          SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  SliverToBoxAdapter buildListMenu(BuildContext parentContext) {
    return SliverToBoxAdapter(
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
                                description: newReminder.description ?? '',
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
    );
  }

  Widget buildAppBar(BuildContext parentContext) {
    final size = MediaQuery.of(parentContext).size;
    return SliverAppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'RemindMe',
          style: TextStyle(
            color: currentTheme.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 40,
      expandedHeight: size.height * 0.26,
      collapsedHeight: 50,
      pinned: true,
      flexibleSpace: buildFlexibleSpace(parentContext, size),
      backgroundColor: currentTheme.primaryColor,
    );
  }

  FlexibleSpaceBar buildFlexibleSpace(BuildContext parentContext, Size size) {
    return FlexibleSpaceBar(
      background: Material(
        color: currentTheme.backgroundColor,
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: size.height * 0.2),
              decoration: BoxDecoration(
                color: currentTheme.primaryColor,
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: currentTheme.primaryColor,
                    width: 2,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: currentTheme.backgroundColor,
                  ),
                  constraints: BoxConstraints.expand(
                    height: size.height * 0.12,
                  ),
                ),
                WeekdayBox(today),
              ],
            ),
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
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return BlocProvider(
                create: (context) => getIt<ReminderBloc>(),
                child: BlocListener<ReminderBloc, ReminderState>(
                  listener: (context, state) {
                    bool update = false;
                    if (state is ReminderSuccess || state is ReminderEdited) {
                      Navigator.pop(context);
                      update = true;
                    } else if (state is ReminderDeleted) {
                      update = true;
                    }

                    if (update) {
                      parentContext.read<RemindersListBloc>().add(
                        GetRemindersListEvent(),
                      );
                    }
                  },
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (innerContext, innderState) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ),
                        child: ReminderListTile(
                          state.reminders![index],
                          context,
                          innerContext,
                        ),
                      );
                    },
                  ),
                ),
              );
            }, childCount: state.reminders?.length ?? 0),
          );
        }

        return SliverToBoxAdapter(child: Text("Unknown error"));
      },
    );
  }
}
