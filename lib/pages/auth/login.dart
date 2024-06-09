import 'package:flutter/material.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import 'package:qrcode_app/routes/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(
        text: "daff@gmail.com");
    final TextEditingController passController = TextEditingController(
        text: "daff123");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  )
              ),
            ),
            const SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                    AuthEventLogin(emailController.text, passController.text)
                );
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  )
              ),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if(state is AuthStateLogin){
                    context.goNamed(Routes.home);
                  } else if(state is AuthStateError){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if(state is AuthStateLoading){
                    return const Text("Loading");
                  }else {
                    return const Text("Login");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
