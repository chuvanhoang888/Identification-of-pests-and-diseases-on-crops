import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_detect_disease_datn/components/custom_surffix_icon.dart';
import 'package:project_detect_disease_datn/components/default_button.dart';
import 'package:project_detect_disease_datn/components/form_error.dart';
import 'package:project_detect_disease_datn/components/no_account_text.dart';
import 'package:project_detect_disease_datn/components/socal_card.dart';
import 'package:project_detect_disease_datn/constants.dart';
import 'package:project_detect_disease_datn/cubit/auth_cubit.dart';
import 'package:project_detect_disease_datn/screens/forgot_password/forgot_password_screen.dart';
import 'package:project_detect_disease_datn/screens/page_view/page_view.dart';
import 'package:project_detect_disease_datn/screens/sign_in/components/sign_form.dart';
import 'package:project_detect_disease_datn/size_config.dart';
import 'package:flutter/material.dart';
import 'package:project_detect_disease_datn/utils/ProgressHuD.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FocusNode myFocusNode;

  late FocusNode myFocusNode2;

  final _formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  bool remember = false;

  bool isApiCallProcess = false;

  bool isHiddenPassword = true;

  //late APIService apiService;
  final List<String> errors = [];
  //errors = ["Demo Error"]
  @override
  void initState() {
    //apiService = new APIService();
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
  }

  @override
  @override
  void dispose() {
    myFocusNode.dispose();
    myFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginError ||
            state is AuthGoogleError ||
            state is AUthFBError) {
          Fluttertoast.showToast(
              msg: state.errorMessage!,
              textColor: Colors.black,
              backgroundColor: Colors.white);
        }
        if (state is AuthLoginSuccess ||
            state is AuthGoogleSuccess ||
            state is AuthFbSuccess) {
          Navigator.pushNamed(context, PagesView.routeName);
        }
      },
      builder: (state, context) => SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  Text(
                    "Chào mừng",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Đăng nhập bằng email và mật khẩu của bạn \nhoặc tiếp tục với mạng xã hội",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  ProgressHUD(
                    inAsyncCall: isApiCallProcess,
                    opacity: 0.1,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildEmailFormField(),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          buildPasswordFormField(),
                          SizedBox(
                            height: getProportionateScreenHeight(
                              30,
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: remember,
                                  activeColor: kPrimaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      remember = value!;
                                    });
                                  }),
                              Text("Nhớ tôi"),
                              Spacer(),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(this.context,
                                    ForgotPasswordScreen.routeName),
                                child: Text(
                                  "Quên mật khẩu",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          FormError(errors: errors),
                          SizedBox(
                            height: getProportionateScreenHeight(
                              20,
                            ),
                          ),
                          DefaultButton(
                            color: kPrimaryColor,
                            text: "Đăng nhập",
                            press: () async {
                              //Navigator.pushNamed(context, AccountScreen.routeName);
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                setState(() {
                                  isApiCallProcess = true;
                                });
                                // signIn(email!, password!)
                                //     .then((uid) => {
                                //           setState(() {
                                //             isApiCallProcess = false;
                                //           }),
                                //           Fluttertoast.showToast(msg: "Đăng nhập thành công"),
                                //           Navigator.pushNamed(context, PagesView.routeName)
                                //         })
                                //     .catchError((e) {
                                //   Fluttertoast.showToast(msg: e!.toString());
                                // });
                                final authCubit =
                                    BlocProvider.of<AuthCubit>(this.context);
                                await authCubit
                                    .login(email!, password!)
                                    .whenComplete(() {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                });
                                //Navigator.pushNamed(context, SignInScreen.routeName);

                                // if all are valid then go to success screen
                                //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () async {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          final authCubit =
                              BlocProvider.of<AuthCubit>(this.context);
                          await authCubit.gmailAuth().whenComplete(() {
                            setState(() {
                              isApiCallProcess = false;
                            });
                          });
                        },
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () async {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          final authCubit =
                              BlocProvider.of<AuthCubit>(this.context);
                          await authCubit.facebookAuth().whenComplete(() {
                            setState(() {
                              isApiCallProcess = false;
                            });
                          });
                        },
                      ),
                      // SocalCard(
                      //   icon: "assets/icons/twitter.svg",
                      //   press: () {},
                      // )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  NoAccountText()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  void _requestFocus2() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode2);
    });
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onTap: _requestFocus,
      focusNode: myFocusNode,
      keyboardType: TextInputType.emailAddress,
      //Hàm onChanged() dùng để kiểm tra sự kiện chỉ cần chạm vào ô email là kiểm tra ngay ko cần button gì hết
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Nhập Email ",
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? kPrimaryColor : Colors.grey),
          //labelStyle: TextStyle(color: Colors.grey),
          //hintText: "Enter your email",
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          //Bạn có thể thêm các biểu tượng trực tiếp vào TextFields. Bạn cũng có thể sử dụng prefixText và hậu tố cho văn bản thay thế.
          prefixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      focusNode: myFocusNode2,
      onTap: _requestFocus2,
      obscureText: isHiddenPassword,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Nhập mật khẩu",
          labelStyle: TextStyle(
              color: myFocusNode2.hasFocus ? kPrimaryColor : Colors.grey),
          //hintText: "Enter your password",
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          //Bạn có thể thêm các biểu tượng trực tiếp vào TextFields. Bạn cũng có thể sử dụng prefixText và hậu tố cho văn bản thay thế.
          prefixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          ),
          suffixIcon: InkWell(
            onTap: () => _togglePasswordView(),
            child: Icon(
              Icons.visibility,
              color: isHiddenPassword == false ? kPrimaryColor : Colors.black26,
            ),
          )),
    );
  }

  void _togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}
