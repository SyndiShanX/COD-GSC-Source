/************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = spawnStruct();
  var_00.origin = (3082.96, 2541.72, -175.928);
  var_00.angles = (0, -0.0219727, 0);
  var_00.script_noteworthy = "emp_console";
  var_00.var_336 = "interaction";
  var_00.requires_power = 0;
  var_00.powered_on = 1;
  var_00.script_parameters = "default";
  level.struct_class_names["targetname"]["interaction"][level.struct_class_names["targetname"]["interaction"].size] = var_00;
  level.struct_class_names["script_noteworthy"]["emp_console"][0] = var_00;
}

rh_boss_stepregistration() {
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("Rhino Boss", 0, ::blank, ::blank, ::blank, ::dbg_start_rhino, 0, "MPQ Quest Step Description");
}

blankusefunc(param_00, param_01) {}

blankhintfunc(param_00, param_01) {
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
  var_00 = scripts\engine\utility::getstructarray("rhino_sentry", "script_noteworthy");
  var_01 = "rhino_sentry_door";
  var_02 = getEntArray(var_01, "targetname");
  var_03 = scripts\engine\utility::getclosest(var_02[0].origin, var_00);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
  var_01 = "rhino_sentry_door_2";
  var_02 = getEntArray(var_01, "targetname");
  var_03 = scripts\engine\utility::getclosest(var_02[0].origin, var_00);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
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
  foreach(var_01 in level.players) {
    var_01 scripts\cp\utility::allow_player_teleport(0);
  }

  level notify("start_rhino_fight");
}

move_players_to_rhino_fight() {
  level.currentneilstate = "angry";
  var_00 = (2896, 2868, -68);
  var_01 = (4, 270, 0);
  var_02 = [50, -50, 50, -50];
  var_03 = [50, 50, -50, -50];
  for(var_04 = 0; var_04 < level.players.size; var_04++) {
    var_05 = (var_00[0] + var_02[var_04], var_00[1] + var_03[var_04], var_00[2]);
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level.players[var_04] setorigin(var_05);
      level.players[var_04] setplayerangles(var_01);
    }

    level.players[var_04] scripts\cp\utility::removedamagemodifier("papRoom", 0);
    level.players[var_04].is_off_grid = undefined;
    level.players[var_04].kicked_out = undefined;
    level.players[var_04].is_in_pap = 0;
    level.players[var_04] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_04]);
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
  var_00 = [(2698.5, 2388.44, -175.876), (0, 54.2883, 0)];
  var_01 = [(3048.75, 2407.74, -175.876), (0, 119.261, 0)];
  var_02 = [(2936.27, 2897.63, -175.876), (0, -106.134, 0)];
  var_03 = [(2721.7, 2900.75, -175.876), (0, -59.1894, 0)];
  var_04 = [(2635.3, 2622.89, -167.775), (0, -0.0610256, 0)];
  var_05 = [(3073.27, 2802.28, -175.876), (0, -141.4, 0)];
  level.startingrespawnpoints = [var_00, var_01, var_02, var_03, var_04, var_05];
  level.force_respawn_location = ::respawn_in_rhino_fight;
  level.getspawnpoint = ::respawn_in_rhino_fight;
}

rhino_boss_fight_vo() {
  wait(7);
  var_00 = scripts\engine\utility::random(level.players);
  if(isDefined(var_00.vo_prefix)) {
    switch (var_00.vo_prefix) {
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
  var_00 = ["iw7_crdb_zm", "iw7_g18_zmr", "iw7_m4_zmr", "iw7_arclassic_zmr"];
  var_01 = ["iw7_minilmg_zm", "iw7_lmg03_zm", "iw7_mauler_zm", "iw7_unsalmg_zm"];
  var_02 = ["perk_machine_revive", "perk_machine_zap", "perk_machine_tough", "perk_machine_flash", "perk_machine_rat_a_tat"];
  var_03 = ["perk_machine_revive", "perk_machine_boom", "perk_machine_tough", "perk_machine_flash", "perk_machine_rat_a_tat"];
  foreach(var_05 in level.players) {
    var_06 = randomint(var_01.size);
    var_07 = randomint(var_00.size);
    var_05 takeweapon(var_05 scripts\cp\utility::getvalidtakeweapon());
    var_08 = scripts\cp\utility::getrawbaseweaponname(var_01[var_06]);
    if(isDefined(var_05.weapon_build_models[var_08])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_05.weapon_build_models[var_08]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_01[var_06]);
    }

    var_09 = scripts\cp\utility::getrawbaseweaponname(var_00[var_07]);
    if(isDefined(var_05.weapon_build_models[var_09])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_05.weapon_build_models[var_09]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_01[var_06]);
    }

    var_05.total_currency_earned = min(10000, var_05 scripts\cp\cp_persistence::get_player_max_currency());
    var_05 scripts\cp\cp_persistence::set_player_currency(10000);
    if(issubstr(var_08, "_g18_")) {
      foreach(var_0B in var_03) {
        var_05 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_0B, 1);
      }
    } else {
      foreach(var_0B in var_02) {
        var_05 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_0B, 1);
      }
    }

    var_05.consumable_meter = var_05.consumable_meter_max;
    var_05 notify("consumable_charge", 0);
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
  scripts\engine\utility::flag_set("completepuzzles_step4");
}

respawn_in_rhino_fight(param_00) {
  if(!scripts\engine\utility::flag("rhino_stage_3")) {
    var_01 = level.startingrespawnpoints;
    var_01 = scripts\engine\utility::array_randomize(var_01);
    var_02 = spawnStruct();
    foreach(var_04 in var_01) {
      if(canspawn(var_04[0]) && !positionwouldtelefrag(var_04[0])) {
        var_02.origin = var_04[0];
        var_02.angles = var_04[1];
        return var_02;
      }
    }

    var_02.origin = var_01[0][0];
    var_02.angles = var_01[0][1];
    return var_02;
  }

  var_01 = scripts\engine\utility::getstructarray("rhino_boss_spawn_loc", "targetname");
  var_05 = scripts\engine\utility::array_randomize(var_05);
  var_02 = spawnStruct();
  foreach(var_06 in var_04) {
    if(canspawn(var_06.origin) && !positionwouldtelefrag(var_06.origin)) {
      var_04.origin = var_06.origin;
      var_04.angles = (0, 90, 0);
      return var_04;
    }
  }

  var_04.origin = var_03[0].origin;
  var_04.angles = (0, 90, 0);
  return var_04;
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
  var_00 = scripts\engine\utility::getstruct("rhino_turret_idle", "targetname");
  aim_at_target(var_00);
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
  var_00 = [];
  var_01 = scripts\engine\utility::getstructarray("goon_spawner", "targetname");
  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  var_01 = scripts\engine\utility::getstructarray("rhino_sentry", "script_noteworthy");
  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  var_01 = scripts\engine\utility::getstructarray("rhino_console", "targetname");
  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  var_00 = scripts\engine\utility::array_randomize(var_00);
  var_02 = 0;
  while(var_02 < 8) {
    var_03 = aim_at_target(var_00[var_02]);
    func_6D02(var_03);
    var_02++;
    wait(0.1);
  }

  var_04 = "rhino_emp_door";
  var_05 = getEntArray(var_04, "targetname");
  var_03 = aim_at_target(var_05[0]);
  wait(1);
  func_6D02(var_03);
  break_door(var_04);
  level thread open_sentry_doors();
  wait(5);
  emp_defend();
}

stage_6() {
  turn_off_lights();
  turn_off_monitors();
  turn_off_spawners("spawner_1", "spawner_2");
  var_00 = scripts\engine\utility::getstruct("rhino_turret_broken", "targetname");
  aim_at_target(var_00);
  scripts\engine\utility::flag_set("rhino_stage_5");
  level notify("create_perk_boxes");
  wait(5);
  release_mammoths();
}

init_door_clip() {
  var_00 = ["rhino_door_stage_1", "rhino_door_stage_2", "rhino_spawn_door_1", "rhino_spawn_door_2", "rhino_spawn_door_3", "rhino_spawn_door_4", "mammoth_spawn_door_1"];
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02, "targetname");
    foreach(var_05 in var_03) {
      wait(0.1);
    }
  }

  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02 + "_clip", "targetname");
    foreach(var_05 in var_03) {
      var_05 func_95B5();
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
  var_00 = getEntArray("rhino_door_stage_2_clip", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.nav_id)) {
      destroynavobstacle(var_02.nav_id);
    }

    var_02 notsolid();
  }

  var_04 = "death_ray_cannon_rock_impact";
  var_00 = getEntArray("rhino_door_stage_2", "targetname");
  foreach(var_02 in var_00) {
    playsoundatpos(var_02.origin, "zmb_rhino_door_explo");
    playFX(level._effect[var_04], var_02.origin);
    var_02 delete();
  }

  var_00 = getEntArray("stage_3_bollard", "targetname");
  foreach(var_02 in var_00) {
    var_02 movez(-34, 2, 0.1, 0.1);
  }
}

listen_for_rhino_trigger() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  waitforplayersnearby();
  wait(5);
  level.zombies_paused = 1;
  foreach(var_01 in level.spawned_enemies) {
    if(isalive(var_01)) {
      var_01.died_poorly = 1;
      var_01 suicide();
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
  var_00 = scripts\engine\utility::getstructarray("initial_rhino_spawn", "targetname");
  var_01 = var_00[0].origin;
  var_02 = 150;
  var_03 = var_02 * var_02;
  var_04 = 0;
  while(!var_04) {
    foreach(var_06 in level.players) {
      if(distance2dsquared(var_01, var_06.origin) < var_03) {
        var_04 = 1;
      }
    }

    wait(0.1);
  }
}

spawn_initial_rhino() {
  scripts\engine\utility::flag_wait("laser_in_place");
  var_00 = ["initial_rhino_spawn", "initial_rhino_spawn_2"];
  var_01 = ["rhino_spawn_door_1", "rhino_spawn_door_2"];
  var_02 = randomint(2);
  var_03 = spawn_starting_rhino(var_00[var_02], var_01[var_02]);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(10);
  var_02 = scripts\engine\utility::ter_op(var_02 == 1, 0, 1);
  spawn_starting_rhino(var_00[var_02], var_01[var_02]);
  var_04 = scripts\engine\utility::random(level.players);
  var_04 thread scripts\cp\cp_vo::try_to_play_vo("rhino_2", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(10);
  var_05 = ["initial_rhino_spawn_3", "initial_rhino_spawn_4"];
  var_06 = ["rhino_spawn_door_3", "rhino_spawn_door_4"];
  var_02 = randomint(2);
  spawn_starting_rhino(var_05[var_02], var_06[var_02]);
  var_04 = scripts\engine\utility::random(level.players);
  var_04 thread scripts\cp\cp_vo::try_to_play_vo("rhino_3", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  wait(5);
  var_02 = scripts\engine\utility::ter_op(var_02 == 1, 0, 1);
  spawn_starting_rhino(var_05[var_02], var_06[var_02]);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_rhino");
  scripts\engine\utility::flag_set("init_rhinos_spawned");
  var_07 = scripts\engine\utility::getstruct("rhino_turret_idle", "targetname");
  aim_at_target(var_07);
}

spawn_starting_rhino(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct(param_00, "targetname");
  var_03 = var_02.origin;
  var_04 = var_02.angles;
  var_05 = "axis";
  var_06 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_rhino", var_03, var_04, var_05);
  var_06 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_rhino");
  var_06.scripted_mode = 1;
  var_06.nodamage = 1;
  var_06 thread rhino_audio_monitor();
  level thread track_rhino_deaths(var_06);
  var_07 = getEntArray(param_01, "targetname");
  var_08 = aim_at_target(var_07[0]);
  func_6D02(var_08);
  break_door(param_01);
  var_06.scripted_mode = 0;
  var_06.nodamage = undefined;
}

init_cargo_doors() {
  var_00 = ["rhino_spawn_door_1", "rhino_spawn_door_2", "rhino_spawn_door_3", "rhino_spawn_door_4"];
  foreach(var_02 in var_00) {
    var_03 = getEntArray(var_02 + "_clip", "targetname");
    foreach(var_05 in var_03) {
      var_05 func_95B5();
      wait(0.1);
    }
  }
}

func_95B5() {
  self.nav_id = createnavobstaclebyent(self);
}

break_door(param_00) {
  var_01 = "death_ray_cannon_rock_impact";
  var_02 = getEntArray(param_00, "targetname");
  foreach(var_04 in var_02) {
    playsoundatpos(var_04.origin, "zmb_rhino_door_explo");
    playFX(level._effect[var_01], var_04.origin);
    var_04 delete();
  }

  var_02 = getEntArray(param_00 + "_clip", "targetname");
  var_06 = scripts\engine\utility::getclosest((2897, 2313, -26), var_02, 250);
  foreach(var_04 in var_02) {
    if(param_00 == "rhino_sentry_door") {
      if(var_04 == var_06) {
        continue;
      }
    }

    if(isDefined(var_04.nav_id)) {
      destroynavobstacle(var_04.nav_id);
    }

    var_04 notsolid();
    var_04 hide();
  }
}

track_rhino_deaths(param_00) {
  level endon("rhino_fight_over");
  level.rhino_array[level.rhino_array.size] = param_00;
  param_00 waittill("death");
  level.rhino_array = scripts\engine\utility::array_remove(level.rhino_array, param_00);
}

func_1071B() {
  level.current_num_spawned_enemies = 0;
  var_00 = 0;
  var_01 = [40, 60, 80, 100];
  var_01 = var_01[level.players.size - 1];
  var_02 = [16, 20, 24, 24];
  var_03 = [1.25, 0.75, 0.5, 0.35];
  var_04 = var_02[level.players.size - 1];
  while(var_00 < var_01) {
    if(level.current_num_spawned_enemies < var_04) {
      var_05 = get_current_spawners();
      if(var_05.size > 0) {
        var_06 = scripts\engine\utility::random(var_05);
        var_07 = func_10719(var_06);
        if(isDefined(var_07)) {
          var_00++;
        }
      }
    }

    wait(var_03[level.players.size - 1]);
  }

  while(level.current_num_spawned_enemies > 0) {
    wait(0.1);
  }
}

get_current_spawners() {
  var_00 = scripts\engine\utility::getstructarray("spawner_1", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray("spawner_2", "script_noteworthy");
  var_00 = scripts\engine\utility::array_combine(var_00, var_01);
  var_02 = [];
  foreach(var_04 in var_00) {
    if(scripts\engine\utility::istrue(var_04.var_19)) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

update_spawn_portals() {
  var_00 = scripts\engine\utility::getstructarray("spawner_1", "script_noteworthy");
  var_00 = scripts\engine\utility::array_randomize(var_00);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(!isDefined(var_00[var_01].target)) {
      continue;
    }

    var_02 = scripts\engine\utility::getstruct(var_00[var_01].target, "targetname");
    if(!isDefined(var_02.angles)) {
      var_02.angles = (0, 0, 0);
    }

    if(!isDefined(var_02.fx)) {
      var_03 = var_02.origin;
      var_02.fx = spawn("script_model", var_03 + (0, 0, 50));
      var_02.fx.angles = var_02.angles + (0, 90, 0);
      wait(0.1);
      var_02.fx setModel("tag_origin_final_rhino_portal");
      var_00[var_01].portal_struct = var_02;
      wait(0.5);
    }
  }

  var_00 = scripts\engine\utility::getstructarray("spawner_2", "script_noteworthy");
  var_00 = scripts\engine\utility::array_randomize(var_00);
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(!isDefined(var_00[var_01].target)) {
      continue;
    }

    var_02 = scripts\engine\utility::getstruct(var_00[var_01].target, "targetname");
    if(!isDefined(var_02.angles)) {
      var_02.angles = (0, 0, 0);
    }

    if(!isDefined(var_02.fx)) {
      var_03 = var_02.origin;
      var_02.fx = spawn("script_model", var_03 + (0, 0, 50));
      var_02.fx.angles = var_02.angles + (0, 90, 0);
      wait(0.1);
      var_02.fx setModel("tag_origin_final_rhino_portal");
      var_00[var_01].portal_struct = var_02;
      wait(0.5);
    }
  }
}

delete_portal_models() {
  var_00 = scripts\engine\utility::getstructarray("spawner_1", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.portal_struct) && isDefined(var_02.portal_struct.fx)) {
      var_02.portal_struct.fx delete();
    }
  }

  var_00 = scripts\engine\utility::getstructarray("spawner_2", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.portal_struct) && isDefined(var_02.portal_struct.fx)) {
      var_02.portal_struct.fx delete();
    }
  }
}

portal_spawn_fx(param_00, param_01) {
  playFX(level._effect["vfx_zmb_portal_exit_burst"], param_00, param_01);
}

func_10719(param_00) {
  var_01 = param_00.origin + (0, 0, 10);
  var_02 = param_00.angles;
  var_03 = "axis";
  var_04 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_goon", var_01, var_02, var_03);
  if(isDefined(var_04)) {
    portal_spawn_fx(param_00.origin, param_00.angles);
    var_04 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_goon");
  }

  return var_04;
}

spawn_phantoms() {
  level.current_num_spawned_enemies = 0;
  var_00 = get_current_spawners();
  var_01 = 0;
  var_02 = [25, 40, 50, 60];
  var_02 = var_02[level.players.size - 1];
  var_03 = [1, 0.75, 0.5, 0.5];
  var_04 = [12, 15, 18, 18];
  var_05 = var_04[level.players.size - 1];
  while(var_01 < var_02) {
    if(level.current_num_spawned_enemies < var_05) {
      if(var_00.size > 0) {
        var_06 = scripts\engine\utility::random(var_00);
        if(var_01 % 5 == 0) {
          var_07 = spawn_phantom(var_06);
        } else {
          var_07 = func_10719(var_07);
        }

        if(isDefined(var_07)) {
          var_01++;
        }
      }
    }

    wait(var_03[level.players.size - 1]);
  }

  while(level.current_num_spawned_enemies > 0) {
    wait(0.1);
  }
}

spawn_phantom(param_00) {
  var_01 = param_00.origin + (0, 0, 10);
  var_02 = param_00.angles;
  var_03 = "axis";
  var_04 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_phantom", var_01, var_02, var_03);
  if(isDefined(var_04)) {
    portal_spawn_fx(param_00.origin, param_00.angles);
    var_04 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_phantom");
  }

  return var_04;
}

spawn_rhino(param_00) {
  var_01 = param_00.origin;
  var_02 = param_00.angles;
  var_03 = "axis";
  var_04 = scripts\cp\zombies\zombies_spawning::func_13F53("alien_rhino", var_01, var_02, var_03);
  if(isDefined(var_04)) {
    portal_spawn_fx(param_00.origin, param_00.angles);
    level thread track_rhino_deaths(var_04);
    var_04 thread scripts\cp\zombies\zombies_spawning::func_64E7("alien_rhino");
    var_04 thread rhino_audio_monitor();
    var_05 = scripts\engine\utility::random(level.players);
    var_05 thread scripts\cp\cp_vo::try_to_play_vo("rhino_spawn", "final_comment_vo", "high", 5, 1, 0, 0, 100);
  }

  return var_04;
}

rhino_audio_monitor() {
  level endon("game_ended");
  self endon("death");
  self.voprefix = "queen_";
  thread scripts\cp\zombies\zombies_vo::play_zombie_death_vo(self.voprefix);
  self.playing_stumble = 0;
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_timeout_1(3, "attack_hit_big", "attack_hit_small", "taunt", "charge_start", "charge_to_stop");
    switch (var_00) {
      case "attack_hit_big":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "attack_pounding_third", 0);
        break;

      case "attack_hit_small":
        var_01 = scripts\engine\utility::random(["attack_pounding", "attack_pounding_second"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_01, 0);
        break;

      case "taunt":
        var_01 = scripts\engine\utility::random(["posture_1", "posture_2"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_01, 0);
        break;

      case "charge_start":
        var_01 = scripts\engine\utility::random(["charge_start", "charge_start_v2", "charge_start_v3"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_01, 0);
        break;

      case "charge_to_stop":
        var_01 = scripts\engine\utility::random(["charge_to_stop"]);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, var_01, 0);
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
  var_00 = "death_ray_cannon_beam";
  var_01 = level.portal_gun.barrel_ents;
  var_02 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  level thread play_laser_fx();
  for(;;) {
    var_03 = undefined;
    var_04 = var_01[0];
    var_05 = level.portal_gun.angles;
    var_06 = anglesToForward(var_05);
    var_06 = vectornormalize(var_06);
    var_07 = var_04.origin + var_06 * 2000;
    var_08 = scripts\engine\utility::array_add(level.players, level.portal_gun);
    var_03 = physics_raycast(var_04.origin, var_07, var_02, var_08, 0, "physicsquery_closest");
    if(isDefined(var_03) && isarray(var_03) && var_03.size > 0) {
      var_09 = var_03[0]["position"];
      level.portal_gun.laser_node_end.origin = var_09;
    }

    scripts\engine\utility::waitframe();
  }
}

play_laser_fx(param_00) {
  wait(1);
  foreach(var_02 in level.players) {
    level.target_laser_fx = playfxontagsbetweenclients(level._effect["target_laser"], level.portal_gun.laser_node_start, "tag_origin", level.portal_gun.laser_node_end, "tag_origin", var_02);
  }
}

make_laser_angry() {
  if(isDefined(level.target_laser_fx)) {
    level.target_laser_fx delete();
  }

  foreach(var_01 in level.players) {
    level.target_laser_fx = playfxontagsbetweenclients(level._effect["target_laser_angry"], level.portal_gun.laser_node_start, "tag_origin", level.portal_gun.laser_node_end, "tag_origin", var_01);
  }
}

aim_and_fire_laser() {
  level endon("rhino_fight_over");
  level endon("stop_firing");
  make_laser_angry();
  var_00 = scripts\engine\utility::random(level.players);
  var_00 thread scripts\cp\cp_vo::try_to_play_vo("rhino_laser_target", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  for(;;) {
    var_01 = get_target();
    if(isDefined(var_01)) {
      var_02 = aim_at_target(var_01);
      wait(1);
      func_6D02(var_02);
    }

    wait(1);
  }
}

get_target() {
  var_00 = level.players;
  var_01 = undefined;
  for(var_02 = 0; !var_02; var_02 = 1) {
    if(var_00.size < 1) {
      break;
    }

    var_01 = scripts\engine\utility::random(var_00);
    if(!var_01 scripts\cp\utility::is_valid_player()) {
      var_00 = scripts\engine\utility::array_remove(var_00, var_01);
      var_01 = undefined;
      continue;
    }
  }

  return var_01;
}

aim_at_target(param_00) {
  var_01 = 3;
  var_02 = param_00.origin;
  if(isDefined(param_00.target)) {
    param_00 = scripts\engine\utility::getstruct(param_00.target, "targetname");
    var_02 = param_00.origin;
  }

  var_03 = param_00.origin - level.portal_gun.origin;
  var_04 = vectortoangles(var_03);
  var_05 = scripts\engine\utility::anglebetweenvectors(level.portal_gun.origin, var_03);
  var_06 = var_05 / 180;
  var_07 = var_01 * var_06;
  level.portal_gun rotateto(var_04, var_07);
  level.portal_gun waittill("rotatedone");
  playsoundatpos(level.portal_gun.origin, "zmb_cannon_charge_up");
  var_02 = level.portal_gun.laser_node_end.origin;
  return var_02;
}

func_6D02(param_00) {
  var_01 = "death_ray_cannon_beam";
  var_02 = "tag_origin_laser_ray_fx";
  var_03 = "death_ray_cannon_rock_impact";
  var_04 = level.portal_gun.barrel_ents;
  foreach(var_06 in var_04) {
    var_07 = spawn("script_model", var_06.origin);
    var_07.angles = var_06.angles;
    var_07 setModel(var_02);
    var_06.fx_spot = var_07;
  }

  wait(1);
  var_09 = param_00;
  foreach(var_06 in var_04) {
    if(!isDefined(var_06.angles)) {
      var_06.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_01], var_06.origin, var_06.angles, var_09);
  }

  playsoundatpos(level.portal_gun.origin, "zmb_railgun_fire");
  wait(0.1);
  foreach(var_06 in var_04) {
    var_06.fx_spot delete();
  }

  playFX(level._effect[var_03], var_09);
  level.portal_gun radiusdamage(var_09, 100, 180, 180);
}

spawn_ammo_crate() {
  wait(1);
  var_00 = scripts\engine\utility::getstruct("ammo_crate_spawn", "targetname");
  var_00 = scripts\engine\utility::drop_to_ground(var_00.origin, 12, -100) + (0, 0, 1);
  var_01 = spawn("script_model", var_00);
  wait(1);
  var_01 setModel("tag_origin_ammo_crate");
}

rhino_ammo_crate_hint(param_00, param_01) {
  return "";
}

rhino_ammo_crate_act(param_00, param_01) {
  var_02 = param_01 scripts\cp\utility::getvalidtakeweapon();
  if(!issubstr(var_02, "venom")) {
    param_01 givemaxammo(var_02);
  }
}

fake_console_timer(param_00) {
  if(isDefined(param_00)) {
    wait(param_00);
  }

  show_console_to_activate();
  turn_on_spawners("spawner_1", undefined, 1);
  turn_on_spawners("spawner_2", undefined, 1);
  scripts\engine\utility::flag_set("consoles_ready");
  var_01 = scripts\engine\utility::random(level.players);
  var_01 thread scripts\cp\cp_vo::try_to_play_vo("rhino_area_console", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
  while(level.rhino_consoles_activated < 3) {
    wait(0.1);
  }

  scripts\engine\utility::flag_set("all_buttons_pressed");
}

endless_wave() {
  level endon("all_buttons_pressed");
  level.current_num_spawned_enemies = 0;
  var_00 = 0;
  var_01 = 100000;
  var_02 = [1, 0.8, 0.65, 0.6];
  var_03 = [0.75, 0.65, 0.4, 0.35];
  var_04 = [14, 16, 18, 20];
  var_05 = var_04[level.players.size - 1];
  var_06 = int(0.75 * var_05);
  var_07 = [20, 25, 30, 30];
  var_08 = [1, 1, 2, 2];
  var_09 = 0;
  var_0A = 4;
  while(var_00 < var_01) {
    if(level.current_num_spawned_enemies < var_05) {
      var_0B = get_current_spawners();
      if(var_0B.size > 0) {
        var_0C = scripts\engine\utility::random(var_0B);
        if(var_09 < var_0A && var_00 > 15 && var_00 % 25 == 0 && level.rhino_array.size < var_08[level.players.size - 1]) {
          var_0D = spawn_rhino(var_0C);
          if(isDefined(var_0D)) {
            var_09++;
          }
        } else if(var_01 % 10 == 0) {
          var_0D = spawn_phantom(var_0D);
        } else {
          var_0D = func_10719(var_0D);
        }

        if(isDefined(var_0D)) {
          var_00++;
        }
      }
    }

    if(var_00 < var_07[level.players.size - 1]) {
      wait(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_02[level.players.size - 1], int(var_02[level.players.size - 1] * 2)));
      continue;
    }

    wait(scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_03[level.players.size - 1], int(var_03[level.players.size - 1] * 3)));
  }
}

emp_wave() {
  level endon("emp_done");
  level.current_num_spawned_enemies = 0;
  var_00 = 0;
  var_01 = 100000;
  var_02 = [0.75, 0.5, 0.3, 0.2];
  var_03 = [0.35, 0.25, 0.15, 0.1];
  var_04 = [16, 18, 21, 24];
  var_05 = var_04[level.players.size - 1];
  var_06 = [20, 25, 30, 30];
  var_07 = 0;
  var_08 = 6;
  var_09 = [1, 1, 2, 2];
  while(var_00 < var_01) {
    if(level.current_num_spawned_enemies < var_05) {
      update_emp_spawners();
      var_0A = get_current_spawners();
      if(var_0A.size > 0) {
        var_0B = scripts\engine\utility::random(var_0A);
        if(var_07 < var_08 && var_00 > 15 && var_00 % 25 == 0 && level.rhino_array.size < var_09[level.players.size - 1]) {
          var_0C = spawn_rhino(var_0B);
          if(isDefined(var_0C)) {
            var_07++;
          }
        } else if(var_01 % 10 == 0) {
          var_0C = spawn_phantom(var_0C);
        } else {
          var_0C = func_10719(var_0C);
        }

        if(isDefined(var_0C)) {
          var_00++;
        }
      }
    }

    if(var_00 < var_06[level.players.size - 1]) {
      wait(var_02[level.players.size - 1]);
      continue;
    }

    wait(var_03[level.players.size - 1]);
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

turn_off_spawners(param_00, param_01) {
  var_02 = getEntArray("rhino_console_screen", "targetname");
  var_03 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_05 in var_03) {
    var_05.portal_struct.fx setscriptablepartstate("portal", "off");
    var_05.var_19 = 0;
    if(isDefined(var_05.script_parameters)) {
      foreach(var_07 in var_02) {
        if(var_07.script_parameters == var_05.script_parameters) {
          var_07 show();
        }
      }
    }
  }

  if(isDefined(param_01)) {
    var_0A = scripts\engine\utility::getstructarray(param_01, "script_noteworthy");
    foreach(var_05 in var_0A) {
      var_05.portal_struct.fx setscriptablepartstate("portal", "off");
      var_05.var_19 = 0;
      if(isDefined(var_05.script_parameters)) {
        foreach(var_07 in var_02) {
          if(var_07.script_parameters == var_05.script_parameters) {
            var_07 show();
          }
        }
      }
    }
  }
}

turn_on_spawners(param_00, param_01, param_02) {
  var_03 = getEntArray("rhino_console_screen", "targetname");
  var_04 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_06 in var_04) {
    var_06.portal_struct.fx setscriptablepartstate("portal", "cooldown");
    var_06.var_19 = 1;
    if(scripts\engine\utility::istrue(param_02) && isDefined(var_06.script_parameters)) {
      foreach(var_08 in var_03) {
        if(var_08.script_parameters == var_06.script_parameters) {
          var_08 hide();
        }
      }
    }
  }

  if(isDefined(param_01)) {
    var_0B = scripts\engine\utility::getstructarray(param_01, "script_noteworthy");
    foreach(var_06 in var_0B) {
      var_06.portal_struct.fx setscriptablepartstate("portal", "cooldown");
      var_06.var_19 = 1;
      if(scripts\engine\utility::istrue(param_02) && isDefined(var_06.script_parameters)) {
        foreach(var_08 in var_03) {
          if(var_08.script_parameters == var_06.script_parameters) {
            var_08 hide();
          }
        }
      }
    }
  }
}

open_sentry_doors() {
  var_00 = scripts\engine\utility::getstructarray("rhino_sentry", "script_noteworthy");
  var_01 = "rhino_sentry_door";
  var_02 = getEntArray(var_01, "targetname");
  var_03 = aim_at_target(var_02[0]);
  wait(1);
  func_6D02(var_03);
  var_04 = scripts\engine\utility::getclosest(var_02[0].origin, var_00);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_04);
  break_door(var_01);
  var_01 = "rhino_sentry_door_2";
  var_02 = getEntArray(var_01, "targetname");
  var_03 = aim_at_target(var_02[0]);
  wait(1);
  func_6D02(var_03);
  var_04 = scripts\engine\utility::getclosest(var_02[0].origin, var_00);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_04);
  break_door(var_01);
}

emp_defend() {
  level thread emp_wave();
  emp_charge(150);
  level waittill("emp_done");
}

emp_charge(param_00) {
  level.emp_console = getent("emp_console", "targetname");
  level.emp_console_clip = getent("emp_console_clip", "targetname");
  level.emp_console_clip solid();
  level.emp_console_clip makeentitysentient("allies", 0);
  level thread damage_monitor(level.emp_console, level.emp_console_clip);
  emp_charge_counter(param_00);
}

damage_monitor(param_00, param_01) {
  level endon("emp_charge_completed");
  param_00 endon("death");
  param_01 setCanDamage(1);
  param_01.health = 9999999;
  param_00.nextdamagetime = 0;
  for(;;) {
    param_01 waittill("damage", var_02, var_03);
    if(isDefined(var_03) && isDefined(var_03.team) && var_03.team == "allies") {
      continue;
    }

    var_03 notify("speaker_attacked");
    var_04 = gettime();
    if(var_04 >= param_00.nextdamagetime) {
      param_00.nextdamagetime = var_04 + 1000;
      if(level.emp_charge > 1) {
        level.emp_charge--;
      }
    }
  }
}

emp_charge_counter(param_00) {
  var_01 = param_00;
  var_02 = param_00 / 100;
  var_03 = getEntArray("emp_console_timer", "targetname");
  var_04 = (3118, 2536, -133);
  var_05 = (0, 270, 52);
  var_03[0].origin = var_04;
  var_03[0].angles = var_05;
  setomnvar("zombie_venomxTimer", 99);
  setomnvar("zm_ui_venomx_timer_ent_4", var_03[0]);
  level.emp_charge = 99;
  while(level.emp_charge > 0) {
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      if(scripts\cp\zombies\zombie_afterlife_arcade::is_in_afterlife_arcade(level.players[0])) {
        wait(0.05);
        continue;
      }
    }

    wait(var_02);
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

turn_on_lights(param_00) {
  wait(param_00);
  var_01 = getEntArray("rhinofight", "script_noteworthy");
  foreach(var_03 in var_01) {
    var_03 setscriptablepartstate("lights", "on");
  }
}

turn_off_lights() {
  var_00 = getEntArray("rhinofight", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lights", "off");
  }
}

turn_on_monitors() {
  level.currentneilstate = "angry";
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    level.players[var_00] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_00]);
  }
}

turn_off_monitors() {
  level.currentneilstate = "blank";
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    level.players[var_00] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_00]);
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
  var_00 = "mammoth_spawn_door_1";
  var_01 = getEntArray(var_00, "targetname");
  var_02 = aim_at_target(var_01[0]);
  wait(1);
  func_6D02(var_02);
  break_door(var_00);
  thread mammothwave();
  if(isDefined(level.target_laser_fx)) {
    level.target_laser_fx delete();
  }

  var_03 = scripts\engine\utility::random(level.players);
  var_03 thread scripts\cp\cp_vo::try_to_play_vo("rhino_behemoth_spawn", "final_comment_vo", "highest", 5, 1, 0, 0, 100);
}

mammothwave() {
  level endon("disconnect");
  level endon("rhino_fight_over");
  wait(45);
  level.current_num_spawned_enemies = 0;
  var_00 = 0;
  var_01 = 100000;
  var_02 = [4, 3, 2, 1.5];
  var_03 = [2, 1.5, 1, 0.75];
  var_04 = [4, 6, 8, 10];
  var_05 = var_04[level.players.size - 1];
  var_06 = [10, 15, 20, 20];
  var_07 = [30, 30, 30, 30];
  var_08 = [2, 2, 2, 2];
  var_09 = [1, 2, 3, 8];
  var_0A = var_05;
  var_0B = [1, 1, 2, 2];
  var_0C = 0;
  var_0D = 6;
  while(var_00 < var_01) {
    if(level.dead_mammoths >= 1) {
      var_0A = var_05 + var_09[level.players.size - 1];
    }

    if(var_00 % var_0A == 0) {
      turn_off_spawners("spawner_1");
      turn_off_spawners("spawner_2");
      var_0E = 1;
      var_0F = 0;
      var_10 = 45;
      while(var_0E && level.current_num_spawned_enemies - level.rhino_array.size >= var_08[level.players.size - 1]) {
        wait(0.25);
        var_0F = var_0F + 0.25;
        if(var_0F >= var_10) {
          var_0E = 0;
        }
      }

      if(var_0E) {
        wait(var_07[level.players.size - 1]);
      }
    }

    turn_on_spawners("spawner_1");
    turn_on_spawners("spawner_2");
    if(level.current_num_spawned_enemies < var_0A) {
      update_emp_spawners();
      var_11 = get_current_spawners();
      if(var_11.size > 0) {
        var_12 = scripts\engine\utility::random(var_11);
        if(level.dead_mammoths >= 1 && var_00 % 10 == 0) {
          var_13 = spawn_phantom(var_12);
        } else {
          var_13 = func_10719(var_13);
        }

        if(isDefined(var_13)) {
          var_00++;
        }
      }
    }

    if(level.dead_mammoths < 1) {
      wait(var_02[level.players.size - 1]);
      continue;
    }

    wait(var_03[level.players.size - 1]);
  }
}

spawn_mammoth(param_00, param_01) {
  var_02 = scripts\engine\utility::getstruct(param_00, "targetname");
  var_03 = spawn_rhino(var_02);
  if(isDefined(param_01)) {
    var_03.origin = var_03.origin + param_01;
  }

  var_03.is_mammoth = 1;
  var_03.mammoth_health_threshold = 0.8;
  var_03 thread mammoth_hit_fx();
  level thread trigger_on_mammoth_death(var_03);
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_release_behemouth");
}

trigger_on_mammoth_death(param_00) {
  level endon("game_ended");
  param_00 waittill("death");
  level.dead_mammoths++;
  if(level.dead_mammoths > 1) {
    if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      level thread scripts\cp\zombies\direct_boss_fight::success_sequence(5, 5);
      return;
    }

    foreach(var_02 in level.spawned_enemies) {
      if(isDefined(var_02) && var_02.health >= 1) {
        var_02 dodamage(var_02.maxhealth, var_02.origin);
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
  var_00 = 150;
  var_01 = var_00 * var_00;
  var_02 = 50;
  var_03 = var_02 * var_02;
  while(!isDefined(level.mammoth_spawned_fx) && !isDefined(level.mammoth_spawned_fx_small)) {
    wait(0.1);
  }

  for(;;) {
    if(isDefined(level.meph_fight_started)) {
      return;
    }

    if(level.mammoth_spawned_fx.size > 0) {
      foreach(var_05 in level.players) {
        if(isDefined(var_05.padding_damage)) {
          continue;
        }

        foreach(var_07 in level.mammoth_spawned_fx) {
          if(distancesquared(var_07, var_05.origin) < var_01) {
            var_08 = int(var_05.maxhealth / 4 + 5);
            var_05 dodamage(var_08, var_07);
            var_05.padding_damage = 1;
            var_05 thread remove_padding_damage();
            continue;
          }
        }
      }
    }

    if(level.mammoth_spawned_fx_small.size > 0) {
      foreach(var_05 in level.players) {
        if(isDefined(var_05.padding_damage)) {
          continue;
        }

        foreach(var_07 in level.mammoth_spawned_fx_small) {
          if(distancesquared(var_07, var_05.origin) < var_03) {
            var_08 = int(var_05.maxhealth / 4 + 5);
            var_05 dodamage(var_08, var_07);
            var_05.padding_damage = 1;
            var_05 thread remove_padding_damage();
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
  var_00 = [];
  var_00[var_00.size] = (3030.07, 2769.07, -176.001);
  var_00[var_00.size] = (2921.49, 2872.24, -176.001);
  var_00[var_00.size] = (2766.03, 2871.07, -176.001);
  var_00[var_00.size] = (2756.7, 2708.45, -176.001);
  var_00[var_00.size] = (2761.76, 2558.08, -176.001);
  var_00[var_00.size] = (2738.19, 2406.54, -176.001);
  var_00[var_00.size] = (2893.63, 2727.39, -176.001);
  var_00[var_00.size] = (3003.43, 2624.42, -176.001);
  var_00[var_00.size] = (2879.27, 2590.13, -176.001);
  var_00[var_00.size] = (3032.97, 2482.05, -176.001);
  var_00[var_00.size] = (2886.88, 2439.73, -176.001);
  var_00[var_00.size] = (2375.27, 2492.82, -176.001);
  var_00[var_00.size] = (2419.08, 2349.31, -176.001);
  var_00[var_00.size] = (2270.71, 2350.09, -176.001);
  var_00[var_00.size] = (2515.05, 2408.24, -176.001);
  var_00[var_00.size] = (2502.83, 2747.2, -176.001);
  var_00[var_00.size] = (2381.83, 2892.18, -176.001);
  var_00[var_00.size] = (2531.89, 2891.3, -176.001);
  var_00[var_00.size] = (2969.91, 3394.51, -176.001);
  var_00[var_00.size] = (2970.24, 3247.45, -176.001);
  var_00[var_00.size] = (3227.62, 3404.88, -176.001);
  var_00[var_00.size] = (3213.7, 3262.82, -176.001);
  var_00[var_00.size] = (3092.91, 3204.3, -176.001);
  var_00[var_00.size] = (2827, 3367.99, -176.001);
  var_00[var_00.size] = (2678.35, 3359.92, -176.001);
  var_00[var_00.size] = (2534.24, 3352.66, -176.001);
  var_00[var_00.size] = (2398.53, 3354.24, -176.001);
  var_00[var_00.size] = (2271.32, 3413.97, -176.001);
  var_00[var_00.size] = (2279.94, 3265.71, -176.001);
  var_00[var_00.size] = (2284, 3117.32, -176.001);
  var_00[var_00.size] = (2279.09, 2984.23, -176.001);
  var_00[var_00.size] = (2411.4, 3036.62, -176.001);
  var_00[var_00.size] = (2555.34, 3035.18, -176.001);
  var_00[var_00.size] = (2403.06, 3160.95, -176.001);
  var_00[var_00.size] = (2403.8, 3258.01, -176.001);
  var_00[var_00.size] = (2529.57, 3224.6, -176.001);
  var_00[var_00.size] = (2653.31, 3143.49, -176.001);
  var_00[var_00.size] = (2673.29, 3255.2, -176.001);
  var_00[var_00.size] = (2762.91, 3143.02, -176.001);
  var_00[var_00.size] = (2906.95, 3143.55, -176.001);
  var_00[var_00.size] = (3130.51, 3144.06, -176.001);
  var_00[var_00.size] = (3267.38, 3135.81, -176.001);
  var_00[var_00.size] = (3400.45, 3136.31, -176.001);
  var_00[var_00.size] = (3496.51, 3148.01, -176.001);
  var_00[var_00.size] = (3498.98, 3295.82, -176.001);
  var_00[var_00.size] = (3351.57, 3276.05, -176.001);
  var_00[var_00.size] = (3360.91, 3411.1, -176.001);
  var_00[var_00.size] = (3501.05, 3420.64, -176.001);
  var_00[var_00.size] = (3191.22, 3009.45, -176.001);
  var_00[var_00.size] = (3251.48, 2873.86, -176.001);
  var_00[var_00.size] = (3364.2, 2967.89, -176.001);
  var_00[var_00.size] = (3488.89, 2964.83, -176.001);
  var_00[var_00.size] = (3487.33, 2821.84, -176.001);
  var_00[var_00.size] = (3369.12, 2845.84, -176.001);
  var_00[var_00.size] = (3253.09, 2730.51, -176.001);
  var_00[var_00.size] = (3399.16, 2705.46, -176.001);
  var_00[var_00.size] = (3377.15, 2574.36, -176.001);
  var_00[var_00.size] = (3364.12, 2454.11, -176.001);
  var_00[var_00.size] = (3457.85, 2287.72, -176.001);
  var_00[var_00.size] = (3301.65, 2323.65, -176.001);
  var_00[var_00.size] = (3319.67, 2184.14, -176.001);
  var_00[var_00.size] = (3466.24, 2144.94, -176.001);
  var_00[var_00.size] = (3361.06, 2049.58, -176.001);
  var_00[var_00.size] = (3215.29, 2082.24, -176.001);
  var_00[var_00.size] = (3097.96, 2181.64, -176.001);
  var_00[var_00.size] = (3078.42, 2058.16, -176.001);
  var_00[var_00.size] = (2928.13, 2059.93, -176.001);
  var_00[var_00.size] = (2953.06, 2207.26, -176.001);
  var_00[var_00.size] = (2728.64, 2195.43, -176.001);
  var_00[var_00.size] = (2806.83, 2105.87, -176.001);
  var_00[var_00.size] = (2661.49, 2069.28, -176.001);
  var_00[var_00.size] = (2581.38, 2197.12, -176.001);
  var_00[var_00.size] = (2514.75, 2060.54, -176.001);
  var_00[var_00.size] = (2371.99, 2074.17, -176.001);
  var_00[var_00.size] = (2287.58, 2220.1, -176.001);
  var_00[var_00.size] = (2462.44, 2170.92, -176.001);
  var_00[var_00.size] = (2373.61, 2268.19, -176.001);
  var_00[var_00.size] = (2565.24, 2294.94, -68.4971);
  var_00[var_00.size] = (2705.31, 2287.48, -68.4971);
  var_00[var_00.size] = (2875.31, 2309.43, -68.0029);
  var_00[var_00.size] = (2610.78, 2435.22, -68.4971);
  var_00[var_00.size] = (2617.04, 2587.92, -68.3332);
  var_00[var_00.size] = (2271.18, 2754.35, -68.0029);
  var_00[var_00.size] = (2374.74, 2760.64, -68.0029);
  var_00[var_00.size] = (2260.24, 2866.3, -68.0029);
  var_00[var_00.size] = (3162.4, 2515.79, -70.998);
  var_00[var_00.size] = (3460.25, 2529.11, -36.998);
  var_00[var_00.size] = (3639.27, 2369, -16.0049);
  var_00[var_00.size] = (3644.49, 2504.91, -16.0049);
  var_00[var_00.size] = (3632.76, 2641.7, -16.0049);
  var_00[var_00.size] = (3628.13, 2782.45, 3.7342);
  var_00[var_00.size] = (3627.1, 2899.39, 4.52104);
  var_00[var_00.size] = (3633.45, 3007.63, -16.0049);
  var_00[var_00.size] = (3725.68, 3103.97, -16.0049);
  var_00[var_00.size] = (3726.87, 3249.61, -16.0049);
  var_00[var_00.size] = (3709.89, 3378.57, -16.0049);
  var_00[var_00.size] = (3573.11, 3397.37, -16.0049);
  var_00[var_00.size] = (3585.88, 3249.86, -16.0049);
  var_00[var_00.size] = (3597.91, 3114.22, -16.0049);
  level.mammoth_ground_fx_small = var_00;
  var_00 = [];
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (363.799, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (180, 0, 0);
  var_00[var_00.size] = (180, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  var_00[var_00.size] = (360, 0, 0);
  level.mammoth_ground_fx_small_ang = var_00;
}

mammoth_hit_fx() {
  self endon("death");
  level endon("mammoth_final");
  var_00 = -3036;
  var_01 = 0;
  var_02 = 1;
  while(var_02) {
    var_03 = 0;
    self waittill("mammoth_hit", var_04);
    if(self != var_04) {
      continue;
    }

    var_05 = self.origin;
    for(var_06 = 0; var_06 < level.mammoth_ground_fx_small.size; var_06++) {
      if(distancesquared(level.mammoth_ground_fx_small[var_06], var_05) < var_00) {
        if(!scripts\engine\utility::array_contains(level.mammoth_spawned_fx_small, level.mammoth_ground_fx_small[var_06])) {
          play_hit_fx();
          self.force_taunt = 1;
          var_07 = level.mammoth_ground_fx_small_ang[var_06];
          level thread trigger_mammoth_small_fx(level.mammoth_ground_fx_small[var_06], var_07);
          var_03 = 1;
          var_01++;
          if(var_01 > 15) {
            var_02 = 0;
          }

          break;
        }
      }
    }

    if(var_03) {
      self.health = self.maxhealth;
      continue;
    }

    self.health = int(self.maxhealth * 0.81);
  }

  self suicide();
}

rhino_fight_over() {
  level notify("rhino_fight_over");
  foreach(var_01 in level.mammoth_fx) {
    var_01 delete();
  }

  level thread delete_portal_models();
  level.no_loot_drop = undefined;
  restorelnfinteractions();
  stopcinematicforall();
  setdvar("bg_cinematicFullscreen", 1);
  preloadcinematicforall("sysload_o1");
  level thread delay_give_rewards();
  level notify("add_hidden_song_to_playlist");
  var_03 = scripts\cp\zombies\directors_cut::directors_cut_is_activated();
  foreach(var_05 in level.players) {
    if(scripts\engine\utility::istrue(var_05.inlaststand) || scripts\engine\utility::istrue(var_05.in_afterlife_arcade)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(var_05);
      var_05 notify("revive_success");
      if(isDefined(var_05.reviveent)) {
        var_05.reviveent notify("revive_success");
      }
    }

    if(scripts\cp\zombies\directors_cut::directors_cut_activated_for(var_05)) {
      var_05 thread scripts\cp\zombies\directors_cut::mark_talisman_possession(var_05);
    }

    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_05);
    scripts\cp\cp_vo::func_C9CB([var_05]);
    var_05 _meth_82C0("bink_fadeout_amb", 0.66);
    var_05 notify("force_cancel_placement");
  }

  scripts\cp\utility::play_bink_video("sysload_o1", 106, 1);
  wait(106.5);
  foreach(var_05 in level.players) {
    var_05 clearclienttriggeraudiozone(0.3);
  }

  if(var_03) {
    var_09 = 0;
    foreach(var_05 in level.players) {
      var_0B = var_05 getplayerdata("cp", "haveItems", "item_1");
      var_0C = var_05 getplayerdata("cp", "haveItems", "item_2");
      var_0D = var_05 getplayerdata("cp", "haveItems", "item_3");
      var_0E = var_05 getplayerdata("cp", "haveItems", "item_4");
      if(var_0B && var_0C && var_0D && var_0E) {
        var_09 = 1;
      }
    }

    if(var_09) {
      level.zombies_paused = 1;
      level thread scripts\cp\maps\cp_final\cp_final_final_boss::start_boss_fight();
    } else {
      level thread resume_cp_final();
    }
  } else {
    level thread resume_cp_final();
  }

  setdvar("bg_cinematicFullscreen", 0);
  if(isDefined(level.rhino_lnf_fx)) {
    level.rhino_lnf_fx delete();
  }

  level.movie_playing = "cp_zmb_screen_640";
  preloadcinematicforall(level.movie_playing);
  playcinematicforalllooping(level.movie_playing);
  foreach(var_05 in level.players) {
    scripts\cp\cp_vo::func_12BE3([var_05]);
    var_05 scripts\cp\zombies\achievement::update_achievement("THE_END", 1);
  }

  level.pause_nag_vo = 0;
}

kill_all_enemies(param_00) {
  var_01 = 0;
  var_02 = 0.25;
  while(var_01 < param_00) {
    foreach(var_04 in level.spawned_enemies) {
      if(isDefined(var_04) && var_04.health >= 1) {
        var_04 dodamage(var_04.maxhealth, var_04.origin);
      }
    }

    var_01 = var_01 + var_02;
    wait(var_02);
  }
}

resume_cp_final() {
  level.getspawnpoint = ::scripts\cp\cp_globallogic::defaultgetspawnpoint;
  level.force_respawn_location = undefined;
  level.zombies_paused = undefined;
  level.specialroundcounter = level.oldspecialroundcounter;
  level.oldspecialroundcounter = undefined;
  scripts\engine\utility::flag_clear("pause_wave_progression");
  level.dont_resume_wave_after_solo_afterlife = undefined;
  var_00 = (3920, 7127, 250);
  var_01 = (358, 41, 0);
  var_02 = [50, -50, 50, -50];
  var_03 = [50, 50, -50, -50];
  for(var_04 = 0; var_04 < level.players.size; var_04++) {
    var_05 = (var_00[0] + var_02[var_04], var_00[1] + var_03[var_04], var_00[2]);
    level.players[var_04] setorigin(var_05);
    level.players[var_04] setplayerangles(var_01);
    level.players[var_04] thread scripts\cp\maps\cp_final\cp_final::update_special_mode_for_player(level.players[var_04]);
  }

  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\maps\cp_final\cp_final::enablepa("pa_facility");
}

delay_give_rewards() {
  level endon("game_ended");
  wait(34.15);
  scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
  foreach(var_01 in level.players) {
    var_01 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_01 setplayerdata("cp", "haveSoulKeys", "soul_key_5", 1);
  }

  level thread eecompletevo();
  foreach(var_01 in level.players) {
    var_01 scripts\cp\utility::allow_player_teleport(1);
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

trigger_mammoth_large_fx(param_00) {
  level endon("rhino_fight_over");
  var_01 = spawn("script_model", param_00);
  level.mammoth_fx[level.mammoth_fx.size] = var_01;
  wait(0.1);
  var_01 setModel("tag_origin_rhino_flame_pool_large");
  wait(0.5);
  level.mammoth_spawned_fx[level.mammoth_spawned_fx.size] = param_00;
}

trigger_mammoth_small_fx(param_00, param_01) {
  level endon("rhino_fight_over");
  var_02 = spawn("script_model", param_00);
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  var_02.angles = param_01;
  level.mammoth_fx[level.mammoth_fx.size] = var_02;
  wait(0.1);
  var_02 setModel("tag_origin_rhino_flame_pool");
  wait(0.5);
  level.mammoth_spawned_fx_small[level.mammoth_spawned_fx_small.size] = param_00;
  var_03 = scripts\engine\utility::getclosest(param_00, level.mammoth_fx, 256);
  if(!isDefined(var_03)) {
    var_02 setscriptablepartstate("pool", "active");
  }
}

rhino_console_hint(param_00, param_01) {
  return "";
}

rhino_console_act(param_00, param_01) {
  level endon("all_buttons_pressed");
  if(!scripts\engine\utility::flag("rhino_stage_3") || scripts\engine\utility::flag("rhino_stage_4")) {
    return;
  }

  if(!scripts\engine\utility::flag("consoles_ready")) {
    return;
  }

  if(isDefined(param_00.activated)) {
    return;
  }

  param_00.activated = 1;
  scripts\cp\maps\cp_final\cp_final_mpq::playneilvo("final_n31l_evil_entangler_panels");
  var_02 = param_00.script_parameters;
  var_03 = scripts\engine\utility::getstructarray("goon_spawner", "targetname");
  foreach(var_05 in var_03) {
    if(var_05.script_parameters == var_02) {
      var_05.portal_struct.fx setscriptablepartstate("portal", "off");
      var_05.var_19 = 0;
    }
  }

  scripts\cp\utility::playsoundatpos_safe(param_00.origin, "zmb_floppy_disc_insert");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level.rhino_consoles_activated++;
  var_07 = getEntArray("rhino_console_screen", "targetname");
  var_08 = scripts\engine\utility::getclosest(param_00.origin, var_07, 500);
  var_08 show();
  wait(20 / level.players.size);
  var_03 = scripts\engine\utility::getstructarray("goon_spawner", "targetname");
  foreach(var_05 in var_03) {
    if(var_05.script_parameters == var_02) {
      var_05.portal_struct.fx setscriptablepartstate("portal", "cooldown");
      var_05.var_19 = 1;
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  level.rhino_consoles_activated--;
  param_00.activated = undefined;
  var_08 hide();
}

rhino_sentry_hint(param_00, param_01) {
  return "";
}

rhino_sentry_act(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.iscarrying)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_01.linked_to_coaster)) {
    return;
  }

  if(isDefined(param_01.allow_carry) && param_01.allow_carry == 0) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(param_01 scripts\cp\utility::is_valid_player()) {
    param_01 thread scripts\cp\cp_weapon_autosentry::givesentry("crafted_autosentry");
  }

  var_02 = getEntArray("rhino_sentry_model", "targetname");
  var_02 = sortbydistance(var_02, param_00.origin);
  var_02[0] delete();
}

init_rk_candy_interactions() {
  level.num_crates_broken = 0;
  level.available_crate_perks = scripts\engine\utility::array_randomize_objects(["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"]);
  var_00 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_02 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

turn_on_perk_boxes() {
  var_00 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_02 in var_00) {
    createperkboxes(var_02);
  }
}

createperkboxes(param_00) {
  var_01 = param_00;
  var_02 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_03 = scripts\engine\utility::random(var_02);
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_03);
  var_04 = spawn("script_model", var_01.origin);
  if(isDefined(var_01.angles)) {
    var_04.angles = var_01.angles;
  }

  var_04 setModel("tag_origin_rk_perks");
  var_01.model = var_04;
  var_01.perk = var_03;
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  switch (var_03) {
    case "perk_machine_fwoosh":
      var_04 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_04 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_04 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_04 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_04 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_04 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_04 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_04 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_04 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_04 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_04 setscriptablepartstate("effects", "neutral");
      break;
  }
}

perkbox_usefunc(param_00, param_01) {
  param_01 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(param_00.perk, 0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  param_00.model hidefromplayer(param_01);
  param_01 playlocalsound("part_pickup");
  if(!isDefined(param_00.respawn_flag)) {
    param_00.respawn_flag = 1;
    level.num_crates_broken++;
    var_02 = level.num_crates_broken * 0.05;
    level.available_crate_perks[level.available_crate_perks.size] = param_00.perk;
    param_00 thread restockperkafternextrelic(param_00, param_01, var_02);
  }
}

restockperkafternextrelic(param_00, param_01, param_02) {
  level endon("game_ended");
  level scripts\engine\utility::waittill_any_timeout_1(180, "create_perk_boxes");
  param_00.respawn_flag = undefined;
  level.num_crates_broken = 0;
  wait(param_02);
  var_03 = param_00.model;
  var_04 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_05 = scripts\engine\utility::random(var_04);
  param_00.perk = var_05;
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_05);
  switch (var_05) {
    case "perk_machine_fwoosh":
      var_03 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_03 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_03 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_03 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_03 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_03 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_03 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_03 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_03 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_03 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_03 setscriptablepartstate("effects", "neutral");
      break;
  }

  foreach(var_07 in level.players) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, var_07);
    param_00.model showtoplayer(var_07);
  }
}

perkbox_hintfunc(param_00, param_01) {
  if(!isDefined(param_00.perk)) {
    return "";
  }

  if(isDefined(param_01.zombies_perks) && param_01.zombies_perks.size > 4) {
    return "";
  }

  if(param_01 scripts\cp\utility::has_zombie_perk(param_00.perk)) {
    return "";
  }

  level thread perkbox_usefunc(param_00, param_01);
  return "";
}

perkboxuse(param_00, param_01) {}

init_rh_neil_monitors() {
  while(!isDefined(level.current_personal_interaction_structs)) {
    wait(0.1);
  }

  var_00 = scripts\engine\utility::getstructarray("rhino_neil_monitors", "script_noteworthy");
  level.special_mode_activation_funcs["rhino_neil_monitors"] = ::setrhinoneilstatepent;
  level.normal_mode_activation_funcs["rhino_neil_monitors"] = ::setrhinoneilstatepent;
  foreach(var_02 in var_00) {
    scripts\cp\maps\cp_final\cp_final::addtopersonalinteractionlist(var_02);
  }
}

setrhinoneilstatepent(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = getmodelfromstruct(param_01);
  switch (level.currentneilstate) {
    case "happy":
      param_00 setModel(var_05 + "_happy");
      break;

    case "angry":
      param_00 setModel(var_05 + "_angry");
      break;

    case "blank":
      param_00 setModel("cp_final_monitor_large_screen_black");
      break;

    default:
      param_00 setModel("cp_final_monitor_large_screen_black");
      break;
  }

  if(!isDefined(param_03.neil_monitors)) {
    param_03.neil_monitors = [];
  }

  if(!scripts\engine\utility::array_contains(param_03.neil_monitors, param_00)) {
    param_03.neil_monitors[param_03.neil_monitors.size] = param_00;
  }
}

show_console_to_activate() {
  var_00 = getEntArray("rhino_console_screen", "targetname");
  foreach(var_02 in var_00) {
    update_neil_face_model("cp_final_monitor_large_screen_happy", var_02.origin);
  }
}

update_neil_face_model(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_04 = scripts\engine\utility::getclosest(param_01, var_03.neil_monitors);
    var_04 setModel(param_00);
  }
}

getmodelfromstruct(param_00) {
  if(isDefined(param_00.script_label)) {
    return param_00.script_label;
  }

  return "cp_final_monitor_large_screen_black";
}

setuplnfinteractions() {
  var_00 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
    if(isDefined(var_03.name) && var_03.name == "rhino_fight") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
      var_01 = var_03;
    }
  }

  var_01.origin = (3100.5, 2760, -176);
  level.rhino_lnf_fx = spawnfx(level._effect["rhino_lnf"], var_01.origin + (10, 0, 0), anglesToForward((0, 180, 0)), anglestoup((0, 180, 0)));
  foreach(var_06 in level.players) {
    if(!isDefined(var_06.lost_and_found_ent)) {
      continue;
    }

    var_06.lost_and_found_ent.origin = var_01.origin;
  }

  triggerfx(level.rhino_lnf_fx);
}

restorelnfinteractions() {
  var_00 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
    if(isDefined(var_03.name) && var_03.name == "rhino_fight") {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
      continue;
    }

    var_01 = var_03;
  }

  foreach(var_06 in level.players) {
    if(!isDefined(var_06.lost_and_found_ent)) {
      continue;
    }

    var_06.lost_and_found_ent.origin = var_01.origin + (0, 0, 45);
  }
}

empconsolehint(param_00, param_01) {
  return &"CP_FINAL_ACTIVATE_RITUAL_CIRCLE";
}

empconsoleuse(param_00, param_01) {
  stopFXOnTag(level._effect["vfx_elec_console"], level.emp_console, "tag_origin");
  level.emp_console stoploopsound();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level notify("emp_done");
  var_02 = (3146, 2538, -176);
  playFX(level._effect["rhino_emp"], var_02);
  playsoundatpos(var_02, "emp_grenade_explode_default");
  foreach(var_04 in level.spawned_enemies) {
    var_04 dodamage(var_04.health, var_02);
  }

  wait(0.1);
  playsoundatpos(var_02, "zmb_emp_poweroff");
  var_06 = getEntArray("rhino_sentry_model", "targetname");
  foreach(var_08 in var_06) {
    var_08 notify("death");
  }

  scripts\cp\maps\cp_final\cp_final_mpq::deactivateinteractionsbynoteworthy("rhino_sentry");
  foreach(var_04 in level.players) {
    var_04 notify("force_cancel_placement");
  }
}

killingtimevalidation(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.is_mammoth)) {
    return 0;
  }

  return 1;
}