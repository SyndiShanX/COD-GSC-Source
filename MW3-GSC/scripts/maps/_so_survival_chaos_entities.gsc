/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\_so_survival_chaos_entities.gsc
********************************************************/

get_level(var_0) {
  return tablelookup(level.chaos_entity_table, 0, var_0, 1);
}

get_level_weapon(var_0) {
  return tablelookup(level.chaos_entity_table, 0, var_0, 2);
}

get_level_weapon_position(var_0) {
  return tablelookup(level.chaos_entity_table, 0, var_0, 3);
}

get_level_drop_location(var_0) {
  return tablelookup(level.chaos_drop_location_table, 0, var_0, 2);
}

get_level_drop_item(var_0) {
  return tablelookup(level.chaos_drop_item_table, 0, var_0, 3);
}

get_level_drop_wave(var_0) {
  return tablelookup(level.chaos_drop_item_table, 0, var_0, 2);
}

get_level_ai_size_wave(var_0) {
  return tablelookup(level.constant_ai_size_table, 0, var_0, 2);
}

get_level_ai_size(var_0) {
  return tablelookup(level.constant_ai_size_table, 0, var_0, 3);
}

get_ai_size_level(var_0) {
  return tablelookup(level.constant_ai_size_table, 0, var_0, 1);
}

get_drop_distance_level(var_0) {
  return tablelookup(level.desired_drop_distance_table, 0, var_0, 1);
}

get_level_desired_drop_distance(var_0) {
  return tablelookup(level.desired_drop_distance_table, 0, var_0, 2);
}

get_level_starting_lives_remaining(var_0) {
  return tablelookup(level.desired_drop_distance_table, 0, var_0, 3);
}

chaos_entities_precache() {
  if(!isDefined(level.chaos_entity_table)) {
    level.chaos_entity_table = "sp/survival_chaos_entities.csv";
  }
  var_0 = getDvar("mapname");

  for(var_1 = 100; var_1 <= 1700; var_1++) {
    var_2 = get_level(var_1);

    if(!isDefined(var_2) || var_2 == "" || var_2 != var_0) {
      continue;
    }
    var_3 = get_level_weapon(var_1);

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }
    var_4 = get_level_weapon_position(var_1);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = strtok(var_4, ",");

    if(!isDefined(var_5) || var_5.size != 3) {
      continue;
    }
    if(!isDefined(level.chaos_weapon_locations)) {
      level.chaos_weapon_locations = [];
    }
    precacheitem(var_3);
    level.chaos_weapon_locations[var_3] = (float(var_5[0]), float(var_5[1]), float(var_5[2]));
  }
}

chaos_entities_place() {
  level.chaos_entities = [];

  foreach(var_9, var_1 in level.chaos_weapon_locations) {
    var_2 = getweaponmodel(var_9);
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = var_1 + (0, 0, 48);
    var_3._id_5C39 = var_9;
    var_3.trigger = spawn("trigger_radius", var_3.origin, 0, 48, 48);
    var_4 = (8, 0, 0);
    var_5 = (0, 0, 0);

    if(issubstr(var_9, "akimbo")) {
      var_3.akimbo = 1;
      var_6 = var_4 + (0, -6, 0);
      var_7 = var_4 + (0, 6, 0);
      var_3.weapon_models[0] = spawn("script_model", var_3.origin);
      var_3.weapon_models[0] setModel(var_2);
      var_3.weapon_models[0] linkto(var_3, "tag_origin", var_6, var_5 + (15, 0, 0));
      var_3.weapon_models[1] = spawn("script_model", var_3.origin);
      var_3.weapon_models[1] setModel(var_2);
      var_3.weapon_models[1] linkto(var_3, "tag_origin", var_7, var_5 + (15, 0, 0));
    } else {
      var_3.akimbo = 0;
      var_3.weapon_models[0] = spawn("script_model", var_3.origin);
      var_3.weapon_models[0] setModel(var_2);
      var_3.weapon_models[0] linkto(var_3, "tag_origin", var_4, var_5);
    }

    var_3 thread chaos_entity_rotate();
    var_3.display_name = get_weapon_display_name(var_9);
    var_8 = chaos_get_weapon_class(var_9);
    var_3.hud_icon = get_weapon_hud_icon(var_8);
    var_3 thread chaos_weapon_collect();
    var_3.headiconforplayer = [];
    level.chaos_entities[level.chaos_entities.size] = var_3;
  }

  level.chaos_weapon_locations = undefined;
}

