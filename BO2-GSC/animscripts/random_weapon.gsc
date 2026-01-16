/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\random_weapon.gsc
*****************************************/

#include animscripts\utility;
#include maps\_utility;
#include common_scripts\utility;

create_weapon_drop_array() {
  flag_init("weapon_drop_arrays_built");
  level thread override_weapon_drop_weights_by_level();
  primary_weapons = array("spectre", "uzi", "mp5k", "mac11", "skorpion", "kiparis", "mpl", "pm63", "ak74u", "aug", "galil", "enfield", "m14", "ak47", "famas", "commando", "g11", "m16", "fnfal", "m60", "stoner63", "hk21", "rpk");
  primary_weapons_2 = array("asp", "cz75", "m1911", "makarov", "python", "psg1", "wa2000", "dragunov", "l96a1", "ithaca", "hs10", "spas", "rottweil71");
  primary_weapons = arraycombine(primary_weapons, primary_weapons_2, 1, 0);
  primary_weapon_attachments = [];
  primary_weapon_attachments["sites"] = array("acog", "elbit", "ir", "reflex");
  primary_weapon_attachments["ammo"] = array("extclip", "dualclip");
  primary_weapon_attachments["barrel"] = array("silencer");
  primary_weapon_attachments["auto"] = array("auto");
  primary_weapon_alts = array("ft", "gl", "mk");
  _sp = "_sp";
  anim.droppable_weapons = [];
  attachment_categories = array("sites", "ammo", "barrel", "auto");

  for(i = 0; i < primary_weapons.size; i++) {
    base_weapon = primary_weapons[i] + _sp;
    anim.droppable_weapons[base_weapon] = [];

    for(l = 0; l < attachment_categories.size; l++) {
      anim.droppable_weapons[base_weapon][attachment_categories[l]] = [];

      for(j = 0; j < primary_weapon_attachments[attachment_categories[l]].size; j++) {
        new_weapon = primary_weapons[i] + "_" + primary_weapon_attachments[attachment_categories[l]][j] + _sp;

        if(isassetloaded("weapon", new_weapon))
          anim.droppable_weapons[base_weapon][attachment_categories[l]][anim.droppable_weapons[base_weapon][attachment_categories[l]].size] = new_weapon;
      }
    }

    anim.droppable_weapons[base_weapon]["alt_weapon"] = [];

    for(j = 0; j < primary_weapon_alts.size; j++) {
      new_weapon = primary_weapon_alts[j] + "_" + primary_weapons[i] + _sp;

      if(isassetloaded("weapon", new_weapon)) {
        new_weapon = primary_weapons[i] + "_" + primary_weapon_alts[j] + _sp;
        anim.droppable_weapons[base_weapon]["alt_weapon"][anim.droppable_weapons[base_weapon]["alt_weapon"].size] = new_weapon;
      }
    }
  }

  build_weight_arrays_by_ai_class("VC", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("NVA", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Spetsnaz", 0, 50, 25, 25, 25);
  build_weight_arrays_by_ai_class("RU", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("CU", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Marines", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Blackops", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Specops", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("UWB", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Rebels", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("Prisoners", 0, 50, 25, 25, 10);
  build_weight_arrays_by_ai_class("hazmat", 0, 50, 25, 25, 10);

  if(!isDefined(level.rw_enabled))
    level.rw_enabled = 1;

  if(!isDefined(level.rw_attachments_allowed))
    level.rw_attachments_allowed = 0;

  if(!isDefined(level.rw_gl_allowed))
    level.rw_gl_allowed = 1;

  if(!isDefined(level.rw_mk_allowed))
    level.rw_mk_allowed = 1;

  if(!isDefined(level.rw_ft_allowed))
    level.rw_ft_allowed = 1;

  flag_set("weapon_drop_arrays_built");
}

build_weight_arrays_by_ai_class(_ai_class, _overwrite, _base_weapon, _scoped_attachment, _ammo_attachment, _alt_weapon) {
  if(isDefined(anim.droppable_weapons[_ai_class]) && !_overwrite) {
    return;
  }
  anim.droppable_weapons[_ai_class] = [];
  anim.droppable_weapons[_ai_class]["base"] = _base_weapon;
  anim.droppable_weapons[_ai_class]["sites"] = _scoped_attachment;
  anim.droppable_weapons[_ai_class]["ammo"] = _ammo_attachment;
  anim.droppable_weapons[_ai_class]["alt_weapon"] = _alt_weapon;
}

get_weapon_name_with_attachments(weapon_name) {
  if(!isDefined(anim.droppable_weapons))
    return weapon_name;

  if(!level.rw_enabled)
    return weapon_name;

  if(!isDefined(anim.droppable_weapons[weapon_name]) || anim.droppable_weapons[weapon_name].size == 0)
    return weapon_name;

  ai_class = get_ai_class_for_weapon_drop(self.classname);

  if(ai_class == "not_defined" || !isDefined(anim.droppable_weapons[ai_class]))
    return weapon_name;

  keys = array("base", "sites", "ammo", "alt_weapon");
  total_weight = 0;

  for(i = 0; i < keys.size; i++) {
    if(keys[i] == "alt_weapon") {
      if(level.rw_attachments_allowed)
        total_weight = total_weight + anim.droppable_weapons[ai_class][keys[i]];

      continue;
    }

    total_weight = total_weight + anim.droppable_weapons[ai_class][keys[i]];
  }

  if(total_weight == 0)
    return weapon_name;

  random_choice = randomint(total_weight);
  current_key = "none";
  current_weight = 0;

  for(i = 0; i < keys.size; i++) {
    current_key = keys[i];
    current_weight = current_weight + anim.droppable_weapons[ai_class][keys[i]];

    if(random_choice < current_weight) {
      break;
    }
  }

  if(current_key == "base")
    return weapon_name;

  if(anim.droppable_weapons[weapon_name][current_key].size == 0)
    return weapon_name;

  if(current_key != "alt_weapon") {
    random_weap_int = randomint(anim.droppable_weapons[weapon_name][current_key].size);
    return anim.droppable_weapons[weapon_name][current_key][random_weap_int];
  } else {
    assert(level.rw_attachments_allowed, "Trying to give an attachment that is not valid.Talk to GLocke if you hit this assert.");
    possible_alt_weapons = anim.droppable_weapons[weapon_name][current_key];

    if(!level.rw_gl_allowed) {
      for(x = 0; x < possible_alt_weapons.size; x++) {
        if(issubstr(possible_alt_weapons[x], "_gl_")) {
          arrayremovevalue(possible_alt_weapons, possible_alt_weapons[x]);
          break;
        }
      }
    }

    if(!level.rw_mk_allowed) {
      for(x = 0; x < possible_alt_weapons.size; x++) {
        if(issubstr(possible_alt_weapons[x], "_mk_")) {
          arrayremovevalue(possible_alt_weapons, possible_alt_weapons[x]);
          break;
        }
      }
    }

    if(!level.rw_ft_allowed) {
      for(x = 0; x < possible_alt_weapons.size; x++) {
        if(issubstr(possible_alt_weapons[x], "_ft_")) {
          arrayremovevalue(possible_alt_weapons, possible_alt_weapons[x]);
          break;
        }
      }
    }

    if(possible_alt_weapons.size == 0)
      return weapon_name;
    else {
      random_weapon_int = randomint(possible_alt_weapons.size);
      return possible_alt_weapons[random_weapon_int];
    }
  }
}

get_ai_class_for_weapon_drop(_classname) {
  if(issubstr(_classname, "Spetsnaz_e"))
    return "Spetsnaz";
  else if(issubstr(_classname, "NVA_e"))
    return "NVA";
  else if(issubstr(_classname, "VC_e"))
    return "VC";
  else if(issubstr(_classname, "RU_e"))
    return "RU";
  else if(issubstr(_classname, "CU_e"))
    return "CU";
  else if(issubstr(_classname, "USMarines"))
    return "Marines";
  else if(issubstr(_classname, "USBlackops"))
    return "Blackops";
  else if(issubstr(_classname, "USSpecs"))
    return "Specops";
  else if(issubstr(_classname, "UWB"))
    return "UWB";
  else if(issubstr(_classname, "CU_a"))
    return "Rebels";
  else if(issubstr(_classname, "Prisoner"))
    return "Prisoners";
  else if(issubstr(_classname, "a_hazmat"))
    return "hazmat";

  return "not_defined";
}

override_weapon_drop_weights_by_level() {
  while(!isDefined(level.script) || !flag("weapon_drop_arrays_built"))
    wait 0.1;

  switch (level.script) {
    case "cuba":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("CU", 1, 50, 20, 75, 20);
      build_weight_arrays_by_ai_class("Rebels", 1, 50, 10, 50, 15);
      break;
    case "vorkuta":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 50, 0, 60, 40);
      build_weight_arrays_by_ai_class("Prisoners", 1, 50, 0, 60, 40);
      break;
    case "flashpoint":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 50, 30, 40, 10);
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 50, 30, 40, 10);
      break;
    case "khe_sanh":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("NVA", 1, 40, 20, 50, 20);
      build_weight_arrays_by_ai_class("Marines", 1, 40, 60, 40, 30);
      break;
    case "hue_city":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("Marines", 1, 40, 25, 25, 15);
      build_weight_arrays_by_ai_class("NVA", 1, 50, 25, 25, 40);
      break;
    case "kowloon":
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 50, 40, 60, 15);
      build_weight_arrays_by_ai_class("Blackops", 1, 50, 40, 60, 15);
      break;
    case "creek_1":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("Marines", 1, 40, 45, 40, 10);
      build_weight_arrays_by_ai_class("VC", 1, 40, 20, 70, 15);
      break;
    case "river":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("Marines", 1, 40, 35, 15, 10);
      build_weight_arrays_by_ai_class("VC", 1, 60, 15, 15, 15);
      break;
    case "pow":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 40, 35, 20, 10);
      build_weight_arrays_by_ai_class("VC", 1, 40, 35, 20, 10);
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 30, 50, 35, 10);
      build_weight_arrays_by_ai_class("Marines", 1, 40, 35, 20, 10);
      break;
    case "fullahead":
      break;
    case "wmd":
    case "wmd_sr71":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 50, 20, 15, 10);
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 50, 20, 15, 10);
      build_weight_arrays_by_ai_class("Blackops", 1, 0, 100, 15, 10);
      break;
    case "rebirth":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 30, 40, 30, 20);
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 30, 40, 20, 15);
      build_weight_arrays_by_ai_class("hazmat", 1, 0, 100, 100, 10);
      break;
    case "underwaterbase":
      level.rw_attachments_allowed = 1;
      build_weight_arrays_by_ai_class("RU", 1, 30, 50, 50, 20);
      build_weight_arrays_by_ai_class("Spetsnaz", 1, 40, 30, 50, 20);
      build_weight_arrays_by_ai_class("UWB", 1, 30, 50, 50, 20);
      break;
    case "default":
      break;
  }
}

