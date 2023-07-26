import 'dart:typed_data';

import 'package:clone_insta/resources/auth_methods.dart';
import 'package:clone_insta/responsive/responsive_layout_screen.dart';
import 'package:clone_insta/screens/login_screen.dart';
import 'package:clone_insta/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _emailController= TextEditingController();
//   final TextEditingController _passwordController= TextEditingController();
//   final TextEditingController _bioController= TextEditingController();
//   final TextEditingController _usernameController= TextEditingController();
//   Uint8List? _image;
//   bool _isLoading=false;
//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _bioController.dispose();
//     _usernameController.dispose();
//   }
//   void selectImage() async {
//     Uint8List im= await pickImage(ImageSource.gallery);
//     setState(() {
//       _image=im;
//     });
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 32.0),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     //Flexible(child: Container(), flex: 2),
//                     const SizedBox(height: 50),
//                     Image.asset('assets/img.png',color: primaryColor,height: 64),
//                     const SizedBox(height: 34),
//                     Stack(
//                       children: [
//                         _image!=null?CircleAvatar(
//                           radius: 64,
//                           backgroundImage: MemoryImage(_image!),
//                         ):CircleAvatar(
//                           radius: 64,
//                           backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt1ceyneFkZchgkrwN7dZxWNl_C5Dctvc5BzNh_rEzPQ&s"),
//                         ),
//                         Positioned(
//                             bottom: -10,
//                             left: 80,
//                             child: IconButton(
//                               onPressed: selectImage,
//                               icon: Icon(Icons.add_a_photo),
//                             )
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     TextFieldInput(
//                       hintText: "Enter your username",
//                       textInputType: TextInputType.text,
//                       textEditingController: _usernameController,
//                     ),
//                     const SizedBox(height: 24),
//                     TextFieldInput(
//                       hintText: "Enter your Email",
//                       textInputType: TextInputType.emailAddress,
//                       textEditingController: _emailController,
//                     ),
//                     const SizedBox(height: 24),
//                     TextFieldInput(
//                       hintText: "Enter your password",
//                       textInputType: TextInputType.text,
//                       textEditingController: _passwordController,
//                       isPass: true,
//                     ),
//                     const SizedBox(height: 24),
//                     TextFieldInput(
//                       hintText: "Enter your bio",
//                       textInputType: TextInputType.text,
//                       textEditingController: _bioController,
//                     ),
//                     const SizedBox(height: 24),
//                     InkWell(
//                       onTap: () async {
//                         setState(() {
//                           _isLoading=true;
//                         });
//                         String res=await AuthMethods().signUpUser(
//                             username: _usernameController.text,
//                             email: _emailController.text,
//                             password: _passwordController.text,
//                             bio: _bioController.text,
//                             file: _image!
//                         );
//                         setState(() {
//                           _isLoading=false;
//                         });
//                         if(res!="Success"){
//                           showSnackBar(res, context);
//                         }else{
//                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
//                               webScreenLayout: WebScreenLayout(),
//                               mobileScreenLayout: MobileScreenLayout())
//                           ));
//                         }
//                       },
//                       child: Container(
//                         child: _isLoading? Center(child: CircularProgressIndicator(color: primaryColor,)):const Text('Sign up'),
//                         width: double.infinity,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(4)
//                             )
//                         ),
//                             color: blueColor
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     //Flexible(child: Container(), flex: 2),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(vertical: 8),
//                           child: const Text("Already have and account?"),
//                         ),
//                         GestureDetector(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
//                             },
//                             child: Container(
//                               child: const Text(
//                                   "Log in",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold
//                                   )
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 8),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//             ),
//           )
//       ),
//     );
//   }
// }
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  Uint8List? _image;
  bool _isLoading=false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im= await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading=true;
    });
    String res = await AuthMethods().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading=false;
    });
    if(res!='Success'){
      showSnackBar(res,context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout())
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Image.asset('assets/img.png',color: primaryColor, height: 64),
                    const SizedBox(height: 34),
                    Stack(
                      children: [
                        _image!=null?CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        ):const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt1ceyneFkZchgkrwN7dZxWNl_C5Dctvc5BzNh_rEzPQ&s'),
                        ),
                        Positioned(bottom: -10,left: 80,child: IconButton(onPressed: selectImage, icon: const Icon(Icons.add_a_photo)))
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextFieldInput(
                      hintText: 'Enter your username',
                      TextInputType: TextInputType.text,
                      textEditingController: _usernameController,
                    ),
                    const SizedBox(height: 24),
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
                    TextFieldInput(
                      hintText: 'Enter your bio',
                      TextInputType: TextInputType.text,
                      textEditingController: _bioController,
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: signUpUser,
                      child: Container(
                        child: _isLoading?Center(child: CircularProgressIndicator(color: primaryColor)):const Text('Sign up'),
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
                    const SizedBox(height: 82),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: const Text("Already have an account?"),
                        ),
                        GestureDetector(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Container(
                              child: const Text(
                                  "Log in",
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
            ),
          )
      ),
    );
  }
}