get_weapon_hud_icon(var_0) {
  var_1 = "";

  if(var_0 == "FG") {
    var_1 = "specops_ui_equipmentstore";
  } else if(var_0 == "SG") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "AR") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "SN") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "Akimbo") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "LMG") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "SMG") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "HG") {
    var_1 = "specops_ui_weaponstore";
  } else if(var_0 == "RPG") {
    var_1 = "specops_ui_weaponstore";
  }
  return var_1;
}

chaos_get_weapon_class(var_0) {
  var_1 = "";

  if(issubstr(var_0, "claymore")) {
    var_1 = "FG";
  } else if(issubstr(var_0, "c4")) {
    var_1 = "FG";
  } else if(issubstr(var_0, "flash")) {
    var_1 = "FG";
  } else if(issubstr(var_0, "1887")) {
    var_1 = "SG";
  } else if(issubstr(var_0, "aa12")) {
    var_1 = "SG";
  } else if(issubstr(var_0, "acr")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "ak47")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "as50")) {
    var_1 = "SN";
  } else if(issubstr(var_0, "cm901")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "fad")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "fmg9")) {
    var_1 = "Akimbo";
  } else if(issubstr(var_0, "g18")) {
    var_1 = "Akimbo";
  } else if(issubstr(var_0, "mg36")) {
    var_1 = "LMG";
  } else if(issubstr(var_0, "g36")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "m16")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "m4")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "m60")) {
    var_1 = "LMG";
  } else if(issubstr(var_0, "m9")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "mk14")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "mk46")) {
    var_1 = "LMG";
  } else if(issubstr(var_0, "mp5")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "mp7")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "mp9")) {
    var_1 = "Akimbo";
  } else if(issubstr(var_0, "pp90")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "p90")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "pecheneg")) {
    var_1 = "LMG";
  } else if(issubstr(var_0, "rsass")) {
    var_1 = "SN";
  } else if(issubstr(var_0, "sa80")) {
    var_1 = "LMG";
  } else if(issubstr(var_0, "scar")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "skorpion")) {
    var_1 = "Akimbo";
  } else if(issubstr(var_0, "striker")) {
    var_1 = "SG";
  } else if(issubstr(var_0, "type95")) {
    var_1 = "AR";
  } else if(issubstr(var_0, "usp45")) {
    var_1 = "HG";
  } else if(issubstr(var_0, "ump45")) {
    var_1 = "SMG";
  } else if(issubstr(var_0, "usas12")) {
    var_1 = "SG";
  } else if(issubstr(var_0, "rpg")) {
    var_1 = "RPG";
  }
  return var_1;
}

get_weapon_display_name(var_0) {
  var_1 = undefined;

  if(issubstr(var_0, "claymore")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_CLAYMORE";
  } else if(issubstr(var_0, "c4")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_C4";
  } else if(issubstr(var_0, "flash")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_FLASH";
  } else if(issubstr(var_0, "1887")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_1887";
  } else if(issubstr(var_0, "aa12")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_AA12";
  } else if(issubstr(var_0, "acr")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_ACR";
  } else if(issubstr(var_0, "ak47")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_AK47";
  } else if(issubstr(var_0, "as50")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_AS50";
  } else if(issubstr(var_0, "cm901")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_CM901";
  } else if(issubstr(var_0, "fad")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_FAD";
  } else if(issubstr(var_0, "fmg9")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_FMG9";
  } else if(issubstr(var_0, "g18")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_G18";
  } else if(issubstr(var_0, "mg36")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MG36";
  } else if(issubstr(var_0, "g36")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_G36";
  } else if(issubstr(var_0, "m16")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_M16";
  } else if(issubstr(var_0, "m4")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_M4";
  } else if(issubstr(var_0, "m60")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_M60";
  } else if(issubstr(var_0, "m9")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_M9";
  } else if(issubstr(var_0, "mk14")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MK14";
  } else if(issubstr(var_0, "mk46")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MK46";
  } else if(issubstr(var_0, "mp5")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MP5";
  } else if(issubstr(var_0, "mp7")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MP7";
  } else if(issubstr(var_0, "mp9")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_MP9";
  } else if(issubstr(var_0, "pp90")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_PP90";
  } else if(issubstr(var_0, "p90")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_P90";
  } else if(issubstr(var_0, "pecheneg")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_PECHENEG";
  } else if(issubstr(var_0, "rsass")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_RSASS";
  } else if(issubstr(var_0, "sa80")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_SA80";
  } else if(issubstr(var_0, "scar")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_SCAR";
  } else if(issubstr(var_0, "skorpion")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_SKORPION";
  } else if(issubstr(var_0, "striker")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_STRIKER";
  } else if(issubstr(var_0, "type95")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_TYPE95";
  } else if(issubstr(var_0, "usp45")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_USP45";
  } else if(issubstr(var_0, "ump45")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_UMP45";
  } else if(issubstr(var_0, "usas12")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_USAS12";
  } else if(issubstr(var_0, "rpg")) {
    var_1 = &"SO_SURVIVAL_CHAOS_PICKUP_RPG";
  }
  return var_1;
}

