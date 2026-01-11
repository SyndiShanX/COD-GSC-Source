/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_crash_site.gsc
***************************************/

crash_site_init() {
  level.start_point = "crash_site";
  maps\satfarm_code::kill_spawners_per_checkpoint("crash_site");
}

crash_site_main() {
  if(!isDefined(level.playertank)) {
    maps\satfarm_code::spawn_player_checkpoint("crash_site_");
    maps\satfarm_code::spawn_heroes_checkpoint("crash_site_");
    common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  }

  level.herotanks[0] thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", "crash_site_end", 200, 15, 2);
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", "crash_site_end", 250, 13.5, 1.5);
  thread crash_site_begin();
  common_scripts\utility::flag_wait("crash_site_end");
  maps\_spawner::killspawner(20);
  maps\satfarm_code::kill_vehicle_spawners_now(20);
  crash_site_cleanup();
}

crash_site_begin() {
  thread intro_and_crash_site_ally_setup();
  thread crash_site_mig29_destroys_ally_tanks();
  thread crash_site_a10_overhead();
  thread crash_site_vo();
  thread a10_and_mig_scene();
  thread setup_solar_panel_player_sound_triggers();
  thread maps\satfarm_base_array::base_array_ambient_dogfight_1();
  thread maps\satfarm_base_array::base_array_ambient_dogfight_2();
  thread maps\satfarm_base_array::base_array_ambient_dogfight_3();
  objective_add(maps\_utility::obj("rendesvouz"), "current", &"SATFARM_OBJ_RENDESVOUZ", level.herotanks[1].origin);
  objective_onentity(maps\_utility::obj("rendesvouz"), level.herotanks[1], (0, 0, 60));
  objective_setpointertextoverride(maps\_utility::obj("rendesvouz"), &"SATFARM_FOLLOW");
  thread maps\satfarm_m880::setup_ambient_missile_launches("ambient_missile_launch_spot", "base_array_end");
  thread maps\satfarm_code::follow_icon_manager();
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("crash_site_background_c17");
  setsaveddvar("compass", 1);
  maps\_utility::autosave_by_name("crash_site");
}

intro_and_crash_site_ally_setup() {
  if(!isDefined(level.intro_and_crash_site_ally_tanks)) {
    if(level.start_point == "intro") {
      level.intro_and_crash_site_ally_tanks = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("intro_allies");
    } else if(level.start_point == "crash_site") {
      level.intro_and_crash_site_ally_tanks = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("crash_site_allies");
    }

    level.allytanks = common_scripts\utility::array_combine(level.allytanks, level.intro_and_crash_site_ally_tanks);
    common_scripts\utility::array_thread(level.intro_and_crash_site_ally_tanks, maps\satfarm_code::npc_tank_combat_init);

    foreach(var_1 in level.intro_and_crash_site_ally_tanks) {
      if(isDefined(var_1.script_noteworthy) && (var_1.script_noteworthy == "intro_ally0" || var_1.script_noteworthy == "crash_site_ally0")) {
        var_1 thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", undefined, 800, 15, 5);
        var_1 thread maps\satfarm_code::delayed_kill(randomfloatrange(0.1, 2.0), "sat_array_enemies_retreat_01");
        continue;
      }

      if(isDefined(var_1.script_noteworthy) && (var_1.script_noteworthy == "intro_ally1" || var_1.script_noteworthy == "crash_site_ally1")) {
        var_1 thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", undefined, 1800, 25, 6);
        var_1 thread maps\satfarm_code::delayed_kill(randomfloatrange(0.1, 2.0), "sat_array_enemies_retreat_01");
        continue;
      }

      if(isDefined(var_1.script_noteworthy) && (var_1.script_noteworthy == "intro_ally2" || var_1.script_noteworthy == "crash_site_ally2")) {
        var_1 thread maps\satfarm_code::tank_relative_speed("base_array_relative_speed", undefined, 1600, 20, 4);
        var_1 thread maps\satfarm_code::delayed_kill(randomfloatrange(0.1, 1.5), "base_array_ridge_reached");
      }
    }
  } else if(level.start_point == "intro") {
    thread maps\satfarm_code::switch_node_on_flag(level.intro_and_crash_site_ally_tanks[0], "", "switch_crash_site_path_ally0", "crash_site_path_ally0");
    thread maps\satfarm_code::switch_node_on_flag(level.intro_and_crash_site_ally_tanks[1], "", "switch_crash_site_path_ally1", "crash_site_path_ally1");
    thread maps\satfarm_code::switch_node_on_flag(level.intro_and_crash_site_ally_tanks[2], "", "switch_crash_site_path_ally2", "crash_site_path_ally2");
  }
}

a10_and_mig_scene() {
  common_scripts\utility::flag_wait("spawn_crash_site_background_enemies");
  level.crash_site_background_enemies = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("crash_site_background_enemies");

  foreach(var_1 in level.crash_site_background_enemies) {
    var_1 thread maps\satfarm_code::npc_tank_combat_init(undefined, 1);
  }

  level.crash_site_a10_missile_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_a10_missile_dive_1");
  wait 1.75;
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_mig29_gun_dive_2");
  var_3 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();
}

crash_site_mig29_destroys_ally_tanks() {
  common_scripts\utility::flag_wait("start_crash_site_mig29_gun_dive_1");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_mig29_gun_dive_1");
}

crash_site_a10_overhead() {
  level.crash_site_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_a10_gun_dive_1");
  wait 0.5;
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("crash_site_mig29_gun_dive_3");
  var_0 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();
}

crash_site_vo() {
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_wemissedthedrop");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_bravoteamispinned");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_weareunderheavy");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_holdtightbravobadger");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_copyoverlord");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_weneedtopush");
}

crash_site_cleanup() {
  var_0 = getEntArray("crash_site_ent", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

setup_solar_panel_player_sound_triggers() {
  var_0 = common_scripts\utility::getstructarray("solar_panel_player_sound_trigger_org", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3 thread solar_panel_player_sound_trigger_wait();
    var_1++;

    if(var_1 > 10) {
      wait 0.05;
      var_1 = 0;
    }
  }
}

solar_panel_player_sound_trigger_wait() {
  level endon("crash_site_end");
  var_0 = spawn("trigger_radius", self.origin, 80, 100, 128);
  var_0 thread maps\satfarm_code::flag_wait_delete("crash_site_end");
  var_0 waittill("trigger", var_1);

  if(isDefined(var_1) && (var_1 == level.playertank || var_1 == level.player)) {
    thread common_scripts\utility::play_sound_in_space("satf_debris_crush_plr", level.player.origin);
  }

  var_0 delete();
}