/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_rhino_boss.gsc
************************************************************/

rhino_boss_init() {
  if(getdvarint("mammoth_fight") == 1 || 0 || 0) {
    level.jump_to_mammoth = 1;
  }

  level.killingtimevalidationcheck = ::killingtimevalidation;
  rh_boss_stepregistration();
  init_rh_boss_flags();
  init_mammoth_fx_locs();
  level.rhino_consoles_activated = 0;
  level.rhino_array = [];
  scripts\cp\cp_weapon_autosentry::init();
  level thread rh_boss_interactions();
  if(0) {
    level thread demo_test_rhino_fight();
  }

  level thread spawn_ammo_crate();
  level thread turn_on_lights(5);
  level thread init_rh_neil_monitors();
  level thread spawnempconsolestruct();
  initial_door_layout();
  level.forceturretplacement = 1;
}

spawnempconsolestruct() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = spawnStruct();
  var_0.origin = (3082.96, 2541.72, -175.928);
  var_0.angles = (0, -0.0219727, 0);
  var_0.script_noteworthy = "emp_console";
  var_0.var_336 = "interaction";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.script_parameters = "default";
  level.struct_class_names["targetname"]["interaction"][level.struct_class_names["targetname"]["interaction"].size] = var_0;
  level.struct_class_names["script_noteworthy"]["emp_console"][0] = var_0;
}

rh_boss_stepregistration() {
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("Rhino Boss", 0, ::blank, ::blank, ::blank, ::dbg_start_rhino, 0, "MPQ Quest Step Description");
}

blankusefunc(var_0, var_1) {}

blankhintfunc(var_0, var_1) {
  return "";
}

init_rh_boss_flags() {
  scripts\engine\utility::flag_init("rhino_stage_1");
  scripts\engine\utility::flag_init("rhino_stage_2");
  scripts\engine\utility::flag_init("rhino_stage_3");
  scripts\engine\utility::flag_init("rhino_stage_4");
  scripts\engine\utility::flag_init("rhino_stage_5");
  scripts\engine\utility::flag_init("laser_in_place");
  scripts\engine\utility::flag_init("init_rhinos_spawned");
  scripts\engine\utility::flag_init("all_buttons_pressed");
  scripts\engine\utility::flag_init("consoles_ready");
  scripts\engine\utility::flag_init("spawning_ready");
  scripts\engine\utility::flag_init("start_rhino_sequence");
}

rh_boss_interactions() {
  while(!scripts\engine\utility::flag_exist("interactions_initialized")) {
    wait(0.1);
  }

  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "rhino_ammo_crate", undefined, undefined, ::rhino_ammo_crate_hint, ::rhino_ammo_crate_act, 0, 0, undefined);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "rhino_sentry", undefined, undefined, ::rhino_sentry_hint, ::rhino_sentry_act, 0, 0, undefined);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "rhino_console", undefined, undefined, ::rhino_console_hint, ::rhino_console_act, 0, 0, undefined);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "perk_candy_box", undefined, undefined, ::perkbox_hintfunc, ::perkboxuse, 0, 0, undefined);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(1, "rhino_neil_monitors", undefined, undefined, ::blankhintfunc, ::blankusefunc, 0, 0, ::init_rh_neil_monitors);
  init_rk_candy_interactions();
  scripts\cp\maps\cp_final\cp_final_mpq::activateinteractionsbynoteworthy("rhino_sentry");
  var_0 = scripts\engine\utility::getStructArray("rhino_sentry", "script_noteworthy");
  var_1 = "rhino_sentry_door";
  var_2 = getEntArray(var_1, "targetname");
  var_3 = scripts\engine\utility::getclosest(var_2[0].origin, var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  var_1 = "rhino_sentry_door_2";
  var_2 = getEntArray(var_1, "targetname");
  var_3 = scripts\engine\utility::getclosest(var_2[0].origin, var_0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
}

blank() {}

demo_test_rhino_fight() {
  wait(10);
  dbg_start_rhino();
}

dbg_start_rhino() {
  scripts\engine\utility::flag_set("power_on");
  level.dbg_rhino = 1;
  start_rhino_fight();
}

start_rhino_fight() {
  setuplnfinteractions();
  move_players_to_rhino_fight();
  level.oldspecialroundcounter = level.specialroundcounter;
  level.specialroundcounter = 5;
  if(0) {
    if(scripts\engine\utility::istrue(level.dbg_rhino)) {
      setupplayerloadouts();
    }
  }

  update_spawning_for_rhino_fight();
  level.pause_nag_vo = 1;
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::allow_player_teleport(0);
  }

  level notify("start_rhino_fight");
}

move_players_to_rhino_fight() {
  level.currentneilstate = "angry";
  var_0 = (2896, 2868, -68);
  var_1 = (4, 270, 0);
  var_2 = [50, -50, 50, -50];
  var_3 = [50, 50, -50, -50];
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = (var_0[0] + var_2[var_4], var_0[1] + var_3[var_4], var_0[2]);
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level.players[var_4] setorigin(var_5);
      level.players[var_4] setplayerangles(var_1);
    }

    level.players[var_4] scripts\cp\utility::removedamagemodifier("papRoom", 0);
    level.players[var_4].is_off_grid = undefined;
    level.players[var_4].kicked_out = undefined;
    level.players[var_4].is_in_pap = 0;
    level.players[var_4] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_4]);
  }
}

update_spawning_for_rhino_fight() {
  level.current_enemy_deaths = 0;
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
  scripts\engine\utility::flag_set("start_rhino_sequence");
  level.no_loot_drop = 1;
  level thread turn_on_perk_boxes();
  var_0 = [(2698.5, 2388.44, -175.876), (0, 54.2883, 0)];
  var_1 = [(3048.75, 2407.74, -175.876), (0, 119.261, 0)];
  var_2 = [(2936.27, 2897.63, -175.876), (0, -106.134, 0)];
  var_3 = [(2721.7, 2900.75, -175.876), (0, -59.1894, 0)];
  var_4 = [(2635.3, 2622.89, -167.775), (0, -0.0610256, 0)];
  var_5 = [(3073.27, 2802.28, -175.876), (0, -141.4, 0)];
  level.startingrespawnpoints = [var_0, var_1, var_2, var_3, var_4, var_5];
  level.force_respawn_location = ::respawn_in_rhino_fight;
  level.getspawnpoint = ::respawn_in_rhino_fight;
}

rhino_boss_fight_vo() {
  wait(7);
  var_0 = scripts\engine\utility::random(level.players);
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
      case "p1_":
        if(!isDefined(level.completed_dialogues["conv_first_rhino_1_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_first_rhino_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_first_rhino_1_1"] = 1;
        }
        break;

      case "p2_":
        if(!isDefined(level.completed_dialogues["conv_first_rhino_3_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_first_rhino_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_first_rhino_3_1"] = 1;
        }
        break;

      case "p3_":
        if(!isDefined(level.completed_dialogues["conv_first_rhino_2_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_first_rhino_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_first_rhino_2_1"] = 1;
        }
        break;

      case "p4_":
        if(!isDefined(level.completed_dialogues["conv_first_rhino_4_1"])) {
          level thread scripts\cp\cp_vo::try_to_play_vo("conv_first_rhino_4_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["conv_first_rhino_4_1"] = 1;
        }
        break;
    }
  }
}

setupplayerloadouts() {
  var_0 = ["iw7_crdb_zm", "iw7_g18_zmr", "iw7_m4_zmr", "iw7_arclassic_zmr"];
  var_1 = ["iw7_minilmg_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_unsalmg_zm"];
  var_2 = ["perk_machine_revive", "perk_machine_zap", "perk_machine_tough", "perk_machine_flash", "perk_machine_rat_a_tat"];
  var_3 = ["perk_machine_revive", "perk_machine_boom", "perk_machine_tough", "perk_machine_flash", "perk_machine_rat_a_tat"];
  foreach(var_5 in level.players) {
    var_6 = randomint(var_1.size);
    var_7 = randomint(var_0.size);
    var_5 takeweapon(var_5 scripts\cp\utility::getvalidtakeweapon());
    var_8 = scripts\cp\utility::getrawbaseweaponname(var_1[var_6]);
    if(isDefined(var_5.weapon_build_models[var_8])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_5.weapon_build_models[var_8]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_1[var_6]);
    }

    var_9 = scripts\cp\utility::getrawbaseweaponname(var_0[var_7]);
    if(isDefined(var_5.weapon_build_models[var_9])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_5.weapon_build_models[var_9]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_1[var_6]);
    }

    var_5.total_currency_earned = min(10000, var_5 scripts\cp\cp_persistence::get_player_max_currency());
    var_5 scripts\cp\cp_persistence::set_player_currency(10000);
    if(issubstr(var_8, "_g18_")) {
      foreach(var_11 in var_3) {
        var_5 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_11, 1);
      }
    } else {
      foreach(var_11 in var_2) {
        var_5 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_11, 1);
      }
    }

    var_5.consumable_meter = var_5.consumable_meter_max;
    var_5 notify("consumable_charge", 0);
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
  scripts\engine\utility::flag_set("completepuzzles_step4");
}

