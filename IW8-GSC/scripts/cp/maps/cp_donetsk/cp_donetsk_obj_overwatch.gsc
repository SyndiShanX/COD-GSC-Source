/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_overwatch.gsc
*******************************************************************/

function overwatch_init() {
  level.overwatch_interaction = &register_interactions;
  level.suicide_bomber_combat_func = &suicide_bomber_combat_func;
  scripts\engine\utility::flag_init("hostages_setup");

  if(!isDefined(level._effect["aerial_explosion_large"])) {
    level._effect["aerial_explosion_large"] = loadfx("vfx/core/expl/aerial_explosion_heli_large.vfx");
  }

  if(!isDefined(level._effect["aerial_explosion"])) {
    level._effect["aerial_explosion"] = loadfx("vfx/core/expl/aerial_explosion.vfx");
    return;
  }
}

function register_overwatch_objective() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("objectives_registered");
  var_0 = &scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("obj_overwatch", &obj_maj_intro_init, &obj_maj_intro_start, &obj_maj_intro_end, &debugbeatobjective, &debug_start_overwatch);
  [[var_0]]("obj_overwatch_bombs", &obj_maj_bombdefuse_init, &obj_maj_bombdefuse_start, &obj_maj_bombdefuse_end, &debugbeatobjective);
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_intro_init(var_0) {
  level.ref_139B5 = 1;
  thread spawn_overwatch_extraguns();
  thread spawn_fake_loots();
  thread ref_135AC();
  thread spawn_exfil_heli_and_rpgs();
  thread ref_131F0();
  thread ref_11A7D();
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_tmtyl");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_tmtyl_0");
}

function obj_maj_intro_start(var_0) {
  wait 1;
  var_1 = scripts\engine\utility::getStruct("stadium_entrance", "targetname");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
  objective_setlabel(var_0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/STADIUM_APPROACH");
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  thread ref_135AE();
  thread ref_123FF();
  var_2 = 4100;
  var_3 = var_2 * var_2;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_3)) {
    wait 0.1;
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12C40("stadium_1", ["deployable_cover"]);
  thread play_intro_vo();
  level waittill("overwatch_played_intro_vo");
  var_4 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
  var_2 = 3500;
  var_3 = var_2 * var_2;

  while(!scripts\cp\utility::any_player_nearby(var_4.origin, var_3)) {
    wait 0.1;
  }

  thread play_intro2_vo();
}

function obj_maj_intro_end(var_0) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_overwatch_bombs");
}

function obj_maj_bombdefuse_init(var_0) {
  thread spawn_juggs();
  thread convoy_start();
  thread run_helicopter_boss();
}

function obj_maj_bombdefuse_start(var_0) {
  level endon("mission_fail");
  scripts\cp\cp_hacking::hacking_init();
  scripts\cp\utility::ref_123FE("mus_cp_landlord_stadium");

  for(var_1 = 0; var_1 < 5; var_1++) {
    hack_relocate(var_1, var_0);
    lb_impulse_dmg_factor_mid_high(var_1, var_0);

    if(var_1 == 4) {
      scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_bombs");
    }

    if(var_1 == 0) {
      lb_impulse_dmg_factor_mid_low(var_0);
    } else if(var_1 != 2) {
      objective_unsetlocation(var_0.objectiveindex, 0);
      wait 6;
    }

    if(var_1 == 2) {
      objective_unsetlocation(var_0.objectiveindex, 0);
      wait_for_tank_deaths(level);
    }
  }

  wait 1;
  objective_unsetlocation(var_0.objectiveindex, 0);
  wait_for_boss_death(level);
  level notify("overwatch_heli_boss_dead");
  level notify("despawn_convoy_05");
  wait 1;

  if(level.overwatch_tanks.size > 0) {
    objective_setlocation(var_0.objectiveindex, 0, level.overwatch_tanks[0]);
    objective_setplayintro(var_0.objectiveindex, 1);
    objective_setplayoutro(var_0.objectiveindex, 1);
    objective_state(var_0.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11F80(var_0.objectiveindex);
    objective_setlabel(var_0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
    objective_setdescription(var_0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
    objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
    objective_sethot(var_0.objectiveindex, 1);
    objective_setbackground(var_0.objectiveindex, 1);
    objective_addalltomask(var_0.objectiveindex);
    objective_showtoplayersinmask(var_0.objectiveindex);
    thread ref_13F61(level, level.overwatch_tanks[0]);

    while(level.overwatch_tanks.size > 0) {
      wait 1;
    }
  }

  level notify("overwatch_final_tank_dead");
  wait 1;
  thread play_win_vo();
}

function ref_13F61(var_0, var_1) {
  var_0 waittill("death");
  objective_unsetlocation(var_1, 0);
}

function obj_maj_bombdefuse_end(var_0) {
  stop_emp_effects_on_players(level);
  level.set_up_blockade_gate_anims = undefined;
  thread ref_12DD6();
}

function wait_for_boss_death() {
  level waittill("spawn_overwatch_heli_boss");
  wait 1;

  if(!isDefined(level.overwatch_boss) || !isent(level.overwatch_boss)) {
    return;
  }

  var_0 = "obj_overwatch_heli";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  var_2 = level.overwatch_boss scripts\engine\utility::spawn_tag_origin();
  var_2 notsolid();
  var_2 show();
  var_2 linkTo(level.overwatch_boss, "tag_origin", (0, 0, 256), (0, 0, 0));
  level.overwatch_boss.obj_pos = var_2;
  objective_setlocation(var_1, 0, level.overwatch_boss.obj_pos);
  objective_state(var_1, "current");
  scripts\cp\cp_objectives::ref_11F80(var_1);
  objective_setlabel(var_1, &"CP_SUBURBS_OBJECTIVES/BOSS_HELI_SHOOT");
  objective_setdescription(var_1, &"CP_SUBURBS_OBJECTIVES/BOSS_HELI");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_sethot(var_1, 1);
  objective_setbackground(var_1, 0);
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  scripts\cp\utility::ref_123FE("mus_cp_landlord_juggernaut");
  level thread scripts\cp\utility::objective_update("obj_overwatch_heli", undefined, undefined, undefined, 1, undefined, 4);

  if(isDefined(level.overwatch_boss) && isalive(level.overwatch_boss)) {
    level.overwatch_boss waittill("death");
  }

  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_heli");
  scripts\cp\utility::ref_123FE("");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("overwatch_soldiers_05_bombers");
  objective_state(var_1, "done");
  scripts\cp\cp_objectives::freeworldid(var_0);
}

function wait_for_tank_deaths() {
  level waittill("overwatch_start_tanks");
  thread spawn_overwatch_tanks();
  thread tank_hint_message();
  thread give_all_players_munition(level, level.priority_player);
  level.ref_121A6 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_tank_backup");
  var_0 = "obj_overwatch_tanks";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  objective_state(var_1, "current");
  scripts\cp\cp_objectives::ref_11F80(var_1);
  objective_setlabel(var_1, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
  objective_setdescription(var_1, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_sethot(var_1, 1);
  objective_setbackground(var_1, 1);
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  scripts\cp\utility::ref_123FE("mus_cp_landlord_juggernaut");
  level thread scripts\cp\utility::objective_update("obj_overwatch_tanks", undefined, undefined, undefined, 1, undefined, 3);
  thread ref_13A59();
  level.ref_11F68 = var_1;

  while(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2) {
    wait 1;
  }

  while(level.overwatch_tanks.size > 0) {
    wait 1;
  }

  level notify("overwatch_tanks_dead");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("overwatch_tank_backup");
  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_tanks");
  scripts\cp\utility::ref_123FE("");
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  objective_state(var_1, "done");
  scripts\cp\cp_objectives::freeworldid(var_0);
}

function ref_13A59() {
  level endon("game_ended");
  var_0 = 12544;
  var_1 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
  var_2 = var_1.origin + (-254, -607, -64);
  var_3 = 180;

  for(;;) {
    wait var_3;

    if(level.overwatch_tanks.size >= 4) {
      var_4 = "rpg_hint_visual";
      var_5 = scripts\cp\cp_objectives::requestworldid(var_4, 2);
      objective_setplayintro(var_5, 1);
      objective_setplayoutro(var_5, 0);
      objective_setbackground(var_5, 0);
      objective_sethot(var_5, 0);
      objective_position(var_5, var_2);
      objective_state(var_5, "current");
      scripts\cp\cp_objectives::ref_11F80(var_5);
      objective_icon(var_5, "icon_waypoint_objective_general");
      objective_setlabel(var_5, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
      objective_setownerteam(var_5, "allies");
      objective_addalltomask(var_5);
      objective_showtoplayersinmask(var_5);
      play_vo_delay(level, "dx_cps_kama_nag_go_to_waypoint_20");
      var_6 = 0;

      for(;;) {
        if(scripts\cp\utility::any_player_nearby(var_2, var_0)) {
          break;
        }

        if(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2) {
          break;
        }

        if(var_6 > 30) {
          break;
        }

        wait 1;
        var_6 += 1;
      }

      if(var_3 > 100) {
        var_3 -= 60;
      }

      objective_state(var_5, "done");
      scripts\cp\cp_objectives::freeworldid(var_4);
      continue;
    }

    break;
  }
}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function spawn_intro_soldiers() {}

function ref_135AE() {
  level.ref_135A1 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_01");
  thread ref_1436A(level);
}

function spawn_overwatch_soldiers_02(var_0) {
  level endon("game_ended");
  var_1 = 4000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 1;
  }

  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_02");
}

function spawn_overwatch_soldiers_03() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_03");
}

function spawn_overwatch_soldiers_04() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_04");
}

function spawn_overwatch_soldiers_05() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_05");
}

function spawn_juggs() {
  level.spawn_module_juggs = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_juggs");
}

function vehicle_dismount_watcher(var_0, var_1) {
  self.combatmode = "no_cover";
  thread vehicle_dlog_enterevent();
}

function vehicle_dlog_enterevent() {
  level endon("game_ended");
  self endon("death");
  thread cargo_truck_mg_enterendinternal(1000);
  vehicle_damage_updatestate(1500);

  if(!isDefined(self.ref_12925)) {
    thread vehicle_docollisiondamagetoplayer();

    while(!isDefined(self.ref_12925)) {
      wait 0.5;
    }

    self notify("end_pursuit");
  }

  if(isDefined(self.ref_12925)) {
    var_0 = 1000;

    if(isDefined(self.ref_12925.radius)) {
      var_0 = self.ref_12925.radius;
    }

    vehicle_fob_think(self.ref_12925, var_0, "cpu_hacking_done");
  }

  vehicle_docollisiondamagetoplayer();
}

function watch_for_player_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isPlayer(var_1)) {
      self.ref_132B8 = 1;
      return;
    }
  }
}

