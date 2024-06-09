import 'package:flutter/material.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import '../routes/router.dart';
import 'bloc/theme/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              print("State $state");
              if(state is ThemeStateDark){
                return IconButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ThemeEventLight());
                    },
                    icon: const Icon(Icons.light_mode));
              } else {
                return IconButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ThemeEventDark());
                    },
                    icon: const Icon(Icons.dark_mode));
              }
            },
          )
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20
          ),
          itemBuilder: (context, index) {
            return gridItem(context, index);
          },
        ),),
      floatingActionButton: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLogout) {
            context.goNamed(Routes.login);
          }
        },
        builder: (context, state) {
          if (state is AuthStateLoading) {
            return const CircularProgressIndicator();
          } else {
            return FloatingActionButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                    AuthEventLogout()
                );
              },
              child: const Icon(Icons.logout),
            );
          }
        },
      ),
    );
  }

  Material gridItem(BuildContext context, int index) {
    late String title;
    late IconData icon;
    late VoidCallback onTap;

    switch(index){
      case 0:
        title = "Add Product";
        icon = Icons.post_add_outlined;
        onTap = (){
          context.goNamed(Routes.addProduct);
        };
        break;
      case 1:
        title = "Products";
        icon = Icons.list_alt_outlined;
        onTap = (){
          context.goNamed(Routes.product);
        };
        break;
      case 2:
        title = "QR Code";
        icon = Icons.qr_code;
        onTap = (){
          context.goNamed(Routes.games);
        };
        break;
      case 3:
        title = "Catalog";
        icon = Icons.document_scanner_outlined;
        onTap = (){};
        break;
    }

    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              color: Theme.of(context).primaryColor.withOpacity(0.8)
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(height: 8.0,),
                Text(title,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
