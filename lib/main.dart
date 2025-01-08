import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mid_basic_exam/controller/budgeting_controller.dart';
import 'package:flutter_mid_basic_exam/controller/task_controller/task_controller_libraries.dart';
import 'package:flutter_mid_basic_exam/routes/routes.dart';
import 'package:flutter_mid_basic_exam/view/module/api_app/api_app.dart';
import 'package:flutter_mid_basic_exam/view/module/bottom_navigation_bar_page.dart';
import 'package:flutter_mid_basic_exam/view/module/budgeting_app/dashboard_budgeting.dart';
import 'package:flutter_mid_basic_exam/view/module/image_picker/media_picker.dart';
import 'package:flutter_mid_basic_exam/view/module/notification/notification_example.dart';
import 'package:flutter_mid_basic_exam/view/module/notification_widget_page.dart';
import 'package:flutter_mid_basic_exam/view/module/simple_todo_app/task_list_page.dart';
import 'package:flutter_mid_basic_exam/view/pages/home/homepage_view.dart';
import 'package:flutter_mid_basic_exam/view/pages/home/main_app.dart';
import 'package:flutter_mid_basic_exam/view/pages/menu/menu_view.dart';
import 'package:flutter_mid_basic_exam/view/widgets/tab_bar_format_navigation.dart';

import 'package:provider/provider.dart';

import 'constants/theme.dart';
import 'controller/auth_controller/login_controller.dart';
import 'controller/auth_controller/register_controller.dart';
import 'controller/toko_controller.dart';

// FIREBASE CONFIG
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// sign in anonymously
Future<void> signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (e) {
    print('Error: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await signInAnonymously();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => TokoController()),
        ChangeNotifierProvider(create: (context) => BudgetingController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tugas Kuliah',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // home: DashboardBudgetingApp(),
      // home: DashboardBudgetingApp(),
      // home: FirebaseAppExample(),
      home: MediaPicker(),
      // home: NotificationPage(),
      // home: ApiPage(),
      // home: TaskListScreen(),
      // home: BottomNavigationBarExample(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

// Firebase Example
class FirebaseAppExample extends StatelessWidget {
  const FirebaseAppExample({super.key});
  void addData() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': 'Rizki',
        'age': 20,
      });
      debugPrint('Data added successfully');
    } catch (e) {
      debugPrint('Error adding data: $e');
    }
  }

  Future<Map<String, dynamic>> getData() async {
    try {
      final data = await FirebaseFirestore.instance.collection('users').get();
      debugPrint('Data retrieved successfully');
      return data.docs.isNotEmpty
          ? data.docs[0].data() as Map<String, dynamic>
          : {};
    } catch (e) {
      debugPrint('Error retrieving data: $e');
      throw e;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllData() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // get all collection
  Stream<List<Map<String, dynamic>>> getAllCollection() {
    return FirebaseFirestore.instance
        .collection('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // create a collection
  void createCollection(String username) async {
    try {
      await FirebaseFirestore.instance.collection('name').add({
        'name': username,
        'age': 20,
      });
      debugPrint('Collection created successfully');
    } catch (e) {
      debugPrint('Error creating collection: $e');
    }
  }

  void getDataCollection() async {
    try {
      final collectionData =
          await FirebaseFirestore.instance.collection('name').get();
      debugPrint(
          'Collection Data retrieved successfully: ${collectionData.docs}');
      final specificUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('Dqh5M5HqsNkTX13T2Pf4')
          .collection('budgeting')
          .get();

      // To access fields from the document
      final userData = specificUserDoc.docs.map((doc) => doc.data()).toList();
      debugPrint('Specific User Data retrieved successfully: $userData');
    } catch (e) {
      debugPrint('Error retrieving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase App Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: addData,
              child: Text('Add Data'),
            ),
            ElevatedButton(
              onPressed: () {
                final data = getDataCollection();
                data;
              },
              child: Text('Get User Informations'),
            ),
            SizedBox(height: 20),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: getAllData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No Data Found');
                } else {
                  List<Map<String, dynamic>> userData = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Name: ${userData[index]['name']}'),
                        subtitle: Text('Age: ${userData[index]['age']}'),
                        leading: Icon(
                          snapshot.data![index]['gender'] == "male"
                              ? Icons.male
                              : Icons.female,
                          color: Colors.blue,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