function vehicle_damage_updatestate(var_0) {
  self endon("death");
  self.ignoreall = 1;
  var_1 = getdvarint("scr_jugg_hold_dist", var_0);
  var_2 = var_1 * var_1;
  thread watch_for_player_damage();

  for(;;) {
    if(istrue(self.ref_132B8)) {
      break;
    }

    if(scripts\cp\utility::any_player_nearby(self.origin, var_2)) {
      break;
    }

    wait 0.5;
  }

  self.ignoreall = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  scripts\cp\cp_modular_spawning::set_goal_radius(500);
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

function cargo_truck_mg_enterendinternal(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = 1000;
  jumpiffalse(isDefined(var_0)) LOC_0000001d;
  var_1 = var_0;

  for(;;) {
    level waittill("data_relocated", var_2);

    if(isDefined(var_2) && isDefined(self.spawnpoint) && distancesquared(self.spawnpoint.origin, var_2.origin) < var_1 * var_1) {
      var_3 = 1000;

      if(isDefined(var_2.target)) {
        var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");

        if(isDefined(var_4)) {
          var_2 = var_4;
        }
      }

      self.ref_12925 = var_2;
      return;
    }
  }
}

function vehicle_docollisiondamagetoplayer() {
  level endon("game_ended");
  self endon("death");
  self endon("end_pursuit");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(500);

  for(;;) {
    var_0 = scripts\cp\utility::get_closest_living_player();

    while(isDefined(var_0) && isalive(var_0)) {
      scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
      wait 5;
    }

    wait 1;
  }
}

function vehicle_fob_think(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("death");
  self endon("end_pursuit");
  self notify("pursuing_target");
  self endon("pursuing_target");

  if(isDefined(var_2)) {
    level endon(var_2);
    self endon(var_2);
  }

  if(!isDefined(var_1)) {
    var_1 = 1000;
  }

  var_3 = 2;
  var_4 = int(var_3 * 20);

  while(isDefined(var_0)) {
    scripts\cp\cp_modular_spawning::set_goal_radius(var_1);
    scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    wait var_3;
  }
}

function ref_13582() {
  level.ref_13598 = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_1");
}

function ref_13583() {
  level.ref_13599 = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_2");
}

function ref_13584() {
  level.ref_1359A = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_3");
}

function ref_13585() {
  level.ref_1359B = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_4");
}

function ref_13586() {
  level.ref_1359C = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_5");
}

function complete_game() {
  wait 1;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].ability_invulnerable = 1;
  }

  announcement("YOU WIN!");
  wait 5;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function mission_fail() {
  level notify("mission_fail");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function spawn_covernode_soldiers() {
  wait 2;
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
  scripts\cp\cp_modular_spawning::run_spawn_module("cover_node_spawning");
}

function hack_relocate(var_0, var_1) {
  level endon("game_ended");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  switch (var_0) {
    case 0:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
      var_3 = "obj_overwatch_bomb_1";
      var_5 = (0, 0, 0);
      var_6 = (0, 0, 64);
      var_7 = "obj_jammer_01";
      var_4 = scripts\engine\utility::getStruct("overwatch_origin_01", "targetname");
      var_8 = "mus_cp_landlord_filescopied_1";
      thread convoy_start_1();
      thread spawning_poi_handler(level, "01");
      thread ref_13582();
      level thread scripts\cp\utility::objective_update("obj_overwatch_bombs", undefined, undefined, undefined, 1, var_0);
      break;
    case 1:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
      var_3 = "obj_overwatch_bomb_2";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "obj_jammer_02";
      var_4 = scripts\engine\utility::getStruct("overwatch_origin_02", "targetname");
      var_8 = "mus_cp_landlord_filescopied_2";
      var_9 = "stadium_2";
      thread ref_1350A();
      thread spawn_overwatch_soldiers_02(level);
      thread ref_13583();
      thread convoy_start_2(level);
      thread wait_to_spawn_convoy_3(level);
      thread spawning_poi_handler(level, "02");
      break;
    case 2:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
      var_3 = "obj_overwatch_bomb_3";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "obj_jammer_03";
      var_4 = scripts\engine\utility::getStruct("overwatch_origin_03", "targetname");
      var_8 = "mus_cp_landlord_filescopied_3";
      var_9 = "stadium_3";
      thread spawn_overwatch_soldiers_03();
      thread ref_13584();
      thread spawning_poi_handler(level, "03");
      break;
    case 3:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
      var_3 = "obj_overwatch_bomb_4";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "obj_jammer_04";
      var_4 = scripts\engine\utility::getStruct("overwatch_origin_04", "targetname");
      var_8 = "mus_cp_landlord_filescopied_1";
      var_9 = "stadium_4";
      thread spawn_overwatch_soldiers_04();
      thread ref_13585();
      thread convoy_start_4();
      thread spawning_poi_handler(level, "04");
      break;
    case 4:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_05", "targetname");
      var_3 = "obj_overwatch_bomb_5";
      var_5 = (0, 0, 32);
      var_6 = (0, 0, 64);
      var_7 = "obj_jammer_05";
      var_4 = scripts\engine\utility::getStruct("overwatch_origin_05", "targetname");
      var_8 = "mus_cp_landlord_filescopied_2";
      var_9 = "stadium_5";
      thread ref_13A6F(level);
      thread spawn_overwatch_soldiers_05();
      thread ref_13586();
      thread convoy_start_5();
      thread hurt_trigger_manage_dog_tag();
      thread spawning_poi_handler(level, "05");
      break;
    case 5:
      var_2 = undefined;
      var_3 = "obj_overwatch_bomb_5";
      var_5 = undefined;
      break;
  }

  objective_setlabel(var_1.objectiveindex, "");

  if(isDefined(var_2)) {
    level notify("data_relocated", var_2);
    objective_setbackground(var_1.objectiveindex, 1);
    objective_setlocation(var_1.objectiveindex, 0, var_2.origin + var_5);
    level thread scripts\cp\cp_objectives::ref_1317E(var_1, var_2.origin);
    objective_icon(var_1.objectiveindex, "icon_waypoint_cyber_bombsite");
    objective_sethot(var_1.objectiveindex, 0);
    objective_setownerteam(var_1.objectiveindex, "neutral");
    objective_setlabel(var_1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DOWNLOAD");
    objective_setdescription(var_1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DOWNLOAD");
    objective_state(var_1.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11F80(var_1.objectiveindex);
    thread relocate_gunship_origin(level);
    thread setup_enemy_sentries(level);

    if(isDefined(var_9)) {
      scripts\cp\crate_drops\cp_crate_drops::ref_12C40(var_9, ["deployable_cover"]);
    }

    var_1.use_old_label = 1;
    level.overwatch_emp_low = 0.8;
    level.overwatch_emp_high = 1.2;
    level.overwatch_emp_free = 5;
    thread play_jammer_returning_vo();
    thread handle_wavespawner_amount(level);
    var_10 = get_jammer_mdl(var_7);
    thread setup_router_objective(level);
    level waittill("router_placed");

    if(var_0 == 4) {
      thread ref_13B07();
    }

    level.overwatch_emp_low = 4;
    level.overwatch_emp_high = 9;
    level.overwatch_emp_free = 1.1;
    scripts\cp\utility::ref_123FE(var_8);
    thread start_hack_threaded(level, var_1, var_2, var_6);
    level waittill("cpu_hacking_done");
    wait 1;
    return;
  }
}

function ref_13A6F(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var_3 in var_1) {
    var_3 thread scripts\cp\cp_modular_spawning::set_script_origin_other_for_group(var_0);
  }
}

function start_hack_threaded(var_0, var_1, var_2, var_3) {
  var_4 = &scripts\cp\cp_objective_mechanics::starthackingdefense;
  var_5 = 30;

  switch (var_3) {
    case 0:
      var_5 = 25;
      break;
    case 1:
      var_5 = 30;
      break;
    case 2:
      var_5 = 35;
      break;
    case 3:
      var_5 = 40;
      break;
    case 4:
      var_5 = 90;
      break;
  }

  if(getdvarint("scr_overwatch_speed", 0) > 0) {
    var_5 = 5;
  }

  level[[var_4]](var_0, var_1.origin - var_2, var_5, "data_downloaded", 320);
  level notify("data_downloaded");
}

function ref_11A7D() {
  level endon("game_ended");

  if(isDefined(level.ref_121AA)) {
    return;
  }

  level.ref_121AA = 0;
  var_0 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
  var_1 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
  var_2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
  var_3 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
  var_4 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4)) {
    wait 0.1;
  }

  var_5 = node_set_children(var_0, 1);
  ref_1432E(var_1, var_5);
  var_5 = node_set_children(var_1, 2);
  ref_1432E(var_2, var_5);
  var_5 = node_set_children(var_2, 3);
  ref_1432E(var_3, var_5);
  var_5 = node_set_children(var_3, 4);
  ref_1432E(undefined, var_5);
  level waittill("cpu_hacking_done");
  waitframe();

  if(isDefined(var_5)) {
    next_threshold(var_5);
    return;
  }
}

function node_set_children(var_0) {
  if(level.ref_121AA >= 3) {
    return undefined;
  }

  var_1 = spawn("script_model", self.origin);
  var_1.team = "allies";
  var_1.id = var_0;
  var_1 makescrambler(level.players[0], "little");
  thread ref_12F1D(level);
  level.ref_121AA += 1;
  return var_1;
}

function ref_1432E(var_0, var_1) {
  level endon("game_ended");
  level waittill("cpu_hacking_done");
  waitframe();

  if(isDefined(var_1)) {
    next_threshold(var_1);
  }

  if(isDefined(var_0)) {
    var_2 = 2250000;

    while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_2)) {
      wait 0.1;
    }

    return;
  }
}

