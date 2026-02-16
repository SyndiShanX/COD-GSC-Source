/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_factory.gsc
********************************************/

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  var_0 = maps\oilrocks_code::spawn_apache_player("apache_factory");
  var_1 = maps\oilrocks_apache_code::spawn_blackhawk_ally("struct_blackhawk_ally_factory");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_attack_0");
  var_1 thread maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("path_blackhawk_ally_factory", "script_noteworthy"));
  var_2 = [1, 2];

  foreach(var_4 in var_2) {
    var_5 = maps\oilrocks_apache_code::get_apache_ally(var_4);
    var_5 thread maps\oilrocks_code::chopper_boss_path_override(common_scripts\utility::getstruct("path_apache_ally_attack_0" + var_4, "script_noteworthy"));
  }
}

catchup_function() {
  common_scripts\utility::flag_set("FLAG_apache_factory_finished");
}

main() {
  thread maps\oilrocks_apache_vo::apache_mission_vo_think(maps\oilrocks_apache_vo::apache_mission_vo_factory);
  thread maps\oilrocks_apache_hints::apache_hints_factory();
  thread maps\_utility::autosave_by_name();
  thread apache_factory_player_pitch();
  thread apache_factory_enemies();
  thread apache_factory_allies_apache_think();
  thread apache_factory_ally_blackhawk_think();
  thread apache_factory_objective();
  common_scripts\utility::flag_wait("FLAG_apache_factory_finished");
}

apache_factory_objective() {
  objective_add(maps\_utility::obj("apache_factory"), "active", &"OILROCKS_OBJ_APACHE_ATTACK");
  objective_current(maps\_utility::obj("apache_factory"));
  var_0 = maps\oilrocks_code::get_obj_ent_hvt();
}

apache_factory_player_pitch() {
  var_0 = maps\oilrocks_apache_code::get_apache_player();
  var_0 endon("death");
  common_scripts\utility::flag_wait("FLAG_apache_factory_exit_canyon");
  thread maps\_utility::lerp_saveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_ground, 2.0);
  common_scripts\utility::flag_wait("FLAG_apache_factory_hint_mg");
  thread maps\_utility::lerp_saveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_mid, 4.0);
  common_scripts\utility::flag_wait("FLAG_apache_factory_player_close");
  thread maps\_utility::lerp_saveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_ground, 4.0);
}

apache_factory_enemies() {
  maps\_utility::array_spawn_function_targetname("apache_factory_gaz_road", maps\oilrocks_apache_code::vehicle_ai_turret_think);
  maps\_utility::array_spawn_function_targetname("apache_factory_hind", ::apache_factory_hind_parked_on_spawn);
  maps\_utility::array_spawn_function_targetname("apache_factory_hind", ::apache_factory_hind_parked_on_death);
  maps\_utility::array_spawn_function_targetname("apache_factory_hind", maps\oilrocks_apache_code::earthquake_on_death);
  maps\_utility::array_spawn_function_targetname("apache_factory_ai_roof", maps\oilrocks_apache_code::ai_record_spawn_pos);
  maps\_utility::array_spawn_function_targetname("apache_factory_ai_roof", ::apache_factory_ai_roof_on_spawn);
  maps\_utility::array_spawn_function_targetname("apache_factory_zpu", ::apache_factory_enemy_on_death);
  maps\_utility::array_spawn_function_targetname("apache_factory_hind", ::apache_factory_enemy_on_death);
  maps\_utility::array_spawn_function_targetname("apache_factory_ai_roof", ::apache_factory_enemy_on_death);
  var_0 = 0.05;
  var_1 = [];
  var_2 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("apache_factory_gaz_road");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("apache_factory_m800_road");
  var_1 = common_scripts\utility::array_combine(var_1, var_3);
  wait(var_0);
  var_4 = maps\_vehicle::spawn_vehicles_from_targetname("apache_factory_zpu_road");
  var_1 = common_scripts\utility::array_combine(var_1, var_4);
  wait(var_0);
  var_5 = maps\_vehicle::spawn_vehicles_from_targetname("apache_factory_zpu");
  var_1 = common_scripts\utility::array_combine(var_1, var_5);
  wait(var_0);
  var_6 = maps\_vehicle::spawn_vehicles_from_targetname("apache_factory_hind");
  var_1 = common_scripts\utility::array_combine(var_1, var_6);
  var_7 = common_scripts\utility::array_combine(var_2, var_4);
  var_8 = common_scripts\utility::array_combine(var_6, var_5);
  common_scripts\utility::flag_wait("FLAG_apache_factory_player_close");
  var_9 = maps\_utility::array_spawn_targetname("apache_factory_ai_roof", 0, 1);
  maps\_utility::waittill_dead_or_dying(var_9);
  common_scripts\utility::flag_wait("FLAG_apache_factory_destroyed_vehicles");
  common_scripts\utility::flag_set("FLAG_apache_factory_destroyed");
  var_9 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_9);
  var_8 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_8);
  var_7 = maps\oilrocks_code::array_remove_undefined_dead_or_dying(var_7);
  common_scripts\utility::array_thread(var_9, maps\oilrocks_apache_code::ai_clean_up, 1, 0);
  common_scripts\utility::array_thread(var_8, maps\oilrocks_apache_code::ai_clean_up, 0, 0);
  common_scripts\utility::array_thread(var_7, maps\oilrocks_apache_code::ai_clean_up, 0, 0);
  level.apache_factory_enemy_counts = undefined;
}