respawn_in_rhino_fight(var_0) {
  if(!scripts\engine\utility::flag("rhino_stage_3")) {
    var_1 = level.startingrespawnpoints;
    var_1 = scripts\engine\utility::array_randomize(var_1);
    var_2 = spawnStruct();
    foreach(var_4 in var_1) {
      if(canspawn(var_4[0]) && !positionwouldtelefrag(var_4[0])) {
        var_2.origin = var_4[0];
        var_2.angles = var_4[1];
        return var_2;
      }
    }

    var_2.origin = var_1[0][0];
    var_2.angles = var_1[0][1];
    return var_2;
  }

  var_1 = scripts\engine\utility::getStructArray("rhino_boss_spawn_loc", "targetname");
  var_5 = scripts\engine\utility::array_randomize(var_5);
  var_2 = spawnStruct();
  foreach(var_6 in var_4) {
    if(canspawn(var_6.origin) && !positionwouldtelefrag(var_6.origin)) {
      var_4.origin = var_6.origin;
      var_4.angles = (0, 90, 0);
      return var_4;
    }
  }

  var_4.origin = var_3[0].origin;
  var_4.angles = (0, 90, 0);
  return var_4;
}

initial_door_layout() {
  level.rhino_doors = [];
  level.rhino_doors_path_1 = [];
  level.rhino_doors_path_2 = [];
  if(getdvarint("scr_direct_to_meph_fight", 0) != 0) {
    return;
  }

  init_door_clip();
  level thread listen_for_rhino_trigger();
  level thread move_laser();
  level thread init_cargo_doors();
  if(0) {
    level thread openrhinofightarena();
    return;
  }

  if(!isDefined(level.jump_to_mammoth)) {
    level thread rhino_fight_sequence();
    return;
  }

  level thread debug_to_mammoth();
}

openrhinofightarena() {
  scripts\engine\utility::flag_wait("spawning_ready");
  scripts\engine\utility::flag_wait("laser_in_place");
  open_stage_1_area();
  open_stage_2_area();
}

rhino_fight_sequence() {
  func_10B42();
  scripts\engine\utility::flag_set("rhino_stage_1");
  func_10B43();
  scripts\engine\utility::flag_set("rhino_stage_2");
  func_10B44();
  scripts\engine\utility::flag_set("rhino_stage_3");
  stage_4();
  level notify("create_perk_boxes");
  scripts\engine\utility::flag_set("rhino_stage_4");
  stage_5();
  level notify("create_perk_boxes");
  stage_6();
}

func_10B42() {
  level endon("game_ended");
  while(level.rhino_array.size < 1) {
    wait(0.1);
  }

  level thread rhino_boss_fight_vo();
  scripts\engine\utility::flag_wait("init_rhinos_spawned");
  while(level.rhino_array.size > 0) {
    wait(0.1);
  }
}

func_10B43() {
  wait(5);
  level thread update_spawn_portals();
  wait(5);
  turn_on_spawners("spawner_1");
  func_1071B();
}

func_10B44() {
  wait(5);
  level thread open_stage_2_area();
  turn_off_spawners("spawner_1");
  turn_on_spawners("spawner_2");
  var_0 = scripts\engine\utility::getstruct("rhino_turret_idle", "targetname");
  aim_at_target(var_0);
  spawn_phantoms();
  wait(5);
}

stage_4() {
  level notify("create_perk_boxes");
  wait(2);
  turn_off_monitors();
  level thread fake_console_timer(45);
  level thread aim_and_fire_laser();
  turn_on_spawners("spawner_1");
  turn_on_spawners("spawner_2");
  turn_on_monitors();
  endless_wave();
}

stage_5() {
  turn_off_lights();
  turn_off_spawners("spawner_1", "spawner_2");
  level notify("stop_firing");
  wait(1);
  turn_on_lights(1);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_portal_open");
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("goon_spawner", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_1 = scripts\engine\utility::getStructArray("rhino_sentry", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_1 = scripts\engine\utility::getStructArray("rhino_console", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_2 = 0;
  while(var_2 < 8) {
    var_3 = aim_at_target(var_0[var_2]);
    func_6D02(var_3);
    var_2++;
    wait(0.1);
  }

  var_4 = "rhino_emp_door";
  var_5 = getEntArray(var_4, "targetname");
  var_3 = aim_at_target(var_5[0]);
  wait(1);
  func_6D02(var_3);
  break_door(var_4);
  level thread open_sentry_doors();
  wait(5);
  emp_defend();
}

stage_6() {
  turn_off_lights();
  turn_off_monitors();
  turn_off_spawners("spawner_1", "spawner_2");
  var_0 = scripts\engine\utility::getstruct("rhino_turret_broken", "targetname");
  aim_at_target(var_0);
  scripts\engine\utility::flag_set("rhino_stage_5");
  level notify("create_perk_boxes");
  wait(5);
  release_mammoths();
}

init_door_clip() {
  var_0 = ["rhino_door_stage_1", "rhino_door_stage_2", "rhino_spawn_door_1", "rhino_spawn_door_2", "rhino_spawn_door_3", "rhino_spawn_door_4", "mammoth_spawn_door_1"];
  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "targetname");
    foreach(var_5 in var_3) {
      wait(0.1);
    }
  }

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2 + "_clip", "targetname");
    foreach(var_5 in var_3) {
      var_5 func_95B5();
      wait(0.2);
    }
  }
}

open_stage_1_area() {
  break_door("rhino_spawn_door_1");
  wait(0.1);
  break_door("rhino_spawn_door_2");
  wait(0.1);
  break_door("rhino_spawn_door_3");
  wait(0.1);
  break_door("rhino_spawn_door_4");
}

open_stage_2_area() {
  var_0 = getEntArray("rhino_door_stage_2_clip", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.nav_id)) {
      destroynavobstacle(var_2.nav_id);
    }

    var_2 notsolid();
  }

  var_4 = "death_ray_cannon_rock_impact";
  var_0 = getEntArray("rhino_door_stage_2", "targetname");
  foreach(var_2 in var_0) {
    playsoundatpos(var_2.origin, "zmb_rhino_door_explo");
    playFX(level._effect[var_4], var_2.origin);
    var_2 delete();
  }

  var_0 = getEntArray("stage_3_bollard", "targetname");
  foreach(var_2 in var_0) {
    var_2 movez(-34, 2, 0.1, 0.1);
  }
}

listen_for_rhino_trigger() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  waitforplayersnearby();
  wait(5);
  level.zombies_paused = 1;
  foreach(var_1 in level.spawned_enemies) {
    if(isalive(var_1)) {
      var_1.died_poorly = 1;
      var_1 suicide();
    }
  }

  scripts\engine\utility::flag_set("pause_wave_progression");
  wait(3);
  if(!isDefined(level.jump_to_mammoth)) {
    spawn_initial_rhino();
    return;
  }

  scripts\engine\utility::flag_set("spawning_ready");
}

waitforplayersnearby() {
  level endon("game_ended");
  level endon("start_rhino_fight");
  var_0 = scripts\engine\utility::getStructArray("initial_rhino_spawn", "targetname");
  var_1 = var_0[0].origin;
  var_2 = 150;
  var_3 = var_2 * var_2;
  var_4 = 0;
  while(!var_4) {
    foreach(var_6 in level.players) {
      if(distance2dsquared(var_1, var_6.origin) < var_3) {
        var_4 = 1;
      }
    }

    wait(0.1);
  }
}

spawn_initial_rhino() {
  scripts\engine\utility::flag_wait("laser_in_place");
  var_0 = ["initial_rhino_spawn", "initial_rhino_spawn_2"];
  var_1 = ["rhino_spawn_door_1", "rhino_spawn_door_2"];
  var_2 = randomint(2);
  var_3 = spawn_starting_rhino(var_0[var_2], var_1[var_2]);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(10);
  var_2 = scripts\engine\utility::ter_op(var_2 == 1, 0, 1);
  spawn_starting_rhino(var_0[var_2], var_1[var_2]);
  var_4 = scripts\engine\utility::random(level.players);
  var_4 thread scripts\cp\cp_vo::try_to_play_vo("rhino_2", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(10);
  var_5 = ["initial_rhino_spawn_3", "initial_rhino_spawn_4"];
  var_6 = ["rhino_spawn_door_3", "rhino_spawn_door_4"];
  var_2 = randomint(2);
  spawn_starting_rhino(var_5[var_2], var_6[var_2]);
  var_4 = scripts\engine\utility::random(level.players);
  var_4 thread scripts\cp\cp_vo::try_to_play_vo("rhino_3", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(5);
  var_2 = scripts\engine\utility::ter_op(var_2 == 1, 0, 1);
  spawn_starting_rhino(var_5[var_2], var_6[var_2]);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  scripts\engine\utility::flag_set("init_rhinos_spawned");
  var_7 = scripts\engine\utility::getstruct("rhino_turret_idle", "targetname");
  aim_at_target(var_7);
}

spawn_starting_rhino(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_3 = var_2.origin;
  var_4 = var_2.angles;
  var_5 = "axis";
  var_6 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_rhino", var_3, var_4, var_5);
  var_6 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_rhino");
  var_6.scripted_mode = 1;
  var_6.nodamage = 1;
  var_6 thread rhino_audio_monitor();
  level thread track_rhino_deaths(var_6);
  var_7 = getEntArray(var_1, "targetname");
  var_8 = aim_at_target(var_7[0]);
  func_6D02(var_8);
  break_door(var_1);
  var_6.scripted_mode = 0;
  var_6.nodamage = undefined;
}

init_cargo_doors() {
  var_0 = ["rhino_spawn_door_1", "rhino_spawn_door_2", "rhino_spawn_door_3", "rhino_spawn_door_4"];
  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2 + "_clip", "targetname");
    foreach(var_5 in var_3) {
      var_5 func_95B5();
      wait(0.1);
    }
  }
}

