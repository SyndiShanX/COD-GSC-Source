/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripted_weapon_assignment.gsc
***********************************************/

getscriptedweapon(var_0, var_1) {
  if(!isDefined(var_0))
    return isundefinedweapon();

  if(!isarray(var_0) && var_0 == "")
    return isundefinedweapon();

  if(isDefined(var_1) && var_1 == "sidearm")
    var_2 = getweapon(var_0, "pistol");
  else
    var_2 = getweapon(var_0, self.scriptedweaponclassprimary);

  return var_2;
}

getweapon(var_0, var_1) {
  var_2 = [];

  if(isarray(var_0)) {
    var_2 = var_0;
    var_0 = var_0[randomint(var_0.size)];
  }

  if(issubstr(tolower(self.classname), "_alq_"))
    return getweapon_aq(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_rus_desert_"))
    return getweapon_ru(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_rus_pmc_"))
    return getweapon_ru(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_spetsnaz_lab"))
    return getweapon_ru_lab(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_spetsnaz_"))
    return getweapon_ru(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_rus_1999_"))
    return getweapon_ru_1999(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_hero_"))
    return getweapon_hero(var_0, var_2);
  else if(issubstr(tolower(self.classname), "_villain_"))
    return getweapon_hero(var_0, var_2);
  else if(issubstr(tolower(self.classname), "_sas_"))
    return getweapon_sas(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_reb_"))
    return getweapon_reb(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_so15_"))
    return getweapon_so15(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_london_police_"))
    return getweapon_so15(var_1, var_0, var_2);
  else if(issubstr(tolower(self.classname), "_usmc_"))
    return getweapon_usmc(var_1, var_0, var_2);
  else {
    if(getdvarint("scr_randomweapon_debug"))
      iprintln("not whitelisted!skipping scripted build.");

    return scripts\sp\utility::make_weapon(var_0);
  }

  return var_0;
}

getweapon_hero(var_0, var_1) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (var_0) {
      case "iw8_pi_mike1911":
        return scripts\sp\utility::make_weapon_special("alex_pistol");
      case "iw8_sn_mike14":
        return scripts\sp\utility::make_weapon_special("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_hadir")) {
    switch (var_0) {
      case "iw8_sm_augolf":
        return scripts\sp\utility::make_weapon_special("hadir_smg");
      case "iw8_sn_hdromeo":
        return scripts\sp\utility::make_weapon_special("hadir_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (var_0) {
      case "iw8_ar_mcharlie":
        return scripts\sp\utility::make_weapon_special("kyle_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (var_0) {
      case "iw8_pi_papa320":
        return scripts\sp\utility::make_weapon_special("papa320_black");
      case "iw8_ar_kilo433":
        return scripts\sp\utility::make_weapon_special("price_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_griggs")) {
    switch (var_0) {
      case "iw8_pi_mike1911":
        return scripts\sp\utility::make_weapon_special("griggs_pistol");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (var_0) {
      case "iw8_ar_akilo47":
        return scripts\sp\utility::make_weapon_special("farah_ar");
    }
  } else if(issubstr(tolower(self.classname), "_villain_barkov")) {
    switch (var_0) {
      case "iw8_pi_golf21":
        return scripts\sp\utility::make_weapon_special("barkov_pistol");
    }
  } else if(issubstr(tolower(self.classname), "_villain_enforcer")) {
    switch (var_0) {
      case "iw8_ar_akilo47":
        return scripts\sp\utility::make_weapon_special("enforcer_ar");
      case "iw8_pi_decho":
        return scripts\sp\utility::make_weapon_special("enforcer_pistol");
    }
  }

  if(getdvarint("scr_randomweapon_debug"))
    iprintln("not whitelisted!skipping scripted build.");

  return scripts\sp\utility::make_weapon(var_0, []);
}

getweapon_aq(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      if(level.script == "piccadilly") {
        var_5["iw8_ar_akilo47"] = 45;
        var_5["iw8_ar_falima"] = 35;
        var_5["iw8_ar_falpha"] = 20;
      } else {
        var_5["iw8_ar_akilo47"] = 70;
        var_5["iw8_ar_falima"] = 20;
        var_5["iw8_ar_falpha"] = 10;
      }

      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          if(level.script == "piccadilly") {
            var_3["scopes"] = [10, "acogstable_east01"];
            var_3["stocks"] = [50, "stocksmg_akilo47"];
            var_3["mags"] = [20, "drums_akilo47_sp"];
            var_3["grips"] = [50, "gripvert_akilo47"];
            var_3["underbarrels"] = [15, "ub_golf25_sp"];
          } else {
            var_3["scopes"] = [10, "acogstable_east01"];
            var_3["stocks"] = [50, "stocklmg_akilo47", "stocksmg_akilo47", "stockno_akilo47"];
            var_3["mags"] = [20, "drums_akilo47_sp", "mag_akilo47|1"];
            var_3["grips"] = [50, "gripvert_akilo47"];
            var_3["barrels"] = [50, "barlmg_akilo47", "front_akilo47|1"];
            var_3["underbarrels"] = [15, "ub_golf25_sp"];
            var_3["other"] = [15, "rec_akilo47|1"];
          }

          break;
        case "iw8_ar_falpha":
          if(level.script == "piccadilly") {
            var_3["scopes"] = [10, "acog_east01_irons"];
            var_3["mags"] = [20, "xmags_falpha", "mag_falpha|1"];
            var_3["grips"] = [50, "gripvert", "gripang"];
            var_3["underbarrels"] = [15, "selectsemi_falpha"];
            var_3["recs"] = [50, "rec_falpha|1"];
            var_3["barrels"] = [50, "front_falpha|1"];
            var_3["triggrip"] = [50, "triggrip_falpha|1"];
            var_3["toprail"] = [50, "toprail_falpha|1"];
          } else {
            var_3["scopes"] = [10, "acog_east01_irons"];
            var_3["stocks"] = [50, "stockh_falpha", "stockl_falpha", "stocks_falpha", "rec_falpha|1"];
            var_3["mags"] = [20, "xmags_falpha", "mag_falpha|1"];
            var_3["grips"] = [50, "gripvert", "gripang"];
            var_3["barrels"] = [50, "barlong_falpha", "barcust_falpha", "barshort_falpha", "front_falpha|1"];
            var_3["underbarrels"] = [15, "selectsemi_falpha"];
            var_3["triggrip"] = [50, "triggrip_falpha|1"];
            var_3["toprail"] = [50, "toprail_falpha|1"];
          }

          break;
        case "iw8_ar_falima":
          if(level.script == "piccadilly") {
            var_3["scopes"] = [20, "acog_east01_irons"];
            var_3["mags"] = [20, "xmags_falima"];
            var_3["grips"] = [50, "gripvert", "gripang"];
            var_3["underbarrels"] = [15, "ub_mike203_sp", "selectauto_falima"];
          } else {
            var_3["scopes"] = [20, "acog_east01_irons"];
            var_3["mags"] = [20, "xmags_falima"];
            var_3["grips"] = [50, "gripvert", "gripang"];
            var_3["barrels"] = [50, "barshort_falima"];
            var_3["underbarrels"] = [15, "ub_mike203_sp", "selectauto_falima"];
          }

          break;
      }

      break;
    case "dmr":
      var_5["iw8_sn_kilo98"] = 50;
      var_5["iw8_ar_falima"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [75, "snprscope_kilo98", "vzscope_kilo98"];
          var_3["laserir"] = [50, "laserads_bar"];
          break;
        case "iw8_ar_falima":
          var_3["scopes"] = [75, "snprscope_mike14_ar", "vzscope_mike14_ar"];
          var_3["laserir"] = [50, "laserads_bar"];
          var_3["mags"] = [35, "xmags_falima"];
          break;
      }

      break;
    case "launcher":
      return "iw8_la_rpapa7";
    case "lmg":
      if(level.script == "piccadilly")
        var_5["iw8_lm_pkilo"] = 100;
      else {
        var_5["iw8_lm_pkilo"] = 55;
        var_5["iw8_lm_mgolf34"] = 45;
      }

      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["bipods"] = [75, "bipod_pkilo"];
          break;
        case "iw8_lm_mgolf34":
          var_3["other"] = [50, "bipod_mgolf34"];
          break;
      }

      break;
    case "pistol":
      var_1 = "iw8_pi_mike1911";

      switch (var_1) {
        case "iw8_pi_mike1911":
          if(level.script == "piccadilly") {} else {
            var_3["scopes"] = [75, "minireddot_mike1911", "irons_mike1911"];
            var_3["mags"] = [35, "xmags_mike1911"];
          }

          break;
      }

      break;
    case "shotgun":
      var_5["iw8_sh_romeo870"] = 50;
      var_5["iw8_sh_charlie725"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sh_romeo870":
          if(level.script == "piccadilly") {
            var_3["stocks"] = [80, "stockno_romeo870", "stockh_romeo870", "stocks_romeo870"];
            var_3["barrels"] = [50, "barshort_romeo870"];
          } else {
            var_3["stocks"] = [80, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
            var_3["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          }

          break;
        case "iw8_sh_charlie725":
          var_3["stocks"] = [50, "stockno_charlie725"];
          var_3["barrels"] = [100, "barshort_charlie725"];
          break;
      }

      break;
    case "smg":
      if(level.script == "piccadilly") {
        var_5["iw8_sm_uzulu"] = 70;
        var_5["iw8_ar_akilo47"] = 30;
      } else {
        var_5["iw8_sm_uzulu"] = 50;
        var_5["iw8_ar_akilo47"] = 50;
      }

      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_uzulu":
          if(level.script == "piccadilly")
            var_3["scopes"] = [20, "minireddot", "reflex_west01", "reflex_east01", "reflex_east02"];
          else
            var_3["scopes"] = [20, "minireddot", "reflex_west01", "reflex_east01", "reflex_east02"];

          break;
        case "iw8_ar_akilo47":
          if(level.script == "piccadilly") {
            var_3["barrels"] = [100, "barsmg_akilo47"];
            var_3["stocks"] = [100, "stockno_akilo47", "stockno_akilo47"];
            var_3["mags"] = [100, "calsmg_akilo47_sp", "calsmgdrums_akilo47_sp"];
            var_3["grips"] = [50, "gripvert_akilo47"];
          } else {
            var_3["barrels"] = [100, "barsmg_akilo47", "front_akilo47|1"];
            var_3["stocks"] = [100, "stockcust_akilo47", "stockno_akilo47", "stockno_akilo47"];
            var_3["mags"] = [100, "calsmg_akilo47_sp", "calsmgdrums_akilo47_sp"];
            var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
            var_3["other"] = [50, "rec_akilo47|1"];
          }

          break;
      }

      break;
    case "sniper":
      var_5["iw8_sn_delta"] = 50;
      var_5["iw8_sn_kilo98"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [100, "snprscope_kilo98"];
          var_3["laserir"] = [100, "laserads_bar"];
          break;
        case "iw8_sn_delta":
          var_3["scopes"] = [100, "snprscope_delta"];
          var_3["laserir"] = [100, "laserads_bar"];
          var_3["mags"] = [35, "xmags_delta"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_ru(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_ar_asierra12"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [75, "acogstable_east01", "holostable_east01", "reflexstable_east01"];
          var_3["stocks"] = [100, "stocksmg_akilo47", "stockcust_akilo47"];
          var_3["mags"] = [100, "drums_akilo47_sp", "mag_akilo47|2", "mag_akilo47|2", "mag_akilo47|2", "mag_akilo47|2"];
          var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          var_3["underbarrels"] = [15, "ub_golf25_sp"];
          var_3["rec"] = [100, "rec_akilo47|2"];
          var_3["other"] = [15, "laserir_bar"];
          var_3["name"] = [100, "akilo12"];

          if(level.script == "proxywar")
            var_3["barrels"] = [100, "barsmg_akilo47|1"];
          else
            var_3["barrels"] = [100, "barcust_akilo47"];

          break;
        case "iw8_ar_asierra12":
          var_3["scopes"] = [70, "reflex_east01", "reflex_east02", "holo_east01", "acog_east01_irons"];
          var_3["stocks"] = [50, "stockh_asierra12", "stockl_asierra12", "stocks_asierra12"];
          var_3["mags"] = [20, "xmags_asierra12"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["other"] = [15, "laserir"];
          var_3["underbarrels"] = [15, "selectsemi"];

          if(level.script == "proxywar")
            var_3["barrels"] = [100, "barshort_asierra12"];
          else
            var_3["barrels"] = [50, "barcust_asierra12", "barshort_asierra12", "barlong_asierra12"];

          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3["scopes"] = [80, "acog_east01", "acog_west01", "snprscope_delta"];
          var_3["stocks"] = [80, "stockl_delta", "stockh_delta", "stocks_delta"];
          var_3["mags"] = [50, "xmags_delta"];
          var_3["other"] = [100, "laserads_bar"];
          var_3["barrelend"] = [50, "flashhidersnpr", "compsnpr", "brakesnpr", "linearbrakesnpr"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["stocks"] = [75, "back_pkilo|1"];
          var_3["receivers"] = [75, "rec_pkilo|1"];
          var_3["barrels"] = [75, "front_pkilo|1"];
          var_3["mags"] = [75, "mag_pkilo|1"];
          var_3["other"] = [50, "bipod_pkilo"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      var_5["iw8_sh_romeo870"] = 50;
      var_5["iw8_sh_oscar12"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["scopes"] = [50, "reflex_east01", "reflex_east02"];
          var_3["stocks"] = [50, "stockno_romeo870"];
          var_3["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          var_3["grips"] = [25, "gripcust_romeo870"];
          var_3["other"] = [50, "laserir_bar"];
          break;
        case "iw8_sh_oscar12":
          var_3["scopes"] = [50, "reflex_east01", "reflex_east02"];
          var_3["stocks"] = [75, "stockno_oscar12", "stockh_oscar12"];
          var_3["mags"] = [75, "drums_oscar12_sp"];
          var_3["barrels"] = [50, "barshort_oscar12", "barmid_oscar12", "barlong_oscar12"];
          var_3["other"] = [50, "laserir"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_sm_augolf"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_augolf":
          var_3["scopes"] = [50, "reflex_east01_irons", "reflex_east02_irons", "holo_east01"];
          var_3["mags"] = [30, "drums_augolf_sp"];
          var_3["other"] = [50, "laserirsmg"];
          var_3["barrels"] = [50, "barshort_augolf"];
          var_3["grips"] = [50, "gripvertsmg", "gripangsmg"];
          break;
        case "iw8_ar_akilo47":
          var_3["stocks"] = [100, "stockcust_akilo47", "stocksmg_akilo47"];
          var_3["mags"] = [100, "calsmg_akilo47_sp", "calsmgdrums_akilo47_sp"];
          var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          var_3["other"] = [50, "laserir_bar"];
          var_3["scopes"] = [70, "holostable_east01", "reflexstable_east01"];
          var_3["rec"] = [100, "rec_akilo47|2"];
          var_3["barrels"] = [100, "barsmg_akilo47|1"];
          break;
      }

      break;
    case "sniper":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3["other"] = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_ru_lab(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_ar_asierra12"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["stocks"] = [100, "stocksmg_akilo47", "stockcust_akilo47"];
          var_3["rec"] = [100, "rec_akilo47|2"];
          var_3["name"] = [100, "akilo12"];
          var_3["barrels"] = [100, "barcust_akilo47"];
          var_3["mags"] = [20, "drums_akilo47_sp"];
          break;
        case "iw8_ar_asierra12":
          var_3["stocks"] = [50, "stockh_asierra12", "stockl_asierra12", "stocks_asierra12"];
          var_3["underbarrels"] = [15, "selectsemi"];
          var_3["barrels"] = [50, "barcust_asierra12", "barshort_asierra12", "barlong_asierra12"];
          var_3["mags"] = [20, "xmags_asierra12"];
          break;
      }

      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3["stocks"] = [75, "back_pkilo|1"];
          var_3["receivers"] = [75, "rec_pkilo|1"];
          var_3["barrels"] = [75, "front_pkilo|1"];
          var_3["mags"] = [75, "mag_pkilo|1"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_sm_augolf"] = 30;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_augolf":
          var_3["mags"] = [30, "drums_augolf_sp"];
          var_3["barrels"] = [50, "barshort_augolf"];
          break;
        case "iw8_ar_akilo47":
          var_3["stocks"] = [100, "stockcust_akilo47", "stocksmg_akilo47"];
          var_3["mags"] = [100, "calsmg_akilo47_sp", "calsmgdrums_akilo47_sp"];
          var_3["rec"] = [100, "rec_akilo47|2"];
          var_3["barrels"] = [100, "barsmg_akilo47|1"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_ru_1999(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [70, "acogstable_east01", "holostable_east01", "reflexstable_east01"];
          var_3["stocks"] = [70, "stocksmg_akilo47"];

          if(level.script == "captive")
            var_1 = "iw8_ar_akilo47_tfarah";

          break;
      }

      break;
    case "pistol":
      switch (var_1) {
        case "iw8_pi_golf21":
          if(level.script == "captive")
            var_1 = "iw8_pi_golf21_tfarah";

          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_reb(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  if(var_0 == "shotgun" && (level.script == "highway" || level.script == "safehouse_finale")) {
    var_0 = "smg";
    var_2 = ["iw8_ar_akilo47", "iw8_sm_uzulu", "iw8_sm_mpapa5"];
  }

  switch (var_0) {
    case "ar":
      var_5["iw8_ar_akilo47"] = 50;
      var_5["iw8_ar_falpha"] = 50;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3["scopes"] = [10, "acogstable_east01"];
          var_3["stocks"] = [50, "stocklmg_akilo47", "stocksmg_akilo47", "stockno_akilo47"];
          var_3["mags"] = [20, "drums_akilo47_sp", "mag_akilo47|1"];
          var_3["grips"] = [50, "gripvert_akilo47"];
          var_3["barrels"] = [50, "barlmg_akilo47", "front_akilo47|1"];
          var_3["underbarrels"] = [15, "ub_golf25_sp"];
          var_3["other"] = [15, "rec_akilo47|1"];
          break;
        case "iw8_ar_falpha":
          var_3["scopes"] = [15, "acog_east01_irons"];
          var_3["stocks"] = [50, "stockh_falpha", "stockl_falpha", "stocks_falpha", "rec_falpha|1"];
          var_3["mags"] = [20, "xmags_falpha", "mag_falpha|1"];
          var_3["grips"] = [50, "gripvert", "gripang"];
          var_3["barrels"] = [50, "barlong_falpha", "barcust_falpha", "barshort_falpha", "front_falpha|1"];
          var_3["underbarrels"] = [15, "selectsemi_falpha"];
          var_3["triggrip"] = [50, "triggrip_falpha|1"];
          var_3["toprail"] = [50, "toprail_falpha|1"];
          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3["scopes"] = [50, "snprscope_kilo98", "vzscope_kilo98"];
          var_3["other"] = [40, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_mgolf34":
          var_3["scopes"] = [50, "reflex_west01", "acog_east01_irons", "holo_east01"];
          var_3["mags"] = [35, "xmags_mgolf34"];
          var_3["other"] = [50, "bipod_mgolf34"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["stocks"] = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          var_3["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      var_5["iw8_ar_akilo47"] = 70;
      var_5["iw8_sm_uzulu"] = 15;
      var_5["iw8_sm_mpapa5"] = 15;
      var_1 = scripts\common\utility::get_weapon_weighted(var_2, var_5);

      switch (var_1) {
        case "iw8_sm_uzulu":
          var_3["scopes"] = [50, "minireddot", "reflex_west01", "reflex_east01", "reflex_east02"];
          break;
        case "iw8_ar_akilo47":
          var_3["barrels"] = [100, "barsmg_akilo47"];
          var_3["stocks"] = [100, "stockcust_akilo47", "stockno_akilo47", "stockno_akilo47"];
          var_3["mags"] = [100, "calsmg_akilo47_sp", "calsmgdrums_akilo47_sp"];
          var_3["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          var_3["scopes"] = [25, "reflexstable_west01", "reflexstable_east01"];
          break;
        case "iw8_sm_mpapa5":
          var_3["stocks"] = [50, "stockno_mpapa5", "stockh_mpapa5", "stocks_mpapa5", "back_mpapa5|1"];
          var_3["mags"] = [35, "mag_mpapa5|1"];
          var_3["grips"] = [35, "gripvertsmg"];
          var_3["scopes"] = [30, "reflex_west01_irons", "reflex_east01", "reflex_east02", "minireddot"];
          var_3["barrels"] = [50, "front_mpapa5|1"];
          var_3["recs"] = [50, "rec_mpapa5|1"];
          var_4[var_4.size] = ["back_mpapa5|1", "front_mpapa5|1", "rec_mpapa5|1", "mag_mpapa5|1"];
          break;
      }

      break;
    case "sniper":
      switch (var_1) {
        case "iw8_sn_alpha50":
          var_3["scopes"] = [100, "snprscope_alpha50", "vzscope_alpha50"];
          var_3["barrels"] = [50, "barmid_alpha50", "barshort_alpha50"];
          var_3["laserir"] = [100, "laserads"];
          var_3["stocks"] = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          var_3["other"] = [25, "bipodsnpr"];
          var_3["mags"] = [35, "mmags_alpha50"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_sas(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      return scripts\sp\utility::make_weapon_special("sas_ar");
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      return scripts\sp\utility::make_weapon_special("papa320_black");
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["recs"] = [100, "rec_romeo870|1"];
          var_3["mags"] = [80, "ammo_romeo870|1"];
          var_3["stocks"] = [70, "back_romeo870|1"];
          var_3["barrels"] = [80, "front_romeo870|1"];
          var_3["grips"] = [80, "grip_romeo870|1"];
          break;
      }
    case "smg":
      break;
    case "sniper":
      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_so15(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      if(level.script == "piccadilly" || level.script == "ai_aitypes_allies")
        return scripts\sp\utility::make_weapon_special("papa320_black_rain");
      else
        return scripts\sp\utility::make_weapon_special("papa320_black");
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["recs"] = [100, "rec_romeo870|1"];
          var_3["mags"] = [80, "ammo_romeo870|1"];
          var_3["stocks"] = [70, "back_romeo870|1"];
          var_3["barrels"] = [80, "front_romeo870|1"];
          var_3["grips"] = [80, "grip_romeo870|1"];
          break;
      }

      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

getweapon_usmc(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      switch (var_1) {
        case "iw8_ar_mike4":
          var_3["scopes"] = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          var_3["stocks"] = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          var_3["mags"] = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          var_3["grips"] = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          var_3["barrels"] = [70, "barshort_mike4", "front_mike4|1"];
          var_3["underbarrels"] = [15, "ub_mike203_sp"];
          var_3["endbarrel"] = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          var_3["other"] = [50, "rec_mike4|1", "rec_mike4|2"];
          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_mike14":
          var_3["scopes"] = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01", "snprscope_mike14"];
          var_3["mags"] = [50, "xmagslrg_mike14", "xmags_mike14|1", "xmags_mike14|2", "xmags_mike14|3", "xmags_mike14|4"];
          var_3["stocks"] = [70, "stockl_mike14", "stockh_mike14", "back_mike14|1", "back_mike14|2", "back_mike14|3", "back_mike14|4"];
          var_3["barrels"] = [70, "barlong_mike14", "barmid_mike14", "front_mike14|1", "front_mike14|3", "front_mike14|3", "front_mike14|3"];
          var_3["endbarrel"] = [65, "flashhider", "comp", "brake", "linearbrake", "silencerdmr04"];
          var_3["receivers"] = [50, "rec_mike14|1", "rec_mike14|2", "rec_mike14|3", "rec_mike14|4"];
          var_3["lasers"] = [100, "laser_bar", "laserir_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      break;
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3["recs"] = [100, "rec_romeo870|1"];
          var_3["mags"] = [80, "ammo_romeo870|1"];
          var_3["stocks"] = [70, "back_romeo870|1"];
          var_3["barrels"] = [80, "front_romeo870|1"];
          var_3["grips"] = [80, "grip_romeo870|1"];
          break;
      }

      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

printweapon() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    var_0 = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      var_1 = createheadicon(self.weapon);
      var_2 = strtok(var_1, "+");

      if(isDefined(var_2[0])) {
        if(var_2.size > 1) {
          var_3 = var_0 - 1.5;

          for(var_4 = 1; var_4 < var_2.size; var_4++)
            var_3 = var_3 - 1.4;
        }
      }
    }

    waitframe();
  }
}