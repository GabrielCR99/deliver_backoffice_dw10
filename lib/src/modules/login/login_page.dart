import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/app_colors.dart';
import '../../core/ui/styles/text_styles.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with Loader<LoginPage>, Messages<LoginPage> {
  late final _controller = context.read<LoginController>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final ReactionDisposer _disposer;

  void _onPressedLogin() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      _controller.login(
        email: _emailEC.text,
        password: _passwordEC.text,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _disposer = reaction((_) => _controller.loginStatus, (status) {
      switch (status) {
        case LoginStateStatus.error:
          hideLoader();
          showError(_controller.errorMessage ?? 'Erro ao realizar login');
        case LoginStateStatus.success:
          hideLoader();
          Modular.to.navigate('/');
        case LoginStateStatus.initial:
          break;
        case LoginStateStatus.loading:
          showLoader();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenShortesSide = context.shortestSide;
    final screenWidth = context.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/lanche.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: screenShortesSide * 0.5,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: context.percentHeight(0.1)),
              width: screenShortesSide * 0.5,
              child: Image.asset('assets/images/logo.png'),
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                constraints: BoxConstraints(
                  maxWidth:
                      context.percentWidth(screenWidth < 1300 ? 0.7 : 0.3),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(height: 20),
                        FittedBox(
                          child: Text(
                            'Login',
                            style: context.textStyles.titleText,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailEC,
                          decoration:
                              const InputDecoration(label: Text('E-mail')),
                          onFieldSubmitted: (_) => _onPressedLogin(),
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail obrigatório'),
                            Validatorless.email('E-mail inválido'),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordEC,
                          decoration:
                              const InputDecoration(label: Text('Senha')),
                          onFieldSubmitted: (_) => _onPressedLogin(),
                          validator:
                              Validatorless.required('Senha obrigatória'),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _onPressedLogin,
                            child: const Text(
                              'Entrar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.appColors.black,
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _disposer();
    super.dispose();
  }
}
