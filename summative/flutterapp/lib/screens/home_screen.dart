import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/custom_dropdown.dart';
import 'package:flutterapp/widgets/custom_number_field.dart';
import '../models/prediction_request.dart';
import '../services/api_service.dart';
import '../constants/app_colors.dart';
import '../widgets/loading_button.dart';
import '../widgets/prediction_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  String? prediction;

  final callToDispatchController = TextEditingController();

  final crewSizeController = TextEditingController();

  final yearController = TextEditingController();

  final ApiService apiService = ApiService();

  String? location;
  String? timeOfDay;
  String? dayOfWeek;
  String? callType;
  String? priority;
  String? callerType;
  String? nationalNumberUsed;
  String? dispatchCenterUsed;
  String? ambulanceAvailable;
  String? highestQualification;
  String? equipmentComplete;
  String? oxygenAvailable;
  String? defibrillatorAvailable;
  String? gpsTracked;
  String? alternativeTransport;

  final locations = [
    "urban",
    "peri_urban",
    "rural",
    "remote",
  ];

  final times = [
    "day",
    "night",
    "dawn_dusk",
  ];

  final days = [
    "weekday",
    "weekend",
  ];

  final callTypes = [
    "medical",
    "trauma",
    "obstetric",
    "cardiac",
    "pediatric",
    "other",
  ];

  final priorities = [
    "p1_emergency",
    "p2_urgent",
    "p3_routine",
  ];

  final callerTypes = [
    "patient_family",
    "bystander",
    "health_facility",
    "police",
    "chw",
    "other",
  ];

  final yesNo = [
    "1",
    "0",
  ];

  final qualifications = [
    "driver_only",
    "emt_basic",
    "emt_intermediate",
    "paramedic",
    "nurse",
    "na",
  ];

  final transport = [
    "ambulance",
    "motorcycle",
    "private_vehicle",
    "taxi",
    "police",
    "walked",
    "none",
  ];

  Future<void> predictResponseTime() async {

    if (location == null ||
        timeOfDay == null ||
        dayOfWeek == null ||
        callType == null ||
        priority == null ||
        callerType == null ||
        nationalNumberUsed == null ||
        dispatchCenterUsed == null ||
        ambulanceAvailable == null ||
        highestQualification == null ||
        equipmentComplete == null ||
        oxygenAvailable == null ||
        defibrillatorAvailable == null ||
        gpsTracked == null ||
        alternativeTransport == null ||
        callToDispatchController.text.isEmpty ||
        crewSizeController.text.isEmpty ||
        yearController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete every field."),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final request = PredictionRequest(
        location: location!,
        timeOfDay: timeOfDay!,
        dayOfWeek: dayOfWeek!,
        callType: callType!,
        priority: priority!,
        callerType: callerType!,
        nationalNumberUsed: int.parse(nationalNumberUsed!),
        dispatchCenterUsed: int.parse(dispatchCenterUsed!),
        callToDispatchMin:
            double.parse(callToDispatchController.text),
        ambulanceAvailable:
            int.parse(ambulanceAvailable!),
        crewSize: int.parse(crewSizeController.text),
        highestQualification:
            highestQualification!,
        equipmentComplete:
            int.parse(equipmentComplete!),
        oxygenAvailable:
            int.parse(oxygenAvailable!),
        defibrillatorAvailable:
            int.parse(defibrillatorAvailable!),
        gpsTracked:
            int.parse(gpsTracked!),
        alternativeTransport:
            alternativeTransport!,
        year:
            int.parse(yearController.text),
      );

      final result =
          await apiService.predict(request);

      setState(() {
        prediction = result.toStringAsFixed(2);
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PredictionCard(
                  prediction: prediction,
                ),
              ),

              const SizedBox(height: 20),

              _buildSection(
                title: "🚨 Incident Information",
                child: Column(
                  children: [

                    CustomDropdown(
                      label: "Location",
                      items: locations,
                      value: location,
                      onChanged: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Time of Day",
                      items: times,
                      value: timeOfDay,
                      onChanged: (value) {
                        setState(() {
                          timeOfDay = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Day of Week",
                      items: days,
                      value: dayOfWeek,
                      onChanged: (value) {
                        setState(() {
                          dayOfWeek = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Call Type",
                      items: callTypes,
                      value: callType,
                      onChanged: (value) {
                        setState(() {
                          callType = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Priority",
                      items: priorities,
                      value: priority,
                      onChanged: (value) {
                        setState(() {
                          priority = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Caller Type",
                      items: callerTypes,
                      value: callerType,
                      onChanged: (value) {
                        setState(() {
                          callerType = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "National Number Used",
                      items: yesNo,
                      value: nationalNumberUsed,
                      onChanged: (value) {
                        setState(() {
                          nationalNumberUsed = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Dispatch Center Used",
                      items: yesNo,
                      value: dispatchCenterUsed,
                      onChanged: (value) {
                        setState(() {
                          dispatchCenterUsed = value;
                        });
                      },
                    ), 

                    CustomNumberField(
                      label: "Call To Dispatch (Minutes)",
                      controller: callToDispatchController,
                    ),

                  ],
                ),
              ),

              _buildSection(
                title: "🚑 Ambulance Information",
                child: Column(
                  children: [

                    CustomDropdown(
                      label: "Ambulance Available",
                      items: yesNo,
                      value: ambulanceAvailable,
                      onChanged: (value) {
                        setState(() {
                          ambulanceAvailable = value;
                        });
                      },
                    ),

                    CustomNumberField(
                      label: "Crew Size",
                      controller: crewSizeController,
                    ),

                    CustomDropdown(
                      label: "Highest Qualification",
                      items: qualifications,
                      value: highestQualification,
                      onChanged: (value) {
                        setState(() {
                          highestQualification = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Equipment Complete",
                      items: yesNo,
                      value: equipmentComplete,
                      onChanged: (value) {
                        setState(() {
                          equipmentComplete = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Oxygen Available",
                      items: yesNo,
                      value: oxygenAvailable,
                      onChanged: (value) {
                        setState(() {
                          oxygenAvailable = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "Defibrillator Available",
                      items: yesNo,
                      value: defibrillatorAvailable,
                      onChanged: (value) {
                        setState(() {
                          defibrillatorAvailable = value;
                        });
                      },
                    ),

                    CustomDropdown(
                      label: "GPS Tracked",
                      items: yesNo,
                      value: gpsTracked,
                      onChanged: (value) {
                        setState(() {
                          gpsTracked = value;
                        });
                      },
                    ),

                  ],
                ),
              ),

              _buildSection(
                title: "📋 Additional Information",
                child: Column(
                  children: [

                    CustomDropdown(
                      label: "Alternative Transport",
                      items: transport,
                      value: alternativeTransport,
                      onChanged: (value) {
                        setState(() {
                          alternativeTransport = value;
                        });
                      },
                    ),

                    CustomNumberField(
                      label: "Year",
                      controller: yearController,
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: LoadingButton(
                        isLoading: isLoading,
                        text: "Predict Response Time",
                        onPressed: predictResponseTime,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        36,
        24,
        36,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1565C0),
            Color(0xFF42A5F5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),

      child: const Column(
        children: [
          Icon(
            Icons.local_hospital,
            color: Colors.white,
            size: 52,
          ),

          SizedBox(height: 12),

          Text(
            "GuardWatch",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "Emergency Response Prediction",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12),

          Text(
            "Estimate ambulance response time using Machine Learning.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Card(
        elevation: 4,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Divider(height: 25),

              child,
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    callToDispatchController.dispose();
    crewSizeController.dispose();
    yearController.dispose();

    super.dispose();
  }
}