/// Türkçe karakter normalizasyonu + whitespace sadeleştirme
String searhcNorm(String s) => s
    .toLowerCase()
    .replaceAll('ç', 'c')
    .replaceAll('ğ', 'g')
    .replaceAll('ı', 'i')
    .replaceAll('i̇', 'i')
    .replaceAll('ö', 'o')
    .replaceAll('ş', 's')
    .replaceAll('ü', 'u')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();
