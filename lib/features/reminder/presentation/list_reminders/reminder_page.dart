import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/shared/request_status.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/presentation/add_reminder/add_reminder_page.dart';
import 'package:reminders_app/features/reminder/presentation/list_reminders/reminder_bloc.dart';
import 'package:reminders_app/features/reminder/presentation/list_reminders/reminder_event.dart';
import 'package:reminders_app/features/reminder/presentation/list_reminders/reminder_state.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    return BlocProvider(
      create: (context) => getIt<RemindersBloc>()..add(GetRemindersEvent()),
      child: Builder(
        builder: (innerContext) {
          return buildRemindersPage(innerContext);
        },
      ),
    );
  }

  Scaffold buildRemindersPage(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReminderPage()),
          );

          if (added ?? false) {
            context.read<RemindersBloc>().add(GetRemindersEvent());
          }
        },
        style: IconButton.styleFrom(backgroundColor: Colors.amberAccent),
        icon: Icon(Icons.add, color: Colors.black),
      ),
      // appBar: AppBar(
      //   leading: Icon(Icons.abc),
      //   title: Text(
      //     "Reminders",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 28,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.blueGrey,
      //   // flexibleSpace: Image.asset(
      //   //   'assets/images/gradient.png',
      //   //   repeat: ImageRepeat.repeat,
      //   // ),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("RemindMe"),
            pinned: true,
            expandedHeight: 130,
            floating: true,
            flexibleSpace: Text(''),
          ),
          BlocBuilder<RemindersBloc, RemindersState>(
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
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: buildListTile(state.reminders![index]),
                    );
                  }, childCount: state.reminders?.length ?? 0),
                );
              }

              return SliverToBoxAdapter(child: Text("Unknown error"));
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(ReminderModel reminder) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Text(reminder.id.toString()),
      title: Text(reminder.title),
      subtitle: Text(
        '${reminder.time.toString()}, ${reminder.reminderDays.toString()}',
      ),
    );
  }
}


                  // padding: EdgeInsets.all(6),
                  // itemBuilder: (context, index) {
                  //   state.reminders?.sort((a, b) => a.time.compareTo(b.time));
                  //   return Padding(
                  //     padding: EdgeInsetsGeometry.symmetric(vertical: 3),
                  //     child: buildListTile(state.reminders![index]),
                  //   );
                  // },
                  // itemCount: state.reminders?.length ?? 0,
                  // shrinkWrap: true,