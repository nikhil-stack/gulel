class Category {
  String id;
  String title;
  String imageUrl;
  Category({this.id, this.title, this.imageUrl});
}

List<Category> categories = [
  Category(
    id: '1',
    title: 'Cardamom',
    imageUrl:
        'https://images.pexels.com/photos/3040873/pexels-photo-3040873.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ),
  Category(
      id: '2',
      title: 'Black pepper',
      imageUrl:
          'https://images.pexels.com/photos/5741507/pexels-photo-5741507.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  Category(
      id: '3',
      title: 'Almond',
      imageUrl:
          'https://images.pexels.com/photos/57042/pexels-photo-57042.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  Category(
      id: '4',
      title: 'Cashew',
      imageUrl:
          'https://images.pexels.com/photos/4663476/pexels-photo-4663476.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
];