function next_threshold(var_0) {
  if(!isDefined(var_0) || !isent(var_0)) {
    return;
  }

  var_0 clearscrambler();
  var_0 notify("clear_scrambler");
  level.ref_121AA -= 1;
}

function ref_12F1D(var_0) {
  level endon("game_ended");
  var_0 endon("clear_scrambler");
  level.players[0] waittill("disconnect");

  if(isDefined(var_0)) {
    next_threshold(var_0);
    return;
  }
}

function setup_enemy_sentries(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
      var_1 = "spawner_ow_0";
      break;
    case 1:
      var_1 = "spawner_ow_1";
      break;
    case 2:
      var_1 = "spawner_ow_2";
      break;
    case 3:
      var_1 = "spawner_ow_3";
      break;
    case 4:
      var_1 = "spawner_ow_4";
      break;
  }

  if(isDefined(var_1)) {
    level.initlocationcircle = var_1;
    level.initlethalmaxoffsetmap = var_1;
    return;
  }
}

function wait_for_players_near(var_0) {
  var_1 = 14400;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 0.25;
  }

  level notify("players_near_data");
}

function emp_effects_on_nearby_players(var_0) {
  level endon("stop_overwatch_emp_effects");
  var_1 = 193600;

  for(;;) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      var_3 = undefined;

      if(istrue(level.players[var_2].mark_emp_effects)) {
        var_3 = distancesquared(level.players[var_2].origin, var_0);

        if(var_3 > var_1) {
          level.players[var_2] notify("stop_overwatch_emp_effects");
          level.players[var_2].mark_emp_effects = undefined;
        }

        continue;
      }

      if(!level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isDefined(var_3)) {
        var_3 = distancesquared(level.players[var_2].origin, var_0);
      }

      if(var_3 < var_1) {
        level.players[var_2].mark_emp_effects = 1;
        thread emp_effects_flickering(level);
      }
    }

    wait 0.25;
  }
}

function emp_effects_flickering(var_0) {
  level endon("stop_overwatch_emp_effects");
  var_0 endon("stop_overwatch_emp_effects");
  var_0 endon("disconnect");
  var_1 = 0.75;

  for(;;) {
    var_2 = randomfloatrange(level.overwatch_emp_low, level.overwatch_emp_high);
    level thread scripts\cp_mp\emp_debuff::ref_1241A(var_0, 5);
    var_3 = randomfloat(level.overwatch_emp_free);
    wait var_2 + var_1 + var_3;
  }
}

function ref_131F0() {
  scripts\cp\utility::skydivestreamhintdvars("overwatch");
}

function lb_impulse_dmg_factor_mid_high(var_0, var_1) {
  level endon("game_ended");
  level endon("hostage_released");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  switch (var_0) {
    case 0:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
      var_3 = "obj_overwatch_bomb_1";
      var_4 = 120;
      var_5 = 60;
      var_6 = 30;
      var_7 = (0, 0, 0);
      var_8 = "obj_jammer_01";
      break;
    case 1:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
      var_3 = "obj_overwatch_bomb_2";
      var_4 = 180;
      var_5 = 90;
      var_6 = 45;
      var_7 = (0, 0, 32);
      var_8 = "obj_jammer_02";
      thread take_away_players_gunshipmunition();
      thread convoy_start_2b();
      break;
    case 2:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
      var_3 = "obj_overwatch_bomb_3";
      var_4 = 180;
      var_5 = 90;
      var_6 = 45;
      var_7 = (0, 0, 32);
      var_8 = "obj_jammer_03";
      thread take_away_players_gunshipmunition();
      thread spawn_overwatch_soldiers_03();
      break;
    case 3:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
      var_3 = "obj_overwatch_bomb_4";
      var_4 = 240;
      var_5 = 120;
      var_6 = 60;
      var_7 = (0, 0, 32);
      var_8 = "obj_jammer_04";
      thread take_away_players_gunshipmunition();
      thread convoy_start_4b();
      thread convoy_start_3b();
      break;
    case 4:
      var_2 = scripts\engine\utility::getStruct("obj_bomb_05", "targetname");
      var_3 = "obj_overwatch_bomb_5";
      var_4 = 240;
      var_5 = 120;
      var_6 = 60;
      var_7 = (0, 0, 32);
      var_8 = "obj_jammer_05";
      thread take_away_players_gunshipmunition();
      break;
    case 5:
      var_2 = undefined;
      var_3 = "obj_overwatch_bomb_7";
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      break;
  }

  objective_setlabel(var_1.objectiveindex, "");

  if(isDefined(var_2)) {
    level notify("bomb_relocated");
    objective_setbackground(var_1.objectiveindex, 1);
    objective_setdescription(var_1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/SHOOT_JAMMER");
    objective_setlocation(var_1.objectiveindex, 0, var_2.origin + var_7);
    objective_icon(var_1.objectiveindex, "hud_icon_c4_plant");
    objective_sethot(var_1.objectiveindex, 0);
    objective_setownerteam(var_1.objectiveindex, "neutral");
    objective_setlabel(var_1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_SHOOT");
    objective_state(var_1.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11F80(var_1.objectiveindex);
    thread hint_jammer_damage(level);
    thread enable_jammer_damage(level, var_8);
    level waittill("jammer_destroyed");
    scripts\cp\utility::ref_123FE("");
    scripts\cp\cp_objectives::screenent_c("minor_objective");
    thread play_jammer_destroyed_vo();
    thread scripts\cp\utility::objective_update("obj_overwatch_bombs", undefined, undefined, undefined, 1, var_0 + 1);
    return;
  }
}

function stop_emp_effects_on_players() {
  level notify("stop_overwatch_emp_effects");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level notify("emp_cleared");
    level.players[var_0].mark_emp_effects = undefined;
  }
}

function start_heli_spawner(var_0) {
  switch (var_0) {
    case 1:
    case 0:
      level.lbravo_se_2 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_se_2");
      break;
    case 4:
    case 3:
    case 2:
      level.lbravo_se_3 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_se_3");
      break;
  }
}

function ref_1350A() {
  level endon("game_ended");
  level endon("jammer_destroyed");
  level waittill("router_placed");
  level.watchleaderdescriptionchange = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer2");
  wait 2;
  level.watchmapselectexitonemp = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer2b");
}

function buy_points_objectives_handler(var_0, var_1) {
  for(var_2 = 0; var_2 < level.agentarray.size; var_2++) {
    if(distance2dsquared(level.agentarray[var_2].origin, var_0.origin) < var_1) {
      if(isalive(level.agentarray[var_2])) {
        return true;
      }
    }
  }

  return false;
}

function relocate_gunship_origin(var_0) {
  level notify("request_relocation_gunship_origin");
  level endon("request_relocation_gunship_origin");

  while(istrue(level.gunshipinuse) || c130_crate()) {
    wait 0.1;
  }

  level.set_up_blockade_gate_anims = var_0.origin;
}

function c130_crate() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      return true;
    }
  }

  return false;
}

function lb_impulse_dmg_factor_mid_low(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = (0, 0, 96);
  objective_setbackground(var_0.objectiveindex, 0);
  objective_icon(var_0.objectiveindex, "icon_waypoint_sp_generic");
  objective_setownerteam(var_0.objectiveindex, "axis");
  objective_setprogressteam(var_0.objectiveindex, "axis");
  objective_setlabel(var_0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DESTROY_VEHICLES");
  level.ref_11F67 = 0;
  var_2 = 16900;

  if(!isDefined(level.player_can_mount)) {
    return;
  }

  if(!isDefined(level.player_can_mount.module_vehicles)) {
    return;
  }

  var_3 = level.player_can_mount.module_vehicles[0];

  if(!isDefined(var_3) || !isent(var_3)) {
    return;
  }

  for(var_4 = 0; var_4 <= 7; var_4++) {
    objective_unsetlocation(var_0.objectiveindex, var_4);
  }

  for(var_5 = 0; var_5 < var_3.riders.size; var_5++) {
    if(var_5 == 0) {
      objective_setlocation(var_0.objectiveindex, 0, var_3);
    }

    if(isalive(var_3.riders[var_5]) && distance2dsquared(var_3.riders[var_5].origin, var_3.origin) < var_2) {
      if(istrue(var_3.riders[var_5].i_see_laststand_player_watcher)) {
        level.ref_11F67 += 1;
        var_3.riders[var_5] hudoutlineenable("outlinefill_nodepth_red");
        thread ref_1432C();
      }
    }
  }

  while(level.ref_11F67 > 0) {
    wait 0.1;
  }

  for(var_4 = 0; var_4 <= 7; var_4++) {
    objective_unsetlocation(var_0.objectiveindex, var_4);
  }
}

function ref_1432C() {
  level endon("game_ended");
  thread zombiekilledlootcachecount(self.origin);
  scripts\engine\utility::ref_143A5("death", "lmg_too_far");
  level.ref_11F67 -= 1;
}

function zombiekilledlootcachecount(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = 160000;

  for(;;) {
    if(distance2dsquared(self.origin, var_0) > var_1) {
      self hudoutlinedisable();
      self notify("lmg_too_far");
      return;
    }

    wait 2;
  }
}

function spawning_poi_handler(var_0, var_1, var_2) {
  level endon("game_ended");
  level notify("spawning_poi_handler");
  var_3 = 640000;
  var_4 = scripts\engine\utility::getStruct("obj_bomb_" + var_0, "targetname");
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_4.origin, 4500, 10000);

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_4.origin, var_3)) {
      break;
    }

    wait 0.5;
  }

  if(isDefined(var_2)) {
    wait var_2;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_4.origin);

  if(isDefined(var_1)) {
    var_5 = scripts\engine\utility::getStruct("obj_bomb_" + var_1, "targetname");
    thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_5.origin, 9000, 15000);
    level waittill("spawning_poi_handler");
    thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_5.origin);
    return;
  }
}

