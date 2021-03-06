import 'package:catcher/catcher_plugin.dart';
import 'package:never_forget/core/localization/localization_options.dart';

final debugOptions = CatcherOptions(
  SilentReportMode(),
  [
    ConsoleHandler(
      enableApplicationParameters: true,
      enableDeviceParameters: true,
      enableCustomParameters: true,
      enableStackTrace: true,
    )
  ],
);

final releaseOptions = CatcherOptions(
  DialogReportMode(),
  [
    EmailAutoHandler('smtp.gmail.com', 587, 'myflutterappserrorlogs@gmail.com',
        'Catcher', 'ggflutter123', ['myflutterappserrorlogs@gmail.com'],
        emailTitle: 'Never Forget'),
  ],
  localizationOptions: localizationOptions,
);