func_95B5() {
  self.nav_id = createnavobstaclebyent(self);
}

break_door(var_0) {
  var_1 = "death_ray_cannon_rock_impact";
  var_2 = getEntArray(var_0, "targetname");
  foreach(var_4 in var_2) {
    playsoundatpos(var_4.origin, "zmb_rhino_door_explo");
    playFX(level._effect[var_1], var_4.origin);
    var_4 delete();
  }

  var_2 = getEntArray(var_0 + "_clip", "targetname");
  var_6 = scripts\engine\utility::getclosest((2897, 2313, -26), var_2, 250);
  foreach(var_4 in var_2) {
    if(var_0 == "rhino_sentry_door") {
      if(var_4 == var_6) {
        continue;
      }
    }

    if(isDefined(var_4.nav_id)) {
      destroynavobstacle(var_4.nav_id);
    }

    var_4 notsolid();
    var_4 hide();
  }
}

track_rhino_deaths(var_0) {
  level endon("rhino_fight_over");
  level.rhino_array[level.rhino_array.size] = var_0;
  var_0 waittill("death");
  level.rhino_array = scripts\engine\utility::array_remove(level.rhino_array, var_0);
}

func_1071B() {
  level.current_num_spawned_enemies = 0;
  var_0 = 0;
  var_1 = [40, 60, 80, 100];
  var_1 = var_1[level.players.size - 1];
  var_2 = [16, 20, 24, 24];
  var_3 = [1.25, 0.75, 0.5, 0.35];
  var_4 = var_2[level.players.size - 1];
  while(var_0 < var_1) {
    if(level.current_num_spawned_enemies < var_4) {
      var_5 = get_current_spawners();
      if(var_5.size > 0) {
        var_6 = scripts\engine\utility::random(var_5);
        var_7 = func_10719(var_6);
        if(isDefined(var_7)) {
          var_0++;
        }
      }
    }

    wait(var_3[level.players.size - 1]);
  }

  while(level.current_num_spawned_enemies > 0) {
    wait(0.1);
  }
}

get_current_spawners() {
  var_0 = scripts\engine\utility::getStructArray("spawner_1", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("spawner_2", "script_noteworthy");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  var_2 = [];
  foreach(var_4 in var_0) {
    if(scripts\engine\utility::istrue(var_4.var_19)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

update_spawn_portals() {
  var_0 = scripts\engine\utility::getStructArray("spawner_1", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1].target)) {
      continue;
    }

    var_2 = scripts\engine\utility::getstruct(var_0[var_1].target, "targetname");
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    if(!isDefined(var_2.fx)) {
      var_3 = var_2.origin;
      var_2.fx = spawn("script_model", var_3 + (0, 0, 50));
      var_2.fx.angles = var_2.angles + (0, 90, 0);
      wait(0.1);
      var_2.fx setModel("tag_origin_final_rhino_portal");
      var_0[var_1].portal_struct = var_2;
      wait(0.5);
    }
  }

  var_0 = scripts\engine\utility::getStructArray("spawner_2", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1].target)) {
      continue;
    }

    var_2 = scripts\engine\utility::getstruct(var_0[var_1].target, "targetname");
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    if(!isDefined(var_2.fx)) {
      var_3 = var_2.origin;
      var_2.fx = spawn("script_model", var_3 + (0, 0, 50));
      var_2.fx.angles = var_2.angles + (0, 90, 0);
      wait(0.1);
      var_2.fx setModel("tag_origin_final_rhino_portal");
      var_0[var_1].portal_struct = var_2;
      wait(0.5);
    }
  }
}

delete_portal_models() {
  var_0 = scripts\engine\utility::getStructArray("spawner_1", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.portal_struct) && isDefined(var_2.portal_struct.fx)) {
      var_2.portal_struct.fx delete();
    }
  }

  var_0 = scripts\engine\utility::getStructArray("spawner_2", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.portal_struct) && isDefined(var_2.portal_struct.fx)) {
      var_2.portal_struct.fx delete();
    }
  }
}

portal_spawn_fx(var_0, var_1) {
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_0, var_1);
}

func_10719(var_0) {
  var_1 = var_0.origin + (0, 0, 10);
  var_2 = var_0.angles;
  var_3 = "axis";
  var_4 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_goon", var_1, var_2, var_3);
  if(isDefined(var_4)) {
    portal_spawn_fx(var_0.origin, var_0.angles);
    var_4 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_goon");
  }

  return var_4;
}

spawn_phantoms() {
  level.current_num_spawned_enemies = 0;
  var_0 = get_current_spawners();
  var_1 = 0;
  var_2 = [25, 40, 50, 60];
  var_2 = var_2[level.players.size - 1];
  var_3 = [1, 0.75, 0.5, 0.5];
  var_4 = [12, 15, 18, 18];
  var_5 = var_4[level.players.size - 1];
  while(var_1 < var_2) {
    if(level.current_num_spawned_enemies < var_5) {
      if(var_0.size > 0) {
        var_6 = scripts\engine\utility::random(var_0);
        if(var_1 % 5 == 0) {
          var_7 = spawn_phantom(var_6);
        } else {
          var_7 = func_10719(var_7);
        }

        if(isDefined(var_7)) {
          var_1++;
        }
      }
    }

    wait(var_3[level.players.size - 1]);
  }

  while(level.current_num_spawned_enemies > 0) {
    wait(0.1);
  }
}

spawn_phantom(var_0) {
  var_1 = var_0.origin + (0, 0, 10);
  var_2 = var_0.angles;
  var_3 = "axis";
  var_4 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_phantom", var_1, var_2, var_3);
  if(isDefined(var_4)) {
    portal_spawn_fx(var_0.origin, var_0.angles);
    var_4 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_phantom");
  }

  return var_4;
}

spawn_rhino(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = "axis";
  var_4 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_rhino", var_1, var_2, var_3);
  if(isDefined(var_4)) {
    portal_spawn_fx(var_0.origin, var_0.angles);
    level thread track_rhino_deaths(var_4);
    var_4 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_rhino");
    var_4 thread rhino_audio_monitor();
    var_5 = scripts\engine\utility::random(level.players);
    var_5 thread scripts\cp\cp_vo::try_to_play_vo("rhino_spawn", "final_comment_vo", "high", 5, 1, 0, 0, 100);
  }

  return var_4;
}

