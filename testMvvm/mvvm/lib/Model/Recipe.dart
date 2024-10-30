class Recipe {
  late String title,recipe,imagePath;

  late List<bool> checks ;

  Recipe(String title,String recipe,String imagePath,List<bool> checks){
    this.title = title;
    this.recipe = recipe;
    this.imagePath = imagePath;
    this.checks = checks;
  }
 Map<String,dynamic> toMap(){
    return {
      "title":title,
      "recipe":recipe,
      "image":imagePath,
      "checks":checks
    };
  }

}