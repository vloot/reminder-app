import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/core/themes/app_themes.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/presentation/form_launcher.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_state.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_event.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_list_state.dart';
import 'package:reminders_app/features/reminder/presentation/widgets/reminder_list_tile.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/reminder_mode_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/cubit/selected_days_cubit.dart';
import 'package:reminders_app/features/weekday_box/presentation/widgets/weekday_box.dart';

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
          create: (_) =>
              getIt<RemindersListBloc>()
                ..add(GetRemindersDayListEvent({today})),
        ),
        BlocProvider(create: (_) => getIt<ReminderBloc>()),
        BlocProvider(create: (_) => SelectedDaysCubit(today)),
        BlocProvider(create: (_) => ReminderModeCubit()),
      ],

      child: Builder(
        builder: (context) {
          return buildRemindersPage(context);
        },
      ),
    );
  }

  Scaffold buildRemindersPage(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          buildAppBar(context),
          buildListHeader(context),
          buildBloc(context),
          // add some space at the bottom
          SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  SliverToBoxAdapter buildListHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: TextButton(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () async {
            showReminderForm(
              context,
              ReminderFormType.add,
              'Add',
              submitCallback: (reminderModel) async {
                context.read<ReminderBloc>().add(
                  AddReminderEvent(
                    title: reminderModel.title,
                    description: reminderModel.description ?? '',
                    time: reminderModel.time,
                    reminderDays: reminderModel.reminderDays,
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

  Widget buildBloc(BuildContext parentContext) {
    return BlocListener(
      bloc: parentContext.read<ReminderBloc>(),
      listener: (_, state) {
        bool reloadList = false;
        if (state is ReminderSuccess || state is ReminderEdited) {
          reloadList = true;
        } else if (state is ReminderDeleted) {
          reloadList = true;
        } else if (state is ReminderLoading) {
          Navigator.of(parentContext, rootNavigator: true).pop();
        }

        if (reloadList) {
          parentContext.read<RemindersListBloc>().add(GetRemindersListEvent());
        }
      },
      child: BlocBuilder<RemindersListBloc, RemindersListState>(
        builder: (_, state) {
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
              delegate: SliverChildBuilderDelegate((sliverContext, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ReminderListTile(
                    state.reminders![index],
                    sliverContext,
                  ),
                );
              }, childCount: state.reminders?.length ?? 0),
            );
          }

          return SliverToBoxAdapter(child: Text("Unknown error"));
        },
      ),
    );
  }
}
