import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final currentSession = Supabase.instance.client.auth.currentSession;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Durations.extralong4, () {
        if (currentSession != null) {
          Navigator.pushReplacementNamed(context, '/');
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bem vindo(a)",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(height: 2.5),
                ),
                const CircularProgressIndicator(),
              ],
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bem vindo(a)", style: Theme.of(context).textTheme.headlineMedium!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                  child: SupaEmailAuth(
                    redirectTo: '/',
                    onError: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    },
                    onSignInComplete: (v) {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    onSignUpComplete: (v) {
                      if (Supabase.instance.client.auth.currentSession != null) {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    localization: const SupaEmailAuthLocalization(
                      enterEmail: 'Email',
                      enterPassword: 'Senha',
                      validEmailError: 'Insira um email válido',
                      passwordLengthError: 'Insira uma senha com no mínimo 6 caracteres',
                      backToSignIn: 'Voltar para o login',
                      haveAccount: 'Já possui uma conta',
                      dontHaveAccount: 'Não possui uma conta',
                      forgotPassword: 'Esqueceu sua senha?',
                      signIn: 'Entrar',
                      signUp: 'Cadastrar',
                      unexpectedError: 'Erro inesperado',
                      passwordResetSent: 'Email de recuperação de senha enviado',
                    ),
                    onPasswordResetEmailSent: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Email de recuperação de senha enviado. Confira sua caixa de entrada."),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
