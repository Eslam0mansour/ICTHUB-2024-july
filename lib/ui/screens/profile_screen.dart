import 'package:flutter/material.dart';
import 'package:icthub_new_repo/data/data_models/user_data_model.dart';
import 'package:icthub_new_repo/data/data_sourec/auth.dart';
import 'package:icthub_new_repo/ui/widgets/error_widget.dart';
import 'package:icthub_new_repo/ui/widgets/loading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<ProfileScreen> {
  late UserDataModel userData;
  bool isLoading = true;
  bool isError = false;
  @override
  void initState() {
    super.initState();
    AuthDataSource.getUserData().then((value) {
      isLoading = false;

      if (value != null) {
        setState(() {
          userData = value;
        });
      } else {
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const LoadingWidget()
          : isError
              ? MyErrorWidget(errorMsg: AuthDataSource.errorMessage)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        tileColor: Colors.teal[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Text('UID'),
                        subtitle: Text(userData.uid),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.teal[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Text('Email'),
                        subtitle: Text(
                          userData.email,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.teal[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Text('Name'),
                        subtitle: Text(
                          userData.name,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.teal[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Text('Phone'),
                        subtitle: Text(
                          userData.phone,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
