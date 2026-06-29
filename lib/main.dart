import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:wayves_wiki/bloc/search_bloc.dart';
import 'package:wayves_wiki/constants/colors.dart';
import 'package:wayves_wiki/themes/theme_manager.dart';
import 'package:wayves_wiki/widgets/sectioned_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final routerDelegate = BeamerDelegate(
    initialPath: '/getting-started/installation',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) =>
            const BeamPage(key: ValueKey('*'), child: SectionedScreen()),
      },
    ).call,
  );

  final theme = ThemeManager.getTheme(
    themeMode: null,
    primaryColor: primaryColor,
    secondaryColor: secondaryColor,
    tertiaryColor: tertiaryColor,
  );

  @override
  Widget build(BuildContext context) {
    final lightTheme = theme[0].copyWith(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
          TargetPlatform.fuchsia: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(
            backgroundColor: theme[0].colorScheme.primaryContainer,
          ),
        },
      ),
    );

    final darkTheme = theme[1].copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );

    return MultiBlocProvider(
      providers: [BlocProvider<SearchBloc>(create: (context) => SearchBloc())],
      child: MaterialApp.router(
        title: 'WayVes Wiki',
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,

        theme: _themeMode == ThemeMode.light ? lightTheme : darkTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(title: const Text(""), elevation: 2),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Plugins",
                  style: TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
                Text(
                  "Development",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Development",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Text(
                  "Welcome to WayVes! Create stunning, pixel-perfect Visualisers!",
                ),
              ],
            ),

            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SectionedScreen(),
                ),
              ),
              child: const Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
