import 'package:buyer_app/authentication/login.dart';
import 'package:buyer_app/authentication/login_backend.dart';
import 'package:buyer_app/authentication/register.dart';
import 'package:buyer_app/global/AppStrings.dart';
import 'package:flutter/material.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(

          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
          ),
          leading: BackButton(),
          automaticallyImplyLeading: true,
          title:  const Text(
            AppString.restaurunt_hub,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: "Poppins",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: AppString.login,
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                text: AppString.register,
              ),
            ],
            indicatorColor: Color.fromARGB(255, 249, 247, 247),
            indicatorWeight: 2,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.orange,
                  Colors.orange,
                ],
              )),
          child: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        )
      ),
    );
  }
}