apache_factory_hind_parked_on_spawn() {
  self.alwaysrocketdeath = 1;
  self.enablerocketdeath = 1;
  var_0 = isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "apache_factory_hind_take_off");

  if(var_0) {
    maps\_vehicle::godon();
    common_scripts\utility::flag_wait("FLAG_apache_factory_allies_close");

    if(isDefined(self.script_parameters))
      wait(float(self.script_parameters));

    self.alwaysrocketdeath = undefined;
    self.enablerocketdeath = undefined;
    self.one_missile_kill = 1;
    thread maps\_vehicle::gopath(self);
    maps\_vehicle::godoff();
    thread maps\oilrocks_apache_code::self_make_chopper_boss();
    self waittill("death");
    common_scripts\utility::flag_set("FLAG_apache_factory_hind_take_off_dead");
  }
}

apache_factory_hind_parked_on_death() {
  self waittill("death");

  if(!isDefined(self.alwaysrocketdeath) || !self.alwaysrocketdeath || !isDefined(self.enablerocketdeath) || !self.enablerocketdeath) {
    var_0 = maps\_vehicle_code::get_unused_crash_locations();
    var_0 = sortbydistance(var_0, self.origin);
    var_1 = distancesquared(level.player.origin, self.origin);

    foreach(var_3 in var_0) {
      var_4 = distancesquared(level.player.origin, var_3.origin);

      if(var_4 > var_1 && distancesquared(self.origin, var_3.origin) < var_4) {
        self.perferred_crash_location = var_3;
        break;
      }
    }
  }
}

apache_factory_ai_roof_on_spawn() {
  self endon("death");
  self.a.disablelongdeath = 1;
  self waittill("goal");
  maps\_utility::set_fixednode_true();
  thread maps\oilrocks_apache_code::enemy_infantry_rpg_only();
  self setengagementmaxdist(4096, 5200);
}

apache_factory_enemy_on_death() {
  if(!isDefined(level.apache_factory_enemy_counts))
    level.apache_factory_enemy_counts = [];

  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  if(isai(self)) {
    var_0 = "ai";
    var_1 = "FLAG_apache_factory_destroyed_ai";
    var_2 = 2;
  } else {
    var_0 = "vehicles";
    var_1 = "FLAG_apache_factory_destroyed_vehicles";
    var_2 = 1;
  }

  if(!isDefined(level.apache_factory_enemy_counts[var_0]))
    level.apache_factory_enemy_counts[var_0] = 0;

  level.apache_factory_enemy_counts[var_0]++;
  self waittill("death");

  if(!isDefined(level.apache_factory_enemy_counts) || !isDefined(level.apache_factory_enemy_counts[var_0])) {
    return;
  }
  level.apache_factory_enemy_counts[var_0]--;

  if(level.apache_factory_enemy_counts[var_0] == var_2) {
    common_scripts\utility::flag_set(var_1);
    level.apache_factory_enemy_counts[var_0] = undefined;
  }
}

apache_factory_allies_apache_think() {
  common_scripts\utility::flag_wait("FLAG_apache_factory_destroyed");
  var_0 = [1, 2];

  foreach(var_2 in var_0) {
    var_3 = maps\oilrocks_apache_code::get_apache_ally(var_2);
    var_4 = common_scripts\utility::getStructArray("apache_factory_ally_guard_path_starts_0" + var_2, "script_noteworthy");
    var_5 = common_scripts\utility::getclosest(var_3.origin, var_4);
    var_3 thread maps\_vehicle::vehicle_paths(var_5);
  }
}

apache_factory_ally_blackhawk_think() {
  common_scripts\utility::flag_wait("FLAG_apache_factory_destroyed");
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_0 thread maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("path_blackhawk_factory_drop_off", "script_noteworthy"));
}