import 'package:clone_insta/resources/auth_methods.dart';
import 'package:clone_insta/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:clone_insta/widgets/text_field_input.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController= TextEditingController();
//   final TextEditingController _passwordController= TextEditingController();
//   bool _isLoading=false;
//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }
//   void loginUser() async {
//     String res=await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
//     if(res=="Success"){
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
//           webScreenLayout: WebScreenLayout(),
//           mobileScreenLayout: MobileScreenLayout())
//       ));
//     }else{
//     showSnackBar(res, context);
//     }
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 32.0),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(child: Container(), flex: 2),
//                 Image.asset('assets/img.png',color: primaryColor,height: 64),
//               const SizedBox(height: 64),
//               TextFieldInput(
//                 hintText: "Enter your Email",
//                 textInputType: TextInputType.emailAddress,
//                 textEditingController: _emailController,
//               ),
//               const SizedBox(height: 24),
//               TextFieldInput(
//                 hintText: "Enter your password",
//                 textInputType: TextInputType.text,
//                 textEditingController: _passwordController,
//                 isPass: true,
//               ),
//               const SizedBox(height: 24),
//               InkWell(
//
//                 onTap: loginUser,
//                 child: Container(
//                   child: _isLoading?Center(child: CircularProgressIndicator(color: primaryColor,)):const Text('Log in'),
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(4)
//                     )
//                   ),
//                     color: blueColor
//                   ),
//                 ),
//               ),
//                 SizedBox(height: 12),
//                 Flexible(child: Container(), flex: 2),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     child: const Text("Don't have an account?"),
//                   ),
//                   GestureDetector(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
//                       },
//                       child: Container(
//                         child: const Text(
//                             "Sign up",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold
//                             )
//                         ),
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         )
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser() async {
    setState(() {
      _isLoading=true;
    });
    String res=await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);
    if(res!="Success"){
      showSnackBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout())
      ));
    }
    setState(() {
      _isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Container(),flex: 2),
                  Image.asset('assets/img.png',color: primaryColor, height: 64),
                  const SizedBox(height: 64),
                  TextFieldInput(
                    hintText: 'Enter your email',
                    TextInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    hintText: 'Enter your password',
                    TextInputType: TextInputType.emailAddress,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: loginUser,
                    child: Container(
                      child: _isLoading?Center(child: CircularProgressIndicator(color: primaryColor)):const Text('Login'),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(child: Container(),flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: const Text("Don't have an account?"),
                      ),
                      GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
                          },
                          child: Container(
                            child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12)
                ],
              )
          )
      ),
    );
  }
}