rhino_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  self.voprefix = "queen_";
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix);
  self.playing_stumble = 0;
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout(3, "attack_hit_big", "attack_hit_small", "taunt", "charge_start", "charge_to_stop");
    switch (var_0) {
      case "attack_hit_big":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_pounding_third", 0);
        break;

      case "attack_hit_small":
        var_1 = scripts\engine\utility::random(["attack_pounding", "attack_pounding_second"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_1, 0);
        break;

      case "taunt":
        var_1 = scripts\engine\utility::random(["posture_1", "posture_2"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_1, 0);
        break;

      case "charge_start":
        var_1 = scripts\engine\utility::random(["charge_start", "charge_start_v2", "charge_start_v3"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_1, 0);
        break;

      case "charge_to_stop":
        var_1 = scripts\engine\utility::random(["charge_to_stop"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_1, 0);
        break;
    }
  }
}

move_laser() {
  wait(10);
  while(!isDefined(level.portal_gun)) {
    wait(0.1);
  }

  scripts\engine\utility::flag_wait("start_rhino_sequence");
  level.portal_gun rotateto(level.portal_gun.var_10B9F, 3, 0.1, 0.1);
  level.portal_gun waittill("rotatedone");
  level.portal_gun_crane thread scripts\cp\maps\cp_final\cp_final_fast_travel::play_move_sounds(5);
  level.portal_gun moveto(level.portal_gun.start_pos, 5, 0.1, 0.1);
  level.portal_gun_crane moveto(level.portal_gun_crane.start_pos, 5, 0.1, 0.1);
  level.portal_gun waittill("movedone");
  scripts\engine\utility::flag_set("laser_in_place");
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_taunt_misc");
  setup_tracking_laser_ents();
  level thread run_tracking_laser();
}

debug_laser_move() {
  level.portal_gun moveto(level.portal_gun.var_62EE, 5, 0.1, 0.1);
  level.portal_gun_crane moveto(level.portal_gun_crane.var_62EE, 5, 0.1, 0.1);
  level.portal_gun waittill("movedone");
  level.portal_gun rotateto(level.portal_gun.end_ang, 3, 0.1, 0.1);
  level.portal_gun waittill("rotatedone");
  wait(1);
}

setup_tracking_laser_ents() {
  level.portal_gun.laser_node_start = spawn("script_model", level.portal_gun.origin);
  scripts\engine\utility::waitframe();
  level.portal_gun.laser_node_start setModel("tag_origin");
  level.portal_gun.laser_node_start linkto(level.portal_gun);
  level.portal_gun.laser_node_end = spawn("script_model", level.portal_gun.origin);
  scripts\engine\utility::waitframe();
  level.portal_gun.laser_node_end setModel("tag_origin");
}

run_tracking_laser() {
  var_0 = "death_ray_cannon_beam";
  var_1 = level.portal_gun.barrel_ents;
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  level thread play_laser_fx();
  for(;;) {
    var_3 = undefined;
    var_4 = var_1[0];
    var_5 = level.portal_gun.angles;
    var_6 = anglesToForward(var_5);
    var_6 = vectornormalize(var_6);
    var_7 = var_4.origin + var_6 * 2000;
    var_8 = scripts\engine\utility::array_add(level.players, level.portal_gun);
    var_3 = physics_raycast(var_4.origin, var_7, var_2, var_8, 0, "physicsquery_closest");
    if(isDefined(var_3) && isarray(var_3) && var_3.size > 0) {
      var_9 = var_3[0]["position"];
      level.portal_gun.laser_node_end.origin = var_9;
    }

    scripts\engine\utility::waitframe();
  }
}

play_laser_fx(var_0) {
  wait(1);
  foreach(var_2 in level.players) {
    level.target_laser_fx = playfxontagsbetweenclients(level._effect["target_laser"], level.portal_gun.laser_node_start, "tag_origin", level.portal_gun.laser_node_end, "tag_origin", var_2);
  }
}

make_laser_angry() {
  if(isDefined(level.target_laser_fx)) {
    level.target_laser_fx delete();
  }

  foreach(var_1 in level.players) {
    level.target_laser_fx = playfxontagsbetweenclients(level._effect["target_laser_angry"], level.portal_gun.laser_node_start, "tag_origin", level.portal_gun.laser_node_end, "tag_origin", var_1);
  }
}

aim_and_fire_laser() {
  level endon("rhino_fight_over");
  level endon("stop_firing");
  make_laser_angry();
  var_0 = scripts\engine\utility::random(level.players);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("rhino_laser_target", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  for(;;) {
    var_1 = get_target();
    if(isDefined(var_1)) {
      var_2 = aim_at_target(var_1);
      wait(1);
      func_6D02(var_2);
    }

    wait(1);
  }
}

get_target() {
  var_0 = level.players;
  var_1 = undefined;
  for(var_2 = 0; !var_2; var_2 = 1) {
    if(var_0.size < 1) {
      break;
    }

    var_1 = scripts\engine\utility::random(var_0);
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      var_1 = undefined;
      continue;
    }
  }

  return var_1;
}

aim_at_target(var_0) {
  var_1 = 3;
  var_2 = var_0.origin;
  if(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_2 = var_0.origin;
  }

  var_3 = var_0.origin - level.portal_gun.origin;
  var_4 = vectortoangles(var_3);
  var_5 = scripts\engine\utility::anglebetweenvectors(level.portal_gun.origin, var_3);
  var_6 = var_5 / 180;
  var_7 = var_1 * var_6;
  level.portal_gun rotateto(var_4, var_7);
  level.portal_gun waittill("rotatedone");
  playsoundatpos(level.portal_gun.origin, "zmb_cannon_charge_up");
  var_2 = level.portal_gun.laser_node_end.origin;
  return var_2;
}

func_6D02(var_0) {
  var_1 = "death_ray_cannon_beam";
  var_2 = "tag_origin_laser_ray_fx";
  var_3 = "death_ray_cannon_rock_impact";
  var_4 = level.portal_gun.barrel_ents;
  foreach(var_6 in var_4) {
    var_7 = spawn("script_model", var_6.origin);
    var_7.angles = var_6.angles;
    var_7 setModel(var_2);
    var_6.fx_spot = var_7;
  }

  wait(1);
  var_9 = var_0;
  foreach(var_6 in var_4) {
    if(!isDefined(var_6.angles)) {
      var_6.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_1], var_6.origin, var_6.angles, var_9);
  }

  playsoundatpos(level.portal_gun.origin, "zmb_railgun_fire");
  wait(0.1);
  foreach(var_6 in var_4) {
    var_6.fx_spot delete();
  }

  playFX(level._effect[var_3], var_9);
  level.portal_gun radiusdamage(var_9, 100, 180, 180);
}

spawn_ammo_crate() {
  wait(1);
  var_0 = scripts\engine\utility::getstruct("ammo_crate_spawn", "targetname");
  var_0 = scripts\engine\utility::drop_to_ground(var_0.origin, 12, -100) + (0, 0, 1);
  var_1 = spawn("script_model", var_0);
  wait(1);
  var_1 setModel("tag_origin_ammo_crate");
}

rhino_ammo_crate_hint(var_0, var_1) {
  return "";
}

rhino_ammo_crate_act(var_0, var_1) {
  var_2 = var_1 scripts\cp\utility::getvalidtakeweapon();
  if(!issubstr(var_2, "venom")) {
    var_1 givemaxammo(var_2);
  }
}

fake_console_timer(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  show_console_to_activate();
  turn_on_spawners("spawner_1", undefined, 1);
  turn_on_spawners("spawner_2", undefined, 1);
  scripts\engine\utility::flag_set("consoles_ready");
  var_1 = scripts\engine\utility::random(level.players);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("rhino_area_console", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  while(level.rhino_consoles_activated < 3) {
    wait(0.1);
  }

  scripts\engine\utility::flag_set("all_buttons_pressed");
}

endless_wave() {
  level endon("all_buttons_pressed");
  level.current_num_spawned_enemies = 0;
  var_0 = 0;
  var_1 = 100000;
  var_2 = [1, 0.8, 0.65, 0.6];
  var_3 = [0.75, 0.65, 0.4, 0.35];
  var_4 = [14, 16, 18, 20];
  var_5 = var_4[level.players.size - 1];
  var_6 = int(0.75 * var_5);
  var_7 = [20, 25, 30, 30];
  var_8 = [1, 1, 2, 2];
  var_9 = 0;
  var_10 = 4;
  while(var_0 < var_1) {
    if(level.current_num_spawned_enemies < var_5) {
      var_11 = get_current_spawners();
      if(var_11.size > 0) {
        var_12 = scripts\engine\utility::random(var_11);
        if(var_9 < var_10 && var_0 > 15 && var_0 % 25 == 0 && level.rhino_array.size < var_8[level.players.size - 1]) {
          var_13 = spawn_rhino(var_12);
          if(isDefined(var_13)) {
            var_9++;
          }
        } else if(var_1 % 10 == 0) {
          var_13 = spawn_phantom(var_13);
        } else {
          var_13 = func_10719(var_13);
        }

        if(isDefined(var_13)) {
          var_0++;
        }
      }
    }

    if(var_0 < var_7[level.players.size - 1]) {
      wait(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_2[level.players.size - 1], int(var_2[level.players.size - 1] * 2)));
      continue;
    }

    wait(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_3[level.players.size - 1], int(var_3[level.players.size - 1] * 3)));
  }
}

emp_wave() {
  level endon("emp_done");
  level.current_num_spawned_enemies = 0;
  var_0 = 0;
  var_1 = 100000;
  var_2 = [0.75, 0.5, 0.3, 0.2];
  var_3 = [0.35, 0.25, 0.15, 0.1];
  var_4 = [16, 18, 21, 24];
  var_5 = var_4[level.players.size - 1];
  var_6 = [20, 25, 30, 30];
  var_7 = 0;
  var_8 = 6;
  var_9 = [1, 1, 2, 2];
  while(var_0 < var_1) {
    if(level.current_num_spawned_enemies < var_5) {
      update_emp_spawners();
      var_10 = get_current_spawners();
      if(var_10.size > 0) {
        var_11 = scripts\engine\utility::random(var_10);
        if(var_7 < var_8 && var_0 > 15 && var_0 % 25 == 0 && level.rhino_array.size < var_9[level.players.size - 1]) {
          var_12 = spawn_rhino(var_11);
          if(isDefined(var_12)) {
            var_7++;
          }
        } else if(var_1 % 10 == 0) {
          var_12 = spawn_phantom(var_12);
        } else {
          var_12 = func_10719(var_12);
        }

        if(isDefined(var_12)) {
          var_0++;
        }
      }
    }

    if(var_0 < var_6[level.players.size - 1]) {
      wait(var_2[level.players.size - 1]);
      continue;
    }

    wait(var_3[level.players.size - 1]);
  }
}

