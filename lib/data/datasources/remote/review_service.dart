import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/review/review_model.dart';

class ReviewService {
  final Dio dio;

  ReviewService(this.dio);

  Future<List<ReviewModel>> getReviewsByProfile(int profileId) async {
    try {
      final response = await dio.get('${ApiConstants.reviews}/profile/$profileId');
      return (response.data as List)
          .map((e) => ReviewModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception('Get reviews failed: ${e.response?.data}');
    }
  }

  double calculateAverageRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return 0.0;
    final sum = reviews.fold<int>(0, (prev, r) => prev + r.rating);
    return sum / reviews.length;
  }
}