set_random_cammo_drop() {
  while(isDefined(self)) {
    self waittill("dropweapon", weapon);

    if(!isDefined(weapon) || !isDefined(weapon.classname)) {
      continue;
    }
    weapon_class = get_weapon_type(weapon.classname);

    if(!isDefined(weapon_class)) {
      return;
    }
    name = tolower(weapon.classname);

    switch (level.script) {
      case "cuba":
        if(weapon_class == "assault") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(9);
        } else if(weapon_class == "lmg") {
          if(issubstr(name, "rpk")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(14);
          } else if(issubstr(name, "m60")) {
            if(randomint(100) > 24)
              weapon itemweaponsetoptions(9);
          }
        } else if(weapon_class == "launcher") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(14);
        }

        break;
      case "vorkuta":
        if(weapon_class == "assault" || weapon_class == "shotgun") {
          if(randomint(100) > 89)
            weapon itemweaponsetoptions(12);
        }

        break;
      case "flashpoint":
        if(weapon_class == "assault") {
          if(issubstr(name, "ak47")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(14);
          } else if(issubstr(name, "mp5k"))
            weapon itemweaponsetoptions(1);
        } else if(weapon_class == "smg") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(5);
        } else if(weapon_class == "sniper") {
          if(randomint(100) > 49)
            weapon itemweaponsetoptions(5);
        } else if(weapon_class == "launcher")
          weapon itemweaponsetoptions(6);

        break;
      case "khe_sanh":
        if(weapon_class == "assault") {
          if(issubstr(name, "m16")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(1);
          } else if(issubstr(name, "m14")) {
            if(randomint(100) > 56)
              weapon itemweaponsetoptions(1);
          } else if(issubstr(name, "ak74")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(7);
          }
        } else if(weapon_class == "launcher") {
          if(issubstr(name, "china")) {
            if(randomint(100) > 49)
              weapon itemweaponsetoptions(6);
          } else if(issubstr(name, "tow"))
            weapon itemweaponsetoptions(6);
          else if(issubstr(name, "law"))
            weapon itemweaponsetoptions(1);
          else if(issubstr(name, "rpg"))
            weapon itemweaponsetoptions(7);
        } else if(weapon_class == "shotgun") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(1);
        } else if(weapon_class == "lmg") {
          if(issubstr(name, "rpk")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(7);
          } else if(issubstr(name, "m60")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(1);
          }
        }

        break;
      case "hue_city":
        if(weapon_class == "shotgun") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(7);
        } else if(weapon_class == "assault") {
          if(issubstr(name, "commando")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(9);
          } else if(issubstr(name, "fnfal")) {
            if(randomint(100) > 74)
              weapon itemweaponsetoptions(7);
          }
        } else if(weapon_class == "lmg") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(7);
        }

        break;
      case "kowloon":
        break;
      case "creek_1":
        if(weapon_class == "sniper") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(9);
        } else if(weapon_class == "assault") {
          if(issubstr(name, "commando")) {
            if(randomint(100) > 79)
              weapon itemweaponsetoptions(8);
          } else if(issubstr(name, "ak47")) {
            if(randomint(100) > 79)
              weapon itemweaponsetoptions(13);
          }
        }

        break;
      case "river":
        if(weapon_class == "sniper") {
          if(randomint(100) > 74)
            weapon itemweaponsetoptions(9);
        } else if(weapon_class == "assault") {
          if(issubstr(name, "commando"))
            weapon itemweaponsetoptions(13);
          else if(issubstr(name, "ak74")) {
            if(randomint(100) > 79)
              weapon itemweaponsetoptions(9);
          } else if(issubstr(name, "m16")) {
            if(randomint(100) > 19)
              weapon itemweaponsetoptions(13);
          }
        } else if(weapon_class == "smg") {
          if(randomint(100) > 49)
            weapon itemweaponsetoptions(9);
        } else if(weapon_class == "shotgun") {
          if(randomint(100) > 49)
            weapon itemweaponsetoptions(13);
        } else if(weapon_class == "launcher") {
          if(randomint(100) > 59)
            weapon itemweaponsetoptions(13);
        }

        break;
      case "pow":
        if(weapon_class == "assault") {
          if(issubstr(name, "ak47") || issubstr(name, "galil")) {
            if(randomint(100) > 39)
              weapon itemweaponsetoptions(14);
          }
        } else if(weapon_class == "smg") {
          if(randomint(100) > 49)
            weapon itemweaponsetoptions(14);
        } else if(weapon_class == "shotgun") {
          if(randomint(100) > 39)
            weapon itemweaponsetoptions(9);
        } else if(weapon_class == "lmg") {
          if(randomint(100) > 39)
            weapon itemweaponsetoptions(13);
        }

        break;
      case "fullahead":
        weapon itemweaponsetoptions(2);
        break;
      case "wmd":
      case "wmd_sr71":
        if(weapon_class == "assault") {
          if(issubstr(name, "famas")) {
            if(randomint(100) > 39)
              weapon itemweaponsetoptions(2);
          }
        } else if(weapon_class == "shotgun") {
          if(randomint(100) > 39)
            weapon itemweaponsetoptions(11);
        } else if(weapon_class == "lmg") {
          if(randomint(100) > 39)
            weapon itemweaponsetoptions(11);
        } else if(weapon_class == "smg") {
          if(randomint(100) > 39)
            weapon itemweaponsetoptions(2);
        }

        break;
      case "rebirth":
        if(weapon_class == "launcher")
          weapon itemweaponsetoptions(7);
        else if(weapon_class == "assault") {
          if(issubstr(name, "enfield"))
            weapon itemweaponsetoptions(7);
        } else if(weapon_class == "lmg") {
          if(issubstr(name, "hk21"))
            weapon itemweaponsetoptions(7);
        }

        break;
      case "underwaterbase":
        if(weapon_class == "assault") {
          if(issubstr(name, "ak74"))
            weapon itemweaponsetoptions(7);
        }

        break;
      case "default":
        break;
    }
  }
}

