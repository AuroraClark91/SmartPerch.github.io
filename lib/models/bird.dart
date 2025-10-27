class Bird {
  final String name;
  final String imagePath;  // For now use placeholder images in assets
  bool isWanted;
  bool isUnwanted;

  Bird({
    required this.name,
    required this.imagePath,
    this.isWanted = false,
    this.isUnwanted = false,
  });
}
