class ProfanityFilter {
  static final List<String> _swearWords = [
    'fuck',
    'shit',
    'asshole',
    'bitch',
    'cunt',
    'dick',
    'pussy',
    'bastard',
    'faggot',
    'nigger',
    'retard',
    'whore',
    'slut',
    'idiot',
    'stupid', // Adding some basic ones, user can expand
  ];

  static String filterText(String text) {
    String filtered = text;
    for (final word in _swearWords) {
      final regex = RegExp(word, caseSensitive: false);
      filtered = filtered.replaceAllMapped(regex, (match) {
        return '*' * match.group(0)!.length;
      });
    }
    return filtered;
  }

  static bool containsSwearWords(String text) {
    for (final word in _swearWords) {
      if (text.toLowerCase().contains(word.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
