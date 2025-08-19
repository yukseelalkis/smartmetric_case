/// [FontName] is an enum that contains the names of the fonts used in the application.
enum FontName {
  /// [lato] is the name of the lato font.
  lato,

  /// [robotoSlab] is the name of the robotoSlab font.
  robotoSlab;

  /// [name] is a getter that returns the name of the font.
  String get name {
    switch (this) {
      case FontName.lato:
        return 'Lato';
      case FontName.robotoSlab:
        return 'Roboto Slab';
    }
  }
}