chaos_entity_rotate() {
  self endon("death");

  for(;;) {
    self rotateyaw(360, 3, 0, 0);
    wait 3.0;
  }
}

chaos_weapon_collect() {
  self endon("death");
  self.trigger endon("death");
  level endon("special_op_terminated");
  self.weapon_in_use = 0;

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(isPlayer(var_0) && !maps\_utility::_id_1A43(var_0)) {
      var_0 maps\_so_survival_chaos::chaoseventpopup(self.display_name, (1, 1, 1));
    }
    if(!isPlayer(var_0) || maps\_utility::_id_1A43(var_0) || !var_0 useButtonPressed()) {
      continue;
    }
    var_1 = 0;
    var_2 = 0;

    if(!var_0 hasweapon(self._id_5C39) && self._id_5C39 != "claymore") {
      var_3 = var_0 getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(isDefined(level._id_1AB1) && var_5 == level._id_1AB1 || weaponclass(var_5) == "item" || weaponclass(var_5) == "none" || weaponinventorytype(var_5) == "altmode") {
          continue;
        }
        var_0 takeweapon(var_5);
      }

      var_0 maps\_so_survival_chaos::chaos_give_weapon(self._id_5C39);
      var_1 = 1;

      if(!isDefined(var_0.weapon_already_used)) {
        var_0.weapon_already_used = [];
      }
      if(!isDefined(var_0.weapon_already_used[self._id_5C39])) {
        maps\_so_survival_chaos::chaos_score_event_raise("new_weapon_collect");
        var_2 = 1;
        var_0.weapon_already_used[self._id_5C39] = 1;
        var_0._id_18D3["new_weapon_collected"]++;
      } else {
        maps\_so_survival_chaos::chaos_score_event_raise("old_weapon_collect");
      }
    } else {
      var_7 = 0;

      if(self._id_5C39 == "claymore" || self._id_5C39 == "c4") {
        if(!var_0 hasweapon(self._id_5C39)) {
          var_0 giveweapon(self._id_5C39);
          var_7 = 1;
        } else {
          var_7 = var_0 getweaponammoclip(self._id_5C39) + 1;
        }
      } else {
        var_7 = weaponclipsize(self._id_5C39);
      }
      if(issubstr(self._id_5C39, "akimbo")) {
        var_0 setweaponammoclip(self._id_5C39, var_7, "left");
        var_0 setweaponammoclip(self._id_5C39, var_7, "right");
      } else {
        var_0 setweaponammoclip(self._id_5C39, var_7);
      }
      var_8 = 0;

      if(var_0 getweaponammostock(self._id_5C39) < weaponmaxammo(self._id_5C39)) {
        var_8 = 1;
      }
      var_9 = weaponaltweaponname(self._id_5C39);

      if(var_9 != "none" && var_0 getweaponammostock(var_9) < weaponmaxammo(var_9)) {
        var_8 = 1;
      }
      if(self._id_5C39 == "flash_grenade" || self._id_5C39 == "claymore" || self._id_5C39 == "c4") {
        var_8 = 1;
        maps\_so_survival_chaos::chaos_score_event_raise("old_weapon_collect");
      }

      if(var_8) {
        if(self._id_5C39 != "claymore" && self._id_5C39 != "c4") {
          var_0 setweaponammostock(self._id_5C39, weaponmaxammo(self._id_5C39));
        }
        var_9 = weaponaltweaponname(self._id_5C39);

        if(var_9 != "none") {
          var_0 setweaponammostock(var_9, weaponmaxammo(var_9));
        }
        maps\_so_survival_chaos::chaos_score_event_raise("weapon_ammo");

        if(self._id_5C39 != "flash_grenade" && self._id_5C39 != "claymore" && self._id_5C39 != "c4") {
          var_0 switchtoweapon(self._id_5C39);
        }
        var_1 = 1;
      }
    }

    if(var_1) {
      common_scripts\utility::array_call(self.weapon_models, ::hide);

      foreach(var_11 in level.players) {
        if(isDefined(self.headiconforplayer[var_11.unique_id])) {
          self.headiconforplayer[var_11.unique_id] destroy();
        }
      }

      self.weapon_in_use = 1;

      if(var_2 == 1) {
        maps\_so_survival_chaos::radio_dialogue_to_player(var_0, "chaos_new_weapon", 1.0);
      }
      wait 25;

      if(self._id_5C39 == "flash_grenade" || self._id_5C39 == "claymore" || self._id_5C39 == "c4") {
        if(self._id_5C39 == "claymore" || self._id_5C39 == "c4") {
          var_13 = weaponclipsize(self._id_5C39) - 5;
        } else {
          var_13 = weaponclipsize(self._id_5C39);
        }
        for(;;) {
          var_14 = 0;

          foreach(var_11 in level.players) {
            if(var_11 getammocount(self._id_5C39) < var_13) {
              var_14 = 1;
            }
          }

          if(var_14 == 0) {
            wait 0.5;
            continue;
          }

          break;
        }
      } else {
        for(;;) {
          var_17 = 0;

          foreach(var_11 in level.players) {
            if(var_11 hasweapon(self._id_5C39)) {
              var_17 = 1;
            }
          }

          if(var_17 == 1) {
            wait 0.5;
            continue;
          }

          break;
        }
      }

      common_scripts\utility::array_call(self.weapon_models, ::show);
      self.weapon_in_use = 0;
    }
  }
}

