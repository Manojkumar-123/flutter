import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';

final MealsProvider = Provider((ref) {
  return dummyMeals;
});
