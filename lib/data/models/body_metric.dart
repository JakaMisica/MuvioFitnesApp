import 'package:isar/isar.dart';

part 'body_metric.g.dart';

@collection
class BodyMetric {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late DateTime date;

  double? weight; // in kg
  double? bodyFatPercentage;

  // Method used to set body fat
  // 0: Estimated, 1: DEXA, 2: Caliper, 3: Auto-calculated
  int? bodyFatMethod;

  // Caliper measurements (if used)
  double? chestSkinfold;
  double? abdominalSkinfold;
  double? thighSkinfold;
  double? tricepSkinfold;
  double? bicepSkinfold;
  double? subscapularSkinfold;
  double? suprailiacSkinfold;
  double? midaxillarySkinfold;
  double? lowerBackSkinfold;
  double? calfSkinfold;

  // Calculated muscle mass estimate (in grams or kg)
  double? muscleMassGains;

  // New metrics
  double? gripStrengthLeft;
  double? gripStrengthRight;
  double? estimatedFreeTestosterone;
  double? labFreeTestosterone;

  // Circumferential Measurements (in cm)
  double? neck;
  double? chest;
  double? waist;
  double? hips;
  double? leftArm;
  double? rightArm;
  double? leftForearm;
  double? rightForearm;
  double? leftThigh;
  double? rightThigh;
  double? leftCalf;
  double? rightCalf;

  BodyMetric({
    this.weight,
    this.bodyFatPercentage,
    this.bodyFatMethod,
    this.chestSkinfold,
    this.abdominalSkinfold,
    this.thighSkinfold,
    this.tricepSkinfold,
    this.bicepSkinfold,
    this.subscapularSkinfold,
    this.suprailiacSkinfold,
    this.midaxillarySkinfold,
    this.lowerBackSkinfold,
    this.calfSkinfold,
    this.muscleMassGains = 0,
    this.gripStrengthLeft,
    this.gripStrengthRight,
    this.estimatedFreeTestosterone,
    this.labFreeTestosterone,
    this.neck,
    this.chest,
    this.waist,
    this.hips,
    this.leftArm,
    this.rightArm,
    this.leftForearm,
    this.rightForearm,
    this.leftThigh,
    this.rightThigh,
    this.leftCalf,
    this.rightCalf,
  });
}
