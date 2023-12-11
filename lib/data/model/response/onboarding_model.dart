class OnboardingModel {
  final String _imageUrl;
  final String? _title;
  final String? _description;

  get imageUrl => _imageUrl;
  get title => _title;
  get description => _description;

  OnboardingModel(this._imageUrl, this._title, this._description);
}