chaos_load_drop_location() {
  if(!isDefined(level.chaos_drop_location_table)) {
    level.chaos_drop_location_table = "sp/survival_chaos_drop_locations.csv";
  }
  var_0 = getDvar("mapname");

  for(var_1 = 100; var_1 <= 1700; var_1++) {
    var_2 = get_level(var_1);

    if(!isDefined(var_2) || var_2 == "" || var_2 != var_0) {
      continue;
    }
    var_3 = get_level_drop_location(var_1);

    if(!isDefined(var_3) || var_3 == "") {
      continue;
    }
    var_4 = strtok(var_3, ",");

    if(!isDefined(var_4) || var_4.size != 3) {
      continue;
    }
    if(!isDefined(level.chaos_drop_locations)) {
      level.chaos_drop_locations = [];
    }
    level.chaos_drop_locations[level.chaos_drop_locations.size] = (float(var_4[0]), float(var_4[1]), float(var_4[2]));
  }
}

chaos_load_drop_item() {
  if(!isDefined(level.chaos_drop_item_table)) {
    level.chaos_drop_item_table = "sp/survival_chaos_drop_items.csv";
  }
  var_0 = getDvar("mapname");

  for(var_1 = 100; var_1 <= 1700; var_1++) {
    var_2 = get_level(var_1);

    if(!isDefined(var_2) || var_2 == "" || var_2 != var_0) {
      continue;
    }
    var_3 = get_level_drop_wave(var_1);
    var_4 = "wave_" + var_3;
    var_5 = get_level_drop_item(var_1);

    if(!isDefined(var_5) || var_5 == "") {
      continue;
    }
    var_6 = strtok(var_5, ";");

    if(!isDefined(level.chaos_drop_items)) {
      level.chaos_drop_items = [];
    }
    level.chaos_drop_items[var_4] = var_6;
  }
}

chaos_load_desired_drop_distance() {
  if(!isDefined(level.desired_drop_distance_table)) {
    level.desired_drop_distance_table = "sp/survival_chaos_drop_distance.csv";
  }
  var_0 = getDvar("mapname");

  for(var_1 = 100; var_1 <= 1700; var_1++) {
    var_2 = get_drop_distance_level(var_1);

    if(isDefined(var_2) && var_2 == var_0) {
      var_3 = get_level_desired_drop_distance(var_1);
      level.map_specific_desired_drop_distance = float(var_3);
      var_4 = get_level_starting_lives_remaining(var_1);

      if(chaos_is_coop()) {
        level.map_specific_starting_lives_remaining = 3;
      } else {
        level.map_specific_starting_lives_remaining = float(var_4);
      }
    }
  }
}

chaos_is_coop() {
  if(issplitscreen() || getDvar("coop") == "1") {
    return 1;
  }
  return 0;
}

chaos_load_ai_size() {
  if(!isDefined(level.constant_ai_size_table)) {
    level.constant_ai_size_table = "sp/survival_chaos_constant_ai_size.csv";
  }
  var_0 = getDvar("mapname");

  for(var_1 = 100; var_1 <= 1700; var_1++) {
    var_2 = get_ai_size_level(var_1);

    if(isDefined(var_2) && var_2 == var_0) {
      var_3 = get_level_ai_size_wave(var_1);
      var_4 = get_level_ai_size(var_1);

      if(!isDefined(level.map_specific_ai_size)) {
        level.map_specific_ai_size = [];
      }
      var_5 = "wave_" + var_3;
      level.map_specific_ai_size[var_5] = float(var_4);
    }
  }
}