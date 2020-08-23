import 'package:app/pages/page_home/room_setting.dart';
import 'package:app/pages/page_study_room/page_study_room.dart';
import 'package:app/pages/signup_login/page_signup_login.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'main.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String, Object);

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument a RegEx match if that is included
  /// in the pattern.
  ///
  /// ```dart
  /// Path(
  ///   'r'^/demo/([\w-]+)$',
  ///   (context, matches) => Page(argument: match),
  /// )
  /// ```
  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path(
      r'^' + PageStudyRoom.defaultRoute,
      (context, match, args) => PageStudyRoom(args: args)
    ),
    Path(
      r'^' + SignupLoginPage.defaultRoute,
          (context, match, args) => SignupLoginPage(),
    ),
    Path(
      r'^' + Constants.ROUTE_ROOM_SETTING,
          (context, match, args) => RoomSettingPage(),
    ),
    Path(
      r'^/',
          (context, match, args) => MainPage(title: 'Yifan'),
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final firstMatch = regExpPattern.firstMatch(settings.name);
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match, settings.arguments),
          settings: settings,
        );
      }
    }

// If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
