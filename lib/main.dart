import 'package:clone_insta/providers/user_provider.dart';
import 'package:clone_insta/responsive/responsive_layout_screen.dart';
import 'package:clone_insta/responsive/web_screen_layout.dart';
import 'package:clone_insta/screens/login_screen.dart';
import 'package:clone_insta/screens/signup_screen.dart';
import 'package:clone_insta/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive/mobile_screen_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCk8qi3w9G9iUFKLSYLgNouChvAvgzSBFo",
          appId: "1:387180862123:web:0d7dd69e4ce83fe3fcb5ee",
          messagingSenderId: "387180862123",
          projectId: "clone-insta-4f0db",
          storageBucket: "clone-insta-4f0db.appspot.com",
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider(),),
      ],
      child: MaterialApp(
        title: 'Instagram_Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        // home: ResponsiveLayout(
        //     mobileScreenLayout: MobileScreenLayout(),
        //     webScreenLayout: WebScreenLayout()),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                }else if(snapshot.hasError){
                  return Center(child: Text('${snapshot.error}'));
                }
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(color: primaryColor));
              }
              return const LoginScreen();
            }
        ),
      ),
    );
  }
}
