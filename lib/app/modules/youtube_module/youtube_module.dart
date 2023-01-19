import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/youtube_module/presenter/screens/initial_screen.dart';
import 'package:youtube/general/routes.dart';

class YoutubeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Routes.initialRoute,
          child: (context, args) => const InitialScreen(),
        )
      ];
}