update_emp_spawners() {
  if(!isDefined(level.emp_charge)) {
    return;
  }

  if(level.emp_charge < 30) {
    turn_on_spawners("spawner_1");
    turn_off_spawners("spawner_2");
    return;
  }

  if(level.emp_charge < 60) {
    turn_on_spawners("spawner_2");
    turn_off_spawners("spawner_1");
    return;
  }

  if(level.emp_charge < 90) {
    turn_on_spawners("spawner_1");
    turn_off_spawners("spawner_2");
    return;
  }

  if(level.emp_charge < 120) {
    turn_on_spawners("spawner_2");
    turn_off_spawners("spawner_1");
    return;
  }

  turn_on_spawners("spawner_1");
  turn_on_spawners("spawner_2");
}

turn_off_spawners(var_0, var_1) {
  var_2 = getEntArray("rhino_console_screen", "targetname");
  var_3 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  foreach(var_5 in var_3) {
    var_5.portal_struct.fx setscriptablepartstate("portal", "off");
    var_5.var_19 = 0;
    if(isDefined(var_5.script_parameters)) {
      foreach(var_7 in var_2) {
        if(var_7.script_parameters == var_5.script_parameters) {
          var_7 show();
        }
      }
    }
  }

  if(isDefined(var_1)) {
    var_10 = scripts\engine\utility::getStructArray(var_1, "script_noteworthy");
    foreach(var_5 in var_10) {
      var_5.portal_struct.fx setscriptablepartstate("portal", "off");
      var_5.var_19 = 0;
      if(isDefined(var_5.script_parameters)) {
        foreach(var_7 in var_2) {
          if(var_7.script_parameters == var_5.script_parameters) {
            var_7 show();
          }
        }
      }
    }
  }
}

turn_on_spawners(var_0, var_1, var_2) {
  var_3 = getEntArray("rhino_console_screen", "targetname");
  var_4 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  foreach(var_6 in var_4) {
    var_6.portal_struct.fx setscriptablepartstate("portal", "cooldown");
    var_6.var_19 = 1;
    if(scripts\engine\utility::istrue(var_2) && isDefined(var_6.script_parameters)) {
      foreach(var_8 in var_3) {
        if(var_8.script_parameters == var_6.script_parameters) {
          var_8 hide();
        }
      }
    }
  }

  if(isDefined(var_1)) {
    var_11 = scripts\engine\utility::getStructArray(var_1, "script_noteworthy");
    foreach(var_6 in var_11) {
      var_6.portal_struct.fx setscriptablepartstate("portal", "cooldown");
      var_6.var_19 = 1;
      if(scripts\engine\utility::istrue(var_2) && isDefined(var_6.script_parameters)) {
        foreach(var_8 in var_3) {
          if(var_8.script_parameters == var_6.script_parameters) {
            var_8 hide();
          }
        }
      }
    }
  }
}

open_sentry_doors() {
  var_0 = scripts\engine\utility::getStructArray("rhino_sentry", "script_noteworthy");
  var_1 = "rhino_sentry_door";
  var_2 = getEntArray(var_1, "targetname");
  var_3 = aim_at_target(var_2[0]);
  wait(1);
  func_6D02(var_3);
  var_4 = scripts\engine\utility::getclosest(var_2[0].origin, var_0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  break_door(var_1);
  var_1 = "rhino_sentry_door_2";
  var_2 = getEntArray(var_1, "targetname");
  var_3 = aim_at_target(var_2[0]);
  wait(1);
  func_6D02(var_3);
  var_4 = scripts\engine\utility::getclosest(var_2[0].origin, var_0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
  break_door(var_1);
}

emp_defend() {
  level thread emp_wave();
  emp_charge(150);
  level waittill("emp_done");
}

emp_charge(var_0) {
  level.emp_console = getent("emp_console", "targetname");
  level.emp_console_clip = getent("emp_console_clip", "targetname");
  level.emp_console_clip solid();
  level.emp_console_clip makeentitysentient("allies", 0);
  level thread damage_monitor(level.emp_console, level.emp_console_clip);
  emp_charge_counter(var_0);
}

damage_monitor(var_0, var_1) {
  level endon("emp_charge_completed");
  var_0 endon("death");
  var_1 setCanDamage(1);
  var_1.health = 9999999;
  var_0.nextdamagetime = 0;
  for(;;) {
    var_1 waittill("damage", var_2, var_3);
    if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == "allies") {
      continue;
    }

    var_3 notify("speaker_attacked");
    var_4 = gettime();
    if(var_4 >= var_0.nextdamagetime) {
      var_0.nextdamagetime = var_4 + 1000;
      if(level.emp_charge > 1) {
        level.emp_charge--;
      }
    }
  }
}

emp_charge_counter(var_0) {
  var_1 = var_0;
  var_2 = var_0 / 100;
  var_3 = getEntArray("emp_console_timer", "targetname");
  var_4 = (3118, 2536, -133);
  var_5 = (0, 270, 52);
  var_3[0].origin = var_4;
  var_3[0].angles = var_5;
  setomnvar("zombie_venomxTimer", 99);
  setomnvar("zm_ui_venomx_timer_ent_4", var_3[0]);
  level.emp_charge = 99;
  while(level.emp_charge > 0) {
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      if(scripts\cp\zombies\zombie_afterlife_arcade::is_in_afterlife_arcade(level.players[0])) {
        wait(0.05);
        continue;
      }
    }

    wait(var_2);
    level.emp_charge--;
    level.emp_console playSound("zmb_wheel_spin_tick");
    setomnvar("zombie_venomxTimer", level.emp_charge);
  }

  wait(1);
  setomnvar("zombie_venomxTimer", -1);
  scripts\cp\maps\cp_final\cp_final_mpq::activateinteractionsbynoteworthy("emp_console");
  level notify("emp_charge_completed");
  playFXOnTag(level._effect["vfx_elec_console"], level.emp_console, "tag_origin");
  level.emp_console playLoopSound("trap_electric_on_lp");
}

turn_on_lights(var_0) {
  wait(var_0);
  var_1 = getEntArray("rhinofight", "script_noteworthy");
  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("lights", "on");
  }
}

turn_off_lights() {
  var_0 = getEntArray("rhinofight", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("lights", "off");
  }
}

turn_on_monitors() {
  level.currentneilstate = "angry";
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_0]);
  }
}

turn_off_monitors() {
  level.currentneilstate = "blank";
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_0]);
  }
}

debug_to_mammoth() {
  scripts\engine\utility::flag_wait("spawning_ready");
  scripts\engine\utility::flag_wait("laser_in_place");
  open_stage_1_area();
  open_stage_2_area();
  turn_off_lights();
  update_spawn_portals();
  release_mammoths();
}

release_mammoths() {
  level.dead_mammoths = 0;
  level.mammoth_spawn = 1;
  level.mammoth_fx = [];
  level.mammoth_spawned_fx = [];
  level.mammoth_spawned_fx_small = [];
  spawn_mammoth("mammoth_spawn", (0, 100, 0));
  spawn_mammoth("mammoth_spawn");
  level thread check_players_for_damage();
  var_0 = "mammoth_spawn_door_1";
  var_1 = getEntArray(var_0, "targetname");
  var_2 = aim_at_target(var_1[0]);
  wait(1);
  func_6D02(var_2);
  break_door(var_0);
  thread mammothwave();
  if(isDefined(level.target_laser_fx)) {
    level.target_laser_fx delete();
  }

  var_3 = scripts\engine\utility::random(level.players);
  var_3 thread scripts\cp\cp_vo::try_to_play_vo("rhino_behemoth_spawn", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
}

mammothwave() {
  level endon("disconnect");
  level endon("rhino_fight_over");
  wait(45);
  level.current_num_spawned_enemies = 0;
  var_0 = 0;
  var_1 = 100000;
  var_2 = [4, 3, 2, 1.5];
  var_3 = [2, 1.5, 1, 0.75];
  var_4 = [4, 6, 8, 10];
  var_5 = var_4[level.players.size - 1];
  var_6 = [10, 15, 20, 20];
  var_7 = [30, 30, 30, 30];
  var_8 = [2, 2, 2, 2];
  var_9 = [1, 2, 3, 8];
  var_10 = var_5;
  var_11 = [1, 1, 2, 2];
  var_12 = 0;
  var_13 = 6;
  while(var_0 < var_1) {
    if(level.dead_mammoths >= 1) {
      var_10 = var_5 + var_9[level.players.size - 1];
    }

    if(var_0 % var_10 == 0) {
      turn_off_spawners("spawner_1");
      turn_off_spawners("spawner_2");
      var_14 = 1;
      var_15 = 0;
      var_10 = 45;
      while(var_14 && level.current_num_spawned_enemies - level.rhino_array.size >= var_8[level.players.size - 1]) {
        wait(0.25);
        var_15 = var_15 + 0.25;
        if(var_15 >= var_10) {
          var_14 = 0;
        }
      }

      if(var_14) {
        wait(var_7[level.players.size - 1]);
      }
    }

    turn_on_spawners("spawner_1");
    turn_on_spawners("spawner_2");
    if(level.current_num_spawned_enemies < var_10) {
      update_emp_spawners();
      var_11 = get_current_spawners();
      if(var_11.size > 0) {
        var_12 = scripts\engine\utility::random(var_11);
        if(level.dead_mammoths >= 1 && var_0 % 10 == 0) {
          var_13 = spawn_phantom(var_12);
        } else {
          var_13 = func_10719(var_13);
        }

        if(isDefined(var_13)) {
          var_0++;
        }
      }
    }

    if(level.dead_mammoths < 1) {
      wait(var_2[level.players.size - 1]);
      continue;
    }

    wait(var_3[level.players.size - 1]);
  }
}

spawn_mammoth(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_3 = spawn_rhino(var_2);
  if(isDefined(var_1)) {
    var_3.origin = var_3.origin + var_1;
  }

  var_3.is_mammoth = 1;
  var_3.mammoth_health_threshold = 0.8;
  var_3 thread mammoth_hit_fx();
  level thread trigger_on_mammoth_death(var_3);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_behemouth");
}

trigger_on_mammoth_death(var_0) {
  level endon("game_ended");
  var_0 waittill("death");
  level.dead_mammoths++;
  if(level.dead_mammoths > 1) {
    if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level thread scripts\cp\zombies\direct_boss_fight::success_sequence(5, 5);
      return;
    }

    foreach(var_2 in level.spawned_enemies) {
      if(isDefined(var_2) && var_2.health >= 1) {
        var_2 dodamage(var_2.maxhealth, var_2.origin);
      }
    }

    level notify("rhino_fight_over");
    level thread kill_all_enemies(10);
    wait(5);
    rhino_fight_over();
  }
}

