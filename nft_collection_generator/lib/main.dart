import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:nft_visor/core/dependency_injection.dart' as di;
import 'package:nft_visor/features/404/unknown_page.dart';
import 'package:nft_visor/features/collection/presentation/pages/collection_detail_page.dart';
import 'package:nft_visor/features/collection/presentation/pages/collections_home_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await di.setup();
  // usePathUrlStrategy();
  runApp(const MyApp());
}

void usePathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFT-Collection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == CollectionsHomePage.route) {
          return MaterialPageRoute(
            builder: (context) => const CollectionsHomePage(),
          );
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == CollectionDetailPage.name) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
            settings: RouteSettings(name: 'detail/$id'),
            builder: (context) => CollectionDetailPage(id: id),
          );
        }

        return MaterialPageRoute(builder: (context) => UnknownPage());
      },
    );
  }
}
