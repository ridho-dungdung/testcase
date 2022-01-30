import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/models/user.dart';
import 'package:majootestcase/register/register.dart';
import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // color: colorBlue,
                    ),
                  ),
                  Text(
                    'Silahkan login terlebih dahulu',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // SizedBox(
                  //   height: 9,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _form(),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                      text: 'Login',
                      onPressed: handleLogin,
                      height: 100,
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                ]
              ),
            ),
            _register(),
          ],
        ),
      ),
    );
  }

  void handleLogin() async {
    final _email = _emailController.value;
    final _password = _passwordController.value;
    if (formKey.currentState?.validate() == true &&
      _email != null && _password != null &&
      _email == 'majoo@gmail.com' && _password == '123456'
    ) {
      showTopSnackBar(context,
        CustomSnackBar.success(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          icon: Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 80,),
          textStyle: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          message: "Yeay.. kamu berhasil login.\n Selamat Menonton",
        ),
      );
      AuthBlocCubit authBlocCubit = AuthBlocCubit();
      User user = User(
        email: _email,
        password: _password,
      );
      authBlocCubit?.login_user(user);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeBlocCubit()..fetching_data(),
            child: HomeBlocScreen(),
          ),
        ),
      );
    } else if(_email == null && _password == null) showTopSnackBar(context,
      CustomSnackBar.info(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        icon: Icon(
          Icons.info_outline_rounded, 
          color: Colors.blue, 
          size: 80,),
        textStyle: TextStyle(
          color: Colors.blue, 
          fontSize: 16,
          fontWeight: FontWeight.bold),
        message: "Oops.. Form ini harus terisi semua",
      ),
    );
    else if(!formKey.currentState?.validate()) showTopSnackBar(context,
      CustomSnackBar.info(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        icon: Icon(
          Icons.info_outline_rounded,
          color: Colors.blue,
          size: 80,),
        textStyle: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        message: "   Oops.. sepertinya ada Form \n belum terisi dengan benar",
      ),
    );
    else showTopSnackBar(context,
      CustomSnackBar.error(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        icon: Icon(
          Icons.highlight_remove_rounded,
          color: Colors.red,
          size: 80,),
        textStyle: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        message: "  Oops.. Maaf anda gagal login",
      ),
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            context: context,
            controller: _emailController,
            isEmail: true,
            hint: 'Example@123.com',
            label: 'Email',
            validator: (val) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
            },
          ),
          CustomTextFormField(
            context: context,
            label: 'Password',
            hint: 'password',
            controller: _passwordController,
            isObscureText: _isObscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword = !_isObscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }


}
