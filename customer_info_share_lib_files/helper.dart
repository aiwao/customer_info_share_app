const Map<String, String> initialGroupMap = {
  'あ': 'あいうえお',
  'か': 'かきくけこがぎぐげご',
  'さ': 'さしすせそざじずぜぞ',
  'た': 'たちつてとだぢづでど',
  'な': 'なにぬねの',
  'は': 'はひふへほばびぶべぼぱぴぷぺぽ',
  'ま': 'まみむめも',
  'や': 'やゆよ', 
  'ら': 'らりるれろ', 
  'わ': 'わ',
  '？': '',
};

String getInitial(String str) {
  return str.substring(0,1);
}
