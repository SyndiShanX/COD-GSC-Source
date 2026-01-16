/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_achievements.gsc
********************************/

achievements_init() {
  level thread master_ninja_init();
  level thread retro_shooter_init();
  level thread weapon_master_init();
  level thread i_hate_dogs_init();
}

master_ninja_init() {
  common_scripts\utility::flag_init("master_ninja_melee_kill");
  common_scripts\utility::flag_init("master_ninja_illegal_kill");
  maps\_utility::add_global_spawn_function("axis", ::master_ninja_enemy_spawned);
  common_scripts\utility::array_thread(getaiarray("axis"), ::master_ninja_enemy_spawned);
  level thread master_ninja_mission_complete();
}

master_ninja_mission_complete() {
  level endon("master_ninja_illegal_kill");
  level waittill("achievements_level_complete");

  if(common_scripts\utility::flag("master_ninja_melee_kill") && !common_scripts\utility::flag("master_ninja_illegal_kill"))
    maps\_utility::giveachievement_wrapper("MASTER_NINJA");
}

master_ninja_enemy_spawned() {
  level endon("master_ninja_illegal_kill");
  self waittill("death", var_0, var_1);

  if(isdefined(var_0) && var_0 == level.player) {
    if(var_1 == "MOD_MELEE")
      common_scripts\utility::flag_set("master_ninja_melee_kill");
    else
      common_scripts\utility::flag_set("master_ninja_illegal_kill");
  }
}

retro_shooter_init() {
  switch (level.script) {
    case "simplecredits":
    case "coup":
    case "aftermath":
    case "ac130":
      return;
    default:
      break;
  }

  level endon("retro_shooter_player_reloaded");
  level thread retro_shooter_mission_complete();

  for (;;) {
    level.player waittill("reload");
    level notify("retro_shooter_player_reloaded");
  }
}

retro_shooter_mission_complete() {
  level endon("retro_shooter_player_reloaded");
  level waittill("achievements_level_complete");
  maps\_utility::giveachievement_wrapper("RETRO_SHOOTER");
}

weapon_master_init() {
  var_0 = get_base_weapon_list();
  maps\_utility::add_global_spawn_function("axis", ::weapon_master_enemy_spawned);
  common_scripts\utility::array_thread(getaiarray("axis"), ::weapon_master_enemy_spawned);
  var_1 = maps\_vehicle_code::_getvehiclespawnerarray();
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::weapon_master_vehicle_spawned);
  common_scripts\utility::array_thread(vehicle_getarray(), ::weapon_master_vehicle_spawned);
  thread weapon_master_barrett();
}

weapon_master_barrett() {
  if(level.script == "sniperescape") {
    common_scripts\utility::waittill_any("weapon_master_barrett_kill", "makarov_killed");
    weapon_master_register_kill("barrett");
  }
}

get_base_weapon_list() {
  var_0 = ["ak47", "ak74u", "barrett", "beretta", "c4", "claymore", "colt45", "deserteagle", "dragunov", "frag", "g36c", "g3", "javelin", "m1014", "m14", "m16", "m4", "m60e4", "mp5", "p90", "remington700", "rpd", "rpg", "saw", "skorpion", "stinger", "usp", "uzi", "winchester1200"];
  return var_0;
}

parse_weapon_name(var_0) {
  var_1 = tolower(var_0);
  var_2 = get_base_weapon_list();

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(issubstr(var_1, var_2[var_3]))
      return var_2[var_3];
  }

  return var_1;
}

weapon_master_enemy_spawned() {
  self waittill("death", var_0, var_1, var_2);

  if(isdefined(var_0) && var_0 == level.player && isdefined(var_2) && var_1 != "MOD_MELEE")
    weapon_master_register_kill(var_2);
}

weapon_master_vehicle_damaged() {
  level.weapon_master_explosive = "unknown";
  level.weapon_master_timestamp = 0;
  level.weapon_master_vehicle_id = "unknown";

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    var_7 = "unknown";
    var_4 = tolower(var_4);

    if(var_4 == "mod_explosive" || var_4 == "mod_explosive_splash") {
      if(var_0 != 100)
        var_7 = "c4";
    } else if(var_4 == "mod_projectile" || var_4 == "mod_projectile_splash") {
      if(var_0 >= 900)
        var_7 = "javelin";
      else if(var_0 >= 300) {
        if(var_1 == level.player)
          var_7 = "rpg";
      }
    }

    if(var_7 != "unknown") {
      level.weapon_master_explosive = var_7;
      level.weapon_master_timestamp = gettime();
      level.weapon_master_vehicle_id = self;
    }
  }
}

weapon_master_vehicle_spawned() {
  var_0 = self;
  thread weapon_master_vehicle_damaged();
  self waittill("death", var_1, var_2, var_3);

  if(isdefined(var_1) && var_1 == level.player && isdefined(var_3) && var_2 != "MOD_MELEE")
    weapon_master_register_kill(var_3);
  else {
    wait 0.25;

    if(level.weapon_master_explosive == "unknown" || level.weapon_master_vehicle_id != var_0) {
      return;
    }
    if(abs(gettime() - level.weapon_master_timestamp) <= 1000)
      weapon_master_register_kill(level.weapon_master_explosive);
  }
}

weapon_master_register_kill(var_0) {
  var_0 = parse_weapon_name(var_0);
  var_1 = common_scripts\utility::array_find(get_base_weapon_list(), var_0);

  if(!isdefined(var_1)) {
    return;
  }
  if(common_scripts\utility::flag("has_cheated") || maps\_cheat::is_cheating()) {
    return;
  }
  if(level.player getlocalplayerprofiledata("sp_weaponMaster", var_1) != "1") {
    level.player setlocalplayerprofiledata("sp_weaponMaster", var_1, 1);
    updategamerprofileall();
    weapon_master_check_success();
  }
}

weapon_master_check_success() {
  var_0 = get_base_weapon_list();
  var_1 = [];
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = level.player getlocalplayerprofiledata("sp_weaponMaster", var_3);
    var_1[var_0[var_3]] = var_4;

    if(var_4 == "1")
      var_2++;
  }

  if(var_2 == var_0.size || platform_tracks_progression())
    maps\_utility::giveachievement_wrapper("WEAPON_MASTER");
}

i_hate_dogs_init() {
  maps\_utility::add_global_spawn_function("axis", ::i_hate_dogs_enemy_spawned);
  common_scripts\utility::array_thread(getaiarray("axis"), ::i_hate_dogs_enemy_spawned);
}

i_hate_dogs_enemy_spawned() {
  if(!isdefined(self.classname)) {
    return;
  }
  if(self.classname != "actor_enemy_dog") {
    return;
  }
  self waittill("death", var_0, var_1);

  if(isdefined(var_0) && var_0 == level.player && var_1 == "MOD_MELEE") {
    if(common_scripts\utility::flag("has_cheated") || maps\_cheat::is_cheating()) {
      return;
    }
    var_2 = level.player getlocalplayerprofiledata("sp_iHateDogs");
    var_3 = 20;

    if(var_2 < var_3) {
      var_2++;
      level.player setlocalplayerprofiledata("sp_iHateDogs", var_2);
      updategamerprofileall();

      if(var_2 >= var_3 || platform_tracks_progression())
        maps\_utility::giveachievement_wrapper("DOGS_I_HATE_DOGS");
    }
  }
}

platform_tracks_progression() {
  return level.xb3 || level.pc;
}