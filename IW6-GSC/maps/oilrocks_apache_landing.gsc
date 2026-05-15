/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_landing.gsc
********************************************/

catchup_function() {
  var_0 = ["landing_zpus"];

  foreach(var_2 in var_0) {
    maps\_utility::array_delete(getEntArray(var_2, "targetname"));
  }

  maps\oilrocks_apache_code::spawn_apache_allies("apache_landing_ally_0");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("apache_landing_blackhawk_ally", undefined, undefined, 0);
  common_scripts\utility::flag_set("FLAG_apache_factory_finished");
}

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  maps\oilrocks_apache_code::spawn_apache_allies("apache_landing_ally_0");
  var_0 = maps\oilrocks_code::spawn_apache_player("apache_landing");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("apache_landing_blackhawk_ally", undefined, undefined, 1);
  var_0 maps\_chopperboss_utility::chopper_boss_locs_monitor_disable_turn_off();
}

main() {
  maps\oilrocks_apache_code::send_apaches_to_hangout("hangout_volume_landingzone");
  thread maps\_utility::smart_radio_dialogue("oilrocks_hp5_youllneedtoengage");
  thread blackhawk_idle_next_to_factory();
  var_0 = objective_player_clears_landing();
  thread maps\_utility::autosave_by_name();
  thread maps\oilrocks_apache_code::objective_protect_start();
  var_1 = getent("apache_landing_gate", "targetname");
  var_2 = var_1.origin;
  blackhawk_landing(var_0, var_1, var_2);
  var_1 moveto(var_2, 2, 0.25, 0.25);
  maps\oilrocks_apache_code::objective_protect_complete();
}

blackhawk_idle_next_to_factory() {
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();

  if(var_0 maps\_utility::ent_flag_exist("blackhawk_reached_end") && var_0 maps\_utility::ent_flag("blackhawk_reached_end")) {
    var_1 = common_scripts\utility::getstruct("apache_landing_blackhawk_ally", "targetname");
    var_0 thread maps\_vehicle::vehicle_paths(var_1);
  }
}

_precache() {
  precachemodel("vehicle_gaz_tigr_base_destroyed_oilrocks");
  common_scripts\utility::flag_init("landing_finished");
}

objective_player_clears_landing() {
  var_0 = maps\_utility::obj("apache_landing_killingeverythings");
  objective_add(var_0, "active", &"OILROCKS_OBJ_CLEAR_THE_LANDING");
  objective_current(var_0);
  objective_position(var_0, common_scripts\utility::getstruct("objective_pos_kill_everything", "targetname").origin);
  var_1 = maps\_utility::array_spawn_targetname("landing_spawn_wave1", undefined, 1, 1);
  maps\oilrocks_apache_code::spawn_vehicles_from_targetname_prunespawning("landing_zpus");
  var_2 = get_landing_zpus();

  if(var_2.size) {
    maps\_utility::waittill_dead(var_2);
  }

  var_1 = maps\_utility::array_removedead_or_dying(var_1);

  if(var_1.size) {
    maps\_utility::waittill_dead(var_1, 6);
  }

  return var_0;
}

get_landing_zpus() {
  var_0 = [];
  var_1 = common_scripts\utility::getstruct("infantry_player_start", "targetname");
  var_2 = squared(1700);
  var_3 = vehicle_getarray();

  foreach(var_5 in var_3) {
    if(distancesquared(var_5.origin, var_1.origin) < var_2) {
      if(isalive(var_5) && var_5.classname == "script_vehicle_zpu4_oilrocks") {
        var_0[var_0.size] = var_5;
      }
    }
  }

  return var_0;
}

blackhawk_landing(var_0, var_1, var_2) {
  var_3 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_3 notify("stop_kicking_up_dust");
  var_3 thread maps\_vehicle_code::aircraft_wash_thread();
  var_4 = getent("trigger_landing_zone", "targetname");
  var_3 settargetyaw(var_4.angles[1]);
  var_5 = maps\_utility::groundpos(maps\_utility::add_z(var_4.origin, 200));
  var_5 = maps\_utility::add_z(var_5, 300);
  var_6 = spawnStruct();
  var_6.origin = var_5;
  var_7 = distance(var_3 gettagorigin("tag_origin"), var_3 gettagorigin("tag_ground"));
  var_6.origin = maps\_utility::add_z(var_6.origin, var_7);
  var_6.angles = var_4.angles;

  if(var_3 maps\_utility::ent_flag_exist("blackhawk_reached_end")) {
    var_3 maps\_utility::ent_flag_wait("blackhawk_reached_end");
  }

  var_8 = (var_6.origin + var_3.origin) * 0.5;
  var_3 setvehgoalpos(var_8, 1);
  var_3 vehicle_setspeed(70, 33, 33);
  wait 2;
  var_1 moveto(maps\_utility::add_z(var_2, 160), 2, 0.25, 0.25);
  spawn_gaz(var_0);
  var_3 setvehgoalpos(var_5, 1);
  var_3 vehicle_setspeed(70, 33, 33);
  var_3 sethoverparams(0, 0, 55);
  var_3 waittill("goal");
  var_3 thread blackhawk_unloads_and_takes_off(var_6);
  kill_enemies_touching_trigger(getent("landing_kill_enemies", "targetname"));
  thread maps\_utility::autosave_by_name();
  maps\_utility::smart_radio_dialogue_interrupt("oilrocks_hp2_thanksforthehelp");
  wait 0.5;
  maps\oilrocks_code::camlanding_from_apache("camlanding");
  level.player clearclienttriggeraudiozone(0.8);
  level.heroguy delete();
  level.heroguy = undefined;
  level.infantry_guys = maps\oilrocks_code::array_remove_undefined_dead_or_dying(level.infantry_guys);
}

spawn_gaz(var_0) {
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("apache_landing_gaz");
  common_scripts\utility::array_thread(var_1, ::landing_gaz_stuff);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(var_4.riders.size) {
      var_2 = common_scripts\utility::array_combine(var_2, var_4.riders);
    }
  }

  maps\_utility::waittill_dead(var_2);
  maps\_utility::objective_complete(var_0);
}

landing_gaz_stuff() {
  maps\_vehicle::godon();
  self.custom_death_script = ::gaz_custom_death;
  self waittill("reached_end_node");
  maps\_vehicle::godoff();
}

gaz_custom_death() {
  self.skipanimbaseddeath = 1;
  self.skipmodelswapdeath = 1;
  playFXOnTag(loadfx("fx/explosions/helicopter_explosion_hind_oilrocks_primary"), self, "tag_body");
  wait 0.4;
  self setModel("vehicle_gaz_tigr_base_destroyed_oilrocks");
  self disconnectpaths();
}

blackhawk_unloads_and_takes_off(var_0) {
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  var_0 vehicle_scripts\silenthawk_landing::silenthawk_lands_and_unloads(self);
  var_1 = common_scripts\utility::getstruct("blackhawk_exist_landing", "targetname");
  self waittill("unloaded");
  maps\oilrocks_code::assign_friendly_heros();
  maps\_vehicle::vehicle_paths(var_1);
}

kill_enemies_touching_trigger(var_0) {
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 istouching(var_0)) {
      var_3 kill();
    }
  }
}