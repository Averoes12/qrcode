import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:qrcode_app/main.dart';
import 'package:qrcode_app/pages/auth/login.dart';
import 'package:qrcode_app/pages/error.dart';
import 'package:qrcode_app/pages/freetogame/game.dart';
import 'package:qrcode_app/pages/home.dart';
import 'package:qrcode_app/pages/product/add_product.dart';
import 'package:qrcode_app/pages/product/detail_product.dart';
import 'package:qrcode_app/pages/product/list_product.dart';
import 'package:qrcode_app/pages/settings.dart';
export 'package:go_router/go_router.dart';

part 'route_name.dart';

final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser == null){
      return "/login";
    } else {
      return null;
    }

  },
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
      path: "/",
      name: Routes.home,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
            path: "setting",
            name: Routes.setting,
            builder: (context, state) => const SettingPage()
        ),
        GoRoute(
          path: "products",
          name: Routes.product,
          builder: (context, state) => const ProductPage(),
          routes: [
            GoRoute(
                path: "detail_product",
                name: Routes.detailProduct,
                builder: (context, state) {
                  return DetailProductPage(product: state.uri.queryParameters,);
                }
            ),
          ]
        ),
        GoRoute(
            path: "add_product",
            name: Routes.addProduct,
            builder: (context, state) => const AddProductPage()
        ),
        GoRoute(
            path: "games",
            name: Routes.games,
            builder: (context, state) => const GamePage()
        ),
      ]
    ),
    GoRoute(
        path: "/login",
        name: Routes.login,
        builder: (context, state) => const LoginPage()
    ),
  ]
);