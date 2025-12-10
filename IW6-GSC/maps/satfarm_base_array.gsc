/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_base_array.gsc
***************************************/

base_array_init() {
  level.start_point = "base_array";
  objective_add(maps\_utility::obj("rendesvouz"), "current", &"SATFARM_OBJ_RENDESVOUZ");
  thread maps\satfarm_code::follow_icon_manager();
  thread base_array_ambient_dogfight_1();
  thread base_array_ambient_dogfight_2();
  thread base_array_ambient_dogfight_3();
  thread maps\satfarm_m880::setup_ambient_missile_launches("ambient_missile_launch_spot", "base_array_end");
  maps\satfarm_code::kill_spawners_per_checkpoint("base_array");
}

base_array_main() {
  if(!isDefined(level.playertank)) {
    maps\satfarm_code::spawn_player_checkpoint("base_array_");
    maps\satfarm_code::spawn_heroes_checkpoint("base_array_");
    common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  } else {
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[0], "", "switch_base_array_path_hero0", "base_array_path_hero0");
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[1], "", "switch_base_array_path_hero1", "base_array_path_hero1");
  }

  level.herotanks[0] thread maps\satfarm_code::tank_relative_speed("air_strip_relative_speed", "base_array_end", 200, 15, 2);
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("air_strip_relative_speed", "base_array_end", 250, 13.5, 1.5);
  objective_onentity(maps\_utility::obj("rendesvouz"), level.herotanks[1], (0, 0, 60));
  objective_setpointertextoverride(maps\_utility::obj("rendesvouz"), &"SATFARM_FOLLOW");
  thread base_array_begin();
  common_scripts\utility::flag_wait("base_array_end");
  maps\_spawner::killspawner(30);
  maps\satfarm_code::kill_vehicle_spawners_now(30);
  base_array_cleanup();
}

base_array_begin() {
  common_scripts\utility::flag_set("base_array_begin");
  thread base_array_allies_setup();
  thread base_array_enemies_setup();
  thread spawn_sat_array_a10_missile_dive_1();
  thread spawn_sat_array_a10_gun_dive_1();
  thread base_array_trucks_01_setup();
  thread base_array_pinned_down_allies();
  thread base_array_trucks_static_setup();
  thread base_array_vo();
  thread base_array_choppers();
  thread base_array_hints();
  thread base_array_end_vo();
  thread base_array_exit_rpg();
  thread setup_mortar_fire();
  thread maps\satfarm_code::saf_streetlight_dynamic_setup("base_array", "base_array_end");
  thread maps\satfarm_code::saf_concrete_barrier_dynamic_setup("base_array", "base_array_end");
  thread satfarm_transient_unload();
  thread satfarm_transient_load();
  maps\_utility::autosave_by_name("base_array");
}

spawn_sat_array_a10_missile_dive_1() {
  common_scripts\utility::flag_wait("start_sat_array_a10_missile_dive_1");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sat_array_a10_missile_dive_1");
}

spawn_sat_array_a10_gun_dive_1() {
  common_scripts\utility::flag_wait("start_sat_array_a10_gun_dive_1");
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sat_array_a10_gun_dive_1");
}

base_array_allies_setup() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("sat_array_allies");
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, var_0);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::npc_tank_combat_init);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_friendname) && var_2.script_friendname == "Buzzard") {
      var_2 thread maps\satfarm_code::tank_relative_speed("air_strip_relative_speed", "base_array_end", 200, 5, 1.5);
      continue;
    }

    if(isDefined(var_2.script_friendname) && var_2.script_friendname == "Barracuda") {
      var_2 thread maps\satfarm_code::tank_relative_speed("air_strip_relative_speed", "base_array_end", 100, 2, 2.0);
      continue;
    }

    if(isDefined(var_2.script_friendname) && var_2.script_friendname == "Bronco")
      var_2 thread maps\satfarm_code::tank_relative_speed("air_strip_relative_speed", "base_array_end", 50, 1, 1.75);
  }
}

