import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/cart_manager.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/models/product_manager.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/screens/base/base_screen.dart';
import 'package:loja_virtual_pro/screens/cart/cart_screen.dart';
import 'package:loja_virtual_pro/screens/login/login_screen.dart';
import 'package:loja_virtual_pro/screens/product/product_screen.dart';
import 'package:loja_virtual_pro/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),

        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
            cartManager..updateUser(userManager),
        ),

      ],
      child: MaterialApp(
        title: 'Sua Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primaryColor: const Color.fromARGB(255, 4, 125, 141),

          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),

          appBarTheme: const AppBarTheme(
            elevation: 0
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()

              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()

                );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) =>
                      ProductScreen(
                          settings.arguments as Product
                      )

              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) =>
                      CartScreen()

              );

            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
          }
        },

      ),
    );

  }
}
