part of 'diet_cubit.dart';

class DietState extends Equatable {
  final bool isLoading;
  final DateTime selectedDate;
  final DailyDiet? currentDiet;
  final List<FoodItem> searchResults;
  final double burnedCalories;

  const DietState({
    required this.isLoading,
    required this.selectedDate,
    this.currentDiet,
    this.searchResults = const [],
    this.burnedCalories = 0.0,
  });

  factory DietState.initial() {
    return DietState(
      isLoading: false,
      selectedDate: DateTime.now(),
      currentDiet: null,
      searchResults: const [],
      burnedCalories: 0.0,
    );
  }

  DietState copyWith({
    bool? isLoading,
    DateTime? selectedDate,
    DailyDiet? currentDiet,
    List<FoodItem>? searchResults,
    double? burnedCalories,
  }) {
    return DietState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      currentDiet: currentDiet ?? this.currentDiet,
      searchResults: searchResults ?? this.searchResults,
      burnedCalories: burnedCalories ?? this.burnedCalories,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    selectedDate,
    currentDiet,
    searchResults,
    burnedCalories,
  ];
}