function stop_if_ground_down(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 5;
  var_3 = 0;

  if(isDefined(var_0) && isDefined(level.players[var_0])) {
    var_3++;
  }

  if(isDefined(var_1) && isDefined(level.players[var_1])) {
    var_3++;
  }

  jumpiffalse(isDefined(var_2) && isDefined(level.players[var_2])) LOC_0000004e;
  var_3++;

  for(;;) {
    var_4 = 0;

    if(isDefined(var_0) && isDefined(level.players[var_0])) {
      if(!level.players[var_0] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_0].inlaststand)) {
        var_4++;
      }
    }

    if(isDefined(var_1) && isDefined(level.players[var_1])) {
      if(!level.players[var_1] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_1].inlaststand)) {
        var_4++;
      }
    }

    if(isDefined(var_2) && isDefined(level.players[var_2])) {
      if(!level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var_2].inlaststand)) {
        var_4++;
      }
    }

    if(var_4 >= var_3) {
      break;
    }

    wait 0.1;
  }

  thread mission_fail();
}

function convoy_start() {
  level.convoy_speed_override = 14;
  level.convoy_path_jitter = 16;
}

function convoy_start_1() {
  level endon("game_ended");
  level waittill("router_placed");
  level.player_can_mount = scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_1");
  level.player_can_use_munitions = scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_1_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_1");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_1_lmg");
  wait 5;
  level.watchinexecution = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer1");
  wait 2;
  level.watchleadchange = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer1b");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer1");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer1b");
}

function wait_to_spawn_convoy_3(var_0) {
  level endon("game_ended");
  var_1 = 2000;
  var_2 = var_1 * var_1;

  while(!scripts\cp\utility::any_player_nearby(var_0, var_2)) {
    wait 1;
  }

  wait 20;
  thread convoy_start_3();
}

function convoy_start_2(var_0) {
  level endon("game_ended");
  level notify("despawn_convoy_01");
  var_1 = 5300;
  var_2 = 1200;
  var_3 = scripts\engine\utility::getStruct("techo_ow_2", "targetname");

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, squared(var_2))) {
      break;
    }

    wait 0.25;

    if(isDefined(var_3) && scripts\cp\utility::any_player_nearby(var_3.origin, squared(var_1))) {
      break;
    }

    wait 0.25;
  }

  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_2");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_2_lmg");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_2_lmg");
}

function convoy_start_2b() {
  level endon("despawn_convoy_02");
  wait 20;
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_2b");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_2b_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_2b");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_2b_lmg");
}

function convoy_start_3() {
  level endon("game_ended");
  level notify("despawn_convoy_02");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_3");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_3_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_3_lmg");
  level.watchmidsideplayerexit = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer3");
  wait 2;
  level.watchminigunweapon = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer3b");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer3b");
}

function convoy_start_3b() {
  level endon("game_ended");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_3b");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_3b_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_3b");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_3b_lmg");
}

function convoy_start_4() {
  level endon("game_ended");
  level notify("despawn_convoy_03");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_4");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_4_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_4");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_4_lmg");
  wait 2;
  level.watchoverheat = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer4");
  wait 2;
  level.watchparachutersoverhead = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer4b");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer4");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("lbravo_spawner_jammer4b");
}

function convoy_start_4b() {
  wait 40;
}

function convoy_start_5() {
  level notify("despawn_convoy_04");
  wait 15;
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_5");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_5_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_5");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_5_lmg");
}

function hurt_trigger_manage_dog_tag() {
  level notify("despawn_convoy_04");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_5b");
  scripts\cp\cp_modular_spawning::run_spawn_module("techo_ow_5b_lmg");
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_5b");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("techo_ow_5b_lmg");
}

