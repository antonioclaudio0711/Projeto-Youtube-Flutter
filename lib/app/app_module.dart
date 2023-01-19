import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/modules/youtube_module/youtube_module.dart';
import 'package:youtube/general/routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          Routes.initialRoute,
          module: YoutubeModule(),
        )
      ];
}