check_players_for_damage() {
  level endon("rhino_fight_over");
  level endon("game_ended");
  var_0 = 150;
  var_1 = var_0 * var_0;
  var_2 = 50;
  var_3 = var_2 * var_2;
  while(!isDefined(level.mammoth_spawned_fx) && !isDefined(level.mammoth_spawned_fx_small)) {
    wait(0.1);
  }

  for(;;) {
    if(isDefined(level.meph_fight_started)) {
      return;
    }

    if(level.mammoth_spawned_fx.size > 0) {
      foreach(var_5 in level.players) {
        if(isDefined(var_5.padding_damage)) {
          continue;
        }

        foreach(var_7 in level.mammoth_spawned_fx) {
          if(distancesquared(var_7, var_5.origin) < var_1) {
            var_8 = int(var_5.maxhealth / 4 + 5);
            var_5 dodamage(var_8, var_7);
            var_5.padding_damage = 1;
            var_5 thread remove_padding_damage();
            continue;
          }
        }
      }
    }

    if(level.mammoth_spawned_fx_small.size > 0) {
      foreach(var_5 in level.players) {
        if(isDefined(var_5.padding_damage)) {
          continue;
        }

        foreach(var_7 in level.mammoth_spawned_fx_small) {
          if(distancesquared(var_7, var_5.origin) < var_3) {
            var_8 = int(var_5.maxhealth / 4 + 5);
            var_5 dodamage(var_8, var_7);
            var_5.padding_damage = 1;
            var_5 thread remove_padding_damage();
            continue;
          }
        }
      }
    }

    wait(0.1);
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.25);
  if(isDefined(self)) {
    self.padding_damage = undefined;
  }
}