base_array_enemies_setup() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname("sat_array_enemies");
  common_scripts\utility::array_thread(var_0, ::base_array_setup_reverse_start);
  level.enemytanks = common_scripts\utility::array_combine(level.enemytanks, var_0);
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::flag_wait_god_mode_off, "base_array_ridge_reached");
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::npc_tank_combat_init);
  maps\satfarm_code::waittilltanksdead(var_0, 2);
  common_scripts\utility::flag_set("sat_array_enemies_retreat_01");
  common_scripts\utility::flag_wait_either("sat_array_initial_enemies_dead", "spawn_base_array_choppers");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2.classname != "script_vehicle_corpse")
      var_2 thread maps\satfarm_code::random_wait_and_kill(1.0, 3.0);
  }
}

base_array_choppers() {
  level endon("start_base_array_mortar_strike");
  maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy", "heli_nav_mesh_base_array");
  common_scripts\utility::flag_wait_either("sat_array_initial_enemies_dead", "spawn_base_array_choppers");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("base_array_intro_flyby_choppers");

  foreach(var_2 in var_0) {
    var_2 thread maps\satfarm_code::target_settings();
    var_2 thread maps\satfarm_code::npc_tank_combat_init();
    var_2 thread maps\satfarm_code::chopper_insta_kill();
  }

  var_4 = maps\satfarm_code_heli::spawn_hind_enemies(3, "heli_nav_mesh_base_array_start");

  foreach(var_2 in var_4) {
    var_2 thread maps\satfarm_code::delayed_kill(randomfloatrange(0.1, 2.0), "start_base_array_mortar_strike");
    var_2 thread maps\satfarm_code::chopper_insta_kill();
  }

  maps\satfarm_code::radio_dialog_add_and_go("satfarm_com_bcompanyyouhaveenemy");
  wait 1.0;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_enemyattackchoppersmoving");
  maps\satfarm_code::waittillhelisdead(maps\satfarm_code::get_hinds_enemy_active(), 2);
  wait 3.0;
  var_4 = maps\satfarm_code::get_hinds_enemy_active();

  foreach(var_2 in var_4) {
    if(isDefined(var_2)) {
      level thread maps\satfarm_audio::chopper_death_player(var_2.origin);
      var_2 kill();
      wait 0.1;

      if(isDefined(var_2))
        var_2 delete();
    }
  }
}

base_array_setup_reverse_start() {
  self endon("death");
  common_scripts\utility::flag_wait("sat_array_enemies_retreat_01");
  wait(randomfloatrange(0.1, 0.5));
  self.veh_transmission = "reverse";
  self.script_transmission = "reverse";
  var_0 = self.script_noteworthy + "_start_node";
  maps\satfarm_code::switch_node_now(self, getvehiclenode(var_0, "targetname"));
  self.veh_transmission = "reverse";
  self.script_transmission = "reverse";
  var_1 = "switch_" + self.script_noteworthy + "_start_node_2";
  var_2 = self.script_noteworthy + "_start_node_2";
  thread maps\satfarm_code::switch_node_on_flag(self, "sat_array_enemies_retreat_02", var_1, var_2);
  self.veh_transmission = "reverse";
  self.script_transmission = "reverse";
  var_1 = "switch_" + self.script_noteworthy + "_start_node_3";
  var_2 = self.script_noteworthy + "_start_node_3";
  thread maps\satfarm_code::switch_node_on_flag(self, "sat_array_enemies_retreat_02", var_1, var_2);
}

base_array_trucks_01_setup() {
  common_scripts\utility::flag_wait("spawn_base_array_choppers");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("base_array_trucks_01");
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::gaz_spawn_setup);
}

base_array_pinned_down_allies() {
  var_0 = maps\_utility::array_spawn_targetname("base_array_pinned_down_allies", 1);

  foreach(var_2 in var_0) {
    var_2 maps\_utility::forceuseweapon("rpg_straight", "primary");
    var_2 maps\_utility::magic_bullet_shield();
  }

  common_scripts\utility::flag_wait("base_array_end");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::stop_magic_bullet_shield();
    var_2 delete();
  }
}

base_array_vo() {
  wait 1.0;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_werenearingyourposition");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_rogerthatpoppinggreen");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_enemyarmorahead");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_keepittightprepare");
  common_scripts\utility::flag_wait("base_array_ridge_reached");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_wehaveavisual");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_welcometotheparty");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_youcanbuyus");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_td3_clearouttheenemy");
  wait 1.0;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_td2_federationtanksincoming");
}

