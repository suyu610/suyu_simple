class MarkItemModel {
  String title; //标题
  String desc; //描述
  int maxScore; //最大分数
  int currentScore; //当前分数

  MarkItemModel(this.title, this.desc, this.maxScore, this.currentScore);

  @override
  String toString() {
    return title +
        "\n" +
        desc +
        "\n" +
        maxScore.toString() +
        "\n" +
        currentScore.toString() +
        "\n";
  }
}