init_mammoth_fx_locs() {
  level.mammoth_ground_fx_large = [(3288.58, 3245.07, -176), (2788.94, 3244.93, -176), (2287.52, 3244.72, -176), (2882.71, 2657.93, -176), (3381.2, 2742.33, -176), (2387.39, 2743.31, -176), (2369.8, 2227.79, -176), (2873.93, 2134.09, -176), (3346.65, 2198.53, -176)];
  var_0 = [];
  var_0[var_0.size] = (3030.07, 2769.07, -176.001);
  var_0[var_0.size] = (2921.49, 2872.24, -176.001);
  var_0[var_0.size] = (2766.03, 2871.07, -176.001);
  var_0[var_0.size] = (2756.7, 2708.45, -176.001);
  var_0[var_0.size] = (2761.76, 2558.08, -176.001);
  var_0[var_0.size] = (2738.19, 2406.54, -176.001);
  var_0[var_0.size] = (2893.63, 2727.39, -176.001);
  var_0[var_0.size] = (3003.43, 2624.42, -176.001);
  var_0[var_0.size] = (2879.27, 2590.13, -176.001);
  var_0[var_0.size] = (3032.97, 2482.05, -176.001);
  var_0[var_0.size] = (2886.88, 2439.73, -176.001);
  var_0[var_0.size] = (2375.27, 2492.82, -176.001);
  var_0[var_0.size] = (2419.08, 2349.31, -176.001);
  var_0[var_0.size] = (2270.71, 2350.09, -176.001);
  var_0[var_0.size] = (2515.05, 2408.24, -176.001);
  var_0[var_0.size] = (2502.83, 2747.2, -176.001);
  var_0[var_0.size] = (2381.83, 2892.18, -176.001);
  var_0[var_0.size] = (2531.89, 2891.3, -176.001);
  var_0[var_0.size] = (2969.91, 3394.51, -176.001);
  var_0[var_0.size] = (2970.24, 3247.45, -176.001);
  var_0[var_0.size] = (3227.62, 3404.88, -176.001);
  var_0[var_0.size] = (3213.7, 3262.82, -176.001);
  var_0[var_0.size] = (3092.91, 3204.3, -176.001);
  var_0[var_0.size] = (2827, 3367.99, -176.001);
  var_0[var_0.size] = (2678.35, 3359.92, -176.001);
  var_0[var_0.size] = (2534.24, 3352.66, -176.001);
  var_0[var_0.size] = (2398.53, 3354.24, -176.001);
  var_0[var_0.size] = (2271.32, 3413.97, -176.001);
  var_0[var_0.size] = (2279.94, 3265.71, -176.001);
  var_0[var_0.size] = (2284, 3117.32, -176.001);
  var_0[var_0.size] = (2279.09, 2984.23, -176.001);
  var_0[var_0.size] = (2411.4, 3036.62, -176.001);
  var_0[var_0.size] = (2555.34, 3035.18, -176.001);
  var_0[var_0.size] = (2403.06, 3160.95, -176.001);
  var_0[var_0.size] = (2403.8, 3258.01, -176.001);
  var_0[var_0.size] = (2529.57, 3224.6, -176.001);
  var_0[var_0.size] = (2653.31, 3143.49, -176.001);
  var_0[var_0.size] = (2673.29, 3255.2, -176.001);
  var_0[var_0.size] = (2762.91, 3143.02, -176.001);
  var_0[var_0.size] = (2906.95, 3143.55, -176.001);
  var_0[var_0.size] = (3130.51, 3144.06, -176.001);
  var_0[var_0.size] = (3267.38, 3135.81, -176.001);
  var_0[var_0.size] = (3400.45, 3136.31, -176.001);
  var_0[var_0.size] = (3496.51, 3148.01, -176.001);
  var_0[var_0.size] = (3498.98, 3295.82, -176.001);
  var_0[var_0.size] = (3351.57, 3276.05, -176.001);
  var_0[var_0.size] = (3360.91, 3411.1, -176.001);
  var_0[var_0.size] = (3501.05, 3420.64, -176.001);
  var_0[var_0.size] = (3191.22, 3009.45, -176.001);
  var_0[var_0.size] = (3251.48, 2873.86, -176.001);
  var_0[var_0.size] = (3364.2, 2967.89, -176.001);
  var_0[var_0.size] = (3488.89, 2964.83, -176.001);
  var_0[var_0.size] = (3487.33, 2821.84, -176.001);
  var_0[var_0.size] = (3369.12, 2845.84, -176.001);
  var_0[var_0.size] = (3253.09, 2730.51, -176.001);
  var_0[var_0.size] = (3399.16, 2705.46, -176.001);
  var_0[var_0.size] = (3377.15, 2574.36, -176.001);
  var_0[var_0.size] = (3364.12, 2454.11, -176.001);
  var_0[var_0.size] = (3457.85, 2287.72, -176.001);
  var_0[var_0.size] = (3301.65, 2323.65, -176.001);
  var_0[var_0.size] = (3319.67, 2184.14, -176.001);
  var_0[var_0.size] = (3466.24, 2144.94, -176.001);
  var_0[var_0.size] = (3361.06, 2049.58, -176.001);
  var_0[var_0.size] = (3215.29, 2082.24, -176.001);
  var_0[var_0.size] = (3097.96, 2181.64, -176.001);
  var_0[var_0.size] = (3078.42, 2058.16, -176.001);
  var_0[var_0.size] = (2928.13, 2059.93, -176.001);
  var_0[var_0.size] = (2953.06, 2207.26, -176.001);
  var_0[var_0.size] = (2728.64, 2195.43, -176.001);
  var_0[var_0.size] = (2806.83, 2105.87, -176.001);
  var_0[var_0.size] = (2661.49, 2069.28, -176.001);
  var_0[var_0.size] = (2581.38, 2197.12, -176.001);
  var_0[var_0.size] = (2514.75, 2060.54, -176.001);
  var_0[var_0.size] = (2371.99, 2074.17, -176.001);
  var_0[var_0.size] = (2287.58, 2220.1, -176.001);
  var_0[var_0.size] = (2462.44, 2170.92, -176.001);
  var_0[var_0.size] = (2373.61, 2268.19, -176.001);
  var_0[var_0.size] = (2565.24, 2294.94, -68.4971);
  var_0[var_0.size] = (2705.31, 2287.48, -68.4971);
  var_0[var_0.size] = (2875.31, 2309.43, -68.0029);
  var_0[var_0.size] = (2610.78, 2435.22, -68.4971);
  var_0[var_0.size] = (2617.04, 2587.92, -68.3332);
  var_0[var_0.size] = (2271.18, 2754.35, -68.0029);
  var_0[var_0.size] = (2374.74, 2760.64, -68.0029);
  var_0[var_0.size] = (2260.24, 2866.3, -68.0029);
  var_0[var_0.size] = (3162.4, 2515.79, -70.998);
  var_0[var_0.size] = (3460.25, 2529.11, -36.998);
  var_0[var_0.size] = (3639.27, 2369, -16.0049);
  var_0[var_0.size] = (3644.49, 2504.91, -16.0049);
  var_0[var_0.size] = (3632.76, 2641.7, -16.0049);
  var_0[var_0.size] = (3628.13, 2782.45, 3.7342);
  var_0[var_0.size] = (3627.1, 2899.39, 4.52104);
  var_0[var_0.size] = (3633.45, 3007.63, -16.0049);
  var_0[var_0.size] = (3725.68, 3103.97, -16.0049);
  var_0[var_0.size] = (3726.87, 3249.61, -16.0049);
  var_0[var_0.size] = (3709.89, 3378.57, -16.0049);
  var_0[var_0.size] = (3573.11, 3397.37, -16.0049);
  var_0[var_0.size] = (3585.88, 3249.86, -16.0049);
  var_0[var_0.size] = (3597.91, 3114.22, -16.0049);
  level.mammoth_ground_fx_small = var_0;
  var_0 = [];
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (363.799, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (180, 0, 0);
  var_0[var_0.size] = (180, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  var_0[var_0.size] = (360, 0, 0);
  level.mammoth_ground_fx_small_ang = var_0;
}

mammoth_hit_fx() {
  self endon("death");
  level endon("mammoth_final");
  var_0 = -3036;
  var_1 = 0;
  var_2 = 1;
  while(var_2) {
    var_3 = 0;
    self waittill("mammoth_hit", var_4);
    if(self != var_4) {
      continue;
    }

    var_5 = self.origin;
    for(var_6 = 0; var_6 < level.mammoth_ground_fx_small.size; var_6++) {
      if(distancesquared(level.mammoth_ground_fx_small[var_6], var_5) < var_0) {
        if(!scripts\engine\utility::array_contains(level.mammoth_spawned_fx_small, level.mammoth_ground_fx_small[var_6])) {
          play_hit_fx();
          self.force_taunt = 1;
          var_7 = level.mammoth_ground_fx_small_ang[var_6];
          level thread trigger_mammoth_small_fx(level.mammoth_ground_fx_small[var_6], var_7);
          var_3 = 1;
          var_1++;
          if(var_1 > 15) {
            var_2 = 0;
          }

          break;
        }
      }
    }

    if(var_3) {
      self.health = self.maxhealth;
      continue;
    }

    self.health = int(self.maxhealth * 0.81);
  }

  self suicide();
}

rhino_fight_over() {
  level notify("rhino_fight_over");
  foreach(var_1 in level.mammoth_fx) {
    var_1 delete();
  }

  level thread delete_portal_models();
  level.no_loot_drop = undefined;
  restorelnfinteractions();
  stopcinematicforall();
  setDvar("bg_cinematicFullscreen", 1);
  preloadcinematicforall("sysload_o1");
  level thread delay_give_rewards();
  level notify("add_hidden_song_to_playlist");
  var_3 = scripts\cp\zombies\directors_cut::directors_cut_is_activated();
  foreach(var_5 in level.players) {
    if(scripts\engine\utility::istrue(var_5.inlaststand) || scripts\engine\utility::istrue(var_5.in_afterlife_arcade)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(var_5);
      var_5 notify("revive_success");
      if(isDefined(var_5.reviveent)) {
        var_5.reviveent notify("revive_success");
      }
    }

    if(scripts\cp\zombies\directors_cut::directors_cut_activated_for(var_5)) {
      var_5 thread scripts\cp\zombies\directors_cut::mark_talisman_possession(var_5);
    }

    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_5);
    scripts\cp\cp_vo::func_C9CB([var_5]);
    var_5 func_82C0("bink_fadeout_amb", 0.66);
    var_5 notify("force_cancel_placement");
  }

  scripts\cp\utility::play_bink_video("sysload_o1", 106, 1);
  wait(106.5);
  foreach(var_5 in level.players) {
    var_5 clearclienttriggeraudiozone(0.3);
  }

  if(var_3) {
    var_9 = 0;
    foreach(var_5 in level.players) {
      var_11 = var_5 getplayerdata("cp", "haveItems", "item_1");
      var_12 = var_5 getplayerdata("cp", "haveItems", "item_2");
      var_13 = var_5 getplayerdata("cp", "haveItems", "item_3");
      var_14 = var_5 getplayerdata("cp", "haveItems", "item_4");
      if(var_11 && var_12 && var_13 && var_14) {
        var_9 = 1;
      }
    }

    if(var_9) {
      level.zombies_paused = 1;
      level thread scripts\cp\maps\cp_final\cp_final_final_boss::start_boss_fight();
    } else {
      level thread resume_cp_final();
    }
  } else {
    level thread resume_cp_final();
  }

  setDvar("bg_cinematicFullscreen", 0);
  if(isDefined(level.rhino_lnf_fx)) {
    level.rhino_lnf_fx delete();
  }

  level.movie_playing = "cp_zmb_screen_640";
  preloadcinematicforall(level.movie_playing);
  playcinematicforalllooping(level.movie_playing);
  foreach(var_5 in level.players) {
    scripts\cp\cp_vo::func_12BE3([var_5]);
    var_5 scripts\cp\zombies\achievement::update_achievement("THE_END", 1);
  }

  level.pause_nag_vo = 0;
}

kill_all_enemies(var_0) {
  var_1 = 0;
  var_2 = 0.25;
  while(var_1 < var_0) {
    foreach(var_4 in level.spawned_enemies) {
      if(isDefined(var_4) && var_4.health >= 1) {
        var_4 dodamage(var_4.maxhealth, var_4.origin);
      }
    }

    var_1 = var_1 + var_2;
    wait(var_2);
  }
}

resume_cp_final() {
  level.getspawnpoint = scripts\cp\cp_globallogic::defaultgetspawnpoint;
  level.force_respawn_location = undefined;
  level.zombies_paused = undefined;
  level.specialroundcounter = level.oldspecialroundcounter;
  level.oldspecialroundcounter = undefined;
  scripts\engine\utility::flag_clear("pause_wave_progression");
  level.dont_resume_wave_after_solo_afterlife = undefined;
  var_0 = (3920, 7127, 250);
  var_1 = (358, 41, 0);
  var_2 = [50, -50, 50, -50];
  var_3 = [50, 50, -50, -50];
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    var_5 = (var_0[0] + var_2[var_4], var_0[1] + var_3[var_4], var_0[2]);
    level.players[var_4] setorigin(var_5);
    level.players[var_4] setplayerangles(var_1);
    level.players[var_4] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_4]);
  }

  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
}

delay_give_rewards() {
  level endon("game_ended");
  wait(34.15);
  scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_1 setplayerdata("cp", "haveSoulKeys", "soul_key_5", 1);
  }

  level thread eecompletevo();
  foreach(var_1 in level.players) {
    var_1 scripts\cp\utility::allow_player_teleport(1);
  }
}