function similar_convoy_settings(var_0, var_1, var_2) {
  var_3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_4 = level[[var_3]](var_0, var_1, var_2);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_farz(1000);
  var_4 thread scripts\cp\cp_convoy_manager::set_suspend_at_end_path(1);
  thread allow_driver_exit(level);
  level waittill("despawn_" + var_0);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var_4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var_4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function allow_driver_exit(var_0) {
  waitframe();
  var_0 notify("able_to_deposit_driver");
  var_0 scripts\cp\cp_convoy_manager::ref_1307D(0);
}

function register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("cp_overwatch_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_overwatch_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_overwatch_create_script_completed");
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("building_guards", 18, 18, 18, 0.1, 0, "building_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
  [[var_0]]("overwatch_juggs", 3, 3, 3, 0.1, 0, "overwatch_juggs", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_juggs", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("overwatch_juggs", &vehicle_dismount_watcher);
  [[var_0]]("overwatch_soldiers_01", 10, 10, 10, 0.1, 0, "overwatch_soldiers_01", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_01", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("overwatch_soldiers_01", &ref_1220A);
  [[var_0]]("overwatch_soldiers_02", 7, 7, 7, 0.1, 0, "overwatch_soldiers_02", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_02", undefined, 20000, 30000);
  [[var_0]]("overwatch_soldiers_03", 9, 9, 9, 0.1, 0, "overwatch_soldiers_03", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_03", undefined, 20000, 30000);
  [[var_0]]("overwatch_soldiers_04", 7, 7, 7, 0.1, 0, "overwatch_soldiers_04", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_04", undefined, 20000, 30000);
  [[var_0]]("overwatch_soldiers_05", 7, 7, 7, 0.1, 0, "overwatch_soldiers_05", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_05", undefined, 20000, 30000);
  [[var_0]]("overwatch_soldiers_06", 7, 7, 7, 0.1, 0, "overwatch_soldiers_06", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_06", undefined, 20000, 30000);
  [[var_0]]("overwatch_soldiers_05_bombers", 1, 1, 8, 0.1, 0, "overwatch_soldiers_05_bombers", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_05_bombers", undefined, 20000, 30000);
  [[var_0]]("overwatch_tank_backup", 0, 12, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "overwatch_tank_backup", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_06", undefined, 20000, 30000);
  [[var_0]]("ow_lmg_1", 2, 2, 2, 0.1, 0, "ow_lmg_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_1", &spawn_in_cover);
  [[var_0]]("ow_lmg_2", 1, 1, 1, 0.1, 0, "ow_lmg_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_2", &spawn_in_cover);
  [[var_0]]("ow_lmg_3", 4, 4, 4, 0.1, 0, "ow_lmg_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_3", &spawn_in_cover);
  [[var_0]]("ow_lmg_4", 2, 2, 2, 0.1, 0, "ow_lmg_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_4", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_4", &spawn_in_cover);
  [[var_0]]("ow_lmg_5", 3, 3, 3, 0.1, 0, "ow_lmg_5", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_5", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_5", &spawn_in_cover);
  [[var_0]]("lbravo_spawner_jammer2", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("lbravo_spawner_jammer2", &play_hack_reminder_goto2);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer2", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer2b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer2b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer2b", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer1", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer1", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer1b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer1b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer1b", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer3", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer3", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer3b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer3b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer3b", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer4", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer4", undefined, 20000, 30000);
  [[var_0]]("lbravo_spawner_jammer4b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer4b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer4b", undefined, 20000, 30000);
  [[var_0]]("juggheli_spawner_jam5_1", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_1", undefined, 20000, 30000);
  [[var_0]]("juggheli_spawner_jam5_2", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_2", undefined, 20000, 30000);
  [[var_0]]("juggheli_spawner_jam5_3", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_3", undefined, 20000, 30000);
  [[var_0]]("juggheli_spawner_jam5_4", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_4", undefined, 20000, 30000);
  [[var_0]]("techo_ow_1", 4, 4, 4, 0.1, 0, "techo_ow_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_1_lmg", 2, 2, 2, 0.1, 0, "techo_ow_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_1", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_1_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_1_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_1");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_1_lmg");
  [[var_0]]("techo_ow_2", 4, 4, 4, 0.1, 0, "techo_ow_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_2_lmg", 2, 2, 2, 0.1, 0, "techo_ow_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2_lmg");
  [[var_0]]("techo_ow_2b", 4, 4, 4, 0.1, 0, "techo_ow_2b", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_2b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_2b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2b_lmg");
  [[var_0]]("techo_ow_3", 4, 4, 4, 0.1, 0, "techo_ow_3", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_3_lmg", 2, 2, 2, 0.1, 0, "techo_ow_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3_lmg");
  [[var_0]]("techo_ow_3b", 4, 4, 4, 0.1, 0, "techo_ow_3b", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_3b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_3b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3b_lmg");
  [[var_0]]("techo_ow_4", 4, 4, 4, 0.1, 0, "techo_ow_4", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_4_lmg", 2, 2, 2, 0.1, 0, "techo_ow_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_4", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_4_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_4", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_4_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_4");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_4_lmg");
  [[var_0]]("techo_ow_5", 4, 4, 4, 0.1, 0, "techo_ow_5", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_5_lmg", 2, 2, 2, 0.1, 0, "techo_ow_5", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5_lmg");
  [[var_0]]("techo_ow_5b", 4, 4, 4, 0.1, 0, "techo_ow_5b", &watchforstopwaves, undefined, undefined);
  [[var_0]]("techo_ow_5b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_5b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5b_lmg");
}

function ref_1220A(var_0, var_1) {
  self.sightmaxdistance = 2000;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

function ref_13210(var_0, var_1) {
  self.i_see_laststand_player_watcher = 1;
  self.equip_armor = 1;
  self.equip_helmet = 1;
  self.maxhealth = 600;
  self.health = 600;
  self.dontkilloff = 1;
}

function monitor_wave_spawning() {
  level endon("game_ended");
  level endon("overwatch_heli_boss_dead");

  for(;;) {
    if(isDefined(level.spawned_enemies)) {
      if(level.spawned_enemies.size > 22) {
        scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
        wait 30;
      }

      if(level.spawned_enemies.size < 8) {
        scripts\cp\cp_modular_spawning::unpause_group_by_group_name("wave_spawning");
      }
    }

    wait 1;
  }
}

function setup_manual_goalpos(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "building_guards":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

function ref_1436A(var_0) {
  level endon("game_ended");
  level endon("router_placed");

  while(var_0.ai_spawned.size <= 5) {
    wait 1;
  }

  while(var_0.activecount > 4) {
    wait 1;
  }

  level notify("ow_activate_first_wave");
}

function play_hack_reminder_goto2(var_0) {
  thread ref_12941();
}

function ref_12941(var_0) {
  level endon("game_ended");
  self endon("death");
  self waittill("unload");
  wait 1;
  var_0 = scripts\engine\utility::getStruct("jammer2_bridge_goal", "targetname");
  scripts\cp\cp_modular_spawning::set_goal_radius(var_0.radius);
  scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
  wait randomintrange(25, 35);
  thread vehicle_docollisiondamagetoplayer();
}

function spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "Prone")) {
      if(issubstr(var_1.type, "Left")) {
        var_2 += (0, 90, 0);
      } else if(issubstr(var_1.type, "Right") || issubstr(var_1.type, "Cover Crouch") || issubstr(var_1.type, "Conceal") || issubstr(var_1.type, "Cover Stand")) {
        var_2 -= (0, 90, 0);
      }
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
    return;
  }
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("end_wave_tugofwar_spawners");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function stopwaveandstartthisone(var_0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var_0]]();
}

function handle_wavespawner_amount(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = "overwatch_low";
      break;
    case 3:
      var_1 = "overwatch_high";
      break;
    case 4:
      var_1 = "overwatch_laser";
      break;
  }

  if(var_0 == 0) {
    level scripts\engine\utility::ref_143A5("router_placed", "ow_activate_first_wave");
    wait 15;
  }

  if(var_0 == 4) {
    level scripts\engine\utility::ref_143A5("router_placed");
    wait 15;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(1, var_1);
}

function handle_pause_wavespawning() {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
}

function setup_router_objective(var_0) {
  level endon("game_ended");
  var_1 = (11.9, 14.59, 40.5);
  var_2 = rotatevector(var_1, var_0.angles);
  var_3 = spawn("script_model", var_0.origin + var_2);
  var_3.angles = var_0.angles + (0, 180, 0);
  var_3 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "cp_tac_waypoint_router", &"CP_SUBURBS_OBJECTIVES/PLACE_ROUTER", 25, "duration_medium", "show", 275, 110, 88, 60);
  var_3 setModel("tag_origin");

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_4 playlocalsound("cp_generic_placement");
    break;
  }

  level notify("router_placed", var_0);
  var_3 makeunusable();
  var_3 setModel("equipment_router_flat_invisi");
  var_3 setscriptablepartstate("transfer", "start");
  level waittill("cpu_hacking_done");
  var_3 setscriptablepartstate("transfer", "finish");
  wait 30;
  var_3 delete();
}

function spawn_overwatch_tanks() {
  var_0 = scripts\engine\utility::getStructArray("overwatch_enemy_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.overwatch_tanks = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    thread spawn_overwatch_tank(level, var_0[var_1]);
    wait 1 + randomfloat(0.5);
  }
}

function ref_135AD() {
  if(!isDefined(level.overwatch_tanks)) {
    level.overwatch_tanks = [];
  }

  var_0 = scripts\engine\utility::getStruct("overwatch_enemy_tank_last", "targetname");
  thread spawn_overwatch_tank(level, var_0, undefined);
}

function spawn_overwatch_tank(var_0, var_1, var_2) {
  level endon("game_ended");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = 50;
  }

  var_3 = spawnStruct();
  var_4 = spawnStruct();
  var_3.origin = var_0.origin;
  var_3.angles = var_0.angles;
  var_3.spawntype = "GAME_MODE";
  var_3.owner = undefined;
  var_3.team = "axis";
  var_3.faceawayfromowner = 0;
  var_3.cancapture = 0;
  var_3.cancaptureimmediately = 0;
  var_3.activateimmediately = 1;
  var_3.cantimeout = 0;
  var_3.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_3);
  var_3.spawnmethod = "airdrop_at_position_unsafe";
  var_5 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_3, var_4);

  if(!isDefined(var_5)) {
    return;
  }

  wait 10;

  if(isDefined(var_1)) {
    var_5.objiconid = var_1;
    objective_setlocation(level.ref_11F68, var_5.objiconid, var_5);
  }

  level.overwatch_tanks[level.overwatch_tanks.size] = var_5;

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers[level.vo_paratroopers.size] = var_5;
  thread tank_waittill_death();
  var_5 endon("death");
  var_5 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var_5.headicon, 8000);
  var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_5, "tur_bradley_mp");
  var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_5, "tur_gun_lighttank_mp");
  var_8 = 250000;
  var_9 = 36000000;
  var_10 = scripts\engine\utility::getStructArray("overwatch_tank_path", "targetname");
  var_11 = sortbydistance(var_10, var_5.origin)[0];
  var_5.ref_13A4C = build_tank_path(var_11);
  var_5.ref_13A46 = build_tank_duration(var_11);
  var_5 startpathnodes(var_5.ref_13A4C, var_5.ref_13A46, 0, 0.5, 0.5, 0, 0, 1);
  thread ref_14350();

  for(;;) {
    var_12 = var_5 scripts\cp\utility::get_closest_living_player(var_9);

    if(!isDefined(var_12)) {
      wait 1;
      continue;
    }

    if(istrue(var_12.binvehicle) && isDefined(var_12.vehicle)) {
      if(var_6 turretcantarget(var_12.vehicle.origin + (0, 0, 50))) {
        var_6 settargetentity(var_12.vehicle);
      }

      if(var_7 turretcantarget(var_12.vehicle.origin + (0, 0, 50))) {
        var_7 settargetentity(var_12.vehicle);
      }
    } else {
      ref_130F2(var_6, var_12, 9, var_2, var_8);
      var_7 settargetentity(var_12);
    }

    thread tank_shoot_at_target(var_5, var_7);
    thread tank_shoot_at_target(var_5, var_6, undefined);
    wait randomfloatrange(11, 16);
  }
}

function ref_130F2(var_0, var_1, var_2, var_3) {
  if(distancesquared(self.origin, var_0.origin) < var_3) {
    self settargetentity(var_0);
    return;
  }

  if(var_1 > randomint(9)) {
    if(!isDefined(var_2)) {
      var_2 = 20;
    }

    var_4 = randomfloatrange(var_2 * -1, var_2);
    var_5 = randomfloatrange(var_2 * -1, var_2);
    var_6 = randomfloatrange(var_2 * -1, var_2);
    self settargetentity(var_0, (var_4, var_5, var_6));
    return;
  }

  self settargetentity(var_0);
}

function tank_hint_message() {
  wait 12;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0].team == "allies" && level.players[var_0] scripts\cp_mp\utility\player_utility::_isalive()) {
      level.players[var_0] thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/TANK_DAMAGE_HELP", 4);
    }
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_3 = 8;
  var_4 = 2;

  if(istrue(var_1)) {
    var_3 = randomintrange(80, 120);
    var_4 = 0.05;
  }

  if(isDefined(var_2)) {
    wait var_2;
  }

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var_4;
  }
}

function build_tank_path(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1 = var_2.origin) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function build_tank_duration(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = 4; isDefined(var_2) && isDefined(var_2.target); var_1 = 4) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  if(isDefined(self.objiconid)) {
    objective_unsetlocation(level.ref_11F68, self.objiconid);
  }

  level.overwatch_tanks = scripts\engine\utility::array_remove(level.overwatch_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}

function ref_14350() {
  self endon("death");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

function isprogressionmismatch() {
  level endon("game_ended");
  wait 1;

  while(getdvarint("scr_debug_overwatch_boss", 0) == 0) {
    wait 1;
  }

  level notify("spawn_overwatch_heli_boss");
}

function run_helicopter_boss() {
  scripts\engine\utility::flag_init("ovewatch_heli_liftoff");
  level waittill("spawn_overwatch_heli_boss");
  thread spawn_enemy_lbravo(level);
  thread play_helicopter_vo();
  stop_emp_effects_on_players(level);
  wait 1;
  scripts\engine\utility::flag_set("ovewatch_heli_liftoff");
}

function spawn_enemy_lbravo(var_0) {
  if(scripts\engine\utility::flag_exist("boss_heli")) {
    scripts\engine\utility::flag_set("boss_heli");
  }

  var_1 = scripts\engine\utility::getStruct("boss_heli_spawn", "targetname");

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  var_1.classname_mp = "script_vehicle_apache_east";
  var_1.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  var_1.vehicletype = "veh_apache_cp";
  level.overwatch_boss = scripts\common\vehicle::vehicle_spawn(var_1);
  level.overwatch_boss scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  level.overwatch_boss.spawnpoint = var_1;
  level.overwatch_boss.isheli = 1;
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = level.overwatch_boss;
  level.overwatch_boss.vehicletype = "apache";
  level.overwatch_boss.health = 50000;
  level.overwatch_boss.maxhealth = 50000;
  level.overwatch_boss.team = "axis";
  level.overwatch_boss setvehicleteam(level.overwatch_boss.team);
  level.overwatch_boss setmaxpitchroll(15, 15);
  level.overwatch_boss.health_remaining = 1500;
  level.overwatch_boss.showseasonalcontent = 1500;
  level.overwatch_boss.bullets_can_damage = 1;
  thread flag_think(level.overwatch_boss, var_0);
  thread setup_pilot(level.overwatch_boss, "tag_driver");
  level.overwatch_boss thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(undefined, 1500);
  level.overwatch_boss sethoverparams(25, 15, 10);
  level.overwatch_boss.minigun makeunusable();
  level.overwatch_boss.minigun hide();
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(level.overwatch_boss);
  level.overwatch_boss.circle_radius = 6000;
  level.overwatch_boss.should_move_to_target_dist = 7000;
  level.overwatch_boss.heli_can_target_dist = 7000;
  level.overwatch_boss.new_target_dist = 1200;
}

function flag_think(var_0, var_1) {
  level.overwatch_boss endon("death");

  if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_wait(var_0);
  }

  if(istrue(var_1)) {
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.overwatch_boss);
    return;
  }

  level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.overwatch_boss);
}

function follow_path_until(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

  while(isDefined(var_1)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var_1.origin;
    var_2 = self.gotopos;

    if(distance2dsquared(self.origin, var_2) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var_2, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_2, 0);
    }

    scripts\engine\utility::ref_143BB(15, "goal", "goal_reached", "near_goal");

    if(isDefined(var_1.target) && var_1.target != var_0) {
      var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
      continue;
    }

    break;
  }

  var_3 = var_1;
  var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  arrive_at_exfil_location(self, var_1, var_3);
}

function arrive_at_exfil_location(var_0, var_1, var_2) {
  var_0 setvehgoalpos(var_2.origin, 1);
  var_0 waittill("goal");
  var_0 settargetyaw(var_1.angles[1]);
  var_0 setyawspeed(40, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location");
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_1.origin, 1);
  var_0 waittill("goal");
  var_0 vehicle_setspeedimmediate(0);
  thread heli_sfx_shutdown();
  var_0 vehicle_cleardrivingstate();
  var_0 notify("heli_landed");
}

function heli_sfx_shutdown() {
  self endon("death");
  self playSound("cp_dwn_twn_heli_shutdown");
  wait 2;
  self vehicle_turnengineoff();
  level waittill("hvt_leaving");
  self playSound("cp_dwn_twn_heli_spoolup");
  wait 2;
  self vehicle_turnengineon();
}

function setup_pilot(var_0, var_1, var_2) {
  var_3 = "tag_pilot";

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  if(!self tagexists(var_3)) {
    var_3 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var_3));
  self.pilot setModel("british_pilot_fullbody");
  self.pilot linkTo(self, var_3, var_4, var_5);
  self.pilot scriptmodelplayanim("vh_blima_rappel_pilot");
}

function heli_damagemonitor() {
  self endon("death");
  var_0 = 0;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    self.health = 1000000;

    if(isDefined(var_2) && var_2 == self) {
      continue;
    }

    if(isDefined(var_14) && isDefined(var_14.owner) && var_14.owner == self) {
      continue;
    }

    if(is_snipe_kill(var_2, var_4, var_10)) {
      var_0++;

      if(var_0 == 2) {
        var_2 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_2 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        thread do_heli_crash(var_2);
        return;
      }

      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      continue;
    }

    if(!isexplosivedamagemod(var_5)) {
      if(istrue(self.bullets_can_damage)) {
        var_1 *= 0.1;
      } else {
        var_1 = 0;
      }

      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    } else {
      var_2.lasthitmarkertime = undefined;
      var_2 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var_10) && var_10.basename == "iw8_thermite_mp") {} else if(var_1 < 700) {
        var_1 = 700;
      }

      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
    }

    self.health_remaining -= var_1;

    if(self.health_remaining <= self.showseasonalcontent * 0.25 && !isDefined(self.deathfx)) {
      playFX(level._effect["aerial_explosion"], self.origin);
      self.deathfx = 1;
    }

    if(self.health_remaining <= self.showseasonalcontent * 0.5 && !isDefined(self.deathfx1)) {
      playFX(level._effect["vfx_blima_explosion"], self.origin);
      self.deathfx1 = 1;
    }

    if(self.health_remaining <= self.showseasonalcontent * 0.75 && !isDefined(self.deathfx2)) {
      self.deathfx2 = 1;
    }

    if(self.health_remaining <= 0) {
      thread ishelperdrone(self.origin);

      if(isDefined(var_10) && issubstr(var_10.basename, "molotov")) {
        if(isDefined(var_2) && isPlayer(var_2)) {
          var_2 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var_2) && isPlayer(var_2)) {
        var_2 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
      }

      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
      self.minigun delete();

      if(isDefined(self.pilot)) {
        self.pilot delete();
      }

      self delete();
    }
  }
}