satfarm_transient_unload() {
  common_scripts\utility::flag_wait("satfarm_transient_unload");
  maps\_utility::transient_unload("satfarm_start_tr");
}

base_array_hints() {
  common_scripts\utility::flag_wait("base_array_ridge_reached");
  maps\_utility::objective_complete(maps\_utility::obj("rendesvouz"));
  objective_add(maps\_utility::obj("reach_air_strip"), "current", &"SATFARM_OBJ_REACH_AIR_STRIP");
  objective_onentity(maps\_utility::obj("reach_air_strip"), level.herotanks[1], (0, 0, 60));
  objective_setpointertextoverride(maps\_utility::obj("reach_air_strip"), &"SATFARM_FOLLOW");

  if(!common_scripts\utility::flag("PLAYER_ZOOMED_ONCE")) {
    if(level.player usinggamepad())
      level.player thread maps\_utility::display_hint_timeout("HINT_ZOOM_SPEED_THROW", 8.0);
    else {
      var_0 = 1;
      var_1 = 0;
      var_2 = getkeybinding("+speed_throw");

      if(!isDefined(var_2) || var_2["count"] == 0) {
        var_0 = 0;
        var_2 = getkeybinding("+toggleads_throw");

        if(isDefined(var_2) && var_2["count"] > 0)
          var_1 = 1;
      }

      if(var_0)
        level.player thread maps\_utility::display_hint_timeout("HINT_ZOOM_SPEED_THROW", 8.0);
      else
        level.player thread maps\_utility::display_hint_timeout("HINT_ZOOM_TOGGLEADS_THROW", 8.0);
    }
  }

  common_scripts\utility::flag_wait_either("sat_array_initial_enemies_dead", "spawn_base_array_choppers");
  wait 4.0;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_switchtolockonround");
  level.player thread maps\_utility::display_hint_timeout("HINT_SWITCH_TO_GUIDED_ROUND", 8.0);
}

base_array_end_vo() {
  common_scripts\utility::flag_wait("sat_array_enemies_retreat_03");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_thanksfortheassist");
}

setup_mortar_fire() {
  level endon("stop_base_array_mortar_strikes");
  common_scripts\utility::flag_wait("start_base_array_mortar_strike");
  common_scripts\utility::flag_set("stop_tank_chatter");
  thread base_array_mortar_strikes();
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_incoming");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_incoming");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_theyvetargetedourposition");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_gogogo");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_dontstop");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_fullthrottle");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_movemove");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_overlordweneedsuppression");
  wait(randomfloatrange(2.0, 4.0));

  for(;;) {
    wait(randomfloatrange(2.0, 4.0));
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_gogogo");
    wait(randomfloatrange(2.0, 4.0));
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_incoming");
    wait(randomfloatrange(2.0, 4.0));
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_movemove");
    wait(randomfloatrange(2.0, 4.0));
    maps\satfarm_code::radio_dialog_add_and_go("satfarm_brv_incoming");
  }
}

