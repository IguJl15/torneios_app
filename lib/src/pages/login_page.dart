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

    if (currentSession != null) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      Future.delayed(Durations.extralong4, () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            isLoading = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SupaEmailAuth(
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
              content:
                  Text("Email de recuperação de senha enviado. Confira sua caixa de entrada."),
            ),
          );
        },
      ),
    );
  }
}