function ishelperdrone(var_0) {
  playFX(level._effect["vfx_blima_explosion"], var_0);
}

function is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "sniper";

  if(!ispointnearpilot(self, var_1) || !var_3) {
    return false;
  }

  return true;
}

function do_heli_crash(var_0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("death", var_0, "MOD_EXPLOSIVE", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var_0, "sniped");
  self makecorpse();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var_0);
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
}

function ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20) {
    return true;
  }

  if(distance(var_1, var_5) <= 20) {
    return true;
  }

  if(distance(var_1, var_6) <= 20) {
    return true;
  }

  return false;
}

function debug_start_overwatch(var_0) {
  thread threaded_debug_start();
}

function threaded_debug_start() {
  scripts\engine\utility::flag_wait("cp_overwatch_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "overwatch_debug_start_loc", 1);
}

function give_all_players_munition(var_0, var_1) {
  level endon("bomb_relocated");
  wait 0.1;

  if(isDefined(var_1)) {
    wait var_1;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    thread each_player_remotestarted();
  }

  thread wait_for_gunship_used();
  thread force_gunship_off_time();

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    thread give_gunship_access_after_personal_delay(level, level.players[var_2]);
  }
}

function each_player_remotestarted() {
  level endon("jammer_destroyed");
  self endon("disconnect");
  thread changepropkey();

  while(!isDefined(level.gunship_intromodel)) {
    wait 0.1;
  }

  level.gunship_intromodel waittill("gunship_end_intro");
  level notify("ac130InUse", self);
}

function changepropkey() {
  level endon("game_ended");
  level endon("jammer_destroyed");
  level endon("clear_players_gunship_delays");
  self endon("disconnect");
  self waittill("attempt_use_gunship");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(self, "obj_interact");
  level waittill("ac130InUse", var_0);

  if(isDefined(var_0) && var_0 != self) {
    scripts\cp\utility::setlowermessage("havesaw", &"CP_SUBURBS_OBJECTIVES/LOSTRACE", 5);
    return;
  }
}

function wait_for_gunship_used() {
  level endon("jammer_destroyed");
  level waittill("ac130InUse", var_0);
  thread track_gunship_uses_per_player();
  take_away_players_gunshipmunition();
}

function track_gunship_uses_per_player() {
  wait 5;

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(!isDefined(level.players[var_0].gunship_uses)) {
      if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
        level.players[var_0].gunship_uses = 1;
      }

      continue;
    }

    if(level.players[var_0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      level.players[var_0].gunship_uses++;
    }
  }
}

function give_gunship_access_after_personal_delay(var_0, var_1) {
  level endon("game_ended");
  level endon("clear_players_gunship_delays");
  var_0 endon("disconnect");
  var_2 = 5;
  var_3 = 3;
  var_4 = 3;

  if(!isDefined(var_0.gunship_uses)) {
    if(isDefined(var_1) && var_1 == var_0) {
      var_4 -= var_3;
    }
  } else {
    for(var_5 = 0; var_5 < var_0.gunship_uses; var_5++) {
      var_4 += var_2;
    }

    if(isDefined(var_1) && var_1 == var_0) {
      var_4 -= var_3;
    }
  }

  if(var_4 > 0) {
    wait var_4;
  }

  var_0.saved_lastweapon = var_0 getcurrentweapon().basename;
  var_6 = scripts\cp\loot_system::get_empty_munition_slot(var_0);

  if(isDefined(var_6) && !istrue(ref_1246B(var_0))) {
    var_0 scripts\cp\cp_munitions::give_munition_to_slot("ac130", var_6, "overwatch");
    var_0.ref_121AB = var_6;

    if(!isDefined(var_0.gunship_uses)) {
      wait 3;
      var_0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/GUNSHIP_TUT", 4);
      return;
    }

    return;
  }
}

function ref_1246B() {
  foreach(var_1 in self.munition_slots) {
    if(isDefined(var_1.ref_134E2) && var_1.ref_134E2 == "overwatch") {
      return true;
    }
  }

  return false;
}

function force_gunship_off_time() {
  level endon("ac130InUse");
  level waittill("ac130InUse");
  take_away_players_gunshipmunition();
}

function take_away_players_gunshipmunition() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(isDefined(level.players[var_0].ref_121AB)) {
      var_1 = level.players[var_0].ref_121AB;
      var_2 = level.players[var_0].munition_slots[var_1];

      if(isDefined(var_2) && isDefined(var_2.ref_134E2) && var_2.ref_134E2 == "overwatch") {
        haspassedsquadleader(level.players[var_0], var_1, var_2.ref);
        level.players[var_0] scripts\cp\cp_munitions::update_lua_inventory_slot(var_1);
      }
    }
  }

  level notify("clear_players_gunship_delays");
}

function haspassedsquadleader(var_0, var_1) {
  for(var_2 = 0; var_2 < self.munition_slots.size; var_2++) {
    if(var_2 == var_0) {
      if(isDefined(self.munition_slots[var_2].ref) && self.munition_slots[var_2].ref == var_1 && isDefined(self.munition_slots[var_2].ref_134E2) && self.munition_slots[var_2].ref_134E2 == "overwatch") {
        scripts\cp\cp_munitions::give_munition_to_slot("none", var_0);
        var_3 = "cp_munition_1_timer";

        switch (var_0) {
          case 0:
            var_3 = "cp_munition_1_timer";
            break;
          case 1:
            var_3 = "cp_munition_2_timer";
            break;
          case 2:
            var_3 = "cp_munition_3_timer";
            break;
          case 3:
            var_3 = "cp_munition_4_timer";
            break;
        }

        self setclientomnvar(var_3, 0);
        self.munition_slots[var_2].ref_134E2 = undefined;
        thread ref_11E0B(level);
      }
    }
  }
}

