/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\scripted_weapon_assignment.gsc
*****************************************************/

function getscriptedweapon(var_0, var_1) {
  if(!isDefined(var_0)) {
    return isundefinedweapon();
  }

  if(!isarray(var_0) && var_0 == "") {
    return isundefinedweapon();
  }

  if(isDefined(var_1) && var_1 == "sidearm") {
    var_2 = getweapon(var_0, "pistol");
  } else {
    var_2 = getweapon(var_1, self.scriptedweaponclassprimary);
  }

  return var_2;
}

function getweapon(var_0, var_1) {
  var_2 = [];

  if(isarray(var_0)) {
    var_2 = var_0;
    var_0 = var_0[randomint(var_0.size)];
  }

  if(issubstr(tolower(self.classname), "_alq_")) {
    return getweapon_aq(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_rus_desert_")) {
    return getweapon_ru(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_rus_pmc_")) {
    return getweapon_ru(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_spetsnaz_lab")) {
    return getweapon_ru_lab(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_spetsnaz_")) {
    return getweapon_ru(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_rus_1999_")) {
    return getweapon_ru_1999(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_hero_")) {
    return getweapon_hero(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_villain_")) {
    return getweapon_hero(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_sas_")) {
    return getweapon_sas(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_reb_")) {
    return getweapon_reb(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_so15_")) {
    return getweapon_so15(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_london_police_")) {
    return getweapon_so15(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_usmc_")) {
    return getweapon_usmc(var_1, var_0, var_2);
  } else {
    if(getdvarint("scr_randomweapon_debug")) {
      iprintln("not whitelisted!skipping scripted build.");
    }

    return scripts\sp\utility::make_weapon(var_0);
  }

  return var_0;
}

function getweapon_hero(var_0, var_1) {
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

  if(getdvarint("scr_randomweapon_debug")) {
    iprintln("not whitelisted!skipping scripted build.");
  }

  return scripts\sp\utility::make_weapon(var_0, []);
}

function getweapon_aq(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      if(level.script == "piccadilly") {
        GscBinSkip1(0x45, "iw8_ar_akilo47", 45);
      }

      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "dmr":
      GscBinSkip1(0x45, "iw8_sn_kilo98", 50);

    case "launcher":
      return "iw8_la_rpapa7";
    case "lmg":
      if(level.script == "piccadilly") {
        GscBinSkip1(0x45, "iw8_lm_pkilo", 100);
      }

      GscBinSkip1(0x45, "iw8_lm_pkilo", 55);

    case "pistol":
      var_1 = "iw8_pi_mike1911";

      switch (var_1) {
        case "iw8_pi_mike1911":
          if(level.script == "piccadilly") {} else {
            var_3 = [75, "minireddot_mike1911", "irons_mike1911"];
            var_3 = [35, "xmags_mike1911"];
          }

          break;
      }

      break;
    case "shotgun":
      GscBinSkip1(0x45, "iw8_sh_romeo870", 50);

    case "smg":
      if(level.script == "piccadilly") {
        GscBinSkip1(0x45, "iw8_sm_uzulu", 70);
      }

      GscBinSkip1(0x45, "iw8_sm_uzulu", 50);

    case "sniper":
      GscBinSkip1(0x45, "iw8_sn_delta", 50);
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_ru(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "dmr":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3 = [80, "acog_east01", "acog_west01", "snprscope_delta"];
          var_3 = [80, "stockl_delta", "stockh_delta", "stocks_delta"];
          var_3 = [50, "xmags_delta"];
          var_3 = [100, "laserads_bar"];
          var_3 = [50, "flashhidersnpr", "compsnpr", "brakesnpr", "linearbrakesnpr"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3 = [75, "back_pkilo|1"];
          var_3 = [75, "rec_pkilo|1"];
          var_3 = [75, "front_pkilo|1"];
          var_3 = [75, "mag_pkilo|1"];
          var_3 = [50, "bipod_pkilo"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      GscBinSkip1(0x45, "iw8_sh_romeo870", 50);

    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "sniper":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3 = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_ru_lab(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3 = [75, "back_pkilo|1"];
          var_3 = [75, "rec_pkilo|1"];
          var_3 = [75, "front_pkilo|1"];
          var_3 = [75, "mag_pkilo|1"];
          break;
      }

      break;
    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_ru_1999(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      switch (var_1) {
        case "iw8_ar_akilo47":
          var_3 = [70, "acogstable_east01", "holostable_east01", "reflexstable_east01"];
          var_3 = [70, "stocksmg_akilo47"];

          if(level.script == "captive") {
            var_1 = "iw8_ar_akilo47_tfarah";
          }

          break;
      }

      break;
    case "pistol":
      switch (var_1) {
        case "iw8_pi_golf21":
          if(level.script == "captive") {
            var_1 = "iw8_pi_golf21_tfarah";
          }

          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_reb(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  if(var_0 == "shotgun" && (level.script == "highway" || level.script == "safehouse_finale")) {
    var_0 = "smg";
    var_2 = ["iw8_ar_akilo47", "iw8_sm_uzulu", "iw8_sm_mpapa5"];
  }

  switch (var_0) {
    case "ar":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 50);

    case "dmr":
      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3 = [50, "snprscope_kilo98", "vzscope_kilo98"];
          var_3 = [40, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_mgolf34":
          var_3 = [50, "reflex_west01", "acog_east01_irons", "holo_east01"];
          var_3 = [35, "xmags_mgolf34"];
          var_3 = [50, "bipod_mgolf34"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3 = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          var_3 = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "sniper":
      switch (var_1) {
        case "iw8_sn_alpha50":
          var_3 = [100, "snprscope_alpha50", "vzscope_alpha50"];
          var_3 = [50, "barmid_alpha50", "barshort_alpha50"];
          var_3 = [100, "laserads"];
          var_3 = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          var_3 = [25, "bipodsnpr"];
          var_3 = [35, "mmags_alpha50"];
          break;
      }

      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_sas(var_0, var_1, var_2) {
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
          var_3 = [100, "rec_romeo870|1"];
          var_3 = [80, "ammo_romeo870|1"];
          var_3 = [70, "back_romeo870|1"];
          var_3 = [80, "front_romeo870|1"];
          var_3 = [80, "grip_romeo870|1"];
          break;
      }
    case "smg":
      break;
    case "sniper":
      break;
  }

  return scripts\common\utility::make_weapon_random(var_1, var_3, var_4);
}

function getweapon_so15(var_0, var_1, var_2) {
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
      if(level.script == "piccadilly" || level.script == "ai_aitypes_allies") {
        return scripts\sp\utility::make_weapon_special("papa320_black_rain");
      } else {
        return scripts\sp\utility::make_weapon_special("papa320_black");
      }
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3 = [100, "rec_romeo870|1"];
          var_3 = [80, "ammo_romeo870|1"];
          var_3 = [70, "back_romeo870|1"];
          var_3 = [80, "front_romeo870|1"];
          var_3 = [80, "grip_romeo870|1"];
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

function getweapon_usmc(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "ar":
      switch (var_1) {
        case "iw8_ar_mike4":
          var_3 = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          var_3 = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          var_3 = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          var_3 = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          var_3 = [70, "barshort_mike4", "front_mike4|1"];
          var_3 = [15, "ub_mike203_sp"];
          var_3 = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          var_3 = [50, "rec_mike4|1", "rec_mike4|2"];
          break;
      }

      break;
    case "dmr":
      switch (var_1) {
        case "iw8_sn_mike14":
          var_3 = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01", "snprscope_mike14"];
          var_3 = [50, "xmagslrg_mike14", "xmags_mike14|1", "xmags_mike14|2", "xmags_mike14|3", "xmags_mike14|4"];
          var_3 = [70, "stockl_mike14", "stockh_mike14", "back_mike14|1", "back_mike14|2", "back_mike14|3", "back_mike14|4"];
          var_3 = [70, "barlong_mike14", "barmid_mike14", "front_mike14|1", "front_mike14|3", "front_mike14|3", "front_mike14|3"];
          var_3 = [65, "flashhider", "comp", "brake", "linearbrake", "silencerdmr04"];
          var_3 = [50, "rec_mike14|1", "rec_mike14|2", "rec_mike14|3", "rec_mike14|4"];
          var_3 = [100, "laser_bar", "laserir_bar"];
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
          var_3 = [100, "rec_romeo870|1"];
          var_3 = [80, "ammo_romeo870|1"];
          var_3 = [70, "back_romeo870|1"];
          var_3 = [80, "front_romeo870|1"];
          var_3 = [80, "grip_romeo870|1"];
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

function printweapon() {
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

          for(var_4 = 1; var_4 < var_2.size; var_4++) {
            var_3 -= 1.4;
          }
        }
      }
    }

    waitframe();
  }
}