eecompletevo() {
  wait(7);
  level thread scripts\cp\cp_vo::try_to_play_vo("conv_soul_key_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
}

play_hit_fx() {
  self endon("death");
  self setscriptablepartstate("laser_hit", "active");
  wait(1);
  self setscriptablepartstate("laser_hit", "off");
}

trigger_mammoth_large_fx(var_0) {
  level endon("rhino_fight_over");
  var_1 = spawn("script_model", var_0);
  level.mammoth_fx[level.mammoth_fx.size] = var_1;
  wait(0.1);
  var_1 setModel("tag_origin_rhino_flame_pool_large");
  wait(0.5);
  level.mammoth_spawned_fx[level.mammoth_spawned_fx.size] = var_0;
}

trigger_mammoth_small_fx(var_0, var_1) {
  level endon("rhino_fight_over");
  var_2 = spawn("script_model", var_0);
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  var_2.angles = var_1;
  level.mammoth_fx[level.mammoth_fx.size] = var_2;
  wait(0.1);
  var_2 setModel("tag_origin_rhino_flame_pool");
  wait(0.5);
  level.mammoth_spawned_fx_small[level.mammoth_spawned_fx_small.size] = var_0;
  var_3 = scripts\engine\utility::getclosest(var_0, level.mammoth_fx, 256);
  if(!isDefined(var_3)) {
    var_2 setscriptablepartstate("pool", "active");
  }
}

rhino_console_hint(var_0, var_1) {
  return "";
}

rhino_console_act(var_0, var_1) {
  level endon("all_buttons_pressed");
  if(!scripts\engine\utility::flag("rhino_stage_3") || scripts\engine\utility::flag("rhino_stage_4")) {
    return;
  }

  if(!scripts\engine\utility::flag("consoles_ready")) {
    return;
  }

  if(isDefined(var_0.activated)) {
    return;
  }

  var_0.activated = 1;
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_entangler_panels");
  var_2 = var_0.script_parameters;
  var_3 = scripts\engine\utility::getStructArray("goon_spawner", "targetname");
  foreach(var_5 in var_3) {
    if(var_5.script_parameters == var_2) {
      var_5.portal_struct.fx setscriptablepartstate("portal", "off");
      var_5.var_19 = 0;
    }
  }

  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "zmb_floppy_disc_insert");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level.rhino_consoles_activated++;
  var_7 = getEntArray("rhino_console_screen", "targetname");
  var_8 = scripts\engine\utility::getclosest(var_0.origin, var_7, 500);
  var_8 show();
  wait(20 / level.players.size);
  var_3 = scripts\engine\utility::getStructArray("goon_spawner", "targetname");
  foreach(var_5 in var_3) {
    if(var_5.script_parameters == var_2) {
      var_5.portal_struct.fx setscriptablepartstate("portal", "cooldown");
      var_5.var_19 = 1;
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  level.rhino_consoles_activated--;
  var_0.activated = undefined;
  var_8 hide();
}

rhino_sentry_hint(var_0, var_1) {
  return "";
}

rhino_sentry_act(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.iscarrying)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.linked_to_coaster)) {
    return;
  }

  if(isDefined(var_1.allow_carry) && var_1.allow_carry == 0) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_1 thread scripts\cp\cp_weapon_autosentry::givesentry("crafted_autosentry");
  }

  var_2 = getEntArray("rhino_sentry_model", "targetname");
  var_2 = sortbydistance(var_2, var_0.origin);
  var_2[0] delete();
}

init_rk_candy_interactions() {
  level.num_crates_broken = 0;
  level.available_crate_perks = scripts\engine\utility::array_randomize_objects(["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"]);
  var_0 = scripts\engine\utility::getStructArray("perk_candy_box", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

turn_on_perk_boxes() {
  var_0 = scripts\engine\utility::getStructArray("perk_candy_box", "script_noteworthy");
  foreach(var_2 in var_0) {
    createperkboxes(var_2);
  }
}

createperkboxes(var_0) {
  var_1 = var_0;
  var_2 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_3 = scripts\engine\utility::random(var_2);
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_3);
  var_4 = spawn("script_model", var_1.origin);
  if(isDefined(var_1.angles)) {
    var_4.angles = var_1.angles;
  }

  var_4 setModel("tag_origin_rk_perks");
  var_1.model = var_4;
  var_1.perk = var_3;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  switch (var_3) {
    case "perk_machine_fwoosh":
      var_4 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_4 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_4 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_4 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_4 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_4 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_4 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_4 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_4 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_4 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_4 setscriptablepartstate("effects", "neutral");
      break;
  }
}

perkbox_usefunc(var_0, var_1) {
  var_1 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_0.perk, 0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_0.model hidefromplayer(var_1);
  var_1 playlocalsound("part_pickup");
  if(!isDefined(var_0.respawn_flag)) {
    var_0.respawn_flag = 1;
    level.num_crates_broken++;
    var_2 = level.num_crates_broken * 0.05;
    level.available_crate_perks[level.available_crate_perks.size] = var_0.perk;
    var_0 thread restockperkafternextrelic(var_0, var_1, var_2);
  }
}

restockperkafternextrelic(var_0, var_1, var_2) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_timeout(180, "create_perk_boxes");
  var_0.respawn_flag = undefined;
  level.num_crates_broken = 0;
  wait(var_2);
  var_3 = var_0.model;
  var_4 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_5 = scripts\engine\utility::random(var_4);
  var_0.perk = var_5;
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_5);
  switch (var_5) {
    case "perk_machine_fwoosh":
      var_3 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_3 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_3 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_3 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_3 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_3 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_3 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_3 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_3 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_3 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_3 setscriptablepartstate("effects", "neutral");
      break;
  }

  foreach(var_7 in level.players) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_7);
    var_0.model showtoplayer(var_7);
  }
}

perkbox_hintfunc(var_0, var_1) {
  if(!isDefined(var_0.perk)) {
    return "";
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 4) {
    return "";
  }

  if(var_1 scripts\cp\utility::has_zombie_perk(var_0.perk)) {
    return "";
  }

  level thread perkbox_usefunc(var_0, var_1);
  return "";
}

perkboxuse(var_0, var_1) {}

init_rh_neil_monitors() {
  while(!isDefined(level.current_personal_interaction_structs)) {
    wait(0.1);
  }

  var_0 = scripts\engine\utility::getStructArray("rhino_neil_monitors", "script_noteworthy");
  level.special_mode_activation_funcs["rhino_neil_monitors"] = ::setrhinoneilstatepent;
  level.normal_mode_activation_funcs["rhino_neil_monitors"] = ::setrhinoneilstatepent;
  foreach(var_2 in var_0) {
    scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(var_2);
  }
}

setrhinoneilstatepent(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = getmodelfromstruct(var_1);
  switch (level.currentneilstate) {
    case "happy":
      var_0 setModel(var_5 + "_happy");
      break;

    case "angry":
      var_0 setModel(var_5 + "_angry");
      break;

    case "blank":
      var_0 setModel("cp_final_monitor_large_screen_black");
      break;

    default:
      var_0 setModel("cp_final_monitor_large_screen_black");
      break;
  }

  if(!isDefined(var_3.neil_monitors)) {
    var_3.neil_monitors = [];
  }

  if(!scripts\engine\utility::array_contains(var_3.neil_monitors, var_0)) {
    var_3.neil_monitors[var_3.neil_monitors.size] = var_0;
  }
}

show_console_to_activate() {
  var_0 = getEntArray("rhino_console_screen", "targetname");
  foreach(var_2 in var_0) {
    update_neil_face_model("cp_final_monitor_large_screen_happy", var_2.origin);
  }
}

update_neil_face_model(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_4 = scripts\engine\utility::getclosest(var_1, var_3.neil_monitors);
    var_4 setModel(var_0);
  }
}

getmodelfromstruct(var_0) {
  if(isDefined(var_0.script_label)) {
    return var_0.script_label;
  }

  return "cp_final_monitor_large_screen_black";
}

setuplnfinteractions() {
  var_0 = scripts\engine\utility::getStructArray("lost_and_found", "script_noteworthy");
  var_1 = undefined;
  foreach(var_3 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
    if(isDefined(var_3.name) && var_3.name == "rhino_fight") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
      var_1 = var_3;
    }
  }

  var_1.origin = (3100.5, 2760, -176);
  level.rhino_lnf_fx = spawnfx(level._effect["rhino_lnf"], var_1.origin + (10, 0, 0), anglesToForward((0, 180, 0)), anglestoup((0, 180, 0)));
  foreach(var_6 in level.players) {
    if(!isDefined(var_6.lost_and_found_ent)) {
      continue;
    }

    var_6.lost_and_found_ent.origin = var_1.origin;
  }

  triggerfx(level.rhino_lnf_fx);
}

restorelnfinteractions() {
  var_0 = scripts\engine\utility::getStructArray("lost_and_found", "script_noteworthy");
  var_1 = undefined;
  foreach(var_3 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
    if(isDefined(var_3.name) && var_3.name == "rhino_fight") {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
      continue;
    }

    var_1 = var_3;
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6.lost_and_found_ent)) {
      continue;
    }

    var_6.lost_and_found_ent.origin = var_1.origin + (0, 0, 45);
  }
}

empconsolehint(var_0, var_1) {
  return &"CP_FINAL_ACTIVATE_RITUAL_CIRCLE";
}

empconsoleuse(var_0, var_1) {
  stopFXOnTag(level._effect["vfx_elec_console"], level.emp_console, "tag_origin");
  level.emp_console stoploopsound();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level notify("emp_done");
  var_2 = (3146, 2538, -176);
  playFX(level._effect["rhino_emp"], var_2);
  playsoundatpos(var_2, "emp_grenade_explode_default");
  foreach(var_4 in level.spawned_enemies) {
    var_4 dodamage(var_4.health, var_2);
  }

  wait(0.1);
  playsoundatpos(var_2, "zmb_emp_poweroff");
  var_6 = getEntArray("rhino_sentry_model", "targetname");
  foreach(var_8 in var_6) {
    var_8 notify("death");
  }

  scripts\cp\maps\cp_final\cp_final_mpq::deactivateinteractionsbynoteworthy("rhino_sentry");
  foreach(var_4 in level.players) {
    var_4 notify("force_cancel_placement");
  }
}

killingtimevalidation(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.is_mammoth)) {
    return 0;
  }

  return 1;
}