enum MockAssets {
  login('asset/mocks/login.json'),
  customer('asset/mocks/custommer.json'),
  customerDetail('asset/mocks/customer_detail.json');

  final String path;
  const MockAssets(this.path);
}