base_array_mortar_strikes() {
  var_0 = level.playertank vehicle_getspeed();
  var_1 = 17.6;

  while(!common_scripts\utility::flag("stop_base_array_mortar_strikes")) {
    for(var_2 = 0; var_2 < 3; var_2++) {
      var_3 = level.player getEye();
      var_4 = level.player getplayerangles();
      var_5 = anglesToForward(var_4);
      var_6 = anglestoright(var_4);
      var_7 = level.playertank vehicle_getspeed() * var_1;

      if(var_7 < var_0)
        var_7 = var_0 - (var_0 - var_7) * 0.25;

      var_8 = var_3 + var_7 * 1.0 * var_5;
      var_9 = randomfloatrange(-500, 500);
      var_10 = randomfloatrange(0, 1000);
      var_11 = var_9 * var_6 + var_10 * var_5;
      var_12 = common_scripts\utility::spawn_tag_origin();
      var_12.origin = common_scripts\utility::drop_to_ground(var_8 + var_11, 3000);
      var_12.angles = (-90, 0, 0);
      thread common_scripts\utility::play_sound_in_space("satf_mortar_incoming", var_12.origin);
      wait(randomfloatrange(0.25, 0.45));
      maps\satfarm_code::mortar_impact(var_12);
      wait(randomfloatrange(0.25, 0.45));
      var_12 delete();
    }

    var_0 = level.playertank vehicle_getspeed();
    wait(randomfloatrange(0.5, 1));
  }

  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_whg_warthog31comingin");
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("air_strip_mortar_killers");
  var_0 = level.playertank vehicle_getspeed();
  var_1 = 17.6;

  for(var_2 = 0; var_2 < 4; var_2++) {
    if(var_2 == 3)
      thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_wereclearwereclear");

    var_3 = level.player getEye();
    var_4 = level.player getplayerangles();
    var_5 = anglesToForward(var_4);
    var_6 = anglestoright(var_4);
    var_7 = level.playertank vehicle_getspeed() * var_1;

    if(var_7 < var_0)
      var_7 = var_0 - (var_0 - var_7) * 0.25;

    var_8 = var_3 + var_7 * 1.0 * var_5;
    var_9 = randomfloatrange(-500, 500);
    var_10 = randomfloatrange(0, 1000);
    var_11 = var_9 * var_6 + var_10 * var_5;
    var_12 = common_scripts\utility::spawn_tag_origin();
    var_12.origin = common_scripts\utility::drop_to_ground(var_8 + var_11, 3000);
    var_12.angles = (-90, 0, 0);
    thread common_scripts\utility::play_sound_in_space("satf_mortar_incoming", var_12.origin);
    wait(randomfloatrange(0.25, 0.45));
    maps\satfarm_code::mortar_impact(var_12);
    wait(randomfloatrange(0.25, 0.45));
    var_12 delete();
    var_0 = level.playertank vehicle_getspeed();
    wait(randomfloatrange(0.5, 0.75));
  }

  common_scripts\utility::flag_clear("stop_tank_chatter");
}

base_array_ai_cleanup_spawn_function() {
  self endon("death");
  thread maps\satfarm_code::detectkill();

  if(issubstr(tolower(self.classname), "rpg"))
    thread maps\satfarm_code::enemy_rpg_unlimited_ammo();

  common_scripts\utility::flag_wait("start_base_array_mortar_strike");

  if(isDefined(self) && isalive(self))
    self kill();
}

base_array_ambient_dogfight_1() {
  level endon("base_array_end");

  for(;;) {
    wait(randomfloatrange(10.0, 20.0));
    level.base_array_ambient_a10_gun_dive_1 = undefined;
    level.base_array_ambient_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_1");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_1_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_1_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_trucks_static_setup() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname("base_array_trucks_static");
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::gaz_spawn_setup);
  common_scripts\utility::flag_wait("base_array_end");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2.classname != "script_vehicle_corpse")
      var_2 delete();
  }
}

base_array_ambient_dogfight_2() {
  level endon("base_array_end");

  for(;;) {
    wait(randomfloatrange(20.0, 40.0));
    level.base_array_ambient_a10_gun_dive_2 = undefined;
    level.base_array_ambient_a10_gun_dive_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_2_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_2");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_2_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_ambient_dogfight_3() {
  level endon("base_array_end");

  for(;;) {
    wait(randomfloatrange(15.0, 30.0));
    level.base_array_ambient_a10_gun_dive_3 = undefined;
    level.base_array_ambient_a10_gun_dive_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_3");

    if(common_scripts\utility::cointoss())
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_a10_gun_dive_3_buddy");

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss())
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("base_array_ambient_mig29_missile_dive_3_buddy");

    wait(randomfloatrange(5.0, 10.0));
  }
}

base_array_cleanup() {
  var_0 = getEntArray("base_array_ent", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

base_array_exit_rpg() {
  common_scripts\utility::flag_wait("base_array_exit_rpg");
  maps\_utility::array_spawn_targetname("base_array_exit_tower_rpg_guys", 1);
  var_0 = common_scripts\utility::getstruct("base_array_exit_rpg_spot", "targetname");
  magicbullet("rpg_straight", var_0.origin, level.playertank.origin);
}

satfarm_transient_load() {
  common_scripts\utility::flag_wait("satfarm_transient_load");
  maps\_utility::transient_load("satfarm_tower_tr");
}