function ref_11E0B(var_0) {
  var_0 endon("disconnect");
  var_0 scripts\cp\utility::setlowermessage("gunship_removed_message", &"CP_SUBURBS_OBJECTIVES/GUNSHIP_REMOVED");
  wait 3;
  var_0 scripts\cp\utility::clearlowermessage("gunship_removed_message");
}

function ref_13B07() {
  wait 15;
  var_0 = scripts\engine\utility::getStructArray("overwatch_mortar", "targetname");
  thread ref_135AD();
  thread ref_1358F();
  thread ref_135D5();
  wait 5;

  for(var_1 = 0; var_1 < 4; var_1++) {
    foreach(var_3 in var_0) {
      var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
      thread watchalleyplayerexit(level, var_3.origin);
      wait 0.2 + randomfloat(0.75);
    }

    wait 40 + randomfloat(6);
    level notify("stop_mortar_smoke");
  }
}

function ref_135D5() {
  wait 15;
  level.ref_121A5 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_05_bombers");
}

function ref_12A06(var_0) {
  var_1 = randomfloatrange(var_0 * -1, var_0);
  var_2 = randomfloatrange(var_0 * -1, var_0);
  return (var_1, var_2, 0);
}

function ref_1358F() {
  level endon("overwatch_final_tank_dead");
  level endon("game_ended");
  level.vehicle_occupancy_giveriotshield = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_1");
  thread ref_138BD(level, 60);
  wait 4;
  level.vehicle_occupancy_handleplayerbc = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_2");
  thread ref_138BD(level, 60);
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_giveriotshield);
  level.vehicle_occupancy_hidecashbag = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_3");
  thread ref_138BD(level, 60);
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_handleplayerbc);
  level.vehicle_occupancy_instanceisregistered = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_4");
  thread ref_138BD(level, 60);
}

function ref_138BD(var_0, var_1) {
  wait var_0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
}

function spawn_lmg_soldiers_04(var_0) {
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    if(var_0.currentmodulekills >= var_0.spawn_count) {
      break;
    }

    if(var_1 > 120) {
      break;
    }

    wait 0.5;
    var_1 += 0.5;
  }
}

function watchalleyplayerexit(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = undefined;

  if(isvector(var_0)) {
    var_2 = spawnStruct();
    var_2.origin = var_0;
    var_2.angles = (0, 0, 0);
    var_0 = var_2;
  }

  var_3 = self;
  var_4 = undefined;

  if(!isent(self)) {
    var_3 = var_2;
    var_4 = var_3.origin;
  } else {
    var_4 = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(var_1)) {
    var_1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread ref_142E2(var_1);
  var_5 = scripts\engine\utility::spawn_tag_origin(var_4, (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), var_3.origin + (0, 0, 3) + anglesToForward(var_3.angles) * 8, anglesToForward(var_3.angles));
  playsoundatpos(var_4, "weap_mortar_fire_dist");
  var_5 show();
  var_6 = 5;
  thread movemortar(var_5, var_4, var_1, var_6, 1200);
  var_5 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_5, "tag_origin");
  var_5 playLoopSound("weap_mortar_fly_lp");
  wait var_6 - 1.7;
  var_5 playSound("weap_mortar_incoming");
  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var_5, "tag_origin");
  var_5 stoploopsound();
  var_7 = (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", var_1);
  thread ref_11D31(var_1);
  var_8 = spawn("script_model", var_1 + (0, 0, 2));
  var_8 setModel("tag_origin");
  var_8 show();
  var_8.angles = (270, 0, 0);
  var_5 delete();
  wait 0.5;
  playFXOnTag(level._effect["vfx_ow_mortar_smoke"], var_8, "tag_origin");
  level waittill("stop_mortar_smoke");
  stopFXOnTag(level._effect["vfx_ow_mortar_smoke"], var_8, "tag_origin");
  wait 1;
  var_8 delete();
}

function movemortar(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1200;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = 1 / var_3 / 0.05;
  var_7 = 0;

  while(var_7 < 1) {
    var_0.origin = scripts\engine\math::get_point_on_parabola(var_1, var_2, var_5, var_7);
    anglemortar(var_0);
    var_7 += var_6;
    wait 0.05;
  }

  var_0.origin = var_2;
}

function anglemortar() {
  if(!isDefined(self.prevorigin)) {
    self.prevorigin = self.origin;
    self.roll = 0;
    return;
  }

  self.angles = vectortoangles(self.origin - self.prevorigin);
  self.prevorigin = self.origin;
}

function ref_142E2(var_0) {
  if(gettime() < level.ref_11E67) {
    return;
  }

  var_1 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_kama_lass_mortar_attacking_10", "dx_cps_kama_lass_mortar_attacking_20"];
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, squared(384));
  var_3 = scripts\engine\utility::random(var_1);

  foreach(var_5 in var_2) {
    thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_5, var_3);
  }

  level.ref_11E67 = gettime() + 30000;
}

function ref_11D31(var_0) {
  var_1 = 3;
  var_2 = 45;
  wait var_1;
  var_3 = scripts\cp\cp_outline_utility::addoutlineoccluder(var_0, 300);
  var_4 = spawn("script_model", var_0);
  var_4 show();
  var_5 = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(isDefined(var_5)) {
    level notify("grenade_exploded_during_stealth", var_4, "smoke_grenade_mp");
    var_4 clonebrushmodeltoscriptmodel(var_5);
    var_4 setmovertransparentvolume();
  } else {
    var_4 delete();
  }

  level waittill("stop_mortar_smoke");

  if(isDefined(var_4)) {
    var_4 delete();
  }

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var_3);
}

function enable_jammer_damage(var_0, var_1) {
  thread mdl_allow_damage_jammers(level, var_0);
  level waittill("jammer_lowhealth", var_2);
  wait 0.75;
  level notify("jammer_destroyed");
  level.priority_player = var_2;
}

function hint_jammer_damage(var_0) {
  var_1 = 193600;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2].team == "allies" && level.players[var_2] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(distancesquared(level.players[var_2].origin, var_0.origin) < var_1) {
        level.players[var_2] thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/SHOOT_JAMMER", 4);
      }
    }
  }
}

function mdl_allow_damage_jammers(var_0, var_1) {
  var_2 = get_jammer_mdl(var_0);
  thread allow_jammer_takedamage(var_2);
  thread jammer_hitmarkers();
}

function get_jammer_mdl(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "obj_jammer_01":
      var_1 = "signal_jammer_mdl_01";
      break;
    case "obj_jammer_02":
      var_1 = "signal_jammer_mdl_02";
      break;
    case "obj_jammer_03":
      var_1 = "signal_jammer_mdl_03";
      break;
    case "obj_jammer_04":
      var_1 = "signal_jammer_mdl_04";
      break;
    case "obj_jammer_05":
      var_1 = "signal_jammer_mdl_05";
      break;
    case "obj_jammer_06":
      var_1 = "signal_jammer_mdl_06";
      break;
  }

  var_2 = getEnt(var_1, "targetname");
  return var_2;
}

