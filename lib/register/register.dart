import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/common/widget/text_form_field.dart';
import 'package:majootestcase/db/datebase.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _emailController = TextController();
  final _passwordController = TextController();
  final _usernameController = TextController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Register',
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
            SizedBox(
              height: 9,
            ),
            _form(),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              text: 'Register',
              onPressed: handleRegister,
              height: 100,
            ),
          ],
        ),
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
            controller: _usernameController,
            hint: 'username',
            label: 'UserName',
            suffixIcon: IconButton(
              icon: Icon( _isObscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined
              ),
              onPressed: () {
                setState(() {
                  _isObscurePassword =! _isObscurePassword;
                });
              },
            ),
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

  void handleRegister() async {
    final dbHelper = DatabaseHelper.instance;
    Map<String, dynamic> row = {
      DatabaseHelper.columnUsername : _usernameController.value,
      DatabaseHelper.columnEmail : _emailController.value,
      DatabaseHelper.columnPassword : _passwordController.value,
    };
    print('cok1 $row');
    await dbHelper.insert(row);

    print('cok ${await dbHelper.getAll()}');
  }
}