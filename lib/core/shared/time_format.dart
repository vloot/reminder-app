enum TimeFormat { h24, h12 }

const Map<TimeFormat, String> timePatterns = {
  TimeFormat.h12: 'h:mm a',
  TimeFormat.h24: 'HH:mm',
};

String dateFormatFor(TimeFormat format) {
  return timePatterns[format]!;
}