function allow_jammer_takedamage(var_0) {
  level endon("game_ended");
  var_1 = 400;

  if(getdvarint("scr_overwatch_speed", 0) > 0) {
    var_1 = 10;
  }

  self.health = var_1;
  self.maxhealth = var_1;
  var_2 = var_1 * 0.8;
  var_3 = var_1 * 0.6;
  var_4 = var_1 * 0.4;
  self setCanDamage(1);
  self setCanRadiusDamage(1);

  while(self.health > var_2) {
    wait 0.1;
  }

  objective_sethot(var_0, 0);
  playFXOnTag(level._effect["vfx_signal_jammer_damage_1"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_01_lp");

  while(self.health > var_3) {
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_1"], self, "tag_origin");
  self stoploopsound();
  playFXOnTag(level._effect["vfx_signal_jammer_damage_2"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_02_lp");

  while(self.health > var_4) {
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_2"], self, "tag_origin");
  self stoploopsound();
  playFXOnTag(level._effect["vfx_signal_jammer_damage_3"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_03_lp");

  while(self.health > 0) {
    wait 0.1;
  }

  var_5 = undefined;
  self waittill("damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

  if(isDefined(var_7) && isDefined(var_7.team) && var_7.team != "axis") {
    var_5 = var_7;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_3"], self, "tag_origin");
  self stoploopsound();
  self playSound("scn_cp_stadium_jammer_dead");
  playFXOnTag(level._effect["vfx_signal_jammer_damage_4"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_04_lp");
  level notify("jammer_lowhealth", var_5);
  wait 120;
  stopFXOnTag(level._effect["vfx_signal_jammer_damage_4"], self, "tag_origin");
  self stoploopsound();
  self playSound("scn_cp_stadium_jammer_04_end");
}

function jammer_hitmarkers() {
  level endon("jammer_lowhealth");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_12DD6() {
  wait 10;
  scripts\engine\utility::flag_init("endgame_delay");
  level thread scripts\cp\utility::objective_update("obj_overwatch_exfil", undefined, undefined, undefined, 1, undefined, 2);
  var_0 = scripts\engine\utility::getStruct("obj_exfil_landing", "targetname");
  var_1 = scripts\engine\utility::getStruct("ow_exfil_spawn", "targetname");
  level.ref_1248F = var_1;
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_exfil_landing");
  waitframe();
  level notify("call_exfil", var_0.origin);
  level waittill("ready_to_exfil");
  ref_130A8(level.heli_trip_vehicle);

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp_mp\xmike109::screenent_d("headhunter");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_3 thread scripts\cp_mp\xmike109::scriptable_callback("headhunter_mod");
        continue;
      }

      var_3 thread scripts\cp_mp\xmike109::scriptable_callback("headhunter_mod_vet");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("SMUGGLED", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("PICKLES", 1);
  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_exfil");
  scripts\cp\cp_objectives::screenent_c("major_objective");

  for(var_5 = 0; var_5 < level.players.size; var_5++) {
    level.players[var_5].ability_invulnerable = 1;
  }

  wait 1;
  scripts\cp\utility::skydiveontacinsertplacement();
  wait 1.5;
  wait 3;
  scripts\engine\utility::flag_set("endgame_delay");
}

function spawn_fake_loots() {
  var_0 = ["brloot_munition_ammo"];
  var_1 = getEntArray("overwatch_loot", "targetname");

  foreach(var_3 in var_1) {
    var_3 thread scripts\cp\utility::create_fake_loot(var_0);
  }
}

function spawn_overwatch_extraguns() {
  wait 1;
  var_0 = scripts\engine\utility::getStructArray("overwatch_guns", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2.script_noteworthy, [], "none", "none", -1);
    var_4 = createheadicon(var_3);
    var_5 = spawn("weapon_" + var_4, var_2.origin);

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_5.angles = var_2.angles;
    var_5 itemweaponsetammo(weaponclipsize(var_3), weaponmaxammo(var_3));
  }
}

function ref_135AC() {
  if(istrue(level.ref_11F69)) {
    return;
  }

  level.ref_11F69 = 1;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var_0 = scripts\engine\utility::getStructArray("overwatch_atv_spawner_early", "targetname");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var_0, 1);
}

function spawn_exfil_heli_and_rpgs() {
  level endon("game_ended");
  wait 3;
  var_0 = scripts\engine\utility::getStructArray("overwatch_atv_spawner_early", "targetname");
  var_1 = var_0[0];
  var_2 = 9000000;
  var_3 = [];
  var_4 = vehicle_getarray();

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isent(var_4[var_5]) && isDefined(var_4[var_5].vehiclename) && var_4[var_5].vehiclename == "atv" && !var_4[var_5] issuspendedvehicle() && distance2dsquared(var_1.origin, var_1.origin) < var_2) {
      var_3 = var_4[var_5];
    }
  }

  foreach(var_7 in var_3) {
    thread little_bird_mg_deathcallback();
    var_7 hudoutlineenable("outline_nodepth_green");
  }

  var_9 = level scripts\engine\utility::ref_143B9(60, "router_placed");
  level notify("disable_atv_outlines");

  foreach(var_7 in var_3) {
    if(isent(var_7) && !var_7 issuspendedvehicle()) {
      var_7 hudoutlinedisable();
    }
  }
}

function little_bird_mg_deathcallback() {
  level endon("disable_atv_outlines");
  self endon("death");

  for(;;) {
    wait 0.1;

    if(!istrue(self.isempty)) {
      break;
    }
  }

  self hudoutlinedisable();
}

function make_enemies_ignore_you() {
  level endon("game_ended");
  self endon("disconnect");

  if(!scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(1);
  }

  scripts\engine\utility::ref_143A6("stop_remote_sequence", "gunshipPlayer_removed", "death");

  if(scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }
}

function play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4)) {
    wait var_4;
  }

  if(isDefined(var_0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "allies", var_3, var_5, var_6);
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(isDefined(var_2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
    return;
  }
}

function vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 /= 1000;
  return var_1;
}

function suicide_bomber_combat_func() {
  self endon("death");
  var_0 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var_0);

  for(;;) {
    self.bomberusegrenade = 0;

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on)) {
        self.bombertarget = self.enemy.vehicle_riding_on;
      } else {
        self.bombertarget = undefined;
      }
    }

    wait 1;
  }
}

function ref_123FF() {
  level endon("game_ended");
  level endon("playing_intro_vo");
  level endon("stop_intro_vo");

  for(;;) {
    wait randomfloatrange(20, 35);
    play_vo_delay(level, "dx_cps_lass_tmtyl_stadium_nag_10");
    wait randomfloatrange(15, 25);
    play_vo_delay(level, "dx_cps_kama_tmtyl_stadium_nag_20");
    wait randomfloatrange(15, 25);
    play_vo_delay(level, "dx_cps_kama_tmtyl_stadium_nag_30");
  }
}

function play_intro_vo() {
  level endon("game_ended");
  level notify("playing_intro_vo");
  level endon("stop_intro_vo");
  wait 2;
  play_vo_delay(level, "dx_cps_kama_overwatch_brief_10");
  play_vo_delay(level, "dx_cps_lass_overwatch_brief_20");
  play_vo_delay(level, "dx_cps_kama_overwatch_brief_30");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "ping_response_copy");
  level notify("overwatch_played_intro_vo");
}

function play_intro2_vo() {
  play_vo_delay(level, "dx_cps_lass_overwatch_brief_40");
  level.ref_139B5 = 0;
}

function play_jammer_destroyed_vo() {
  if(!isDefined(level.vo_jammerdestroyed)) {
    level.vo_jammerdestroyed = 1;
  } else {
    level.vo_jammerdestroyed++;
  }

  var_0 = undefined;
  var_1 = undefined;
  level.ref_139B5 = 1;

  switch (level.vo_jammerdestroyed) {
    case 1:
      var_0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_30";
      var_1 = undefined;
      break;
    case 2:
      var_0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_20";
      var_1 = 1;
      break;
    case 3:
      var_0 = "dx_cps_lass_overwatch_scrambler_destroyed_30";
      var_1 = 2;
      break;
    case 4:
      var_0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_40";
      var_1 = undefined;
      break;
    case 5:
      var_0 = "dx_cps_lass_overwatch_all_scramblers_10";
      var_1 = 3;
      level.vo_jammerdestroyed = undefined;
      break;
  }

  if(isDefined(var_0)) {
    level.vehicle_cp_createlate = gettime();
    play_vo_delay(level, var_0, undefined, undefined, undefined, 0.2);
  }

  if(isDefined(var_1)) {
    switch (var_1) {
      case 1:
        wait 0.2;
        play_vo_delay(level, "dx_cps_land_overwatch_landlord_checkin_1_10");
        play_vo_delay(level, "dx_cps_land_overwatch_landlord_checkin_1_30");
        break;
      case 2:
        wait 0.2;
        play_vo_delay(level, "dx_cps_aqlie_overwatch_landlord_checkin_2_10");
        play_vo_delay(level, "dx_cps_land_overwatch_landlord_checkin_2_20");
        level notify("overwatch_start_tanks");
        var_2 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
        play_vo_delay(level, scripts\engine\utility::random(var_2), undefined, undefined, undefined, 1);
        break;
      case 3:
        level notify("spawn_overwatch_heli_boss");
        break;
    }
  }

  level.ref_139B5 = 0;
}

function play_jammer_returning_vo() {
  if(!isDefined(level.vo_jammerreturning)) {
    level.vo_jammerreturning = 1;
  } else {
    level.vo_jammerreturning++;
  }

  level.ref_139B5 = 1;
  var_0 = undefined;

  switch (level.vo_jammerreturning) {
    case 2:
      var_0 = "dx_cps_lass_overwatch_scrambler_returning_10";
      break;
    case 3:
      var_0 = "dx_cps_lass_overwatch_scrambler_returning_20";
      break;
    case 4:
      var_0 = "dx_cps_lass_overwatch_scrambler_returning_30";
      break;
    case 5:
      var_0 = "dx_cps_lass_overwatch_scrambler_returning_20";
      break;
  }

  if(isDefined(level.vehicle_cp_createlate)) {
    if(gettime() < level.vehicle_cp_createlate + 6000) {
      wait 6;
    }
  }

  if(isDefined(var_0)) {
    wait 0.35;
    play_vo_delay(level, var_0, undefined, undefined, undefined, 0.25);
  }

  level.ref_139B5 = 0;
}

function play_helicopter_vo() {
  level.ref_139B5 = 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_enemy_helo_nag_30", undefined, undefined);
  level.ref_139B5 = 0;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_lass_overwatch_enemy_helo_nag_30");
  play_vo_delay(level, "dx_cps_lass_overwatch_enemy_helo_nag_30", undefined, undefined, 1, undefined, 40);
  level.overwatch_boss waittill("death", var_0);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_lass_overwatch_enemy_helo_nag_30");

  if(isDefined(var_0) && isPlayer(var_0)) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "obj_sitrep_success");
    return;
  }
}

function heli_help(var_0) {
  level.overwatch_boss endon("death");
  level endon("game_ended");

  for(;;) {
    wait var_0;
    thread give_all_players_munition(level);
  }
}

function tank_help(var_0) {
  level endon("overwatch_tanks_dead");
  level endon("game_ended");

  for(;;) {
    wait var_0;
    thread give_all_players_munition(level);
  }
}

function play_win_vo() {
  level.ref_139B5 = 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_mission_complete_10");
  wait 1;
  play_vo_delay(level, "dx_cps_kama_overwatch_mission_complete_20");
  wait 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_mission_complete_30");
  wait 1;
  play_vo_delay(level, "dx_cps_kama_overwatch_mission_complete_40");
  level.ref_139B5 = 0;
}

function ref_130A8(var_0) {
  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340D(2, 1, 1);
  }

  wait 2;

  foreach(var_2 in level.players) {
    if(!istrue(var_2.try_to_punish_with_jugg)) {
      continue;
    }

    var_5 = var_2 getEye();
    var_6 = spawn("script_model", var_5);
    var_6 setModel("tag_origin");
    var_6.angles = (0, 200, 0);
    var_6 linkTo(var_0);
    var_2 playerhide();
    var_2 allowfire(0);
    var_2 disableoffhandweapons();
    var_2 disableusability();
    var_2 allowmovement(0);
    var_2 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var_2, var_6);
    var_2 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "tag_origin", 1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("cg_fov", "50");
    return;
  }
}