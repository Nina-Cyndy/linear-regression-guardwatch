class PredictionRequest {
  final String location;
  final String timeOfDay;
  final String dayOfWeek;
  final String callType;
  final String priority;
  final String callerType;

  final int nationalNumberUsed;
  final int dispatchCenterUsed;
  final double callToDispatchMin;

  final int ambulanceAvailable;
  final int crewSize;

  final String highestQualification;

  final int equipmentComplete;
  final int oxygenAvailable;
  final int defibrillatorAvailable;
  final int gpsTracked;

  final String alternativeTransport;

  final int year;

  PredictionRequest({
    required this.location,
    required this.timeOfDay,
    required this.dayOfWeek,
    required this.callType,
    required this.priority,
    required this.callerType,
    required this.nationalNumberUsed,
    required this.dispatchCenterUsed,
    required this.callToDispatchMin,
    required this.ambulanceAvailable,
    required this.crewSize,
    required this.highestQualification,
    required this.equipmentComplete,
    required this.oxygenAvailable,
    required this.defibrillatorAvailable,
    required this.gpsTracked,
    required this.alternativeTransport,
    required this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "time_of_day": timeOfDay,
      "day_of_week": dayOfWeek,
      "call_type": callType,
      "priority": priority,
      "caller_type": callerType,
      "national_number_used": nationalNumberUsed,
      "dispatch_center_used": dispatchCenterUsed,
      "call_to_dispatch_min": callToDispatchMin,
      "ambulance_available": ambulanceAvailable,
      "crew_size": crewSize,
      "highest_qualification": highestQualification,
      "equipment_complete": equipmentComplete,
      "oxygen_available": oxygenAvailable,
      "defibrillator_available": defibrillatorAvailable,
      "gps_tracked": gpsTracked,
      "alternative_transport": alternativeTransport,
      "year": year,
    };
  }
}