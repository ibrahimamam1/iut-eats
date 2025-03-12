class NewPrediction {
  final String placeId;
  final String description; // Full text (e.g., "Dhaka, Bangladesh")
  final String mainText;    // Primary text (e.g., "Dhaka")
  final String secondaryText; // Secondary text (e.g., "Bangladesh")
  final List<String> types; // Types like ["political", "geocode"]

  NewPrediction({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
    required this.types,
  });

  factory NewPrediction.fromJson(Map<String, dynamic> json) {
    final placePrediction = json['placePrediction'] as Map<String, dynamic>;
    final text = placePrediction['text'] as Map<String, dynamic>;
    final structuredFormat = placePrediction['structuredFormat'] as Map<String, dynamic>;
    final mainTextData = structuredFormat['mainText'] as Map<String, dynamic>;
    final secondaryTextData = structuredFormat['secondaryText'] as Map<String, dynamic>;

    return NewPrediction(
      placeId: placePrediction['placeId'] as String,
      description: text['text'] as String,
      mainText: mainTextData['text'] as String,
      secondaryText: secondaryTextData['text'] as String,
      types: List<String>.from(placePrediction['types'] ?? []),
    );
  }
}