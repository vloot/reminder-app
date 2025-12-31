import 'package:flutter/material.dart';

class SettingsToggle<T> extends StatefulWidget {
  final String settingName;
  final T initValue;
  final Map<T, String> segmentsMap;
  final IconData iconData;
  final bool multiSelection;
  final bool emptySelection;
  // final void Function(T) onSelectionChanged;
  final ValueChanged<T> onSelectionChanged;

  const SettingsToggle({
    super.key,
    required this.settingName,
    required this.segmentsMap,
    required this.iconData,
    required this.onSelectionChanged,
    required this.initValue,
    this.multiSelection = false,
    this.emptySelection = false,
  });

  @override
  _SettingsToggleState createState() => _SettingsToggleState<T>();
}

class _SettingsToggleState<T> extends State<SettingsToggle<T>> {
  late List<ButtonSegment<T>> segments;
  late Set<T> _selection;

  @override
  void initState() {
    super.initState();
    _selection = <T>{widget.initValue};
    segments = getSegments();
  }

  @override
  void didUpdateWidget(covariant SettingsToggle<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      setState(() {
        _selection = <T>{widget.initValue};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.iconData),
      title: Text(widget.settingName),
      trailing: SegmentedButton<T>(
        multiSelectionEnabled: widget.multiSelection,
        emptySelectionAllowed: widget.emptySelection,
        showSelectedIcon: false,
        segments: segments,
        selected: _selection,
        onSelectionChanged: (Set<T> newSelection) {
          setState(() {
            _selection = newSelection;
          });
          widget.onSelectionChanged(_selection.first);
        },
      ),
    );
  }

  List<ButtonSegment<T>> getSegments() {
    final res = <ButtonSegment<T>>[];
    for (var key in widget.segmentsMap.keys) {
      res.add(
        ButtonSegment<T>(value: key, label: Text(widget.segmentsMap[key]!)),
      );
    }
    return res;
  }
}
