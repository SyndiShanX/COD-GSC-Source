/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_progression.gsc
****************************************************/

func_00D5() {
  setdvarifuninitialized("spv_zm_difficulty_enabled", 1);
  setdvarifuninitialized("spv_zm_shotgun_difficulty", 1);
  setdvarifuninitialized("spv_zm_shotgun_health_mod", 1);
  setdvarifuninitialized("spv_shattered_srv_unlock_easy", 0);
  setdvarifuninitialized("spv_zm_shotgun_xp_mod", 1);
  setdvarifuninitialized("zm_shotgun_show_level", 0);
  setdvarifuninitialized("zm_shotgun_show_xp", 0);
  setdvarifuninitialized("zm_shotgun_cheat_level", -1);
  setdvarifuninitialized("zm_enable_lan_xp", 0);
  setDvar("spv_zm_difficulty_enabled", 1);
  setDvar("spv_zm_shotgun_difficulty", 1);
  if(getdvarint("spv_zm_difficulty_enabled", 0) == 0) {
    return;
  }

  level.zm_shotgun_difficulty = getdvarint("spv_zm_shotgun_difficulty", 0);
  level thread debug_show_shotgun_player_levels();
  level thread debug_show_shotgun_player_xp();
}

get_zm_shotgun_player_level() {
  var_00 = getdvarint("zm_shotgun_cheat_level", -1);
  if(var_00 >= 0) {
    if(isDefined(level.zmshotgunmaxlevel)) {
      if(var_00 > level.zmshotgunmaxlevel) {
        var_00 = level.zmshotgunmaxlevel;
      }
    }

    return var_00;
  }

  if(isDefined(self.var_AB46)) {
    if(isDefined(self.var_AB46["shotgunLevel"])) {
      return self.var_AB46["shotgunLevel"];
    }
  }

  return -1;
}

get_zm_shotgun_player_xp() {
  if(isDefined(self.var_AB46)) {
    if(isDefined(self.var_AB46["shotgunXP"])) {
      return self.var_AB46["shotgunXP"];
    }
  }

  return -1;
}

zombie_shotgun_mode_bonus_damage(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    return 0;
  }

  if(!isDefined(param_02)) {
    return param_01;
  }

  if(!isDefined(param_00)) {
    return param_01;
  }

  var_03 = param_00 get_zm_shotgun_ranktable_value(20);
  var_03 = var_03 / 100 + 1;
  param_01 = param_01 * var_03;
  return param_01;
}

get_zm_shotgun_ranktable_value(param_00) {
  var_01 = get_zm_shotgun_player_level();
  if(var_01 >= 0) {
    if(isDefined(level.zmshotgunranktable)) {
      if(isDefined(level.zmshotgunranktable[var_01])) {
        if(isDefined(level.zmshotgunranktable[var_01][param_00])) {
          return level.zmshotgunranktable[var_01][param_00];
        }
      }
    }
  }

  return 0;
}

apply_zm_shotgun_level_perks() {
  self.zm_pistol_damage_mod = get_zm_shotgun_ranktable_value(21);
  self.zm_sniper_damage_mod = get_zm_shotgun_ranktable_value(22);
  self.zm_shotgun_damage_mod = get_zm_shotgun_ranktable_value(23);
  self.zm_smg_damage_mod = get_zm_shotgun_ranktable_value(24);
  self.zm_ar_damage_mod = get_zm_shotgun_ranktable_value(25);
  self.zm_lmg_damage_mod = get_zm_shotgun_ranktable_value(26);
}

debug_show_shotgun_player_levels() {
  level endon("game_ended");
  for(;;) {
    if(getdvarint("zm_shotgun_show_level", 0)) {
      foreach(var_01 in level.var_744A) {
        var_02 = var_01 get_zm_shotgun_player_level();
      }
    }

    wait(5);
  }
}

debug_show_shotgun_player_xp() {
  level endon("game_ended");
  for(;;) {
    if(getdvarint("zm_shotgun_show_xp", 0)) {
      foreach(var_01 in level.var_744A) {
        var_02 = var_01 get_zm_shotgun_player_xp();
      }
    }

    wait(5);
  }
}