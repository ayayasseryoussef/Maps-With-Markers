// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'bindings/app_binding.dart';
import 'views/map_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://pxyfskuveindjbvkvfzk.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB4eWZza3V2ZWluZGpidmt2ZnprIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0NzE1OTYsImV4cCI6MjA3NDA0NzU5Nn0.o9MkUGZWh_yhwxpt-3oQ32JRCSD4RviRJCRTqPudmlM',                // replace with your anon key
  );
  AppBinding().dependencies(); // init GetX controllers
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapView(),
    );
  }
}