get_weapon_type(weapon_name) {
  _classname = tolower(weapon_name);

  if(issubstr(_classname, "ks23") || issubstr(_classname, "rottweil") || issubstr(_classname, "ithaca") || issubstr(_classname, "spas"))
    return "shotgun";
  else if(issubstr(_classname, "m16") || issubstr(_classname, "fnfal") || issubstr(_classname, "ak47") || issubstr(_classname, "ak74") || issubstr(_classname, "mp5k") || issubstr(_classname, "m14") || issubstr(_classname, "commando") || issubstr(_classname, "g11") || issubstr(_classname, "aug") || issubstr(_classname, "famas") || issubstr(_classname, "galil") || issubstr(_classname, "enfield"))
    return "assault";
  else if(issubstr(_classname, "skorpion") || issubstr(_classname, "pm63") || issubstr(_classname, "kiparis") || issubstr(_classname, "spectre") || issubstr(_classname, "uzi") || issubstr(_classname, "ppsh") || issubstr(_classname, "mp40") || issubstr(_classname, "sten") || issubstr(_classname, "mp44") || issubstr(_classname, "mac11"))
    return "smg";
  else if(issubstr(_classname, "rpk") || issubstr(_classname, "m60") || issubstr(_classname, "hk21") || issubstr(_classname, "mg42") || issubstr(_classname, "stoner"))
    return "lmg";
  else if(issubstr(_classname, "dragon") || issubstr(_classname, "wa2000") || issubstr(_classname, "psg"))
    return "sniper";
  else if(issubstr(_classname, "tow") || issubstr(_classname, "rpg") || issubstr(_classname, "fhj18") || issubstr(_classname, "strela") || issubstr(_classname, "panzer") || issubstr(_classname, "china") || issubstr(_classname, "m202") || issubstr(_classname, "law"))
    return "launcher";
}