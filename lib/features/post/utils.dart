import 'models/post.dart';

List<Post> binarySearchPosts(List<Post> hPosts, String category) {
 
  List<Post> posts = List<Post>.from(hPosts);

  // Sort the new list by category
  posts.sort((a, b) => a.category.compareTo(b.category));

  int left = 0;
  int right = posts.length - 1;
  List<Post> result = [];

  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    if (posts[mid].category == category) {
      // Find the range of posts with the same category
      int start = mid;
      int end = mid;
      while (start > 0 && posts[start - 1].category == category) {
        start--;
      }
      while (end < posts.length - 1 && posts[end + 1].category == category) {
        end++;
      }
      result = posts.sublist(start, end + 1);
      break;
    } else if (posts[mid].category.compareTo(category) < 0) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return result;
}
