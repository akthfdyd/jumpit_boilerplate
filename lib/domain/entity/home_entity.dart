class HomeEntity {
  HomeTitleEntity homeTitleEntity;
  HomeContentsEntity homeContentsEntity;

  HomeEntity({
    required this.homeTitleEntity,
    required this.homeContentsEntity,
  });
}

class HomeTitleEntity {
  String title;

  HomeTitleEntity({
    required this.title,
  });
}

class HomeContentsEntity {
  String contents;

  HomeContentsEntity({
    required this.contents,
  });
}
