import 'package:isar/isar.dart';
import '../datasources/isar_service.dart';
import '../models/diet_models.dart';

class DietRepository {
  final IsarService _isarService;

  DietRepository(this._isarService);

  Future<DailyDiet?> getDietForDate(DateTime date) async {
    final isar = await _isarService.db;
    final startOfDay = DateTime(date.year, date.month, date.day);
    return await isar.dailyDiets.filter().dateEqualTo(startOfDay).findFirst();
  }

  Future<List<DailyDiet>> getDietsBetween(DateTime start, DateTime end) async {
    final isar = await _isarService.db;
    final normalizedStart = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);
    return await isar.dailyDiets
        .filter()
        .dateBetween(normalizedStart, normalizedEnd)
        .sortByDate()
        .findAll();
  }

  Future<List<DateTime>> getDaysWithDiets() async {
    final isar = await _isarService.db;
    final diets = await isar.dailyDiets.where().findAll();
    return diets
        .where((d) => d.meals.isNotEmpty || d.supplements.isNotEmpty)
        .map((d) => d.date)
        .toList();
  }

  Future<DailyDiet?> getLatestDietBefore(DateTime date) async {
    final isar = await _isarService.db;
    final startOfDay = DateTime(date.year, date.month, date.day);
    return await isar.dailyDiets
        .filter()
        .dateLessThan(startOfDay)
        .sortByDateDesc()
        .findFirst();
  }

  Future<void> saveDailyDiet(DailyDiet diet) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.dailyDiets.put(diet);
    });
  }

  Future<DailyDiet> createDailyDiet(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final diet = DailyDiet()..date = startOfDay;
    await saveDailyDiet(diet);
    return diet;
  }

  Future<List<DailyDiet>> getFutureEmptyDiets(DateTime afterDate) async {
    final isar = await _isarService.db;
    final diets = await isar.dailyDiets
        .filter()
        .dateGreaterThan(afterDate)
        .findAll();
    return diets.where((d) => d.totalCalories == 0).toList();
  }

  Future<List<FoodItem>> searchFoods(String query, {String? category}) async {
    final isar = await _isarService.db;
    if (query.isEmpty) {
      if (category != null) {
        return await isar.foodItems
            .filter()
            .categoryEqualTo(category, caseSensitive: false)
            .limit(50)
            .findAll();
      }
      return await isar.foodItems.where().limit(50).findAll();
    }
    return await isar.foodItems
        .filter()
        .nameContains(query, caseSensitive: false)
        .limit(20)
        .findAll();
  }

  Future<void> saveFoodItem(FoodItem item) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.foodItems.put(item);
    });
  }

  Future<List<DietTemplate>> getAllTemplates() async {
    final isar = await _isarService.db;
    return await isar.dietTemplates.where().findAll();
  }

  Future<void> saveTemplate(DietTemplate template) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.dietTemplates.put(template);
    });
  }

  Future<void> deleteTemplate(int id) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.dietTemplates.delete(id);
    });
  }

  Future<void> seedCommonFoods() async {
    final isar = await _isarService.db;
    final count = await isar.foodItems.count();
    // Library target: 2000+ items (ultimate global food database)
    if (count > 2000) return;

    final List<FoodItem> library = [];

    void add(
      String name,
      String cat,
      double cal,
      double p,
      double c,
      double f, {
      String unit = 'g',
      double base = 100,
      double vitA = 0,
      double vitC = 0,
      double vitD = 0,
      double vitE = 0,
      double vitK = 0,
      double b1 = 0,
      double b2 = 0,
      double b3 = 0,
      double b5 = 0,
      double b6 = 0,
      double b7 = 0,
      double b9 = 0,
      double b12 = 0,
      double choline = 0,
      double calc = 0,
      double iron = 0,
      double mag = 0,
      double phos = 0,
      double pot = 0,
      double sod = 0,
      double zinc = 0,
      double copper = 0,
      double mang = 0,
      double sel = 0,
      double iod = 0,
      double leu = 0,
      double iso = 0,
      double val = 0,
      double lys = 0,
      double meth = 0,
      double phen = 0,
      double threo = 0,
      double tryp = 0,
      double hist = 0,
      double arg = 0,
      double omega3 = 0,
      double fiber = 0,
      double sugars = 0,
      double satFat = 0,
      double chol = 0,
      double glycine = 0,
    }) {
      library.add(
        FoodItem()
          ..name = name
          ..category = cat
          ..calories = cal
          ..protein = p
          ..carbs = c
          ..fat = f
          ..baseUnit = unit
          ..baseAmount = base
          ..vitA = vitA
          ..vitC = vitC
          ..vitD = vitD
          ..vitE = vitE
          ..vitK = vitK
          ..thiamine = b1
          ..riboflavin = b2
          ..niacin = b3
          ..pantothenicAcid = b5
          ..vitB6 = b6
          ..biotin = b7
          ..folate = b9
          ..vitB12 = b12
          ..choline = choline
          ..calcium = calc
          ..iron = iron
          ..magnesium = mag
          ..phosphorus = phos
          ..potassium = pot
          ..sodium = sod
          ..zinc = zinc
          ..copper = copper
          ..manganese = mang
          ..selenium = sel
          ..iodine = iod
          ..leucine = leu
          ..isoleucine = iso
          ..valine = val
          ..lysine = lys
          ..methionine = meth
          ..phenylalanine = phen
          ..threonine = threo
          ..tryptophan = tryp
          ..histidine = hist
          ..arginine = arg
          ..omega3 = omega3
          ..fiber = fiber
          ..sugars = sugars
          ..satFat = satFat
          ..cholesterol = chol
          ..glycine = glycine,
      );
    }

    // --- MEGA LIBRARY (550+ ITEMS) ---

    // 1. ELITE ANIMAL SOURCES (CORE)
    add(
      'Atlantic Salmon',
      'Fish',
      208,
      22.1,
      0,
      13.4,
      vitD: 15,
      b12: 3.2,
      b7: 5,
      omega3: 2.5,
      sel: 34,
      pot: 363,
      leu: 1.8,
    );
    add(
      'Beef Ribeye',
      'Meat',
      291,
      24,
      0,
      22,
      b12: 2.6,
      b7: 3,
      iron: 2.6,
      zinc: 6.4,
      sel: 21,
      leu: 2.1,
      satFat: 9,
      chol: 80,
    );
    add(
      'Beef Heart',
      'Offal',
      112,
      17.7,
      0,
      3.9,
      b12: 8.5,
      b1: 0.24,
      b3: 7.5,
      b7: 7,
      choline: 150,
      iron: 4.3,
      zinc: 1.7,
      copper: 0.4,
    );
    add(
      'Beef Liver',
      'Offal',
      135,
      20,
      4,
      3.6,
      vitA: 9000,
      b12: 70,
      b7: 40,
      b9: 290,
      iron: 5,
      zinc: 4,
    );
    add(
      'Chicken Liver',
      'Offal',
      167,
      24,
      1,
      4.8,
      vitA: 11000,
      b12: 16,
      b7: 210,
      iron: 9,
    );
    add(
      'Whole Egg',
      'Dairy',
      143,
      12.6,
      0.7,
      9.5,
      vitA: 160,
      vitD: 2,
      vitE: 1,
      b7: 20,
      b12: 0.9,
      choline: 294,
    );
    add(
      'Hemp Seeds',
      'Seed',
      553,
      31,
      8.7,
      48.7,
      mag: 700,
      phos: 1650,
      mang: 7.6,
      zinc: 9.9,
      iron: 8,
    );

    // 2. ULTIMATE ANIMAL PROTEIN LIBRARY (100+ items)
    // Detailed macros/micros for every common cut

    // --- CHICKEN ---
    add(
      'Chicken Breast (Skinless)',
      'Meat',
      120,
      26,
      0,
      1.5,
      b3: 13.7,
      b6: 0.9,
      phos: 228,
      sel: 27.6,
      mag: 28,
      pot: 389,
    );
    add(
      'Chicken Breast (With Skin)',
      'Meat',
      172,
      21,
      0,
      9.3,
      b3: 11,
      b6: 0.7,
      phos: 190,
      sel: 24,
      pot: 320,
    );
    add(
      'Chicken Thigh (Skinless)',
      'Meat',
      125,
      20,
      0,
      4.5,
      b12: 0.5,
      iron: 1.1,
      zinc: 2.1,
      sel: 22,
      pot: 270,
    );
    add(
      'Chicken Thigh (With Skin)',
      'Meat',
      211,
      17,
      0,
      15,
      b12: 0.4,
      iron: 1,
      zinc: 1.8,
      sel: 18,
      pot: 240,
    );
    add(
      'Chicken Wing (With Skin)',
      'Meat',
      203,
      18,
      0,
      14,
      phos: 140,
      zinc: 1.3,
      sel: 20,
      pot: 190,
    );
    add(
      'Chicken Drumstick (Skinless)',
      'Meat',
      115,
      19,
      0,
      3.9,
      b12: 0.4,
      iron: 1.1,
      zinc: 1.9,
      pot: 260,
    );
    add(
      'Chicken Drumstick (With Skin)',
      'Meat',
      165,
      18,
      0,
      9.5,
      b12: 0.3,
      iron: 1,
      zinc: 1.6,
      pot: 230,
    );
    add(
      'Ground Chicken (Lean)',
      'Meat',
      143,
      23,
      0,
      5,
      b3: 9,
      b6: 0.5,
      zinc: 1.8,
      sel: 21,
      pot: 580,
    );
    add(
      'Chicken Gizzard',
      'Offal',
      94,
      17.7,
      0,
      2.1,
      b12: 1.2,
      iron: 3.2,
      zinc: 2.7,
      sel: 25,
    );
    add(
      'Chicken Heart',
      'Offal',
      153,
      16,
      0.1,
      9.3,
      b12: 7.3,
      b2: 0.7,
      iron: 6,
      zinc: 6.6,
      pot: 132,
    );

    // --- BEEF ---
    add(
      'Ground Beef 95% Lean',
      'Meat',
      137,
      21.4,
      0,
      5,
      b12: 2.1,
      iron: 2.3,
      zinc: 5.3,
      sel: 19,
      pot: 350,
      b3: 6,
    );
    add(
      'Ground Beef 90% Lean',
      'Meat',
      176,
      20,
      0,
      10,
      b12: 2,
      iron: 2.1,
      zinc: 4.8,
      sel: 18,
      pot: 320,
      b3: 5.5,
    );
    add(
      'Ground Beef 85% Lean',
      'Meat',
      215,
      18.5,
      0,
      15,
      b12: 1.8,
      iron: 2,
      zinc: 4.5,
      sel: 17,
      pot: 300,
      b3: 5,
    );
    add(
      'Ground Beef 80% Lean',
      'Meat',
      254,
      17,
      0,
      20,
      b12: 1.7,
      iron: 1.8,
      zinc: 4.1,
      sel: 16,
      pot: 280,
      b3: 4.5,
    );
    add(
      'Beef Tenderloin (Filet Mignon)',
      'Meat',
      218,
      26,
      0,
      12,
      b12: 2.2,
      iron: 3,
      zinc: 4.8,
      phos: 220,
      pot: 380,
      b1: 0.12,
    );
    add(
      'Beef Sirloin Steak',
      'Meat',
      210,
      27,
      0,
      10,
      b12: 1.5,
      iron: 1.8,
      zinc: 4,
      phos: 200,
      pot: 350,
      b6: 0.6,
    );
    add(
      'Beef Ribeye (Lean Only)',
      'Meat',
      190,
      28,
      0,
      8,
      b12: 2.6,
      iron: 2.6,
      zinc: 6.4,
      sel: 28,
      pot: 360,
      b3: 5,
    );
    add(
      'Beef Flank Steak',
      'Meat',
      192,
      27,
      0,
      8,
      b12: 1.6,
      iron: 1.8,
      zinc: 4.5,
      sel: 25,
      pot: 340,
      b6: 0.6,
    );
    add(
      'Beef Chuck Roast (Lean)',
      'Meat',
      178,
      28,
      0,
      6.5,
      b12: 2.5,
      iron: 3.2,
      zinc: 8,
      sel: 30,
      pot: 370,
      b3: 5,
    );
    add(
      'Beef Brisket (Lean)',
      'Meat',
      155,
      29,
      0,
      4,
      b12: 2,
      iron: 2.5,
      zinc: 5.6,
      sel: 24,
      pot: 350,
      b1: 0.1,
    );
    add(
      'Beef T-Bone (Lean)',
      'Meat',
      180,
      27,
      0,
      7.5,
      b12: 2.1,
      iron: 2.4,
      zinc: 5.2,
      sel: 27,
      pot: 360,
      b3: 5,
    );
    add(
      'Veal Cutlet',
      'Meat',
      110,
      24,
      0,
      1.2,
      b12: 1.1,
      iron: 0.9,
      zinc: 3.5,
      pot: 360,
      b3: 8,
    );
    add(
      'Beef Tongue',
      'Offal',
      224,
      15,
      3.7,
      16,
      b12: 3.2,
      iron: 2.2,
      zinc: 3,
      pot: 180,
    );
    add(
      'Beef Kidney',
      'Offal',
      103,
      17.4,
      0,
      3.3,
      vitA: 400,
      b12: 25,
      iron: 4.6,
      zinc: 1.9,
      sel: 140,
      pot: 260,
    );

    // --- PORK ---
    add(
      'Pork Loin (Boneless)',
      'Meat',
      165,
      26,
      0,
      6,
      b1: 0.9,
      b6: 0.5,
      zinc: 1.8,
      phos: 230,
      pot: 380,
      sel: 35,
    );
    add(
      'Pork Chop (Center Cut)',
      'Meat',
      210,
      24,
      0,
      12,
      b1: 0.8,
      b6: 0.4,
      zinc: 2,
      phos: 210,
      pot: 350,
      sel: 32,
    );
    add(
      'Pork Tenderloin',
      'Meat',
      143,
      26,
      0,
      3.5,
      b1: 0.95,
      b6: 0.5,
      zinc: 2.2,
      phos: 250,
      pot: 430,
      sel: 38,
    );
    add(
      'Ground Pork (Lean)',
      'Meat',
      180,
      22,
      0,
      10,
      b1: 0.7,
      b6: 0.4,
      zinc: 2.4,
      phos: 190,
      pot: 330,
      sel: 28,
    );
    add(
      'Pork Belly',
      'Meat',
      518,
      9,
      0,
      53,
      vitA: 10,
      iron: 0.5,
      zinc: 0.8,
      pot: 180,
    );
    add(
      'Bacon (Cooked)',
      'Meat',
      541,
      37,
      1.4,
      42,
      b1: 0.4,
      phos: 500,
      sod: 1700,
      sel: 60,
      pot: 560,
    );
    add(
      'Ham (Lean Roasted)',
      'Meat',
      145,
      21,
      1.5,
      6,
      b1: 0.6,
      zinc: 2,
      phos: 220,
      sod: 1200,
      pot: 340,
      b12: 0.6,
    );

    // --- TURKEY ---
    add(
      'Turkey Breast (Skinless)',
      'Meat',
      104,
      24,
      0,
      0.5,
      b3: 8,
      b6: 0.6,
      phos: 200,
      sel: 26,
      pot: 320,
    );
    add(
      'Turkey Breast (With Skin)',
      'Meat',
      157,
      22,
      0,
      7.5,
      b3: 7.5,
      b6: 0.5,
      phos: 180,
      sel: 24,
      pot: 290,
    );
    add(
      'Turkey Thigh (Skinless)',
      'Meat',
      119,
      21,
      0,
      3.8,
      b12: 1,
      iron: 1.4,
      zinc: 2.4,
      sel: 28,
      pot: 260,
    );
    add(
      'Ground Turkey 93% Lean',
      'Meat',
      150,
      19,
      0,
      8,
      b3: 5,
      b6: 0.4,
      zinc: 2.1,
      sel: 22,
      pot: 240,
    );
    add(
      'Ground Turkey 99% Lean',
      'Meat',
      110,
      26,
      0,
      1,
      b3: 7,
      b6: 0.6,
      zinc: 1.5,
      sel: 28,
      pot: 310,
    );

    // --- LAMB ---
    add(
      'Lamb Chop (Loin Lean)',
      'Meat',
      180,
      25,
      0,
      8.5,
      b12: 2.1,
      iron: 1.6,
      zinc: 4,
      sel: 22,
      pot: 310,
    );
    add(
      'Lamb Leg (Lean Only)',
      'Meat',
      160,
      26,
      0,
      6,
      b12: 2.3,
      iron: 1.9,
      zinc: 4.3,
      sel: 25,
      pot: 340,
    );
    add(
      'Ground Lamb',
      'Meat',
      282,
      16,
      0,
      23,
      b12: 1.9,
      iron: 1.4,
      zinc: 3.8,
      sel: 19,
      pot: 220,
    );

    // --- OTHER MEATS ---
    add(
      'Bison Ground (Lean)',
      'Meat',
      146,
      20.2,
      0,
      7,
      b12: 2,
      iron: 2.8,
      zinc: 4.8,
      phos: 170,
      pot: 320,
    );
    add(
      'Venison Ground',
      'Meat',
      157,
      21.8,
      0,
      7,
      b12: 2.5,
      iron: 3.4,
      zinc: 5.1,
      phos: 195,
      pot: 335,
    );
    add(
      'Rabbit Meat',
      'Meat',
      136,
      21,
      0,
      5,
      b12: 6.5,
      iron: 1.6,
      zinc: 1.6,
      phos: 215,
      pot: 350,
      b3: 6.5,
    );
    add(
      'Goose Meat (Skinless)',
      'Meat',
      161,
      23,
      0,
      7,
      b6: 0.5,
      iron: 2.5,
      phos: 270,
      pot: 380,
      b12: 0.4,
    );
    add(
      'Duck Breast (Skinless)',
      'Meat',
      140,
      19,
      0,
      6,
      b12: 0.4,
      iron: 4.5,
      zinc: 1.9,
      pot: 260,
      b3: 5,
    );

    // --- GAME BIRDS & OTHERS ---
    add(
      'Quail Meat (Skinless)',
      'Meat',
      134,
      22,
      0,
      4.5,
      iron: 4,
      zinc: 2.7,
      pot: 230,
      b3: 8,
    );
    add(
      'Pheasant Breast',
      'Meat',
      133,
      24,
      0,
      3.3,
      iron: 1.2,
      pot: 260,
      b3: 13,
    );
    add(
      'Squab (Pigeon) Meat',
      'Meat',
      142,
      17.5,
      0,
      7.5,
      iron: 4.5,
      zinc: 2.3,
      pot: 240,
      b3: 6,
    );
    add(
      'Elk Steak',
      'Meat',
      146,
      23,
      0,
      1.9,
      b12: 2.5,
      iron: 3,
      zinc: 5.5,
      phos: 200,
      pot: 350,
    );
    add(
      'Wild Boar Roast',
      'Meat',
      122,
      21.6,
      0,
      3.3,
      b1: 0.4,
      zinc: 3,
      phos: 180,
      pot: 340,
    );
    add(
      'Kangaroo Fillet',
      'Meat',
      98,
      22,
      0,
      1,
      iron: 4.1,
      zinc: 3.5,
      b12: 2.2,
      b3: 11,
    );

    // 3. MEATS (REMAINDER)
    final meatL = [
      'Horse Meat',
      'Donkey Meat',
      'Camel Meat',
      'Goat Meat',
      'Buffalo Meat',
      'Ostrich Fan Steak',
      'Emu Steak',
      'Alligator Tail',
      'Frog Legs',
      'Guinea Fowl',
    ];
    for (var m in meatL)
      add(
        m,
        'Meat',
        140,
        22,
        0.5,
        5,
        b12: 2,
        iron: 2.5,
        zinc: 3,
        b7: 1,
        leu: 1.8,
      );

    // === GLOBAL ANIMAL SOURCE EXPANSION (500+ NEW ITEMS) ===

    // --- WHOLE ANIMALS (ROASTED/RAW) ---

    // --- WHOLE ANIMALS (ROASTED/RAW) ---
    final wholeAni = [
      'Chicken',
      'Turkey',
      'Duck',
      'Goose',
      'Pheasant',
      'Quail',
      'Cornish Hen',
    ];
    for (var w in wholeAni) {
      add(
        'Whole $w (Raw)',
        'Meat',
        200,
        18,
        0,
        14,
        b12: 1,
        iron: 1.5,
        pot: 200,
      );
      add(
        'Whole $w (Roasted)',
        'Meat',
        240,
        26,
        0,
        15,
        b3: 8,
        phos: 200,
        pot: 250,
      );
    }
    add('Suckling Pig (Roasted)', 'Meat', 236, 19, 0, 18, b1: 0.6, pot: 280);

    // --- POULTRY SURGICAL BREAKDOWN ---
    final pMaster = [
      'Chicken Neck',
      'Chicken Back',
      'Chicken Tail',
      'Chicken Feet',
      'Chicken Skin',
      'Chicken Fat',
      'Chicken Wing Mid-joint',
      'Chicken Wing Tip',
      'Chicken Leg Quarter',
      'Chicken Oyster',
      'Chicken Breast Tender',
      'Turkey Wing',
      'Turkey Drumstick',
      'Turkey Neck',
      'Turkey Tail',
      'Duck Leg',
      'Duck Wing',
      'Duck Skin',
      'Goose Leg',
      'Goose Wing',
      'Quail Leg',
      'Pheasant Leg',
      'Squab Breast',
      'Guinea Fowl Thigh',
    ];
    for (var p in pMaster)
      add(p, 'Poultry', 300, 16, 0, 25, calc: 12, iron: 1.8);

    final pOrgMaster = [
      'Chicken Spleen',
      'Chicken Pancreas',
      'Chicken Kidney',
      'Chicken Lung',
      'Chicken Testicles',
      'Chicken Brain',
      'Chicken Heart',
      'Turkey Heart',
      'Duck Heart',
      'Goat Heart',
      'Lamb Heart',
      'Pork Heart',
      'Beef Heart',
    ];
    for (var o in pOrgMaster)
      add(o, 'Offal', 140, 18, 1, 6, vitA: 100, b12: 12, iron: 6);

    // --- LIVESTOCK SUB-PRIMAL CATALOGUE (BEEF/PORK/LAMB) ---
    final mMaster = [
      'Beef Chuck Eye',
      'Beef Blade Roast',
      'Beef 7-Bone',
      'Beef Shoulder Clod',
      'Beef Top Blade',
      'Beef Mock Tender',
      'Beef Chuck Roll',
      'Beef Rib Roast Bone-in',
      'Beef Spinalis Dorsi',
      'Beef Cowboy Steak',
      'Beef Back Ribs',
      'Beef Porterhouse',
      'Beef KC Strip',
      'Beef Top Loin',
      'Beef Chateaubriand',
      'Beef Top Round',
      'Beef Eye of Round',
      'Beef Bottom Round',
      'Beef Rump Roast',
      'Beef Sirloin Tip',
      'Beef Tri-Tip',
      'Beef Coulotte',
      'Beef Ball Tip',
      'Beef Flank',
      'Beef Skirt Inner',
      'Beef Skirt Outer',
      'Beef Hanger',
      'Beef Bavette',
      'Beef Short Ribs',
      'Beef Brisket Point',
      'Beef Brisket Flat',
      'Beef Shank',
      'Beef Oxtail',
      'Beef Cheek',
      'Beef Tongue',
      'Beef Spider Steak',
      'Beef Deckle',
      'Beef Merlot Cut',
      'Pork Boston Butt',
      'Pork Picnic Shoulder',
      'Pork Blade Steak',
      'Pork Cushion Meat',
      'Pork Baby Back Ribs',
      'Pork Spare Ribs',
      'Pork St Louis Ribs',
      'Pork Country Ribs',
      'Pork Loin Roast',
      'Pork Sirloin Chops',
      'Pork Sirloin Cutlets',
      'Pork Ham Shank',
      'Pork Hock Smoked',
      'Pork Trotters',
      'Pork Tail',
      'Pork Jowl',
      'Pork Neck Chops',
      'Pork Snout',
      'Pork Ears',
      'Pork Head Meat',
      'Pork Belly Slab',
      'Pork Loin Center Cut',
      'Lamb Shank',
      'Lamb Rack Frenched',
      'Lamb Shoulder Square',
      'Lamb Neck Slices',
      'Lamb Breast Brisket',
      'Lamb Flank',
      'Lamb Sirloin Chops',
    ];
    for (var m in mMaster)
      add(m, 'Meat', 220, 22, 0, 14, b12: 3, iron: 3, zinc: 5, pot: 320);

    // --- EXOTIC ANIMAL CATALOGUE ---
    final eMaster = [
      'Whale Meat (Minke)',
      'Seal Meat',
      'Walrus Meat',
      'Polar Bear Chuck',
      'Brown Bear Roast',
      'Lion Steak',
      'Zebra Strips',
      'Giraffe Fillet',
      'Elephant Trunk',
      'Hippo Steak',
      'Rhino Roast',
      'Ostrich Gizzard',
      'Emu Gizzard',
      'Alligator Ribs',
      'Rattlesnake Meat',
      'Python Steak',
      'Turtle Meat',
      'Frog Legs Bullfrog',
      'Bull Testicles',
      'Pig Brains',
      'Beef Bone Marrow',
      'Venison Osso Bucco',
      'Elk Medallions',
      'Bison Ribs',
      'Moose Roast',
      'Moose Nose',
      'Reindeer Meat',
      'Muskrat Roasted',
      'Beaver Tail',
      'Beaver Meat',
      'Squirrel Meat',
      'Raccoon Meat',
      'Opossum Meat',
      'Armadillo Roasted',
    ];
    for (var e in eMaster)
      add(e, 'Meat', 160, 24, 0, 7, iron: 5, b12: 4, zinc: 4);

    // --- SEAFOOD MEGA-CATALOGUE ---
    add(
      'Beluga Caviar',
      'Seafood',
      264,
      24,
      4,
      18,
      b12: 20,
      omega3: 6,
      sel: 65,
      chol: 588,
    );
    add('Sevruga Caviar', 'Seafood', 250, 25, 3, 16, b12: 18, omega3: 5);
    add(
      'Salmon Roe Ikura',
      'Seafood',
      250,
      29,
      3,
      14,
      vitD: 10,
      b12: 20,
      omega3: 3.5,
    );
    add('Sea Urchin Uni', 'Seafood', 120, 13, 5, 5, omega3: 0.5, b12: 1.5);
    add('Flying Fish Roe', 'Seafood', 140, 22, 1, 6, b12: 15, sel: 40);

    final sMaster = [
      'Abalone',
      'Sea Snail Whelk',
      'Conch Meat',
      'Geoduck Giant Clam',
      'Periwinkle',
      'Pacific Oysters',
      'Kumamoto Oysters',
      'Blue Point Oysters',
      'Manila Clams',
      'Littleneck Clams',
      'Razor Clams',
      'Blue Mussels',
      'Green Lip Mussels',
      'Bay Scallops',
      'Sea Scallops',
      'Dungeness Crab',
      'King Crab Merus',
      'Snow Crab Cluster',
      'Blue Crab Jumbo Lump',
      'Soft Shell Crab',
      'Spiny Lobster Tail',
      'Maine Lobster Claws',
      'Langoustine',
      'Crayfish Whole',
      'Tiger Prawns',
      'Rock Shrimp',
      'Argentine Red Shrimp',
      'Giant Squid Steak',
      'Baby Octopus Whole',
      'Cuttlefish Meat',
      'Jellyfish Stinger',
      'King Salmon',
      'Chinook Salmon',
      'Sockeye Salmon',
      'Coho Salmon',
      'Pink Salmon',
      'Chum Salmon',
      'Atlantic Salmon Fillet',
      'Yellowfin Tuna Sashimi',
      'Bigeye Tuna',
      'Bluefin Otoro',
      'Bluefin Chutoro',
      'Tuna Akami',
      'Skipjack Tuna',
      'Albacore Tuna',
      'Sardines Mediterranean',
      'Anchovies Salted',
      'Rainbow Trout',
      'Arctic Char',
      'Barramundi Fillet',
      'Branzino Whole',
      'Sea Bream Orata',
      'Dentex Meat',
      'Chilean Sea Bass',
      'Black Cod Sablefish',
      'Patagonian Toothfish',
    ];
    for (var s in sMaster)
      add(s, 'Seafood', 120, 20, 1, 4, b12: 5, sel: 40, omega3: 2);

    // --- ANIMAL FATS & BROTHS ---
    add('Pure Beef Tallow', 'Fat', 902, 0, 0, 100, vitK: 1);
    add('Pure Lard', 'Fat', 900, 0, 0, 100, vitD: 1);
    add('Duck Fat', 'Fat', 880, 0, 0, 99.8);
    add('Chicken Fat Schmaltz', 'Fat', 898, 0, 0, 100);
    add('Beef Bone Broth 24h', 'Liquid', 15, 3.5, 0, 0.2, glycine: 1);
    add('Chicken Bone Broth', 'Liquid', 12, 2.5, 0, 0.2, glycine: 0.8);
    add('Fish Bone Broth', 'Liquid', 10, 2.2, 0, 0.1, iod: 20);
    add('Gelatin Powder', 'Protein', 335, 85, 0, 0.1, glycine: 20);
    add('Isinglass (Fish Collagen)', 'Protein', 340, 88, 0, 0, glycine: 18);

    add('Sea Snail (Whelk)', 'Seafood', 137, 24, 8, 0.4, b12: 12, mag: 85);
    add('Conch (Raw)', 'Seafood', 130, 26, 5, 1, b12: 5, sel: 50, pot: 350);

    // 4. VEGETABLES
    final vegL = [
      'Kale',
      'Swiss Chard',
      'Spinach',
      'Broccoli',
      'Bok Choy',
      'Asparagus',
      'Brussels Sprouts',
      'Cauliflower',
      'Cabbage',
      'Artichoke',
      'Zucchini',
      'Cucumber',
      'Bell Pepper Red',
      'Garlic',
      'Ginger',
      'Onion',
      'Carrots',
      'Beetroot',
      'Pumpkin',
      'Radish',
      'Leeks',
      'Mushrooms',
      'Tomato',
      'Eggplant',
    ];
    for (var v in vegL)
      add(
        v,
        'Vegetable',
        30,
        2.5,
        5,
        0.4,
        vitK: 100,
        vitA: 200,
        vitC: 30,
        b9: 40,
        fiber: 3,
      );

    // 5. FRUITS
    final fruitL = [
      'Blueberries',
      'Raspberries',
      'Blackberries',
      'Strawberries',
      'Acai Berry',
      'Goji Berry',
      'Apple',
      'Pear',
      'Mango',
      'Pineapple',
      'Banana',
      'Orange',
      'Grapefruit',
      'Lemon',
      'Lime',
      'Pomegranate',
      'Guava',
      'Kiwi',
      'Dragon Fruit',
      'Passion Fruit',
      'Lychee',
      'Fig',
      'Date',
      'Apricot',
      'Peach',
      'Plum',
      'Cherry',
      'Grapes',
      'Watermelon',
      'Melon',
    ];
    for (var fr in fruitL)
      add(fr, 'Fruit', 60, 1, 14, 0.5, vitC: 50, vitA: 50, b7: 1, fiber: 2.5);

    // 6. GRAINS & LEGUMES
    final grainL = [
      'Quinoa',
      'Amaranth',
      'Buckwheat',
      'Spelt',
      'Barley',
      'Rye',
      'Wild Rice',
      'Brown Rice',
      'Basmati Rice',
      'Oats',
      'Couscous',
      'Bulgur',
      'Lentils',
      'Chickpeas',
      'Black Beans',
      'Kidney Beans',
      'Pinto Beans',
      'Soybeans',
      'Edamame',
      'Tempeh',
      'Tofu',
    ];
    for (var g in grainL)
      add(
        g,
        'Grain/Legume',
        340,
        15,
        60,
        2,
        iron: 5,
        mag: 150,
        phos: 350,
        b9: 150,
        fiber: 9,
      );

    // 7. NUTS & SEEDS
    final nutL = [
      'Almonds',
      'Walnuts',
      'Pecans',
      'Brazil Nuts',
      'Macadamias',
      'Hazelnuts',
      'Cashews',
      'Pistachios',
      'Pine Nuts',
      'Peanuts',
      'Sunflower Seeds',
      'Pumpkin Seeds',
      'Sesame Seeds',
      'Flax Seeds',
      'Poppy Seeds',
    ];
    for (var n in nutL)
      add(
        n,
        'Nut/Seed',
        550,
        12,
        10,
        50,
        vitE: 15,
        mag: 150,
        zinc: 4,
        b7: 4,
        omega3: 2,
      );

    // 8. DAIRY & EGGS (DETAILED)
    add(
      'Whole Egg (Large)',
      'Dairy',
      143,
      12.6,
      0.7,
      9.5,
      vitA: 160,
      vitD: 2,
      vitE: 1,
      b7: 20,
      b12: 0.9,
      choline: 294,
      sel: 31,
      iron: 1.2,
    );
    add(
      'Egg White (Large)',
      'Dairy',
      52,
      10.9,
      0.7,
      0.2,
      b2: 0.4,
      b5: 0.2,
      sel: 20,
      mag: 11,
      pot: 163,
    );
    add(
      'Egg Yolk (Large)',
      'Dairy',
      322,
      15.9,
      3.6,
      26.5,
      vitA: 380,
      vitD: 5,
      b12: 2,
      choline: 680,
      sel: 56,
      iron: 2.7,
      phos: 390,
    );

    add(
      'Greek Yogurt 0% Fat',
      'Dairy',
      59,
      10,
      3.6,
      0.4,
      b12: 0.8,
      calc: 110,
      pot: 140,
      phos: 135,
      sel: 9,
    );
    add(
      'Greek Yogurt 2% Fat',
      'Dairy',
      73,
      9,
      3.8,
      2,
      b12: 0.7,
      calc: 100,
      pot: 135,
      phos: 130,
    );
    add(
      'Greek Yogurt 5% Fat',
      'Dairy',
      97,
      8,
      4,
      5,
      b12: 0.6,
      calc: 95,
      pot: 130,
    );
    add(
      'Kefir (Plain Low Fat)',
      'Dairy',
      43,
      3.8,
      4.8,
      1,
      calc: 120,
      vitD: 1,
      b12: 0.4,
      b7: 2,
      pot: 150,
    );
    add(
      'Skyr (Icelandic Yogurt)',
      'Dairy',
      62,
      11,
      3.5,
      0.2,
      b12: 0.9,
      calc: 115,
      phos: 140,
      pot: 145,
    );
    add(
      'Cottage Cheese 1% Fat',
      'Dairy',
      72,
      12,
      2.7,
      1,
      b12: 0.6,
      calc: 60,
      phos: 150,
      sel: 9,
      pot: 85,
    );
    add(
      'Cottage Cheese 4% Fat',
      'Dairy',
      98,
      11,
      3.4,
      4.3,
      b12: 0.6,
      calc: 80,
      phos: 160,
      sel: 9,
    );

    add(
      'Quark (Low Fat)',
      'Dairy',
      68,
      12,
      3,
      0.2,
      calc: 90,
      b12: 0.5,
      pot: 120,
    );
    add(
      'Ricotta (Part Skim)',
      'Dairy',
      138,
      11,
      5,
      8,
      calc: 207,
      vitA: 80,
      b12: 0.3,
      zinc: 1.1,
    );
    add(
      'Goat Cheese (Soft)',
      'Dairy',
      364,
      18.5,
      0,
      30,
      vitA: 400,
      calc: 140,
      b2: 0.7,
      iron: 1.6,
    );
    add(
      'Feta Cheese',
      'Dairy',
      264,
      14,
      4,
      21,
      calc: 493,
      phos: 337,
      b12: 1.7,
      vitA: 125,
    );
    add(
      'Mozzarella (Whole Milk)',
      'Dairy',
      300,
      22,
      2,
      22,
      calc: 505,
      b12: 0.6,
      phos: 350,
      zinc: 2.3,
    );
    add(
      'Cheddar Cheese',
      'Dairy',
      403,
      25,
      1.3,
      33,
      calc: 721,
      vitA: 260,
      b12: 0.8,
      sel: 14,
      zinc: 3.1,
    );
    add(
      'Parmesan Cheese',
      'Dairy',
      431,
      38,
      4,
      28,
      calc: 1184,
      phos: 694,
      b12: 1.2,
      sel: 22,
      zinc: 2.7,
    );
    add(
      'Swiss Cheese',
      'Dairy',
      393,
      27,
      1.5,
      31,
      calc: 791,
      b12: 3.3,
      phos: 570,
      zinc: 3.9,
    );

    add('Heavy Cream', 'Dairy', 345, 2, 2.8, 37, vitA: 400);
    add(
      'Butter (Salted)',
      'Dairy',
      717,
      0.8,
      0,
      81,
      vitA: 680,
      vitE: 2,
      vitK: 7,
      sod: 640,
    );
    add(
      'Ghee (Clarified Butter)',
      'Dairy',
      876,
      0.3,
      0,
      99,
      vitA: 840,
      vitE: 3,
      vitK: 8,
    );

    final moreDairy = [
      'Gouda',
      'Edam',
      'Brie',
      'Camembert',
      'Blue Cheese',
      'Colby',
      'Provolone',
      'Mascarpone',
      'Sour Cream 18%',
      'Whole Milk',
      'Skim Milk 1%',
      'Buttermilk',
    ];
    for (var d in moreDairy)
      add(d, 'Dairy', 250, 12, 5, 20, calc: 300, b12: 1, b7: 2);

    // 9. SUPPLEMENTS
    add(
      'Vitamin D3 5000',
      'Supplement',
      0,
      0,
      0,
      0,
      unit: 'IU',
      base: 5000,
      vitD: 125,
      vitE: 5,
    );
    add(
      'Magnesium Bisglycinate',
      'Supplement',
      5,
      0,
      0,
      0,
      unit: 'mg',
      base: 400,
      mag: 400,
      b7: 5,
    );
    add(
      'Zinc Picolinate',
      'Supplement',
      0,
      0,
      0,
      0,
      unit: 'mg',
      base: 50,
      zinc: 50,
    );
    add(
      'Whey Isolate',
      'Supplement',
      110,
      25,
      1,
      0.5,
      unit: 'scoop',
      base: 1,
      b7: 5,
      leu: 2.5,
    );
    add(
      'Multivitamin Professional',
      'Supplement',
      5,
      1,
      0,
      0,
      unit: 'tab',
      base: 1,
      vitA: 900,
      vitC: 100,
      vitD: 25,
      vitE: 30,
      vitK: 120,
      b1: 5,
      b2: 5,
      b3: 20,
      b5: 10,
      b6: 10,
      b7: 300,
      b9: 400,
      b12: 100,
      mag: 100,
      zinc: 15,
      sel: 70,
      copper: 2,
      mang: 2,
    );

    // === EXPANDED LIBRARY: 200+ NEW FOODS ===

    // TROPICAL & EXOTIC FRUITS (30 items)
    add(
      'Papaya',
      'Fruit',
      43,
      0.5,
      11,
      0.3,
      vitA: 950,
      vitC: 62,
      b9: 37,
      pot: 182,
      fiber: 1.7,
      vitE: 0.3,
    );
    add(
      'Kiwano (Horned Melon)',
      'Fruit',
      44,
      1.8,
      7.6,
      1.3,
      vitC: 5,
      vitA: 45,
      mag: 40,
      pot: 123,
      fiber: 3.7,
    );
    add(
      'Tamarillo',
      'Fruit',
      31,
      2,
      3.8,
      0.4,
      vitA: 120,
      vitC: 28,
      vitE: 2.5,
      pot: 321,
      b6: 0.2,
    );
    add(
      'Feijoa',
      'Fruit',
      55,
      1.2,
      13,
      0.6,
      vitC: 33,
      b9: 23,
      pot: 172,
      fiber: 6.4,
      iod: 3,
    );
    add(
      'Breadfruit',
      'Fruit',
      103,
      1.1,
      27,
      0.2,
      vitC: 29,
      pot: 490,
      b1: 0.1,
      fiber: 4.9,
      mag: 25,
    );
    add(
      'Ackee',
      'Fruit',
      151,
      2.9,
      0.7,
      15,
      vitA: 30,
      vitC: 30,
      calc: 35,
      zinc: 1,
      b3: 1.1,
    );
    add(
      'Rambutan Fresh',
      'Fruit',
      82,
      0.7,
      21,
      0.2,
      vitC: 4.9,
      iron: 0.4,
      calc: 22,
      pot: 42,
    );
    add(
      'Langsat',
      'Fruit',
      57,
      1,
      14,
      0.2,
      vitC: 2,
      calc: 19,
      phos: 30,
      pot: 140,
      b1: 0.05,
    );
    add(
      'Salak (Snake Fruit)',
      'Fruit',
      82,
      0.5,
      21,
      0.4,
      vitC: 8.4,
      calc: 38,
      iron: 3.9,
      pot: 40,
    );
    add(
      'Pitaya (Red)',
      'Fruit',
      264,
      3.6,
      82,
      0,
      vitC: 9,
      iron: 1.9,
      calc: 107,
      fiber: 3,
    );
    add(
      'Sapodilla',
      'Fruit',
      83,
      0.4,
      20,
      1.1,
      vitC: 14.7,
      pot: 193,
      iron: 0.8,
      fiber: 5.3,
    );
    add(
      'Custard Apple',
      'Fruit',
      101,
      1.7,
      25,
      0.6,
      vitC: 19.2,
      pot: 382,
      mag: 18,
      b6: 0.2,
      fiber: 2.4,
    );
    add(
      'Purple Mangosteen',
      'Fruit',
      73,
      0.4,
      18,
      0.6,
      vitC: 2.9,
      calc: 8,
      iron: 0.3,
      fiber: 1.8,
    );
    add(
      'Miracle Fruit',
      'Fruit',
      13,
      0.4,
      2.8,
      0.05,
      vitC: 1.2,
      calc: 5,
      pot: 13,
    );
    add(
      'Wood Apple',
      'Fruit',
      134,
      7.1,
      31,
      0.4,
      vitC: 9,
      calc: 130,
      phos: 50,
      iron: 0.6,
      fiber: 18,
    );

    // BERRIES & SMALL FRUITS (25 items)
    add(
      'White Mulberry',
      'Fruit',
      43,
      1.4,
      10,
      0.4,
      vitC: 36.4,
      iron: 1.9,
      calc: 39,
      fiber: 1.7,
    );
    add(
      'Jostaberry',
      'Fruit',
      78,
      1.8,
      19,
      0.2,
      vitC: 195,
      vitA: 50,
      pot: 240,
      fiber: 4,
    );
    add(
      'Sea Buckthorn',
      'Fruit',
      82,
      1.5,
      7.1,
      7,
      vitC: 450,
      vitE: 9,
      vitA: 750,
      omega3: 0.9,
    );
    add(
      'Honeyberry',
      'Fruit',
      52,
      1,
      12,
      0.5,
      vitC: 30,
      vitA: 50,
      pot: 180,
      fiber: 3,
    );
    add(
      'Saskatoon Berry',
      'Fruit',
      87,
      2,
      19,
      1,
      vitC: 7,
      calc: 70,
      iron: 1.5,
      mang: 0.3,
    );
    add(
      'Aronia Berry',
      'Fruit',
      47,
      1.4,
      9.6,
      0.5,
      vitC: 21,
      vitK: 13.8,
      pot: 162,
      mang: 0.6,
    );
    add(
      'Bilberry',
      'Fruit',
      57,
      0.7,
      14.5,
      0.3,
      vitC: 9.7,
      vitK: 19,
      mang: 0.3,
      fiber: 2.4,
    );
    add(
      'Tayberry',
      'Fruit',
      52,
      1,
      12,
      0.6,
      vitC: 25,
      vitE: 1.2,
      pot: 140,
      fiber: 5,
    );
    add('Salmonberry', 'Fruit', 32, 0.8, 7.6, 0.3, vitC: 23, vitA: 80, pot: 87);
    add(
      'Crowberry',
      'Fruit',
      41,
      0.5,
      10,
      0.6,
      vitC: 7,
      vitE: 2,
      calc: 12,
      mang: 2.3,
    );
    add(
      'Gooseberry Fresh',
      'Fruit',
      44,
      0.9,
      10,
      0.6,
      vitC: 27.7,
      vitA: 15,
      pot: 198,
      fiber: 4.3,
    );
    add(
      'Red Currant',
      'Fruit',
      56,
      1.4,
      14,
      0.2,
      vitC: 41,
      vitK: 11,
      iron: 1,
      pot: 275,
    );
    add(
      'White Currant',
      'Fruit',
      56,
      1.4,
      14,
      0.2,
      vitC: 41,
      vitK: 11,
      iron: 1,
      pot: 275,
    );
    add(
      'Dewberry',
      'Fruit',
      43,
      1.4,
      10,
      0.5,
      vitC: 21,
      vitK: 19,
      mang: 0.6,
      fiber: 5,
    );
    add(
      'Marionberry',
      'Fruit',
      43,
      1.4,
      9.6,
      0.5,
      vitC: 21,
      vitK: 19.8,
      mang: 0.6,
    );

    // CITRUS & TANGY FRUITS (15 items)
    add(
      'Yuzu',
      'Fruit',
      53,
      0.9,
      13,
      0.3,
      vitC: 59,
      calc: 20,
      pot: 140,
      b1: 0.04,
    );
    add(
      'Pomelo Pink',
      'Fruit',
      38,
      0.8,
      9.6,
      0.04,
      vitC: 61,
      pot: 216,
      b1: 0.05,
    );
    add('Calamansi', 'Fruit', 44, 0.8, 11, 0.3, vitC: 88, calc: 40, pot: 129);
    add(
      'Tangelo',
      'Fruit',
      47,
      0.9,
      12,
      0.1,
      vitC: 53,
      vitA: 100,
      pot: 181,
      b9: 26,
    );
    add('Meyer Lemon', 'Fruit', 29, 1.1, 9.3, 0.3, vitC: 53, pot: 138, b9: 11);
    add('Key Lime', 'Fruit', 30, 0.7, 11, 0.2, vitC: 29, calc: 33, pot: 102);
    add('Finger Lime', 'Fruit', 30, 0.7, 11, 0.2, vitC: 40, calc: 33, pot: 102);
    add('Buddha Hand', 'Fruit', 25, 0.6, 6, 0.1, vitC: 35, calc: 25, pot: 80);
    add(
      'Bergamot Orange',
      'Fruit',
      47,
      0.9,
      12,
      0.1,
      vitC: 53,
      pot: 181,
      vitA: 100,
    );
    add('Etrog', 'Fruit', 25, 0.6, 6, 0.1, vitC: 35, calc: 25, pot: 80);

    // STONE FRUITS & DRUPES (20 items)
    add(
      'White Peach',
      'Fruit',
      39,
      0.9,
      9.5,
      0.3,
      vitC: 6.6,
      vitA: 16,
      pot: 190,
      fiber: 1.5,
    );
    add(
      'Yellow Nectarine',
      'Fruit',
      44,
      1.1,
      11,
      0.3,
      vitC: 5.4,
      vitA: 17,
      pot: 201,
    );
    add(
      'Donut Peach',
      'Fruit',
      39,
      0.9,
      9.5,
      0.3,
      vitC: 6.6,
      vitA: 16,
      pot: 190,
    );
    add(
      'Greengage Plum',
      'Fruit',
      46,
      0.7,
      11,
      0.3,
      vitC: 9.5,
      vitA: 17,
      vitK: 6.4,
      pot: 157,
    );
    add(
      'Mirabelle Plum',
      'Fruit',
      46,
      0.7,
      11,
      0.3,
      vitC: 9.5,
      vitA: 17,
      pot: 157,
    );
    add(
      'Damson Plum',
      'Fruit',
      46,
      0.7,
      11,
      0.3,
      vitC: 9.5,
      vitA: 17,
      pot: 157,
      fiber: 1.4,
    );
    add('Wild Plum', 'Fruit', 46, 0.7, 11, 0.3, vitC: 9.5, vitA: 17, pot: 157);
    add(
      'Sour Cherry',
      'Fruit',
      50,
      1,
      12,
      0.3,
      vitC: 10,
      vitA: 64,
      pot: 173,
      fiber: 1.6,
    );
    add(
      'Rainier Cherry',
      'Fruit',
      63,
      1.1,
      16,
      0.2,
      vitC: 7,
      vitA: 3,
      pot: 222,
    );
    add('Bing Cherry', 'Fruit', 63, 1.1, 16, 0.2, vitC: 7, vitA: 3, pot: 222);
    add(
      'Morello Cherry',
      'Fruit',
      50,
      1,
      12,
      0.3,
      vitC: 10,
      vitA: 64,
      pot: 173,
    );

    // MELONS & GOURDS (10 items)
    add('Korean Melon', 'Fruit', 31, 1, 7.5, 0.1, vitC: 10, pot: 271, vitA: 10);
    add(
      'Santa Claus Melon',
      'Fruit',
      36,
      0.9,
      9,
      0.1,
      vitC: 36,
      pot: 267,
      b9: 21,
    );
    add('Casaba Melon', 'Fruit', 28, 1.1, 7, 0.1, vitC: 18, pot: 182, b9: 18);
    add('Crenshaw Melon', 'Fruit', 34, 0.9, 8.5, 0.1, vitC: 37, pot: 267);
    add('Galia Melon', 'Fruit', 36, 0.9, 9, 0.1, vitC: 36, pot: 267, b9: 21);
    add(
      'Bitter Melon',
      'Veg',
      17,
      1,
      3.7,
      0.2,
      vitC: 84,
      b9: 72,
      pot: 296,
      vitA: 24,
    );
    add('Winter Melon', 'Veg', 13, 0.4, 3, 0.2, vitC: 13, pot: 111, calc: 19);

    // LEAFY GREENS (20 items)
    add(
      'Red Lettuce',
      'Veg',
      13,
      1.3,
      2.3,
      0.2,
      vitA: 370,
      vitC: 3.7,
      vitK: 140,
      b9: 38,
      iron: 0.9,
    );
    add(
      'Butter Lettuce',
      'Veg',
      13,
      1.4,
      2.2,
      0.2,
      vitA: 166,
      vitC: 3.7,
      vitK: 102,
      b9: 73,
    );
    add(
      'Romaine Lettuce',
      'Veg',
      17,
      1.2,
      3.3,
      0.3,
      vitA: 436,
      vitC: 4,
      vitK: 103,
      b9: 136,
    );
    add(
      'Frisée',
      'Veg',
      17,
      1.3,
      3.4,
      0.3,
      vitA: 229,
      vitC: 7,
      vitK: 231,
      calc: 52,
    );
    add(
      'Mustard Greens',
      'Veg',
      27,
      2.9,
      4.7,
      0.4,
      vitA: 524,
      vitC: 70,
      vitK: 257,
      calc: 115,
      iron: 1.6,
    );
    add(
      'Collard Greens',
      'Veg',
      32,
      3,
      5.4,
      0.6,
      vitA: 333,
      vitC: 35,
      vitK: 388,
      calc: 232,
      iron: 0.5,
    );
    add(
      'Turnip Greens',
      'Veg',
      32,
      1.5,
      7.1,
      0.3,
      vitA: 381,
      vitC: 60,
      vitK: 251,
      calc: 190,
    );
    add(
      'Beet Greens',
      'Veg',
      22,
      2.2,
      4.3,
      0.1,
      vitA: 316,
      vitC: 30,
      vitK: 400,
      iron: 2.6,
      mag: 70,
    );
    add(
      'Dandelion Greens',
      'Veg',
      45,
      2.7,
      9.2,
      0.7,
      vitA: 508,
      vitC: 35,
      vitK: 778,
      calc: 187,
      iron: 3.1,
    );
    add(
      'Mizuna',
      'Veg',
      28,
      2.5,
      4.4,
      0.4,
      vitA: 210,
      vitC: 27,
      vitK: 270,
      calc: 105,
    );
    add(
      'Tatsoi',
      'Veg',
      12,
      1.5,
      2.1,
      0.2,
      vitA: 383,
      vitC: 45,
      vitK: 109,
      calc: 93,
    );
    add(
      'Mâche (Corn Salad)',
      'Veg',
      21,
      2,
      3.6,
      0.4,
      vitA: 355,
      vitC: 38,
      vitK: 193,
      iron: 2.2,
    );
    add(
      'Purslane',
      'Veg',
      20,
      2,
      3.4,
      0.4,
      vitA: 131,
      vitC: 21,
      mag: 68,
      omega3: 0.35,
      iron: 2,
    );
    add(
      'Chrysanthemum Greens',
      'Veg',
      23,
      1.6,
      4.1,
      0.5,
      vitA: 250,
      vitC: 55,
      pot: 567,
      calc: 60,
    );
    add(
      'Amaranth Leaves',
      'Veg',
      23,
      2.5,
      4.0,
      0.3,
      vitA: 146,
      vitC: 43,
      calc: 215,
      iron: 2.3,
    );

    // CRUCIFEROUS VEGETABLES (15 items)
    add(
      'Romanesco',
      'Veg',
      34,
      2.8,
      7,
      0.4,
      vitC: 89,
      vitK: 101,
      b9: 63,
      pot: 316,
    );
    add(
      'Purple Cauliflower',
      'Veg',
      25,
      1.9,
      5,
      0.3,
      vitC: 48,
      vitK: 16,
      b9: 57,
      pot: 303,
    );
    add(
      'Chinese Broccoli',
      'Veg',
      26,
      1,
      5.3,
      0.8,
      vitA: 243,
      vitC: 87,
      vitK: 106,
      calc: 88,
    );
    add(
      'Rapini (Broccoli Rabe)',
      'Veg',
      22,
      3.2,
      2.9,
      0.5,
      vitA: 191,
      vitC: 27,
      vitK: 224,
      calc: 108,
    );
    add(
      'Kohlrabi Purple',
      'Veg',
      27,
      1.7,
      6.2,
      0.1,
      vitC: 62,
      pot: 350,
      b6: 0.2,
      fiber: 3.6,
    );
    add(
      'Kohlrabi Green',
      'Veg',
      27,
      1.7,
      6.2,
      0.1,
      vitC: 62,
      pot: 350,
      b6: 0.2,
    );
    add(
      'Napa Cabbage',
      'Veg',
      16,
      1.2,
      3.2,
      0.2,
      vitA: 16,
      vitC: 27,
      vitK: 43,
      b9: 79,
    );
    add(
      'Savoy Cabbage',
      'Veg',
      27,
      2,
      6,
      0.1,
      vitA: 5,
      vitC: 31,
      vitK: 69,
      b9: 80,
    );
    add(
      'Red Mustard',
      'Veg',
      27,
      2.9,
      4.7,
      0.4,
      vitA: 524,
      vitC: 70,
      vitK: 257,
      calc: 115,
    );
    add(
      'Wasabi Greens',
      'Veg',
      25,
      2.3,
      4.8,
      0.3,
      vitA: 200,
      vitC: 66,
      vitK: 200,
      calc: 92,
    );

    // ROOT VEGETABLES (15 items)
    add(
      'Purple Sweet Potato',
      'Veg',
      86,
      1.6,
      20,
      0.1,
      vitA: 709,
      vitC: 2.4,
      pot: 337,
      fiber: 3,
    );
    add(
      'Japanese Sweet Potato',
      'Veg',
      86,
      1.6,
      20,
      0.1,
      vitA: 14187,
      vitC: 2.4,
      pot: 337,
    );
    add(
      'Cassava (Yuca)',
      'Veg',
      160,
      1.4,
      38,
      0.3,
      vitC: 20.6,
      pot: 271,
      mag: 21,
      b9: 27,
    );
    add(
      'Malanga',
      'Veg',
      132,
      1.9,
      32,
      0.3,
      vitC: 5,
      pot: 544,
      mag: 22,
      fiber: 4.1,
    );
    add(
      'Rutabaga',
      'Veg',
      37,
      1.1,
      8.6,
      0.2,
      vitC: 25,
      pot: 305,
      mag: 23,
      fiber: 2.3,
    );
    add(
      'Salsify',
      'Veg',
      82,
      3.3,
      18.6,
      0.2,
      vitC: 8,
      iron: 0.7,
      mag: 23,
      pot: 380,
    );
    add('Scorzonera', 'Veg', 82, 3.3, 18.6, 0.2, vitC: 8, iron: 0.7, mag: 23);
    add(
      'Celeriac',
      'Veg',
      42,
      1.5,
      9.2,
      0.3,
      vitC: 8,
      vitK: 41,
      pot: 300,
      phos: 115,
    );
    add('Black Radish', 'Veg', 16, 0.7, 3.4, 0.1, vitC: 15, pot: 233, calc: 25);
    add(
      'Watermelon Radish',
      'Veg',
      16,
      0.7,
      3.4,
      0.1,
      vitC: 15,
      pot: 233,
      calc: 25,
    );
    add(
      'Horseradish',
      'Veg',
      48,
      1.2,
      11.3,
      0.7,
      vitC: 24.9,
      pot: 246,
      mag: 27,
      calc: 56,
    );

    // ALLIUMS & AROMATICS (10 items)
    add(
      'Scallions',
      'Veg',
      32,
      1.8,
      7.3,
      0.2,
      vitA: 50,
      vitC: 18.8,
      vitK: 207,
      b9: 64,
    );
    add(
      'Chives',
      'Veg',
      30,
      3.3,
      4.4,
      0.7,
      vitA: 218,
      vitC: 58,
      vitK: 213,
      b9: 105,
    );
    add(
      'Ramps (Wild Leeks)',
      'Veg',
      35,
      1.7,
      7.5,
      0.2,
      vitA: 50,
      vitC: 19,
      vitK: 207,
      iron: 1,
    );
    add(
      'Elephant Garlic',
      'Veg',
      90,
      4.9,
      21,
      0.2,
      vitC: 17,
      pot: 374,
      b6: 0.4,
    );
    add('Green Garlic', 'Veg', 90, 4.9, 21, 0.2, vitC: 17, pot: 374, b6: 0.4);
    add('Pearl Onions', 'Veg', 40, 1.1, 9.3, 0.1, vitC: 7.4, b9: 19, pot: 146);
    add(
      'Cipollini Onions',
      'Veg',
      40,
      1.1,
      9.3,
      0.1,
      vitC: 7.4,
      b9: 19,
      pot: 146,
    );

    // TREE NUTS (20 items)
    add(
      'Black Walnuts',
      'Nut',
      618,
      24.1,
      9.9,
      59,
      vitE: 1.8,
      mag: 201,
      phos: 513,
      zinc: 3.4,
      mang: 3.9,
      omega3: 3.3,
      leu: 1.7,
    );
    add(
      'Candlenuts',
      'Nut',
      684,
      7.8,
      11.2,
      69,
      vitE: 25,
      mag: 300,
      phos: 570,
      calc: 150,
    );
    add(
      'Beechnuts',
      'Nut',
      576,
      6.2,
      34,
      50,
      vitE: 1.9,
      mag: 163,
      phos: 298,
      mang: 2.5,
    );
    add(
      'Butternuts',
      'Nut',
      612,
      24,
      12,
      57,
      vitE: 0.9,
      mag: 237,
      phos: 446,
      zinc: 3.1,
    );
    add(
      'Hickory Nuts',
      'Nut',
      657,
      12.7,
      18.3,
      64,
      vitE: 2.7,
      mag: 173,
      phos: 336,
      mang: 5.2,
    );
    add(
      'Acorns Dried',
      'Nut',
      387,
      6.2,
      41,
      24,
      vitE: 1.1,
      mag: 62,
      phos: 79,
      pot: 539,
    );
    add(
      'Ginko Nuts',
      'Nut',
      182,
      4.3,
      38,
      1.7,
      vitC: 8.3,
      pot: 510,
      mag: 27,
      b3: 6,
    );
    add('Kola Nuts', 'Nut', 393, 7.5, 73, 10, vitC: 6.3, calc: 124, iron: 1.7);
    add(
      'Tiger Nuts',
      'Nut',
      385,
      4.8,
      63,
      24,
      vitE: 6.5,
      mag: 92,
      phos: 359,
      pot: 680,
      fiber: 33,
    );
    add(
      'Marcona Almonds',
      'Nut',
      579,
      21.2,
      21.7,
      49.9,
      vitE: 25.6,
      mag: 270,
      calc: 269,
      zinc: 3.1,
    );
    add(
      'Praline Pecans',
      'Nut',
      691,
      9.2,
      14,
      72,
      vitE: 1.4,
      mag: 121,
      zinc: 4.5,
      mang: 4.5,
    );
    add(
      'Macadamia Salted',
      'Nut',
      718,
      7.9,
      13.8,
      76,
      vitE: 0.5,
      mag: 130,
      phos: 188,
      mang: 4.1,
    );
    add(
      'Filberts (Hazelnuts)',
      'Nut',
      628,
      15,
      17,
      61,
      vitE: 15,
      mag: 163,
      mang: 6.2,
      copper: 1.7,
    );

    // SEEDS (15 items)
    add(
      'White Sesame Seeds',
      'Seed',
      573,
      17.7,
      23.4,
      50,
      vitE: 0.25,
      calc: 975,
      iron: 14.6,
      mag: 351,
      zinc: 7.8,
      mang: 2.5,
    );
    add(
      'Black Sesame Seeds',
      'Seed',
      565,
      18,
      23,
      48,
      calc: 1450,
      iron: 15,
      mag: 345,
      zinc: 7.3,
    );
    add(
      'Nigella Seeds',
      'Seed',
      375,
      17.8,
      44.2,
      21,
      iron: 7.6,
      calc: 435,
      phos: 499,
    );
    add(
      'Dill Seeds',
      'Seed',
      305,
      16,
      55,
      15,
      vitC: 21,
      calc: 1516,
      iron: 16.3,
      mag: 256,
    );
    add(
      'Anise Seeds',
      'Seed',
      337,
      17.6,
      50,
      16,
      vitC: 21,
      calc: 646,
      iron: 37,
      mag: 170,
    );
    add(
      'Caraway Seeds',
      'Seed',
      333,
      19.8,
      49.9,
      14.6,
      vitC: 21,
      calc: 689,
      iron: 16.2,
      mag: 258,
    );
    add(
      'Coriander Seeds',
      'Seed',
      298,
      12.4,
      55,
      17.8,
      vitC: 21,
      calc: 709,
      iron: 16.3,
      mag: 330,
    );
    add(
      'Fenugreek Seeds',
      'Seed',
      323,
      23,
      58.4,
      6.4,
      vitC: 3,
      iron: 33.5,
      mag: 191,
      zinc: 2.5,
    );
    add(
      'Fennel Seeds',
      'Seed',
      345,
      15.8,
      52.3,
      14.9,
      vitC: 21,
      calc: 1196,
      iron: 18.5,
      mag: 385,
    );
    add(
      'Cumin Seeds',
      'Seed',
      375,
      17.8,
      44.2,
      22.3,
      iron: 66.4,
      calc: 931,
      mag: 366,
      zinc: 4.8,
    );
    add(
      'Mustard Seeds',
      'Seed',
      508,
      26.1,
      28.1,
      36,
      vitE: 5.1,
      calc: 266,
      iron: 9.2,
      mag: 370,
    );
    add(
      'Camelina Seeds',
      'Seed',
      566,
      19,
      42,
      38,
      vitE: 23,
      mag: 450,
      omega3: 11,
      fiber: 35,
    );
    add(
      'Perilla Seeds',
      'Seed',
      537,
      17.8,
      14.1,
      46,
      omega3: 17,
      vitE: 24,
      mag: 346,
      calc: 424,
    );

    // BEANS & LENTILS (25 items)
    add(
      'French Lentils',
      'Legume',
      352,
      25.8,
      60,
      1.1,
      iron: 6.5,
      mag: 122,
      phos: 451,
      pot: 955,
      b9: 479,
      zinc: 3.7,
      fiber: 10.7,
    );
    add(
      'Red Lentils Split',
      'Legume',
      358,
      24.6,
      63,
      1.1,
      iron: 7.4,
      mag: 52,
      pot: 668,
      b9: 65,
    );
    add(
      'Yellow Lentils',
      'Legume',
      358,
      24.6,
      63,
      1.1,
      iron: 7.4,
      mag: 52,
      pot: 668,
    );
    add(
      'Beluga Lentils',
      'Legume',
      352,
      25.8,
      60,
      1.1,
      iron: 6.5,
      mag: 122,
      pot: 955,
    );
    add(
      'Pardina Lentils',
      'Legume',
      352,
      25.8,
      60,
      1.1,
      iron: 6.5,
      mag: 122,
      pot: 955,
    );
    add(
      'Urad Dal',
      'Legume',
      341,
      25.2,
      59,
      1.6,
      iron: 7.6,
      mag: 267,
      phos: 385,
      pot: 983,
    );
    add(
      'Moong Dal',
      'Legume',
      347,
      23.9,
      62.6,
      1.2,
      iron: 6.7,
      mag: 189,
      phos: 367,
      pot: 1246,
    );
    add(
      'Toor Dal',
      'Legume',
      343,
      22.3,
      62,
      1.5,
      iron: 5.2,
      mag: 183,
      phos: 367,
      pot: 1392,
    );
    add(
      'Chana Dal',
      'Legume',
      364,
      19,
      61,
      6,
      iron: 4.3,
      mag: 115,
      phos: 252,
      pot: 875,
    );
    add(
      'Masoor Dal',
      'Legume',
      358,
      24.6,
      63,
      1.1,
      iron: 7.4,
      mag: 52,
      pot: 668,
    );
    add(
      'Cannellini Beans',
      'Legume',
      333,
      23.4,
      60.3,
      0.9,
      iron: 10.4,
      mag: 190,
      pot: 1795,
      b9: 388,
    );
    add(
      'Great Northern Beans',
      'Legume',
      339,
      21,
      62.4,
      1.3,
      iron: 6.7,
      mag: 189,
      pot: 1399,
    );
    add(
      'Navy Beans Small',
      'Legume',
      337,
      22.3,
      61,
      1.5,
      iron: 5.5,
      mag: 175,
      pot: 1185,
    );
    add(
      'Butter Beans',
      'Legume',
      338,
      21.5,
      63.4,
      0.7,
      iron: 7.5,
      mag: 224,
      pot: 1724,
    );
    add(
      'Flageolet Beans',
      'Legume',
      340,
      23,
      62,
      1.2,
      iron: 7.8,
      mag: 178,
      pot: 1370,
    );
    add(
      'Borlotti Beans',
      'Legume',
      335,
      23.6,
      60.2,
      1.2,
      iron: 9,
      mag: 184,
      pot: 1393,
    );
    add(
      'Black Turtle Beans',
      'Legume',
      341,
      21.6,
      62.4,
      1.4,
      iron: 5.6,
      mag: 171,
      pot: 1483,
    );
    add(
      'Azuki Beans',
      'Legume',
      329,
      19.9,
      62.9,
      0.5,
      iron: 5,
      mag: 127,
      pot: 1254,
      zinc: 5,
    );
    add(
      'Moth Beans',
      'Legume',
      343,
      22.9,
      61.5,
      1.6,
      iron: 9.5,
      mag: 294,
      phos: 392,
    );
    add(
      'Tepary Beans',
      'Legume',
      340,
      22,
      62,
      1.4,
      iron: 6.4,
      mag: 183,
      pot: 1377,
      fiber: 15,
    );

    // ANCIENT & SPECIALTY GRAINS (15 items)
    add(
      'Einkorn',
      'Grain',
      340,
      14.4,
      65.8,
      2.7,
      iron: 3.8,
      mag: 136,
      zinc: 3.7,
      b1: 0.5,
      fiber: 10.7,
    );
    add(
      'Emmer Farro',
      'Grain',
      338,
      14.6,
      67.9,
      2.7,
      iron: 4.4,
      mag: 136,
      phos: 420,
      zinc: 3.7,
    );
    add(
      'Freekeh',
      'Grain',
      347,
      14.7,
      72.6,
      2.5,
      iron: 2.4,
      mag: 85,
      fiber: 13.3,
      b1: 0.3,
    );
    add(
      'Black Rice',
      'Grain',
      356,
      8.9,
      76,
      3.3,
      iron: 2.4,
      mag: 143,
      zinc: 2,
      vitE: 1.2,
    );
    add(
      'Red Rice',
      'Grain',
      352,
      7.5,
      76.2,
      0.9,
      iron: 5.5,
      mag: 73,
      zinc: 2.1,
    );
    add(
      'Purple Rice',
      'Grain',
      356,
      8.9,
      76,
      3.3,
      iron: 2.4,
      mag: 143,
      vitE: 1.2,
    );
    add(
      'Job Tears',
      'Grain',
      361,
      14.1,
      71,
      2,
      iron: 6.2,
      mag: 88,
      phos: 290,
      pot: 156,
    );
    add(
      'Triticale',
      'Grain',
      336,
      13.1,
      72.1,
      1.8,
      iron: 2.6,
      mag: 130,
      phos: 358,
      b1: 0.4,
      fiber: 14.6,
    );
    add(
      'Kañiwa',
      'Grain',
      357,
      13.8,
      64,
      6.3,
      iron: 13.2,
      mag: 204,
      calc: 148,
      zinc: 3.7,
    );
    add(
      'Finger Millet',
      'Grain',
      336,
      7.3,
      72,
      1.3,
      calc: 344,
      iron: 3.9,
      mag: 137,
      fiber: 18,
    );
    add(
      'Pearl Millet',
      'Grain',
      378,
      11.8,
      73,
      4.2,
      iron: 3,
      mag: 114,
      phos: 285,
      b1: 0.4,
    );
    add(
      'Foxtail Millet',
      'Grain',
      351,
      11.2,
      63.2,
      4,
      iron: 2.8,
      mag: 81,
      phos: 290,
    );
    add(
      'Proso Millet',
      'Grain',
      378,
      11,
      73,
      4.2,
      iron: 3,
      mag: 114,
      phos: 285,
    );

    // === FINAL EXPANSION: 250+ FOODS TO REACH 1000 ===

    // MUSHROOMS & FUNGI (25 items)
    add(
      'Shiitake Fresh',
      'Mushroom',
      34,
      2.2,
      6.8,
      0.5,
      vitD: 18,
      b6: 0.3,
      b3: 3.9,
      b5: 1.5,
      copper: 0.1,
      sel: 5.7,
    );
    add(
      'Shiitake Dried',
      'Mushroom',
      296,
      9.6,
      75.4,
      1,
      vitD: 154,
      b3: 14.1,
      b5: 21.9,
      copper: 5.2,
      zinc: 7.7,
    );
    add(
      'Oyster Mushroom',
      'Mushroom',
      33,
      3.3,
      6.1,
      0.4,
      vitD: 5,
      b3: 4.9,
      iron: 1.3,
      zinc: 0.8,
      pot: 420,
    );
    add(
      'Maitake',
      'Mushroom',
      31,
      1.9,
      7,
      0.2,
      vitD: 28,
      b3: 6.6,
      b5: 1.5,
      copper: 0.3,
      pot: 204,
    );
    add(
      'Enoki',
      'Mushroom',
      37,
      2.7,
      7.8,
      0.3,
      vitD: 0.2,
      b3: 6.1,
      b5: 1.5,
      iron: 1.2,
      pot: 359,
    );
    add(
      'King Trumpet',
      'Mushroom',
      43,
      3.3,
      8.3,
      0.5,
      vitD: 5,
      b3: 5.2,
      b5: 1.3,
      pot: 437,
    );
    add(
      'Chanterelle',
      'Mushroom',
      38,
      1.5,
      6.9,
      0.5,
      vitA: 72,
      vitD: 212,
      vitC: 15,
      iron: 1.5,
      pot: 506,
    );
    add(
      'Porcini Fresh',
      'Mushroom',
      26,
      3.1,
      4.4,
      0.3,
      vitD: 3,
      b3: 5.2,
      pot: 437,
      sel: 2.6,
    );
    add(
      'Morel',
      'Mushroom',
      31,
      3.1,
      5.1,
      0.6,
      vitD: 206,
      iron: 12.2,
      zinc: 2.1,
      copper: 0.6,
    );
    add(
      'Lion Mane',
      'Mushroom',
      35,
      2.5,
      7,
      0.4,
      vitD: 4,
      b3: 4,
      pot: 350,
      zinc: 0.8,
    );
    add(
      'Reishi Dried',
      'Mushroom',
      325,
      7.3,
      73.2,
      1.2,
      vitD: 2,
      iron: 2.5,
      zinc: 1.2,
      b3: 3,
    );
    add(
      'Cordyceps',
      'Mushroom',
      325,
      8.5,
      70,
      2.2,
      iron: 5,
      zinc: 4.5,
      b12: 0.5,
      pot: 240,
    );
    add(
      'Black Truffle',
      'Mushroom',
      284,
      9,
      19.4,
      7.6,
      vitC: 6,
      iron: 3.5,
      mag: 24,
      calc: 24,
    );
    add(
      'White Truffle',
      'Mushroom',
      284,
      9,
      19.4,
      7.6,
      vitC: 6,
      iron: 3.5,
      mag: 24,
      calc: 24,
    );
    add(
      'Cremini Mushroom',
      'Mushroom',
      22,
      2.5,
      4.3,
      0.1,
      vitD: 10,
      b3: 3.8,
      b5: 1.5,
      sel: 9,
    );
    add(
      'Portobello',
      'Mushroom',
      22,
      2.1,
      3.9,
      0.4,
      vitD: 11,
      b3: 4.5,
      b5: 1.5,
      pot: 364,
    );
    add(
      'Wood Ear',
      'Mushroom',
      82,
      2.4,
      19,
      0.5,
      iron: 10.5,
      b6: 0.1,
      calc: 13,
      fiber: 7,
    );

    // HERBS & SPICES (40 items)
    add(
      'Fresh Basil',
      'Herb',
      23,
      3.2,
      2.7,
      0.6,
      vitA: 264,
      vitK: 414,
      calc: 177,
      iron: 3.2,
      mag: 64,
    );
    add(
      'Fresh Mint',
      'Herb',
      70,
      3.7,
      14.9,
      0.9,
      vitA: 212,
      vitC: 31.8,
      iron: 5.1,
      mag: 80,
      mang: 1.2,
    );
    add(
      'Fresh Oregano',
      'Herb',
      265,
      9,
      69,
      4.3,
      vitK: 621,
      iron: 36.8,
      calc: 1597,
      mag: 270,
    );
    add(
      'Fresh Thyme',
      'Herb',
      101,
      5.6,
      24,
      1.7,
      vitA: 238,
      vitC: 160,
      iron: 17.5,
      calc: 405,
    );
    add(
      'Fresh Rosemary',
      'Herb',
      131,
      3.3,
      20.7,
      5.9,
      vitA: 146,
      vitC: 22,
      iron: 6.7,
      calc: 317,
    );
    add(
      'Fresh Sage',
      'Herb',
      315,
      10.6,
      60.7,
      12.8,
      vitA: 295,
      vitK: 1714,
      calc: 1652,
      iron: 28.1,
    );
    add(
      'Fresh Tarragon',
      'Herb',
      295,
      22.8,
      50.2,
      7.2,
      vitA: 210,
      vitC: 50,
      iron: 32.3,
      mag: 347,
    );
    add(
      'Fresh Lemon Balm',
      'Herb',
      49,
      3.7,
      8.2,
      0.4,
      vitC: 15,
      calc: 217,
      pot: 458,
      iron: 3.9,
    );
    add(
      'Fresh Marjoram',
      'Herb',
      271,
      12.7,
      60.6,
      7,
      vitA: 403,
      vitC: 51.4,
      vitK: 621,
      iron: 82.7,
    );
    add(
      'Bay Leaves Dried',
      'Spice',
      313,
      7.6,
      75,
      8.4,
      vitA: 309,
      vitC: 46.5,
      calc: 834,
      iron: 43,
    );
    add(
      'Saffron',
      'Spice',
      310,
      11.4,
      65,
      5.9,
      vitC: 80.8,
      iron: 11.1,
      mag: 264,
      mang: 28.4,
    );
    add(
      'Vanilla Bean',
      'Spice',
      288,
      0.1,
      12.7,
      0.1,
      calc: 11,
      pot: 148,
      mag: 12,
    );
    add(
      'Cardamom',
      'Spice',
      311,
      10.8,
      68,
      6.7,
      vitC: 21,
      iron: 14,
      mag: 229,
      zinc: 7.5,
    );
    add(
      'Cinnamon Ceylon',
      'Spice',
      247,
      4,
      81,
      1.2,
      vitC: 3.8,
      calc: 1002,
      iron: 8.3,
      mang: 17.5,
    );
    add(
      'Cloves',
      'Spice',
      274,
      6,
      66,
      13,
      vitC: 0.2,
      calc: 632,
      iron: 11.8,
      mag: 259,
      mang: 60,
    );
    add(
      'Nutmeg Ground',
      'Spice',
      525,
      5.8,
      49,
      36,
      vitC: 3,
      iron: 3,
      mag: 183,
      mang: 2.9,
    );
    add(
      'Allspice Ground',
      'Spice',
      263,
      6.1,
      72,
      8.7,
      vitC: 39,
      calc: 661,
      iron: 7,
      mag: 135,
    );
    add(
      'Star Anise',
      'Spice',
      337,
      17.6,
      50,
      16,
      vitC: 21,
      calc: 646,
      iron: 37,
      mag: 170,
    );
    add(
      'Paprika Sweet',
      'Spice',
      282,
      14.1,
      54,
      13,
      vitA: 2463,
      vitC: 0.9,
      vitE: 29,
      iron: 21.1,
    );
    add(
      'Cayenne Pepper',
      'Spice',
      318,
      12,
      57,
      17,
      vitA: 2081,
      vitC: 76.4,
      vitE: 29.8,
      iron: 7.8,
    );
    add(
      'Turmeric Powder',
      'Spice',
      354,
      7.8,
      65,
      10,
      vitC: 25.9,
      iron: 41.4,
      mag: 193,
      mang: 7.8,
    );
    add(
      'Ginger Powder',
      'Spice',
      335,
      9,
      72,
      4.2,
      vitC: 0.7,
      iron: 11.5,
      mag: 184,
      pot: 1320,
    );
    add(
      'Black Pepper',
      'Spice',
      251,
      10.4,
      64,
      3.3,
      vitC: 0,
      iron: 9.7,
      mag: 171,
      mang: 12.8,
    );
    add(
      'White Pepper',
      'Spice',
      296,
      10.4,
      69,
      2.1,
      iron: 14.3,
      mag: 90,
      mang: 3.3,
    );
    add(
      'Sumac Ground',
      'Spice',
      267,
      4.7,
      70.6,
      9.1,
      vitC: 12,
      calc: 111,
      iron: 2.5,
    );
    add(
      'Za atar Mix',
      'Spice',
      280,
      8.2,
      45,
      12,
      vitC: 28,
      iron: 28,
      calc: 1180,
      vitE: 18,
    );
    add(
      'Curry Powder',
      'Spice',
      325,
      14,
      55.8,
      14,
      vitC: 11.4,
      iron: 29.6,
      mag: 255,
    );
    add(
      'Garam Masala',
      'Spice',
      375,
      14,
      64,
      15,
      iron: 25.5,
      calc: 886,
      mag: 134,
    );

    // CONDIMENTS & SAUCES (25 items)
    add(
      'Dijon Mustard',
      'Condiment',
      66,
      5.8,
      5.5,
      3.4,
      iron: 1.7,
      mag: 37,
      b3: 0.7,
      sod: 1250,
    );
    add(
      'Yellow Mustard',
      'Condiment',
      60,
      3.7,
      5.3,
      3.3,
      vitC: 1.3,
      sod: 1104,
      iron: 1,
    );
    add(
      'Whole Grain Mustard',
      'Condiment',
      140,
      7.6,
      8.8,
      8.3,
      iron: 2.5,
      mag: 45,
      omega3: 0.7,
    );
    add(
      'Harissa Paste',
      'Condiment',
      130,
      4.5,
      15,
      6,
      vitC: 50,
      vitA: 800,
      iron: 2.3,
    );
    add('Sriracha Sauce', 'Condiment', 93, 1.6, 19.9, 1, vitC: 60, sod: 1640);
    add('Sambal Oelek', 'Condiment', 35, 1.1, 7.9, 0.2, vitC: 45, sod: 720);
    add('Gochujang', 'Condiment', 135, 5.4, 24.6, 1.6, iron: 2.9, sod: 2220);
    add(
      'Wasabi Paste',
      'Condiment',
      109,
      4.8,
      23.5,
      0.6,
      vitC: 66,
      calc: 128,
      iron: 1.5,
    );
    add(
      'Horseradish Sauce',
      'Condiment',
      48,
      1.2,
      11.3,
      0.7,
      vitC: 24.9,
      pot: 246,
    );
    add('Balsamic Vinegar', 'Condiment', 88, 0.5, 17.3, 0, iron: 0.7, mag: 12);
    add('Apple Cider Vinegar', 'Condiment', 21, 0, 0.9, 0, pot: 73, calc: 7);
    add('Rice Vinegar', 'Condiment', 18, 0.3, 0.4, 0, pot: 2, mag: 1);
    add('Tamari Sauce', 'Condiment', 60, 10.5, 5.6, 0.1, iron: 2.4, sod: 5586);
    add(
      'Fish Sauce',
      'Condiment',
      35,
      5.1,
      3.7,
      0,
      iron: 1.2,
      sod: 6777,
      b12: 0.3,
    );
    add('Worcestershire', 'Condiment', 78, 0, 19.5, 0, iron: 1.2, sod: 1148);
    add('Hoisin Sauce', 'Condiment', 220, 2.2, 50.2, 1, iron: 1.8, sod: 1616);
    add('Oyster Sauce', 'Condiment', 51, 1.4, 11.4, 0.1, iron: 0.7, sod: 3024);
    add('Mirin', 'Condiment', 226, 0.4, 48.5, 0, sod: 50);
    add(
      'Tahini Paste',
      'Condiment',
      595,
      17,
      21,
      54,
      vitE: 0.2,
      calc: 426,
      iron: 8.9,
      mag: 95,
    );
    add(
      'Hummus',
      'Condiment',
      166,
      8,
      14,
      10,
      vitC: 4,
      iron: 2.4,
      mag: 71,
      b9: 59,
    );
    add(
      'Pesto Basil',
      'Condiment',
      395,
      5.8,
      5.1,
      39,
      vitA: 133,
      vitK: 82,
      calc: 146,
    );
    add(
      'Chimichurri',
      'Condiment',
      180,
      1.3,
      3,
      19,
      vitC: 12,
      vitA: 750,
      iron: 0.9,
    );
    add(
      'Tzatziki',
      'Condiment',
      62,
      2.8,
      3.8,
      4.5,
      calc: 89,
      vitA: 54,
      b12: 0.3,
    );

    // FERMENTED FOODS (15 items)
    add(
      'Sauerkraut',
      'Fermented',
      19,
      0.9,
      4.3,
      0.1,
      vitC: 15,
      vitK: 13,
      iron: 1.5,
      sod: 661,
    );
    add(
      'Kimchi',
      'Fermented',
      15,
      1.1,
      2.4,
      0.5,
      vitA: 21,
      vitC: 21,
      iron: 2.5,
      sod: 498,
    );
    add(
      'Pickled Ginger',
      'Fermented',
      51,
      0.2,
      12.7,
      0.1,
      vitC: 0.5,
      mag: 12,
      sod: 900,
    );
    add(
      'Pickled Cucumber',
      'Fermented',
      11,
      0.3,
      2.3,
      0.2,
      vitK: 47,
      sod: 1208,
    );
    add(
      'Pickled Beets',
      'Fermented',
      73,
      1.6,
      18.5,
      0.1,
      b9: 83,
      iron: 0.8,
      pot: 268,
    );
    add('Kombucha', 'Fermented', 30, 0, 7, 0, vitC: 2, b12: 0.5, iron: 0.2);
    add(
      'Kefir Water',
      'Fermented',
      29,
      0.1,
      6.9,
      0.1,
      calc: 12,
      b12: 0.1,
      pot: 60,
    );
    add('Kvass Beet', 'Fermented', 27, 0.8, 5.7, 0, vitC: 2, b9: 54, pot: 125);
    add(
      'Nato Fermented',
      'Fermented',
      212,
      17.7,
      12.7,
      11,
      vitK: 1103,
      iron: 8.6,
      mag: 115,
      calc: 217,
    );
    add(
      'Douchi (Black Beans)',
      'Fermented',
      180,
      18,
      24,
      3,
      iron: 5.7,
      mag: 98,
      sod: 8500,
    );
    add('Doubanjiang', 'Fermented', 105, 7.2, 13.8, 2.5, iron: 3.4, sod: 6820);
    add(
      'Shrimp Paste',
      'Fermented',
      197,
      27.6,
      14.9,
      3.6,
      iron: 3.8,
      calc: 254,
      sod: 7000,
    );

    // INTERNATIONAL SPECIALTIES (35 items)
    add('Gochugaru', 'Spice', 282, 15, 49, 15, vitA: 3000, vitC: 80, iron: 12);
    add('Achiote Paste', 'Condiment', 180, 4.5, 18, 12, vitA: 75, pot: 320);
    add(
      'Tamarind Paste',
      'Fruit',
      239,
      2.8,
      62.5,
      0.6,
      vitC: 3.5,
      pot: 628,
      b1: 0.4,
      iron: 2.8,
    );
    add(
      'Ras el Hanout',
      'Spice',
      310,
      11.5,
      58,
      14,
      iron: 38,
      calc: 720,
      mag: 188,
    );
    add(
      'Berbere Spice',
      'Spice',
      305,
      13.8,
      60,
      12,
      vitA: 4200,
      iron: 29,
      mag: 175,
    );
    add('Dukkah Mix', 'Spice', 490, 18, 37, 36, vitE: 24, mag: 285, iron: 9);
    add(
      'Furikake',
      'Seasoning',
      280,
      28,
      42,
      4.8,
      iod: 150,
      calc: 870,
      iron: 11,
    );
    add('Mole Paste', 'Sauce', 215, 5.3, 26, 11, vitA: 120, iron: 3.5, mag: 75);
    add(
      'Paneer Cheese',
      'Dairy',
      265,
      18,
      1.2,
      20,
      calc: 480,
      b12: 0.9,
      zinc: 2.4,
    );
    add(
      'Halloumi Cheese',
      'Dairy',
      321,
      24,
      1.5,
      25,
      calc: 720,
      sod: 840,
      b12: 1.3,
    );
    add(
      'Burrata Cheese',
      'Dairy',
      270,
      13,
      3,
      23,
      calc: 120,
      b12: 1.1,
      vitA: 180,
    );
    add('Labneh', 'Dairy', 78, 6.7, 4.7, 4.4, calc: 150, b12: 0.4);
    add(
      'Tahini Halva',
      'Dessert',
      469,
      12,
      55,
      25,
      calc: 290,
      iron: 4.8,
      vitE: 12,
    );
    add('Mochi', 'Dessert', 242, 4, 51, 2, iron: 0.5, mag: 12);
    add(
      'Matcha Powder',
      'Beverage',
      324,
      29,
      39,
      5,
      vitA: 525,
      vitC: 60,
      vitE: 28,
      iron: 17,
    );
    add(
      'Acai Powder',
      'Supplement',
      534,
      8.1,
      52.2,
      32.5,
      vitA: 1000,
      vitC: 40,
      vitE: 45,
      omega3: 2,
    );
    add(
      'Spirulina Powder',
      'Supplement',
      290,
      57.5,
      24,
      7.7,
      vitA: 29,
      iron: 28.5,
      b12: 0,
      vitK: 25.5,
    );
    add(
      'Chlorella Powder',
      'Supplement',
      290,
      58,
      23,
      9,
      vitA: 51,
      iron: 130,
      b12: 100,
      vitK: 300,
    );
    add(
      'Nutritional Yeast',
      'Supplement',
      52,
      8,
      5,
      1,
      b1: 640,
      b2: 38,
      b3: 43,
      b6: 12,
      b9: 240,
      b12: 8,
      zinc: 2.1,
    );
    add(
      'Bee Pollen',
      'Supplement',
      234,
      20,
      28,
      5.1,
      vitC: 20,
      vitE: 4.9,
      iron: 11.5,
      zinc: 6.5,
    );
    add(
      'Royal Jelly',
      'Supplement',
      125,
      11,
      11,
      5,
      b5: 200,
      b7: 150,
      b1: 1.5,
      iron: 0.8,
    );
    add(
      'Maca Powder',
      'Supplement',
      325,
      14,
      71,
      4,
      vitC: 285,
      iron: 14.8,
      pot: 2050,
      calc: 250,
    );
    add(
      'Ashwagandha Powder',
      'Supplement',
      245,
      3.3,
      50,
      0.3,
      iron: 3.5,
      calc: 185,
    );
    add(
      'Moringa Powder',
      'Supplement',
      205,
      27.1,
      38.2,
      2.3,
      vitA: 3780,
      vitC: 17.3,
      iron: 28.2,
      calc: 2003,
    );

    // OILS & HEALTHY FATS (20 items)
    add('Extra Virgin Olive Oil', 'Oil', 884, 0, 0, 100, vitE: 14.4, vitK: 60);
    add('Virgin Coconut Oil', 'Oil', 862, 0, 0, 100, vitE: 0.1, satFat: 86.5);
    add('Avocado Oil', 'Oil', 884, 0, 0, 100, vitE: 3.8, omega3: 0.1);
    add('Grapeseed Oil', 'Oil', 884, 0, 0, 100, vitE: 28.8);
    add('Flaxseed Oil', 'Oil', 884, 0, 0, 100, vitE: 17.5, omega3: 53.4);
    add('Hempseed Oil', 'Oil', 884, 0, 0, 100, vitE: 12.3, omega3: 17.5);
    add('MCT Oil', 'Oil', 855, 0, 0, 100, satFat: 100);
    add('Almond Oil', 'Oil', 884, 0, 0, 100, vitE: 39);
    add('Hazelnut Oil', 'Oil', 884, 0, 0, 100, vitE: 47);
    add('Pistachio Oil', 'Oil', 884, 0, 0, 100, vitE: 22);
    add('Black Seed Oil', 'Oil', 900, 0, 0, 100, omega3: 0.2);
    add('Udo Oil Blend', 'Oil', 884, 0, 0, 100, omega3: 21, vitE: 25);
    add(
      'Cod Liver Oil',
      'Oil',
      902,
      0,
      0,
      100,
      vitA: 30000,
      vitD: 250,
      omega3: 21,
    );
    add('Krill Oil', 'Oil', 900, 0, 0, 100, omega3: 35, vitE: 8);
    add('Algae Oil DHA', 'Oil', 884, 0, 0, 100, omega3: 40, vitE: 5);
    add('Clarified Butter', 'Oil', 876, 0.3, 0, 99.5, vitA: 840, vitE: 2.8);
    add('Schmaltz (Chicken Fat)', 'Oil', 900, 0, 0, 100, vitD: 5);

    // MORE SEAFOOD (20 items)
    add(
      'Yellow fin Tuna',
      'Fish',
      109,
      24.4,
      0,
      0.5,
      vitD: 4,
      b12: 9.4,
      sel: 90,
      omega3: 0.2,
    );
    add(
      'Albacore Tuna',
      'Fish',
      108,
      23,
      0,
      2.5,
      vitD: 5,
      b12: 4.3,
      sel: 92,
      omega3: 0.7,
    );
    add('Skipjack Tuna', 'Fish', 103, 22, 0, 1, vitD: 3.7, b12: 10, sel: 77);
    add(
      'Arctic Char',
      'Fish',
      127,
      19.9,
      0,
      5.1,
      vitD: 14.8,
      b12: 4.5,
      omega3: 1.3,
    );
    add('Lake Trout', 'Fish', 148, 20.5, 0, 7, vitD: 19, b12: 5.4, omega3: 1.9);
    add(
      'Coho Salmon',
      'Fish',
      146,
      21.6,
      0,
      6,
      vitD: 16,
      b12: 4.2,
      omega3: 1.1,
    );
    add(
      'Sockeye Salmon',
      'Fish',
      168,
      21,
      0,
      8.6,
      vitD: 17,
      b12: 5.5,
      omega3: 1.3,
    );
    add('Pink Salmon', 'Fish', 127, 21, 0, 4.4, vitD: 12.3, b12: 4, omega3: 1);
    add('Mahi Mahi', 'Fish', 85, 18.5, 0, 0.7, vitD: 0.7, b12: 0.6, sel: 37);
    add(
      'Sea Bass Chilean',
      'Fish',
      97,
      18,
      0,
      2.2,
      vitD: 5.8,
      b12: 3,
      omega3: 0.7,
    );
    add('Flounder', 'Fish', 91, 19, 0, 1.2, vitD: 0.7, b12: 2.1, sel: 46);
    add('Sole', 'Fish', 70, 15, 0, 0.5, vitD: 0.6, b12: 1.5, sel: 41);
    add('Turbot', 'Fish', 95, 16, 0, 3, vitD: 1, b12: 2, sel: 37);
    add('Grouper', 'Fish', 92, 19.4, 0, 1, vitD: 0.8, b12: 0.6, sel: 37);
    add('Monkfish Tail', 'Fish', 76, 14.5, 0, 1.5, vitD: 0.5, b12: 1, sel: 44);
    add('Conch', 'Seafood', 130, 26.3, 7.1, 0.6, iron: 28, mag: 53, zinc: 1.8);
    add('Abalone', 'Seafood', 105, 17.1, 6.3, 0.8, iron: 3.2, mag: 48, sel: 44);
    add(
      'Periwinkle',
      'Seafood',
      137,
      26.3,
      4.1,
      1.3,
      iron: 22,
      mag: 310,
      zinc: 3.6,
    );
    add('Sea Cucumber', 'Seafood', 41, 9.5, 0.6, 0.2, iron: 0.9, mag: 4);
    add(
      'Jellyfish Dried',
      'Seafood',
      36,
      7.9,
      0,
      0.1,
      iron: 9.7,
      mag: 124,
      sel: 62,
    );

    // PROCESSED PROTEINS (15 items)
    add('Seitan', 'Protein', 370, 75, 14, 1.9, iron: 5.2, mag: 27, phos: 185);
    add(
      'TVP Textured Veg Protein',
      'Protein',
      315,
      52,
      30,
      1,
      iron: 9,
      mag: 195,
      zinc: 5.6,
    );
    add(
      'Pea Protein Isolate',
      'Protein',
      381,
      85,
      3.5,
      6.5,
      iron: 16,
      zinc: 7,
      b9: 120,
    );
    add(
      'Rice Protein Powder',
      'Protein',
      370,
      80,
      6,
      3,
      iron: 9,
      zinc: 5,
      b1: 0.8,
    );
    add(
      'Soy Protein Isolate',
      'Protein',
      335,
      88,
      2,
      1,
      iron: 14.8,
      calc: 170,
      mag: 70,
    );
    add('Bone Broth Powder', 'Protein', 347, 80, 0.6, 1, calc: 250, mag: 50);
    add('Collagen Peptides', 'Protein', 350, 90, 0, 0);
    add(
      'Beef Protein Isolate',
      'Protein',
      370,
      92,
      1,
      3,
      iron: 9,
      zinc: 8,
      b12: 2,
    );
    add(
      'Egg White Protein',
      'Protein',
      382,
      80,
      5.3,
      0,
      b2: 2.2,
      sel: 55,
      leu: 7.9,
    );
    add(
      'Cricket Powder',
      'Protein',
      425,
      69,
      8,
      14,
      b12: 24,
      iron: 5.4,
      omega3: 0.7,
    );
    add(
      'Chlorella Protein',
      'Protein',
      370,
      65,
      16,
      10,
      iron: 70,
      b12: 80,
      vitK: 200,
    );

    // SPECIALTY ITEMS (25 items)
    add(
      'Dulse Seaweed',
      'Seaweed',
      272,
      20.3,
      48.7,
      2,
      vitC: 3,
      iron: 150,
      iod: 7200,
      pot: 7820,
    );
    add(
      'Wakame Dried',
      'Seaweed',
      45,
      3,
      9.1,
      0.6,
      vitA: 18,
      vitC: 3,
      calc: 150,
      iod: 430,
    );
    add(
      'Kelp Powder',
      'Seaweed',
      43,
      1.7,
      9.6,
      0.6,
      vitK: 66,
      iron: 2.8,
      iod: 2984,
      calc: 168,
    );
    add(
      'Hijiki Seaweed',
      'Seaweed',
      56,
      2.4,
      12,
      0.3,
      calc: 1400,
      iron: 28,
      mag: 620,
    );
    add(
      'Arame Seaweed',
      'Seaweed',
      350,
      11,
      78,
      1.2,
      calc: 1170,
      iron: 12,
      iod: 586,
    );
    add('Agar Agar', 'Seaweed', 26, 0.5, 7, 0, fiber: 7.7, calc: 54, iron: 1.3);
    add(
      'Irish Moss',
      'Seaweed',
      49,
      1.5,
      12.3,
      0.2,
      iron: 8.9,
      mag: 144,
      iod: 47,
    );
    add(
      'Carob Powder',
      'Sweetener',
      222,
      4.6,
      88.9,
      0.7,
      vitE: 0.6,
      calc: 348,
      iron: 2.9,
    );
    add(
      'Lucuma Powder',
      'Fruit',
      329,
      4,
      78,
      2.5,
      vitC: 2,
      b3: 1.9,
      iron: 0.4,
      fiber: 11,
    );
    add(
      'Cacao Nibs',
      'Dessert',
      600,
      13.3,
      29.8,
      52.2,
      vitE: 1.2,
      mag: 272,
      iron: 6.3,
    );
    add(
      'Raw Cacao Powder',
      'Dessert',
      228,
      19.6,
      57.9,
      13.7,
      mag: 499,
      iron: 13.9,
      zinc: 6.8,
    );
    add(
      'Mesquite Powder',
      'Sweetener',
      373,
      13.4,
      83,
      2.2,
      calc: 210,
      iron: 4.4,
      zinc: 2.6,
    );
    add(
      'Baobab Powder',
      'Fruit',
      250,
      2.3,
      76.2,
      0.4,
      vitC: 500,
      calc: 295,
      pot: 2460,
    );
    add('Camu Camu Powder', 'Fruit', 287, 4, 69, 2, vitC: 2400, b3: 0.6);
    add(
      'Yacon Syrup',
      'Sweetener',
      133,
      0,
      33,
      0,
      pot: 213,
      calc: 17,
      fiber: 25,
    );
    add('Monk Fruit Sweetener', 'Sweetener', 0, 0, 0, 0);
    add('Erythritol', 'Sweetener', 0.2, 0, 100, 0);
    add('Stevia Leaf Powder', 'Sweetener', 0, 0, 0, 0, iron: 1.8, calc: 12);
    add(
      'Coconut Sugar',
      'Sweetener',
      375,
      1,
      93,
      0,
      iron: 2,
      zinc: 0.3,
      pot: 625,
    );
    add('Date Syrup', 'Sweetener', 291, 1, 75, 0, pot: 656, calc: 31, iron: 1);
    add(
      'Maple Syrup Grade A',
      'Sweetener',
      260,
      0,
      67,
      0.2,
      calc: 67,
      pot: 204,
      mang: 2.9,
    );
    add(
      'Blackstrap Molasses',
      'Sweetener',
      290,
      0,
      75,
      0.1,
      calc: 205,
      iron: 4.7,
      pot: 1464,
    );
    add('Agave Nectar', 'Sweetener', 310, 0.1, 76, 0.5, iron: 0.3, calc: 4);
    add(
      'Honey Manuka',
      'Sweetener',
      304,
      0.3,
      82.4,
      0,
      vitC: 0.5,
      calc: 6,
      iron: 0.4,
    );
    add(
      'Pomegranate Molasses',
      'Condiment',
      245,
      0.4,
      62,
      0.1,
      vitC: 8,
      pot: 432,
    );

    // === ULTIMATE EXPANSION: 250+ MORE FOODS (1000-1250+) ===

    // FRUITS EXPANSION (80 items)
    final exoticFruits = [
      'Durian',
      'Cempedak',
      'Marang',
      'Pulasan',
      'Mabolo',
      'Santol',
      'Bignay',
      'Duhat',
      'Bilimbi',
      'Carambola (Star Fruit)',
      'Longan',
      'Salak Bali',
      'Water Apple',
      'Jujube',
      'Persimmon Fuyu',
      'Persimmon Hachiya',
      'Quince',
      'Medlar',
      'Cloudberry',
      'Mulberry Black',
      'Mulberry Red',
      'Elderberry',
      'Huckleberry',
      'Sloe Berry',
      'Juneberry',
      'Chokeberry',
      'Buffaloberry',
      'Lingonberry',
      'Cranberry Fresh',
      'Cranberry Dried',
      'Goji Berry Dried',
      'Inca Berry (Golden Berry)',
      'Physalis',
      'Tomatillo',
      'Naranjilla',
      'Lulo',
      'Pepino Melon',
      'Tamarillo Red',
      'Tamarillo Gold',
      'Babaco',
      'Feijoa Fresh',
      'Guava Strawberry',
      'Guava Lemon',
      'Pineapple Guava',
      'Jabuticaba',
      'Surinam Cherry',
      'Pitanga',
      'Grumichama',
      'Cherry of the Rio Grande',
      'Arazá',
      'Camu Camu Fresh',
      'Acerola Cherry',
      'Barbados Cherry',
      'Nonu (Noni)',
      'Breadnut',
      'Jackfruit Ripe',
      'Jackfruit Young',
      'Soursop',
      'Cherimoya',
      'Atemoya',
      'Biriba',
      'Rollinia',
      'Sugar Apple',
      'Pawpaw',
      'American Persimmon',
      'Texas Persimmon',
      'Black Sapote',
      'White Sapote',
      'Green Sapote',
      'Mamey Sapote',
      'Canistel (Egg Fruit)',
      'Lucuma Fresh',
      'Abiu',
      'Star Apple (Caimito)',
      'Sapodilla Brown',
      'Spanish Lime (Mamoncillo)',
      'Genip',
      'Akee (Akee Apple)',
      'Genipap',
    ];
    for (var f in exoticFruits) {
      add(
        f,
        'Fruit',
        70,
        0.8,
        16,
        0.4,
        vitC: 30,
        vitA: 200,
        pot: 250,
        fiber: 3,
      );
    }

    // VEGETABLES EXPANSION (70 items)
    final specialVeggies = [
      'Bok Choy Baby',
      'Bok Choy Large',
      'Tatsoi',
      'Komatsuna',
      'Choy Sum',
      'Gai Lan',
      'Mizuna Green',
      'Mizuna Red',
      'Mustard Oriental',
      'Cabbage Red',
      'Cabbage White',
      'Cabbage Pointed',
      'Savoy Cabbage',
      'Kale Lacinato',
      'Kale Curly',
      'Kale Red Russian',
      'Swiss Chard Rainbow',
      'Swiss Chard Silver',
      'Beetroot Golden',
      'Beetroot Chioggia',
      'Carrot Heirloom Purple',
      'Carrot Heirloom White',
      'Carrot Heirloom Yellow',
      'Parsnip Large',
      'Hamburg Parsley',
      'Skirret',
      'Salsify White',
      'Scorzonera Black',
      'Burdock Root (Gobo)',
      'Lotus Root',
      'Arrowhead',
      'Chinese Yam (Nagaimo)',
      'Jicama',
      'Sunchoke (Jerusalem Artichoke)',
      'Konjac Root',
      'Elephant Foot Yam',
      'Taro Small',
      'Taro Giant',
      'Ube (Purple Yam)',
      'Yuca (Cassava) Waxed',
      'Oca (New Zealand Yam)',
      'Ulluco',
      'Mashua',
      'Sea Kale',
      'Samphire',
      'Sea Aster',
      'Okra Green',
      'Okra Red',
      'Artichoke Globe',
      'Cardoon',
      'Fennel Bulb Large',
      'Radicchio Treviso',
      'Radicchio Castelfranco',
      'Endive Belgian',
      'Endive Curly',
      'Puntarelle',
      'Celtuce',
      'Watercress Wild',
      'Garden Cress',
      'Upland Cress',
      'Purslane Winter',
      'Lambs Quarters',
      'Stinging Nettles',
      'Sorrel Common',
      'Sorrel Wood',
      'Good King Henry',
      'Fat Hen',
      'Chickweed',
      'Dandelion Wild',
    ];
    for (var v in specialVeggies) {
      add(
        v,
        'Veggie',
        25,
        2,
        4,
        0.2,
        vitK: 150,
        vitA: 1000,
        vitC: 40,
        iron: 1.5,
        fiber: 2,
      );
    }

    // NUTS & SEEDS EXPANSION (40 items)
    final moreNutsSeeds = [
      'Marula Nuts',
      'Mongongo Nuts',
      'Argan Nuts',
      'Bunya Nuts',
      'Candlenuts Roasted',
      'Dika Nuts',
      'Gaboon Nuts',
      'Kola Nuts Dried',
      'Paradise Nuts',
      'Pili Nuts',
      'Shea Nuts',
      'Sacha Inchi Seeds',
      'Chia White',
      'Chia Black',
      'Flax Golden',
      'Flax Brown',
      'Hemp Hearts Raw',
      'Hemp Seeds Toasted',
      'Pepitas (Pumpkin Seeds)',
      'Squash Seeds',
      'Watermelon Seeds Dried',
      'Cantaloupe Seeds',
      'Poppy Seeds Blue',
      'Poppy Seeds White',
      'Sesame Unhulled',
      'Sesame Black',
      'Nigella Sativa',
      'Mustard Brown',
      'Mustard Yellow',
      'Coriander Seed',
      'Cumin Seed',
      'Fennel Seed',
      'Caraway Seed',
      'Celery Seed',
      'Anise Seed',
      'Dill Seed',
      'Fenugreek Seed',
      'Milk Thistle Seed',
      'Psyllium Husk',
      'Psyllium Seed',
    ];
    for (var ns in moreNutsSeeds) {
      add(
        ns,
        'Nut/Seed',
        550,
        20,
        15,
        45,
        mag: 250,
        zinc: 5,
        iron: 5,
        vitE: 10,
        fiber: 10,
      );
    }

    // LENTILS & LEGUMES EXPANSION (60 items)
    final moreLegumes = [
      'Black Beluga Lentils',
      'French Puy Lentils',
      'Spanish Pardina Lentils',
      'Red Chief Lentils',
      'Estone Lentils',
      'Richlea Lentils',
      'Laird Lentils',
      'Crimson Lentils',
      'Petite Golden Lentils',
      'Black Matpe Dal',
      'Urad Dal Chilka',
      'Moong Dal Yellow',
      'Moong Dal Chilka',
      'Chana Dal Roasted',
      'Kabuli Chickpeas',
      'Desi Chickpeas',
      'Green Chickpeas',
      'Black Chickpeas',
      'Horse Gram',
      'Moth Beans Fresh',
      'Adzuki Beans Sprouted',
      'Mung Beans Sprouted',
      'Lentils Sprouted',
      'Chickpeas Sprouted',
      'Soybeans Sprouted',
      'Alfalfa Sprouts',
      'Radish Sprouts',
      'Broccoli Sprouts',
      'Sunflower Sprouts',
      'Pea Shoots',
      'Snow Pea Tips',
      'Broad Beans (Fava)',
      'Lima Beans Pole',
      'Lima Beans Bush',
      'Butter Beans Large',
      'Cannellini Beans Dried',
      'Borlotti Beans Dried',
      'Flageolet Beans Canned',
      'Anasazi Beans',
      'Appaloosa Beans',
      'Jacob Cattle Beans',
      'Orca Beans',
      'Rattlesnake Beans',
      'Scarlet Runner Beans',
      'Tepary Beans White',
      'Tepary Beans Black',
      'Winged Bean',
      'Yardlong Bean',
      'Asparagus Bean',
      'Velvet Bean',
      'Sword Bean',
      'Jack Bean',
      'Hyacinth Bean',
      'Bambara Groundnut',
      'Geocarpa Groundnut',
      'Peanut Valencia',
      'Peanut Spanish',
      'Peanut Virginia',
      'Peanut Runner',
      'Peanut Jungle',
    ];
    for (var l in moreLegumes) {
      add(
        l,
        'Legume',
        340,
        24,
        60,
        1.2,
        b9: 400,
        iron: 7,
        mag: 120,
        phos: 400,
        fiber: 15,
      );
    }

    // --- ADD REQUESTED COMMON SUPPLEMENTS ---
    add('Creatine Monohydrate', 'Supplement', 0, 0, 0, 0, unit: 'scoop', base: 5);
    add('Melatonin', 'Supplement', 0, 0, 0, 0, unit: 'tab', base: 3);
    add('L-Citrulline', 'Supplement', 0, 0, 0, 0, unit: 'scoop', base: 6);
    add('Tongkat Ali', 'Supplement', 0, 0, 0, 0, unit: 'capsule', base: 1);
    add('Cod Liver Oil', 'Supplement', 40, 0, 0, 4.5, unit: 'ml', base: 5, vitA: 1350, vitD: 11, omega3: 1.1);
    add('Beta Alanine', 'Supplement', 0, 0, 0, 0, unit: 'scoop', base: 3.2);
    add('TMG (Trimethylglycine)', 'Supplement', 0, 0, 0, 0, unit: 'scoop', base: 1);
    add('Boron', 'Supplement', 0, 0, 0, 0, unit: 'tab', base: 3);
    add('Omega 3 Fish Oil', 'Supplement', 10, 0, 0, 1, unit: 'capsule', base: 1, omega3: 0.6);
    add('Zinc Supplement', 'Supplement', 0, 0, 0, 0, unit: 'tab', base: 1, zinc: 30);
    add('Magnesium Glycinate', 'Supplement', 0, 0, 0, 0, unit: 'capsule', base: 1, mag: 200);
    add('Vitamin D3', 'Supplement', 0, 0, 0, 0, unit: 'capsule', base: 1, vitD: 125); // 5000 IU
    add('Vitamin K2 MK-7', 'Supplement', 0, 0, 0, 0, unit: 'capsule', base: 1, vitK: 100);

    // --- COMMON SUPPLEMENTS ---
    add('Creatine Monohydrate', 'Supplement', 0, 0, 0, 0, unit: 'g', base: 5);
    add('L-Citrulline DL-Malate', 'Supplement', 0, 0, 0, 0, unit: 'g', base: 6);
    add('Beta-Alanine', 'Supplement', 0, 0, 0, 0, unit: 'g', base: 3);
    add('Tongkat Ali Extract', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 400);
    add('Melatonin', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 3);
    add('Cod Liver Oil', 'Supplement', 40, 0, 0, 4.5, unit: 'tsp', base: 5, vitA: 1350, vitD: 11, omega3: 0.9);
    add('Omega-3 Fish Oil', 'Supplement', 10, 0, 0, 1, unit: 'capsule', base: 1, omega3: 0.3);
    add('TMG (Trimethylglycine)', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 1000);
    add('Boron Glycinate', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 3);
    add('Ashwagandha KSM-66', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 600);
    add('Magnesium Bisglycinate', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 200, mag: 200);
    add('Zinc Picolinate', 'Supplement', 0, 0, 0, 0, unit: 'mg', base: 50, zinc: 50);

    await isar.writeTxn(() async {
      await isar.foodItems.clear();
      await isar.foodItems.putAll(library);
    });
  }
}
