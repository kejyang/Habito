//
//  Recipes.swift
//  Habito
//
//  Created by Kenneth Yang on 2/17/25.
//

import Foundation


let recipes = [
    RecipeModel(title: "Avocado Salad", description: RecipeDescriptions.salad.rawValue, img: "greenSalad"),
    RecipeModel(title: "Mediterranean Salmon", description: RecipeDescriptions.salmon.rawValue, img:"salmon"),
    RecipeModel(title: "Chicken Rice Bowl", description: RecipeDescriptions.salmon.rawValue, img:"chicken")
]

enum RecipeDescriptions: String {
    case salad = """
    Ingredients
    
    - 2 small heads of soft lettuce, butter lettuce or similar
    - Lemon Vinaigrette, half recipe
    - 1 Persian cucumber, thinly sliced
    - ¼ cup shaved Parmesan cheese
    - 2 tablespoons pepitas
    - 1 avocado, thinly sliced
    - ¼ cup microgreens
    - Flaky sea salt, optional

    Roasted Tamari Almonds
    
    - ½ cup raw almonds
    - ½ tablespoon tamari
    
    Instructions

    - Roast the almonds: Preheat the oven to 350°F and line a baking sheet with parchment paper. Place the almonds on the sheet and toss with tamari. Bake for 10 to 14 minutes or until browned. Remove from the oven and let cool for 5 minutes.

    - Assemble the salad. In a large bowl toss the lettuce with a few spoonfuls of the lemon vinaigrette. Add the cucumber, parmesan, pepitas, avocado, and tamari almonds. Drizzle with more dressing and top with microgreens. Season to taste with flaky sea salt, if desired.
    """
    
    case salmon = """
    Ingredients
    
    - 4 (12x16-inch) rectangles aluminum foil
    - 4 (6 to 8 ounce) salmon filets
    - 3 tablespoons olive oil, or as needed, divided
    - 1 teaspoon Greek seasoning
    - 1 cup diced cherry or grape tomatoes
    - 4 marinated artichoke hearts, quartered
    - 3 tablespoons minced red onion
    - 3 tablespoons halved, pitted Kalamata olives
    - 1/2 lemon, zested and juiced
    - 2 tablespoons minced fresh parsley, plus parsley sprigs for garnish (optional)
    - 1 tablespoon balsamic vinegar
    - 2 cloves garlic, minced
    - 1/4 teaspoon red pepper flakes (optional)
    - Salt and freshly ground black pepper
    - 1 lemon, cut into wedges (optional)
    
    Directions
    
    - Preheat the oven to 400 degrees F (200 degrees C). Brush the center of each foil rectangle with a small amount of olive oil.

    - Place a salmon filet in the center of each foil sheet. Brush filets lightly with olive oil; sprinkle with Greek seasoning.

    - In a small bowl, combine tomatoes, artichokes, onion, olives, lemon zest and juice, minced parsley, balsamic vinegar, garlic, red pepper flakes, and 1 tablespoon olive oil. Season to taste with salt and pepper.

    - Spoon tomato mixture evenly over filets. Pull the long ends of foil rectangles over filets and fold twice to crimp, with the foil not touching the contents. Lift each end of the packet and pinch closed. Place packets on a rimmed baking sheet.

    - Bake in the center of the preheated oven for 12 to 15 minutes. An instant read thermometer, inserted into the center of filets through the foil packet, should read 145 degrees F (63 degrees C).

    - To serve, place foil packs on serving plates. Open packets, drizzle with any remaining olive oil, garnish with parsley sprigs, and serve with lemon wedges.
    """
    
    case chicken = """
    Ingredients
    
    Chicken
    
    - 1 1/4 pounds boneless skinless chicken thighs, cut into 1-inch pieces
    - 4 tablespoons olive oil, divided, plus more for frying chicken
    - 2 teaspoons Greek seasoning, divided
    - 1/2 teaspoon paprika
    - 2 cloves garlic, minced
    - 1/4 teaspoon kosher salt
    
    Dressing
    
    - 1/4 cup olive oil
    - 1 tablespoon red wine vinegar
    - 1 tablespoon banana pepper brine
    - 2 teaspoons honey
    - 1 teaspoon Dijon mustard
    - 1/4 teaspoon dried oregano
    - 1/4 teaspoon kosher salt
    - 1/4 teaspoon ground black pepper
    - 1/4 cup water
    
    Rice Bowls
    
    - 3 cups cooled cooked rice
    - 1 tablespoon soy sauce
    - 1 cup cherry tomatoes
    - 1 cup sliced, quartered English cucumber
    - 1/2 cup thinly sliced red onion
    - 1/2 cup banana pepper rings
    - 1/2 cup chopped flat-leaf parsley
    - 1/2 cup Kalamata olives
    - 1/2 cup crumbled feta cheese
    
    - Preheat the oven to 400 degrees F (200 degrees C). Lightly grease a baking sheet or line with parchment.
    
    - Combine chicken, 1 tablespoon oil, 1 teaspoon Greek seasoning, paprika, garlic, and salt in a bowl. Stir until well coated; set aside.
    
    - For dressing, whisk olive oil, red wine vinegar, pepper brine, honey, Dijon mustard, salt, and black pepper together in a small bowl until well combined; set aside.
    
    - Combine cooked rice and soy sauce with remaining 3 tablespoons olive oil and 1 teaspoon Greek seasoning in a bowl. Spread rice onto the prepared baking sheet.
    
    - Bake rice in the preheated oven until rice is crispy and lightly browned, about 40 minutes.
    
    - Meanwhile, heat a small amount of oil in a skillet over medium-high heat. Add chicken and cook, undisturbed, until chicken is browned on one side and releases easily from pan, 3 to 4 minutes. Continue to cook and stir until chicken is no longer pink at the center and browned on all sides, about 4 minutes more. Add water to the skillet and continue to stir until bottom of skillet is deglazed. Remove from heat.
    
    - To serve, divide chicken, tomatoes, cucumber, red onion, banana peppers, parsley, and olives among 4 bowls. Top evenly with crispy rice and feta cheese and drizzle with dressing.

    """
}
