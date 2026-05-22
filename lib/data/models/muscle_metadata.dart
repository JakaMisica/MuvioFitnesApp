import 'enums.dart';

class MuscleMetadata {
  static const Map<MuscleGroup, List<String>> subgroups = {
    MuscleGroup.chest: ['Upper Chest', 'Middle Chest', 'Lower Chest'],
    MuscleGroup.back: ['Lats', 'Rhomboids', 'Lower Back', 'Rear Delt'],
    MuscleGroup.legs: ['Quads', 'Hamstrings', 'Glutes', 'Calves', 'Adductors'],
    MuscleGroup.shoulders: ['Front Delts', 'Middle Delts', 'Rear Delts'],
    MuscleGroup.arms: ['Biceps', 'Triceps', 'Forearms'],
    MuscleGroup.core: ['Upper Abs', 'Lower Abs', 'Obliques'],
    MuscleGroup.cardio: ['Cardio Training'],
    MuscleGroup.other: [],
  };

  static const List<String> gluteParts = [
    'Gluteus Maximus',
    'Gluteus Medius',
    'Gluteus Minimus'
  ];

  static String getMuscleImagePath(MuscleGroup group, [String? subGroup]) {
    final groupName = group.name.toLowerCase();
    
    // Default image for the whole group
    String fileName = groupName;
    if (groupName == 'shoulders') fileName = 'shoulders';

    if (subGroup != null && subGroup.isNotEmpty) {
      final s = subGroup.toLowerCase();
      if (s.contains('biceps')) fileName = 'biceps';
      else if (s.contains('triceps')) fileName = 'triceps';
      else if (s.contains('forearm')) fileName = 'forearms';
      else if (s.contains('lats')) fileName = 'lats';
      else if (s.contains('rhomboid')) fileName = 'rhomboids';
      else if (s.contains('lower back')) fileName = 'lower_back';
      else if (s.contains('rear delt')) {
         fileName = group == MuscleGroup.back ? 'rear_delt_back' : 'rear_delts';
      }
      else if (s.contains('upper abs')) fileName = 'upper_abs';
      else if (s.contains('lower abs')) fileName = 'lower_abs';
      else if (s.contains('oblique')) fileName = 'obliques';
      else if (s.contains('quad')) fileName = 'quads';
      else if (s.contains('hamstring')) fileName = 'hamstrings';
      else if (s.contains('glute')) fileName = 'glutes';
      else if (s.contains('calves')) fileName = 'calves';
      else if (s.contains('adductor')) fileName = 'adductors';
      else if (s.contains('front delt')) fileName = 'front_delts';
      else if (s.contains('middle delt') || s.contains('side delt')) fileName = 'middle_delts';
      else if (s.contains('upper chest')) fileName = 'upper_chest';
      else if (s.contains('middle chest') || s.contains('midle')) fileName = 'middle_chest';
      else if (s.contains('lower chest')) fileName = 'lower_chest';
      else if (group == MuscleGroup.cardio) fileName = 'cardio';
    }

    // Handle spelling correction for group name if no subgroup matched
    if (fileName == 'shoulders') fileName = 'shoulders';

    return 'assets/images/muscles/$fileName.png';
  }
}
