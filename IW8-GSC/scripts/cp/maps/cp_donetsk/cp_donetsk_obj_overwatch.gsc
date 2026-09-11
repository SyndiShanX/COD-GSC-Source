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
  var0 = &scripts\cp\cp_objectives::registerobjective;
  [[var0]]("obj_overwatch", &obj_maj_intro_init, &obj_maj_intro_start, &obj_maj_intro_end, &debugbeatobjective, &debug_start_overwatch);
  [[var0]]("obj_overwatch_bombs", &obj_maj_bombdefuse_init, &obj_maj_bombdefuse_start, &obj_maj_bombdefuse_end, &debugbeatobjective);
  thread register_spawn_functions();
}

function register_interactions() {}

function obj_maj_intro_init(var0) {
  level.ref_139b5 = 1;
  thread spawn_overwatch_extraguns();
  thread spawn_fake_loots();
  thread ref_135ac();
  thread spawn_exfil_heli_and_rpgs();
  thread ref_131f0();
  thread ref_11a7d();
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_tmtyl");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_tmtyl_0");
}

function obj_maj_intro_start(var0) {
  wait 1;
  var1 = scripts\engine\utility::getStruct("stadium_entrance", "targetname");
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_position(var0.objectiveindex, var1.origin);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_setlabel(var0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/STADIUM_APPROACH");
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  thread ref_135ae();
  thread ref_123ff();
  var2 = 4100;
  var3 = var2 * var2;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var3)) {
    wait 0.1;
  }

  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("stadium_1", ["deployable_cover"]);
  thread play_intro_vo();
  level waittill("overwatch_played_intro_vo");
  var4 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
  var2 = 3500;
  var3 = var2 * var2;

  while(!scripts\cp\utility::any_player_nearby(var4.origin, var3)) {
    wait 0.1;
  }

  thread play_intro2_vo();
}

function obj_maj_intro_end(var0) {
  scripts\cp\cp_objectives::overridenextstep(var0, "obj_overwatch_bombs");
}

function obj_maj_bombdefuse_init(var0) {
  thread spawn_juggs();
  thread convoy_start();
  thread run_helicopter_boss();
}

function obj_maj_bombdefuse_start(var0) {
  level endon("mission_fail");
  scripts\cp\cp_hacking::hacking_init();
  scripts\cp\utility::ref_123fe("mus_cp_landlord_stadium");

  for(var1 = 0; var1 < 5; var1++) {
    hack_relocate(var1, var0);
    lb_impulse_dmg_factor_mid_high(var1, var0);

    if(var1 == 4) {
      scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_bombs");
    }

    if(var1 == 0) {
      lb_impulse_dmg_factor_mid_low(var0);
    } else if(var1 != 2) {
      objective_unsetlocation(var0.objectiveindex, 0);
      wait 6;
    }

    if(var1 == 2) {
      objective_unsetlocation(var0.objectiveindex, 0);
      wait_for_tank_deaths(level);
    }
  }

  wait 1;
  objective_unsetlocation(var0.objectiveindex, 0);
  wait_for_boss_death(level);
  level notify("overwatch_heli_boss_dead");
  level notify("despawn_convoy_05");
  wait 1;

  if(level.overwatch_tanks.size > 0) {
    objective_setlocation(var0.objectiveindex, 0, level.overwatch_tanks[0]);
    objective_setplayintro(var0.objectiveindex, 1);
    objective_setplayoutro(var0.objectiveindex, 1);
    objective_state(var0.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
    objective_setlabel(var0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
    objective_setdescription(var0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
    objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
    objective_sethot(var0.objectiveindex, 1);
    objective_setbackground(var0.objectiveindex, 1);
    objective_addalltomask(var0.objectiveindex);
    objective_showtoplayersinmask(var0.objectiveindex);
    thread ref_13f61(level, level.overwatch_tanks[0]);

    while(level.overwatch_tanks.size > 0) {
      wait 1;
    }
  }

  level notify("overwatch_final_tank_dead");
  wait 1;
  thread play_win_vo();
}

function ref_13f61(var0, var1) {
  var0 waittill("death");
  objective_unsetlocation(var1, 0);
}

function obj_maj_bombdefuse_end(var0) {
  stop_emp_effects_on_players(level);
  level.set_up_blockade_gate_anims = undefined;
  thread ref_12dd6();
}

function wait_for_boss_death() {
  level waittill("spawn_overwatch_heli_boss");
  wait 1;

  if(!isDefined(level.overwatch_boss) || !isent(level.overwatch_boss)) {
    return;
  }

  var0 = "obj_overwatch_heli";
  var1 = scripts\cp\cp_objectives::requestworldid(var0, 15);
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 1);
  var2 = level.overwatch_boss scripts\engine\utility::spawn_tag_origin();
  var2 notsolid();
  var2 show();
  var2 linkTo(level.overwatch_boss, "tag_origin", (0, 0, 256), (0, 0, 0));
  level.overwatch_boss.obj_pos = var2;
  objective_setlocation(var1, 0, level.overwatch_boss.obj_pos);
  objective_state(var1, "current");
  scripts\cp\cp_objectives::ref_11f80(var1);
  objective_setlabel(var1, &"CP_SUBURBS_OBJECTIVES/BOSS_HELI_SHOOT");
  objective_setdescription(var1, &"CP_SUBURBS_OBJECTIVES/BOSS_HELI");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_sethot(var1, 1);
  objective_setbackground(var1, 0);
  objective_addalltomask(var1);
  objective_showtoplayersinmask(var1);
  scripts\cp\utility::ref_123fe("mus_cp_landlord_juggernaut");
  level thread scripts\cp\utility::objective_update("obj_overwatch_heli", undefined, undefined, undefined, 1, undefined, 4);

  if(isDefined(level.overwatch_boss) && isalive(level.overwatch_boss)) {
    level.overwatch_boss waittill("death");
  }

  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_heli");
  scripts\cp\utility::ref_123fe("");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("overwatch_soldiers_05_bombers");
  objective_state(var1, "done");
  scripts\cp\cp_objectives::freeworldid(var0);
}

function wait_for_tank_deaths() {
  level waittill("overwatch_start_tanks");
  thread spawn_overwatch_tanks();
  thread tank_hint_message();
  thread give_all_players_munition(level, level.priority_player);
  level.ref_121a6 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_tank_backup");
  var0 = "obj_overwatch_tanks";
  var1 = scripts\cp\cp_objectives::requestworldid(var0, 15);
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 1);
  objective_state(var1, "current");
  scripts\cp\cp_objectives::ref_11f80(var1);
  objective_setlabel(var1, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS_OBJ");
  objective_setdescription(var1, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_sethot(var1, 1);
  objective_setbackground(var1, 1);
  objective_addalltomask(var1);
  objective_showtoplayersinmask(var1);
  scripts\cp\utility::ref_123fe("mus_cp_landlord_juggernaut");
  level thread scripts\cp\utility::objective_update("obj_overwatch_tanks", undefined, undefined, undefined, 1, undefined, 3);
  thread ref_13a59();
  level.ref_11f68 = var1;

  while(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2) {
    wait 1;
  }

  while(level.overwatch_tanks.size > 0) {
    wait 1;
  }

  level notify("overwatch_tanks_dead");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("overwatch_tank_backup");
  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_tanks");
  scripts\cp\utility::ref_123fe("");
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  objective_state(var1, "done");
  scripts\cp\cp_objectives::freeworldid(var0);
}

function ref_13a59() {
  level endon("game_ended");
  var0 = 12544;
  var1 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
  var2 = var1.origin + (-254, -607, -64);
  var3 = 180;

  for(;;) {
    wait var3;

    if(level.overwatch_tanks.size >= 4) {
      var4 = "rpg_hint_visual";
      var5 = scripts\cp\cp_objectives::requestworldid(var4, 2);
      objective_setplayintro(var5, 1);
      objective_setplayoutro(var5, 0);
      objective_setbackground(var5, 0);
      objective_sethot(var5, 0);
      objective_position(var5, var2);
      objective_state(var5, "current");
      scripts\cp\cp_objectives::ref_11f80(var5);
      objective_icon(var5, "icon_waypoint_objective_general");
      objective_setlabel(var5, &"CP_SUBURBS_OBJECTIVES/BOSS_TANKS");
      objective_setownerteam(var5, "allies");
      objective_addalltomask(var5);
      objective_showtoplayersinmask(var5);
      play_vo_delay(level, "dx_cps_kama_nag_go_to_waypoint_20");
      var6 = 0;

      for(;;) {
        if(scripts\cp\utility::any_player_nearby(var2, var0)) {
          break;
        }

        if(!isDefined(level.overwatch_tanks) || level.overwatch_tanks.size < 2) {
          break;
        }

        if(var6 > 30) {
          break;
        }

        wait 1;
        var6 += 1;
      }

      if(var3 > 100) {
        var3 -= 60;
      }

      objective_state(var5, "done");
      scripts\cp\cp_objectives::freeworldid(var4);
      continue;
    }

    break;
  }
}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function spawn_intro_soldiers() {}

function ref_135ae() {
  level.ref_135a1 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_01");
  thread ref_1436a(level);
}

function spawn_overwatch_soldiers_02(var0) {
  level endon("game_ended");
  var1 = 4000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var1)) {
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

function vehicle_dismount_watcher(var0, var1) {
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
    var0 = 1000;

    if(isDefined(self.ref_12925.radius)) {
      var0 = self.ref_12925.radius;
    }

    vehicle_fob_think(self.ref_12925, var0, "cpu_hacking_done");
  }

  vehicle_docollisiondamagetoplayer();
}

function watch_for_player_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isPlayer(var1)) {
      self.ref_132b8 = 1;
      return;
    }
  }
}

function vehicle_damage_updatestate(var0) {
  self endon("death");
  self.ignoreall = 1;
  var1 = getdvarint("scr_jugg_hold_dist", var0);
  var2 = var1 * var1;
  thread watch_for_player_damage();

  for(;;) {
    if(istrue(self.ref_132b8)) {
      break;
    }

    if(scripts\cp\utility::any_player_nearby(self.origin, var2)) {
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

function cargo_truck_mg_enterendinternal(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = 1000;
  jumpiffalse(isDefined(var0)) LOC_0000001d;
  var1 = var0;

  for(;;) {
    level waittill("data_relocated", var2);

    if(isDefined(var2) && isDefined(self.spawnpoint) && distancesquared(self.spawnpoint.origin, var2.origin) < var1 * var1) {
      var3 = 1000;

      if(isDefined(var2.target)) {
        var4 = scripts\engine\utility::getStruct(var2.target, "targetname");

        if(isDefined(var4)) {
          var2 = var4;
        }
      }

      self.ref_12925 = var2;
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
    var0 = scripts\cp\utility::get_closest_living_player();

    while(isDefined(var0) && isalive(var0)) {
      scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
      wait 5;
    }

    wait 1;
  }
}

function vehicle_fob_think(var0, var1, var2) {
  level endon("game_ended");
  self endon("death");
  self endon("end_pursuit");
  self notify("pursuing_target");
  self endon("pursuing_target");

  if(isDefined(var2)) {
    level endon(var2);
    self endon(var2);
  }

  if(!isDefined(var1)) {
    var1 = 1000;
  }

  var3 = 2;
  var4 = int(var3 * 20);

  while(isDefined(var0)) {
    scripts\cp\cp_modular_spawning::set_goal_radius(var1);
    scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
    wait var3;
  }
}

function ref_13582() {
  level.ref_13598 = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_1");
}

function ref_13583() {
  level.ref_13599 = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_2");
}

function ref_13584() {
  level.ref_1359a = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_3");
}

function ref_13585() {
  level.ref_1359b = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_4");
}

function ref_13586() {
  level.ref_1359c = scripts\cp\cp_modular_spawning::run_spawn_module("ow_lmg_5");
}

function complete_game() {
  wait 1;

  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0].ability_invulnerable = 1;
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

function hack_relocate(var0, var1) {
  level endon("game_ended");
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;

  switch (var0) {
    case 0:
      var2 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
      var3 = "obj_overwatch_bomb_1";
      var5 = (0, 0, 0);
      var6 = (0, 0, 64);
      var7 = "obj_jammer_01";
      var4 = scripts\engine\utility::getStruct("overwatch_origin_01", "targetname");
      var8 = "mus_cp_landlord_filescopied_1";
      thread convoy_start_1();
      thread spawning_poi_handler(level, "01");
      thread ref_13582();
      level thread scripts\cp\utility::objective_update("obj_overwatch_bombs", undefined, undefined, undefined, 1, var0);
      break;
    case 1:
      var2 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
      var3 = "obj_overwatch_bomb_2";
      var5 = (0, 0, 32);
      var6 = (0, 0, 64);
      var7 = "obj_jammer_02";
      var4 = scripts\engine\utility::getStruct("overwatch_origin_02", "targetname");
      var8 = "mus_cp_landlord_filescopied_2";
      var9 = "stadium_2";
      thread ref_1350a();
      thread spawn_overwatch_soldiers_02(level);
      thread ref_13583();
      thread convoy_start_2(level);
      thread wait_to_spawn_convoy_3(level);
      thread spawning_poi_handler(level, "02");
      break;
    case 2:
      var2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
      var3 = "obj_overwatch_bomb_3";
      var5 = (0, 0, 32);
      var6 = (0, 0, 64);
      var7 = "obj_jammer_03";
      var4 = scripts\engine\utility::getStruct("overwatch_origin_03", "targetname");
      var8 = "mus_cp_landlord_filescopied_3";
      var9 = "stadium_3";
      thread spawn_overwatch_soldiers_03();
      thread ref_13584();
      thread spawning_poi_handler(level, "03");
      break;
    case 3:
      var2 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
      var3 = "obj_overwatch_bomb_4";
      var5 = (0, 0, 32);
      var6 = (0, 0, 64);
      var7 = "obj_jammer_04";
      var4 = scripts\engine\utility::getStruct("overwatch_origin_04", "targetname");
      var8 = "mus_cp_landlord_filescopied_1";
      var9 = "stadium_4";
      thread spawn_overwatch_soldiers_04();
      thread ref_13585();
      thread convoy_start_4();
      thread spawning_poi_handler(level, "04");
      break;
    case 4:
      var2 = scripts\engine\utility::getStruct("obj_bomb_05", "targetname");
      var3 = "obj_overwatch_bomb_5";
      var5 = (0, 0, 32);
      var6 = (0, 0, 64);
      var7 = "obj_jammer_05";
      var4 = scripts\engine\utility::getStruct("overwatch_origin_05", "targetname");
      var8 = "mus_cp_landlord_filescopied_2";
      var9 = "stadium_5";
      thread ref_13a6f(level);
      thread spawn_overwatch_soldiers_05();
      thread ref_13586();
      thread convoy_start_5();
      thread hurt_trigger_manage_dog_tag();
      thread spawning_poi_handler(level, "05");
      break;
    case 5:
      var2 = undefined;
      var3 = "obj_overwatch_bomb_5";
      var5 = undefined;
      break;
  }

  objective_setlabel(var1.objectiveindex, "");

  if(isDefined(var2)) {
    level notify("data_relocated", var2);
    objective_setbackground(var1.objectiveindex, 1);
    objective_setlocation(var1.objectiveindex, 0, var2.origin + var5);
    level thread scripts\cp\cp_objectives::ref_1317e(var1, var2.origin);
    objective_icon(var1.objectiveindex, "icon_waypoint_cyber_bombsite");
    objective_sethot(var1.objectiveindex, 0);
    objective_setownerteam(var1.objectiveindex, "neutral");
    objective_setlabel(var1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DOWNLOAD");
    objective_setdescription(var1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DOWNLOAD");
    objective_state(var1.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11f80(var1.objectiveindex);
    thread relocate_gunship_origin(level);
    thread setup_enemy_sentries(level);

    if(isDefined(var9)) {
      scripts\cp\crate_drops\cp_crate_drops::ref_12c40(var9, ["deployable_cover"]);
    }

    var1.use_old_label = 1;
    level.overwatch_emp_low = 0.8;
    level.overwatch_emp_high = 1.2;
    level.overwatch_emp_free = 5;
    thread play_jammer_returning_vo();
    thread handle_wavespawner_amount(level);
    var10 = get_jammer_mdl(var7);
    thread setup_router_objective(level);
    level waittill("router_placed");

    if(var0 == 4) {
      thread ref_13b07();
    }

    level.overwatch_emp_low = 4;
    level.overwatch_emp_high = 9;
    level.overwatch_emp_free = 1.1;
    scripts\cp\utility::ref_123fe(var8);
    thread start_hack_threaded(level, var1, var2, var6);
    level waittill("cpu_hacking_done");
    wait 1;
    return;
  }
}

function ref_13a6f(var0) {
  var1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var3 in var1) {
    var3 thread scripts\cp\cp_modular_spawning::set_script_origin_other_for_group(var0);
  }
}

function start_hack_threaded(var0, var1, var2, var3) {
  var4 = &scripts\cp\cp_objective_mechanics::starthackingdefense;
  var5 = 30;

  switch (var3) {
    case 0:
      var5 = 25;
      break;
    case 1:
      var5 = 30;
      break;
    case 2:
      var5 = 35;
      break;
    case 3:
      var5 = 40;
      break;
    case 4:
      var5 = 90;
      break;
  }

  if(getdvarint("scr_overwatch_speed", 0) > 0) {
    var5 = 5;
  }

  level[[var4]](var0, var1.origin - var2, var5, "data_downloaded", 320);
  level notify("data_downloaded");
}

function ref_11a7d() {
  level endon("game_ended");

  if(isDefined(level.ref_121aa)) {
    return;
  }

  level.ref_121aa = 0;
  var0 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
  var1 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
  var2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
  var3 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
  var4 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var0.origin, var4)) {
    wait 0.1;
  }

  var5 = node_set_children(var0, 1);
  ref_1432e(var1, var5);
  var5 = node_set_children(var1, 2);
  ref_1432e(var2, var5);
  var5 = node_set_children(var2, 3);
  ref_1432e(var3, var5);
  var5 = node_set_children(var3, 4);
  ref_1432e(undefined, var5);
  level waittill("cpu_hacking_done");
  waitframe();

  if(isDefined(var5)) {
    next_threshold(var5);
    return;
  }
}

function node_set_children(var0) {
  if(level.ref_121aa >= 3) {
    return undefined;
  }

  var1 = spawn("script_model", self.origin);
  var1.team = "allies";
  var1.id = var0;
  var1 makescrambler(level.players[0], "little");
  thread ref_12f1d(level);
  level.ref_121aa += 1;
  return var1;
}

function ref_1432e(var0, var1) {
  level endon("game_ended");
  level waittill("cpu_hacking_done");
  waitframe();

  if(isDefined(var1)) {
    next_threshold(var1);
  }

  if(isDefined(var0)) {
    var2 = 2250000;

    while(!scripts\cp\utility::any_player_nearby(var0.origin, var2)) {
      wait 0.1;
    }

    return;
  }
}

function next_threshold(var0) {
  if(!isDefined(var0) || !isent(var0)) {
    return;
  }

  var0 clearscrambler();
  var0 notify("clear_scrambler");
  level.ref_121aa -= 1;
}

function ref_12f1d(var0) {
  level endon("game_ended");
  var0 endon("clear_scrambler");
  level.players[0] waittill("disconnect");

  if(isDefined(var0)) {
    next_threshold(var0);
    return;
  }
}

function setup_enemy_sentries(var0) {
  var1 = undefined;

  switch (var0) {
    case 0:
      var1 = "spawner_ow_0";
      break;
    case 1:
      var1 = "spawner_ow_1";
      break;
    case 2:
      var1 = "spawner_ow_2";
      break;
    case 3:
      var1 = "spawner_ow_3";
      break;
    case 4:
      var1 = "spawner_ow_4";
      break;
  }

  if(isDefined(var1)) {
    level.initlocationcircle = var1;
    level.initlethalmaxoffsetmap = var1;
    return;
  }
}

function wait_for_players_near(var0) {
  var1 = 14400;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var1)) {
      break;
    }

    wait 0.25;
  }

  level notify("players_near_data");
}

function emp_effects_on_nearby_players(var0) {
  level endon("stop_overwatch_emp_effects");
  var1 = 193600;

  for(;;) {
    for(var2 = 0; var2 < level.players.size; var2++) {
      var3 = undefined;

      if(istrue(level.players[var2].mark_emp_effects)) {
        var3 = distancesquared(level.players[var2].origin, var0);

        if(var3 > var1) {
          level.players[var2] notify("stop_overwatch_emp_effects");
          level.players[var2].mark_emp_effects = undefined;
        }

        continue;
      }

      if(!level.players[var2] scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isDefined(var3)) {
        var3 = distancesquared(level.players[var2].origin, var0);
      }

      if(var3 < var1) {
        level.players[var2].mark_emp_effects = 1;
        thread emp_effects_flickering(level);
      }
    }

    wait 0.25;
  }
}

function emp_effects_flickering(var0) {
  level endon("stop_overwatch_emp_effects");
  var0 endon("stop_overwatch_emp_effects");
  var0 endon("disconnect");
  var1 = 0.75;

  for(;;) {
    var2 = randomfloatrange(level.overwatch_emp_low, level.overwatch_emp_high);
    level thread scripts\cp_mp\emp_debuff::ref_1241a(var0, 5);
    var3 = randomfloat(level.overwatch_emp_free);
    wait var2 + var1 + var3;
  }
}

function ref_131f0() {
  scripts\cp\utility::skydivestreamhintdvars("overwatch");
}

function lb_impulse_dmg_factor_mid_high(var0, var1) {
  level endon("game_ended");
  level endon("hostage_released");
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;

  switch (var0) {
    case 0:
      var2 = scripts\engine\utility::getStruct("obj_bomb_01", "targetname");
      var3 = "obj_overwatch_bomb_1";
      var4 = 120;
      var5 = 60;
      var6 = 30;
      var7 = (0, 0, 0);
      var8 = "obj_jammer_01";
      break;
    case 1:
      var2 = scripts\engine\utility::getStruct("obj_bomb_02", "targetname");
      var3 = "obj_overwatch_bomb_2";
      var4 = 180;
      var5 = 90;
      var6 = 45;
      var7 = (0, 0, 32);
      var8 = "obj_jammer_02";
      thread take_away_players_gunshipmunition();
      thread convoy_start_2b();
      break;
    case 2:
      var2 = scripts\engine\utility::getStruct("obj_bomb_03", "targetname");
      var3 = "obj_overwatch_bomb_3";
      var4 = 180;
      var5 = 90;
      var6 = 45;
      var7 = (0, 0, 32);
      var8 = "obj_jammer_03";
      thread take_away_players_gunshipmunition();
      thread spawn_overwatch_soldiers_03();
      break;
    case 3:
      var2 = scripts\engine\utility::getStruct("obj_bomb_04", "targetname");
      var3 = "obj_overwatch_bomb_4";
      var4 = 240;
      var5 = 120;
      var6 = 60;
      var7 = (0, 0, 32);
      var8 = "obj_jammer_04";
      thread take_away_players_gunshipmunition();
      thread convoy_start_4b();
      thread convoy_start_3b();
      break;
    case 4:
      var2 = scripts\engine\utility::getStruct("obj_bomb_05", "targetname");
      var3 = "obj_overwatch_bomb_5";
      var4 = 240;
      var5 = 120;
      var6 = 60;
      var7 = (0, 0, 32);
      var8 = "obj_jammer_05";
      thread take_away_players_gunshipmunition();
      break;
    case 5:
      var2 = undefined;
      var3 = "obj_overwatch_bomb_7";
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;
      var7 = undefined;
      break;
  }

  objective_setlabel(var1.objectiveindex, "");

  if(isDefined(var2)) {
    level notify("bomb_relocated");
    objective_setbackground(var1.objectiveindex, 1);
    objective_setdescription(var1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/SHOOT_JAMMER");
    objective_setlocation(var1.objectiveindex, 0, var2.origin + var7);
    objective_icon(var1.objectiveindex, "hud_icon_c4_plant");
    objective_sethot(var1.objectiveindex, 0);
    objective_setownerteam(var1.objectiveindex, "neutral");
    objective_setlabel(var1.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_SHOOT");
    objective_state(var1.objectiveindex, "current");
    scripts\cp\cp_objectives::ref_11f80(var1.objectiveindex);
    thread hint_jammer_damage(level);
    thread enable_jammer_damage(level, var8);
    level waittill("jammer_destroyed");
    scripts\cp\utility::ref_123fe("");
    scripts\cp\cp_objectives::screenent_c("minor_objective");
    thread play_jammer_destroyed_vo();
    thread scripts\cp\utility::objective_update("obj_overwatch_bombs", undefined, undefined, undefined, 1, var0 + 1);
    return;
  }
}

function stop_emp_effects_on_players() {
  level notify("stop_overwatch_emp_effects");

  for(var0 = 0; var0 < level.players.size; var0++) {
    level notify("emp_cleared");
    level.players[var0].mark_emp_effects = undefined;
  }
}

function start_heli_spawner(var0) {
  switch (var0) {
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

function ref_1350a() {
  level endon("game_ended");
  level endon("jammer_destroyed");
  level waittill("router_placed");
  level.watchleaderdescriptionchange = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer2");
  wait 2;
  level.watchmapselectexitonemp = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_jammer2b");
}

function buy_points_objectives_handler(var0, var1) {
  for(var2 = 0; var2 < level.agentarray.size; var2++) {
    if(distance2dsquared(level.agentarray[var2].origin, var0.origin) < var1) {
      if(isalive(level.agentarray[var2])) {
        return true;
      }
    }
  }

  return false;
}

function relocate_gunship_origin(var0) {
  level notify("request_relocation_gunship_origin");
  level endon("request_relocation_gunship_origin");

  while(istrue(level.gunshipinuse) || c130_crate()) {
    wait 0.1;
  }

  level.set_up_blockade_gate_anims = var0.origin;
}

function c130_crate() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    if(level.players[var0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      return true;
    }
  }

  return false;
}

function lb_impulse_dmg_factor_mid_low(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = (0, 0, 96);
  objective_setbackground(var0.objectiveindex, 0);
  objective_icon(var0.objectiveindex, "icon_waypoint_sp_generic");
  objective_setownerteam(var0.objectiveindex, "axis");
  objective_setprogressteam(var0.objectiveindex, "axis");
  objective_setlabel(var0.objectiveindex, &"CP_SUBURBS_OBJECTIVES/OBJ_DESTROY_VEHICLES");
  level.ref_11f67 = 0;
  var2 = 16900;

  if(!isDefined(level.player_can_mount)) {
    return;
  }

  if(!isDefined(level.player_can_mount.module_vehicles)) {
    return;
  }

  var3 = level.player_can_mount.module_vehicles[0];

  if(!isDefined(var3) || !isent(var3)) {
    return;
  }

  for(var4 = 0; var4 <= 7; var4++) {
    objective_unsetlocation(var0.objectiveindex, var4);
  }

  for(var5 = 0; var5 < var3.riders.size; var5++) {
    if(var5 == 0) {
      objective_setlocation(var0.objectiveindex, 0, var3);
    }

    if(isalive(var3.riders[var5]) && distance2dsquared(var3.riders[var5].origin, var3.origin) < var2) {
      if(istrue(var3.riders[var5].i_see_laststand_player_watcher)) {
        level.ref_11f67 += 1;
        var3.riders[var5] hudoutlineenable("outlinefill_nodepth_red");
        thread ref_1432c();
      }
    }
  }

  while(level.ref_11f67 > 0) {
    wait 0.1;
  }

  for(var4 = 0; var4 <= 7; var4++) {
    objective_unsetlocation(var0.objectiveindex, var4);
  }
}

function ref_1432c() {
  level endon("game_ended");
  thread zombiekilledlootcachecount(self.origin);
  scripts\engine\utility::ref_143a5("death", "lmg_too_far");
  level.ref_11f67 -= 1;
}

function zombiekilledlootcachecount(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = 160000;

  for(;;) {
    if(distance2dsquared(self.origin, var0) > var1) {
      self hudoutlinedisable();
      self notify("lmg_too_far");
      return;
    }

    wait 2;
  }
}

function spawning_poi_handler(var0, var1, var2) {
  level endon("game_ended");
  level notify("spawning_poi_handler");
  var3 = 640000;
  var4 = scripts\engine\utility::getStruct("obj_bomb_" + var0, "targetname");
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var4.origin, 4500, 10000);

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var4.origin, var3)) {
      break;
    }

    wait 0.5;
  }

  if(isDefined(var2)) {
    wait var2;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var4.origin);

  if(isDefined(var1)) {
    var5 = scripts\engine\utility::getStruct("obj_bomb_" + var1, "targetname");
    thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var5.origin, 9000, 15000);
    level waittill("spawning_poi_handler");
    thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var5.origin);
    return;
  }
}

function stop_if_ground_down(var0, var1, var2) {
  level endon("game_ended");
  wait 5;
  var3 = 0;

  if(isDefined(var0) && isDefined(level.players[var0])) {
    var3++;
  }

  if(isDefined(var1) && isDefined(level.players[var1])) {
    var3++;
  }

  jumpiffalse(isDefined(var2) && isDefined(level.players[var2])) LOC_0000004e;
  var3++;

  for(;;) {
    var4 = 0;

    if(isDefined(var0) && isDefined(level.players[var0])) {
      if(!level.players[var0] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var0].inlaststand)) {
        var4++;
      }
    }

    if(isDefined(var1) && isDefined(level.players[var1])) {
      if(!level.players[var1] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var1].inlaststand)) {
        var4++;
      }
    }

    if(isDefined(var2) && isDefined(level.players[var2])) {
      if(!level.players[var2] scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.players[var2].inlaststand)) {
        var4++;
      }
    }

    if(var4 >= var3) {
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

function wait_to_spawn_convoy_3(var0) {
  level endon("game_ended");
  var1 = 2000;
  var2 = var1 * var1;

  while(!scripts\cp\utility::any_player_nearby(var0, var2)) {
    wait 1;
  }

  wait 20;
  thread convoy_start_3();
}

function convoy_start_2(var0) {
  level endon("game_ended");
  level notify("despawn_convoy_01");
  var1 = 5300;
  var2 = 1200;
  var3 = scripts\engine\utility::getStruct("techo_ow_2", "targetname");

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, squared(var2))) {
      break;
    }

    wait 0.25;

    if(isDefined(var3) && scripts\cp\utility::any_player_nearby(var3.origin, squared(var1))) {
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

function similar_convoy_settings(var0, var1, var2) {
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_farz(1000);
  var4 thread scripts\cp\cp_convoy_manager::set_suspend_at_end_path(1);
  thread allow_driver_exit(level);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function allow_driver_exit(var0) {
  waitframe();
  var0 notify("able_to_deposit_driver");
  var0 scripts\cp\cp_convoy_manager::ref_1307d(0);
}

function register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("cp_overwatch_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_overwatch_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_overwatch_create_script_completed");
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("building_guards", 18, 18, 18, 0.1, 0, "building_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("building_guards", &setup_manual_goalpos);
  [[var0]]("overwatch_juggs", 3, 3, 3, 0.1, 0, "overwatch_juggs", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_juggs", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("overwatch_juggs", &vehicle_dismount_watcher);
  [[var0]]("overwatch_soldiers_01", 10, 10, 10, 0.1, 0, "overwatch_soldiers_01", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_01", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("overwatch_soldiers_01", &ref_1220a);
  [[var0]]("overwatch_soldiers_02", 7, 7, 7, 0.1, 0, "overwatch_soldiers_02", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_02", undefined, 20000, 30000);
  [[var0]]("overwatch_soldiers_03", 9, 9, 9, 0.1, 0, "overwatch_soldiers_03", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_03", undefined, 20000, 30000);
  [[var0]]("overwatch_soldiers_04", 7, 7, 7, 0.1, 0, "overwatch_soldiers_04", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_04", undefined, 20000, 30000);
  [[var0]]("overwatch_soldiers_05", 7, 7, 7, 0.1, 0, "overwatch_soldiers_05", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_05", undefined, 20000, 30000);
  [[var0]]("overwatch_soldiers_06", 7, 7, 7, 0.1, 0, "overwatch_soldiers_06", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_06", undefined, 20000, 30000);
  [[var0]]("overwatch_soldiers_05_bombers", 1, 1, 8, 0.1, 0, "overwatch_soldiers_05_bombers", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_05_bombers", undefined, 20000, 30000);
  [[var0]]("overwatch_tank_backup", 0, 12, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "overwatch_tank_backup", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("overwatch_soldiers_06", undefined, 20000, 30000);
  [[var0]]("ow_lmg_1", 2, 2, 2, 0.1, 0, "ow_lmg_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_1", &spawn_in_cover);
  [[var0]]("ow_lmg_2", 1, 1, 1, 0.1, 0, "ow_lmg_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_2", &spawn_in_cover);
  [[var0]]("ow_lmg_3", 4, 4, 4, 0.1, 0, "ow_lmg_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_3", &spawn_in_cover);
  [[var0]]("ow_lmg_4", 2, 2, 2, 0.1, 0, "ow_lmg_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_4", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_4", &spawn_in_cover);
  [[var0]]("ow_lmg_5", 3, 3, 3, 0.1, 0, "ow_lmg_5", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("ow_lmg_5", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("ow_lmg_5", &spawn_in_cover);
  [[var0]]("lbravo_spawner_jammer2", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("lbravo_spawner_jammer2", &play_hack_reminder_goto2);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer2", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer2b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer2b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer2b", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer1", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer1", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer1b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer1b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer1b", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer3", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer3", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer3b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer3b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer3b", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer4", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer4", undefined, 20000, 30000);
  [[var0]]("lbravo_spawner_jammer4b", 5, 5, 5, 0.1, 0, "lbravo_spawner_jammer4b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("lbravo_spawner_jammer4b", undefined, 20000, 30000);
  [[var0]]("juggheli_spawner_jam5_1", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_1", undefined, 20000, 30000);
  [[var0]]("juggheli_spawner_jam5_2", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_2", undefined, 20000, 30000);
  [[var0]]("juggheli_spawner_jam5_3", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_3", undefined, 20000, 30000);
  [[var0]]("juggheli_spawner_jam5_4", 2, 2, 2, 0.1, 0, "juggheli_spawner_jammer5_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_jammer5_4", undefined, 20000, 30000);
  [[var0]]("techo_ow_1", 4, 4, 4, 0.1, 0, "techo_ow_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_1_lmg", 2, 2, 2, 0.1, 0, "techo_ow_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_1", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_1_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_1_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_1");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_1_lmg");
  [[var0]]("techo_ow_2", 4, 4, 4, 0.1, 0, "techo_ow_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_2_lmg", 2, 2, 2, 0.1, 0, "techo_ow_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2_lmg");
  [[var0]]("techo_ow_2b", 4, 4, 4, 0.1, 0, "techo_ow_2b", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_2b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_2b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_2b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_2b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_2b_lmg");
  [[var0]]("techo_ow_3", 4, 4, 4, 0.1, 0, "techo_ow_3", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_3_lmg", 2, 2, 2, 0.1, 0, "techo_ow_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3_lmg");
  [[var0]]("techo_ow_3b", 4, 4, 4, 0.1, 0, "techo_ow_3b", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_3b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_3b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_3b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_3b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_3b_lmg");
  [[var0]]("techo_ow_4", 4, 4, 4, 0.1, 0, "techo_ow_4", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_4_lmg", 2, 2, 2, 0.1, 0, "techo_ow_4", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_4", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_4_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_4", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_4_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_4");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_4_lmg");
  [[var0]]("techo_ow_5", 4, 4, 4, 0.1, 0, "techo_ow_5", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_5_lmg", 2, 2, 2, 0.1, 0, "techo_ow_5", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5_lmg");
  [[var0]]("techo_ow_5b", 4, 4, 4, 0.1, 0, "techo_ow_5b", &watchforstopwaves, undefined, undefined);
  [[var0]]("techo_ow_5b_lmg", 2, 2, 2, 0.1, 0, "techo_ow_5b", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5b", &ref_13210);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("techo_ow_5b_lmg", &ref_13210);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5b", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("techo_ow_5b_lmg", undefined, 20000, 30000);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5b");
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, "techo_ow_5b_lmg");
}

function ref_1220a(var0, var1) {
  self.sightmaxdistance = 2000;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

function ref_13210(var0, var1) {
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

function setup_manual_goalpos(var0, var1) {
  var2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var2);

  switch (var0.group_name) {
    case "building_guards":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

function ref_1436a(var0) {
  level endon("game_ended");
  level endon("router_placed");

  while(var0.ai_spawned.size <= 5) {
    wait 1;
  }

  while(var0.activecount > 4) {
    wait 1;
  }

  level notify("ow_activate_first_wave");
}

function play_hack_reminder_goto2(var0) {
  thread ref_12941();
}

function ref_12941(var0) {
  level endon("game_ended");
  self endon("death");
  self waittill("unload");
  wait 1;
  var0 = scripts\engine\utility::getStruct("jammer2_bridge_goal", "targetname");
  scripts\cp\cp_modular_spawning::set_goal_radius(var0.radius);
  scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
  wait randomintrange(25, 35);
  thread vehicle_docollisiondamagetoplayer();
}

function spawn_in_cover(var0) {
  var1 = self getnearestnode();

  if(isDefined(var1)) {
    var2 = var1.angles;
    var3 = var1.origin;

    if(!issubstr(var1.type, "Prone")) {
      if(issubstr(var1.type, "Left")) {
        var2 += (0, 90, 0);
      } else if(issubstr(var1.type, "Right") || issubstr(var1.type, "Cover Crouch") || issubstr(var1.type, "Conceal") || issubstr(var1.type, "Cover Stand")) {
        var2 -= (0, 90, 0);
      }
    }

    self forceteleport(var3, var2);
    self usecovernode(var1, 1);
    self setgoalnode(var1);
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

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("end_wave_tugofwar_spawners");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function stopwaveandstartthisone(var0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var0]]();
}

function handle_wavespawner_amount(var0) {
  var1 = undefined;

  switch (var0) {
    case 2:
    case 1:
    case 0:
      var1 = "overwatch_low";
      break;
    case 3:
      var1 = "overwatch_high";
      break;
    case 4:
      var1 = "overwatch_laser";
      break;
  }

  if(var0 == 0) {
    level scripts\engine\utility::ref_143a5("router_placed", "ow_activate_first_wave");
    wait 15;
  }

  if(var0 == 4) {
    level scripts\engine\utility::ref_143a5("router_placed");
    wait 15;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(1, var1);
}

function handle_pause_wavespawning() {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
}

function setup_router_objective(var0) {
  level endon("game_ended");
  var1 = (11.9, 14.59, 40.5);
  var2 = rotatevector(var1, var0.angles);
  var3 = spawn("script_model", var0.origin + var2);
  var3.angles = var0.angles + (0, 180, 0);
  var3 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "cp_tac_waypoint_router", &"CP_SUBURBS_OBJECTIVES/PLACE_ROUTER", 25, "duration_medium", "show", 275, 110, 88, 60);
  var3 setModel("tag_origin");

  for(;;) {
    var3 waittill("trigger", var4);

    if(!var4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var4 playlocalsound("cp_generic_placement");
    break;
  }

  level notify("router_placed", var0);
  var3 makeunusable();
  var3 setModel("equipment_router_flat_invisi");
  var3 setscriptablepartstate("transfer", "start");
  level waittill("cpu_hacking_done");
  var3 setscriptablepartstate("transfer", "finish");
  wait 30;
  var3 delete();
}

function spawn_overwatch_tanks() {
  var0 = scripts\engine\utility::getStructArray("overwatch_enemy_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.overwatch_tanks = [];

  for(var1 = 0; var1 < var0.size; var1++) {
    thread spawn_overwatch_tank(level, var0[var1]);
    wait 1 + randomfloat(0.5);
  }
}

function ref_135ad() {
  if(!isDefined(level.overwatch_tanks)) {
    level.overwatch_tanks = [];
  }

  var0 = scripts\engine\utility::getStruct("overwatch_enemy_tank_last", "targetname");
  thread spawn_overwatch_tank(level, var0, undefined);
}

function spawn_overwatch_tank(var0, var1, var2) {
  level endon("game_ended");

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = 50;
  }

  var3 = spawnStruct();
  var4 = spawnStruct();
  var3.origin = var0.origin;
  var3.angles = var0.angles;
  var3.spawntype = "GAME_MODE";
  var3.owner = undefined;
  var3.team = "axis";
  var3.faceawayfromowner = 0;
  var3.cancapture = 0;
  var3.cancaptureimmediately = 0;
  var3.activateimmediately = 1;
  var3.cantimeout = 0;
  var3.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var3);
  var3.spawnmethod = "airdrop_at_position_unsafe";
  var5 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var3, var4);

  if(!isDefined(var5)) {
    return;
  }

  wait 10;

  if(isDefined(var1)) {
    var5.objiconid = var1;
    objective_setlocation(level.ref_11f68, var5.objiconid, var5);
  }

  level.overwatch_tanks[level.overwatch_tanks.size] = var5;

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers[level.vo_paratroopers.size] = var5;
  thread tank_waittill_death();
  var5 endon("death");
  var5 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var5.headicon, 8000);
  var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var5, "tur_bradley_mp");
  var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var5, "tur_gun_lighttank_mp");
  var8 = 250000;
  var9 = 36000000;
  var10 = scripts\engine\utility::getStructArray("overwatch_tank_path", "targetname");
  var11 = sortbydistance(var10, var5.origin)[0];
  var5.ref_13a4c = build_tank_path(var11);
  var5.ref_13a46 = build_tank_duration(var11);
  var5 startpathnodes(var5.ref_13a4c, var5.ref_13a46, 0, 0.5, 0.5, 0, 0, 1);
  thread ref_14350();

  for(;;) {
    var12 = var5 scripts\cp\utility::get_closest_living_player(var9);

    if(!isDefined(var12)) {
      wait 1;
      continue;
    }

    if(istrue(var12.binvehicle) && isDefined(var12.vehicle)) {
      if(var6 turretcantarget(var12.vehicle.origin + (0, 0, 50))) {
        var6 settargetentity(var12.vehicle);
      }

      if(var7 turretcantarget(var12.vehicle.origin + (0, 0, 50))) {
        var7 settargetentity(var12.vehicle);
      }
    } else {
      ref_130f2(var6, var12, 9, var2, var8);
      var7 settargetentity(var12);
    }

    thread tank_shoot_at_target(var5, var7);
    thread tank_shoot_at_target(var5, var6, undefined);
    wait randomfloatrange(11, 16);
  }
}

function ref_130f2(var0, var1, var2, var3) {
  if(distancesquared(self.origin, var0.origin) < var3) {
    self settargetentity(var0);
    return;
  }

  if(var1 > randomint(9)) {
    if(!isDefined(var2)) {
      var2 = 20;
    }

    var4 = randomfloatrange(var2 * -1, var2);
    var5 = randomfloatrange(var2 * -1, var2);
    var6 = randomfloatrange(var2 * -1, var2);
    self settargetentity(var0, (var4, var5, var6));
    return;
  }

  self settargetentity(var0);
}

function tank_hint_message() {
  wait 12;

  for(var0 = 0; var0 < level.players.size; var0++) {
    if(level.players[var0].team == "allies" && level.players[var0] scripts\cp_mp\utility\player_utility::_isalive()) {
      level.players[var0] thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/TANK_DAMAGE_HELP", 4);
    }
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var1) && isPlayer(var1)) {
      var1.lasthitmarkertime = undefined;
      var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function tank_shoot_at_target(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("death");
  var3 = 8;
  var4 = 2;

  if(istrue(var1)) {
    var3 = randomintrange(80, 120);
    var4 = 0.05;
  }

  if(isDefined(var2)) {
    wait var2;
  }

  for(var5 = 0; var5 < var3; var5++) {
    var0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var4;
  }
}

function build_tank_path(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function build_tank_duration(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 4; isDefined(var2) && isDefined(var2.target); var1 = 4) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  if(isDefined(self.objiconid)) {
    objective_unsetlocation(level.ref_11f68, self.objiconid);
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

function spawn_enemy_lbravo(var0) {
  if(scripts\engine\utility::flag_exist("boss_heli")) {
    scripts\engine\utility::flag_set("boss_heli");
  }

  var1 = scripts\engine\utility::getStruct("boss_heli_spawn", "targetname");

  if(!isDefined(var1.angles)) {
    var1.angles = (0, 0, 0);
  }

  var1.classname_mp = "script_vehicle_apache_east";
  var1.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
  var1.vehicletype = "veh_apache_cp";
  level.overwatch_boss = scripts\common\vehicle::vehicle_spawn(var1);
  level.overwatch_boss scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
  level.overwatch_boss.spawnpoint = var1;
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
  thread flag_think(level.overwatch_boss, var0);
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

function flag_think(var0, var1) {
  level.overwatch_boss endon("death");

  if(isDefined(var0) && scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_wait(var0);
  }

  if(istrue(var1)) {
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.overwatch_boss);
    return;
  }

  level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.overwatch_boss);
}

function follow_path_until(var0) {
  self endon("death");
  var1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

  while(isDefined(var1)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var1.origin;
    var2 = self.gotopos;

    if(distance2dsquared(self.origin, var2) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var2, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var2, 0);
    }

    scripts\engine\utility::ref_143bb(15, "goal", "goal_reached", "near_goal");

    if(isDefined(var1.target) && var1.target != var0) {
      var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
      continue;
    }

    break;
  }

  var3 = var1;
  var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
  arrive_at_exfil_location(self, var1, var3);
}

function arrive_at_exfil_location(var0, var1, var2) {
  var0 setvehgoalpos(var2.origin, 1);
  var0 waittill("goal");
  var0 settargetyaw(var1.angles[1]);
  var0 setyawspeed(40, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location");
  var0.goalradius = 4;
  var0 setvehgoalpos(var1.origin, 1);
  var0 waittill("goal");
  var0 vehicle_setspeedimmediate(0);
  thread heli_sfx_shutdown();
  var0 vehicle_cleardrivingstate();
  var0 notify("heli_landed");
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

function setup_pilot(var0, var1, var2) {
  var3 = "tag_pilot";

  if(isDefined(var0)) {
    var3 = var0;
  }

  var4 = (0, 0, 0);

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = (0, 0, 0);

  if(isDefined(var2)) {
    var5 = var2;
  }

  if(!self tagexists(var3)) {
    var3 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var3));
  self.pilot setModel("british_pilot_fullbody");
  self.pilot linkTo(self, var3, var4, var5);
  self.pilot scriptmodelplayanim("vh_blima_rappel_pilot");
}

function heli_damagemonitor() {
  self endon("death");
  var0 = 0;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
    self.health = 1000000;

    if(isDefined(var2) && var2 == self) {
      continue;
    }

    if(isDefined(var14) && isDefined(var14.owner) && var14.owner == self) {
      continue;
    }

    if(is_snipe_kill(var2, var4, var10)) {
      var0++;

      if(var0 == 2) {
        var2 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var2 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        thread do_heli_crash(var2);
        return;
      }

      var2.lasthitmarkertime = undefined;
      var2 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      continue;
    }

    if(!isexplosivedamagemod(var5)) {
      if(istrue(self.bullets_can_damage)) {
        var1 *= 0.1;
      } else {
        var1 = 0;
      }

      var2.lasthitmarkertime = undefined;
      var2 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    } else {
      var2.lasthitmarkertime = undefined;
      var2 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var10) && var10.basename == "iw8_thermite_mp") {} else if(var1 < 700) {
        var1 = 700;
      }

      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
    }

    self.health_remaining -= var1;

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

      if(isDefined(var10) && issubstr(var10.basename, "molotov")) {
        if(isDefined(var2) && isPlayer(var2)) {
          var2 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var2) && isPlayer(var2)) {
        var2 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
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

function ishelperdrone(var0) {
  playFX(level._effect["vfx_blima_explosion"], var0);
}

function is_snipe_kill(var0, var1, var2) {
  var3 = isDefined(var2) && isDefined(var2.classname) && var2.classname == "sniper";

  if(!ispointnearpilot(self, var1) || !var3) {
    return false;
  }

  return true;
}

function do_heli_crash(var0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("death", var0, "MOD_EXPLOSIVE", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var0, "sniped");
  self makecorpse();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var0);
  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
}

function ispointnearpilot(var0, var1) {
  var2 = anglesToForward(self.angles);
  var3 = anglestoleft(self.angles);
  var4 = self.origin + var2 * 133 + (0, 0, -70);
  var5 = self.origin + var2 * 112 + var3 * 17 + (0, 0, -70);
  var6 = self.origin + var2 * 112 + (0, 0, -50);

  if(distance(var1, var4) <= 20) {
    return true;
  }

  if(distance(var1, var5) <= 20) {
    return true;
  }

  if(distance(var1, var6) <= 20) {
    return true;
  }

  return false;
}

function debug_start_overwatch(var0) {
  thread threaded_debug_start();
}

function threaded_debug_start() {
  scripts\engine\utility::flag_wait("cp_overwatch_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "overwatch_debug_start_loc", 1);
}

function give_all_players_munition(var0, var1) {
  level endon("bomb_relocated");
  wait 0.1;

  if(isDefined(var1)) {
    wait var1;
  }

  for(var2 = 0; var2 < level.players.size; var2++) {
    thread each_player_remotestarted();
  }

  thread wait_for_gunship_used();
  thread force_gunship_off_time();

  for(var2 = 0; var2 < level.players.size; var2++) {
    thread give_gunship_access_after_personal_delay(level, level.players[var2]);
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
  level waittill("ac130InUse", var0);

  if(isDefined(var0) && var0 != self) {
    scripts\cp\utility::setlowermessage("havesaw", &"CP_SUBURBS_OBJECTIVES/LOSTRACE", 5);
    return;
  }
}

function wait_for_gunship_used() {
  level endon("jammer_destroyed");
  level waittill("ac130InUse", var0);
  thread track_gunship_uses_per_player();
  take_away_players_gunshipmunition();
}

function track_gunship_uses_per_player() {
  wait 5;

  for(var0 = 0; var0 < level.players.size; var0++) {
    if(!isDefined(level.players[var0].gunship_uses)) {
      if(level.players[var0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
        level.players[var0].gunship_uses = 1;
      }

      continue;
    }

    if(level.players[var0] scripts\cp_mp\killstreaks\gunship::isusinggunship()) {
      level.players[var0].gunship_uses++;
    }
  }
}

function give_gunship_access_after_personal_delay(var0, var1) {
  level endon("game_ended");
  level endon("clear_players_gunship_delays");
  var0 endon("disconnect");
  var2 = 5;
  var3 = 3;
  var4 = 3;

  if(!isDefined(var0.gunship_uses)) {
    if(isDefined(var1) && var1 == var0) {
      var4 -= var3;
    }
  } else {
    for(var5 = 0; var5 < var0.gunship_uses; var5++) {
      var4 += var2;
    }

    if(isDefined(var1) && var1 == var0) {
      var4 -= var3;
    }
  }

  if(var4 > 0) {
    wait var4;
  }

  var0.saved_lastweapon = var0 getcurrentweapon().basename;
  var6 = scripts\cp\loot_system::get_empty_munition_slot(var0);

  if(isDefined(var6) && !istrue(ref_1246b(var0))) {
    var0 scripts\cp\cp_munitions::give_munition_to_slot("ac130", var6, "overwatch");
    var0.ref_121ab = var6;

    if(!isDefined(var0.gunship_uses)) {
      wait 3;
      var0 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/GUNSHIP_TUT", 4);
      return;
    }

    return;
  }
}

function ref_1246b() {
  foreach(var1 in self.munition_slots) {
    if(isDefined(var1.ref_134e2) && var1.ref_134e2 == "overwatch") {
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
  for(var0 = 0; var0 < level.players.size; var0++) {
    if(isDefined(level.players[var0].ref_121ab)) {
      var1 = level.players[var0].ref_121ab;
      var2 = level.players[var0].munition_slots[var1];

      if(isDefined(var2) && isDefined(var2.ref_134e2) && var2.ref_134e2 == "overwatch") {
        haspassedsquadleader(level.players[var0], var1, var2.ref);
        level.players[var0] scripts\cp\cp_munitions::update_lua_inventory_slot(var1);
      }
    }
  }

  level notify("clear_players_gunship_delays");
}

function haspassedsquadleader(var0, var1) {
  for(var2 = 0; var2 < self.munition_slots.size; var2++) {
    if(var2 == var0) {
      if(isDefined(self.munition_slots[var2].ref) && self.munition_slots[var2].ref == var1 && isDefined(self.munition_slots[var2].ref_134e2) && self.munition_slots[var2].ref_134e2 == "overwatch") {
        scripts\cp\cp_munitions::give_munition_to_slot("none", var0);
        var3 = "cp_munition_1_timer";

        switch (var0) {
          case 0:
            var3 = "cp_munition_1_timer";
            break;
          case 1:
            var3 = "cp_munition_2_timer";
            break;
          case 2:
            var3 = "cp_munition_3_timer";
            break;
          case 3:
            var3 = "cp_munition_4_timer";
            break;
        }

        self setclientomnvar(var3, 0);
        self.munition_slots[var2].ref_134e2 = undefined;
        thread ref_11e0b(level);
      }
    }
  }
}

function ref_11e0b(var0) {
  var0 endon("disconnect");
  var0 scripts\cp\utility::setlowermessage("gunship_removed_message", &"CP_SUBURBS_OBJECTIVES/GUNSHIP_REMOVED");
  wait 3;
  var0 scripts\cp\utility::clearlowermessage("gunship_removed_message");
}

function ref_13b07() {
  wait 15;
  var0 = scripts\engine\utility::getStructArray("overwatch_mortar", "targetname");
  thread ref_135ad();
  thread ref_1358f();
  thread ref_135d5();
  wait 5;

  for(var1 = 0; var1 < 4; var1++) {
    foreach(var3 in var0) {
      var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
      thread watchalleyplayerexit(level, var3.origin);
      wait 0.2 + randomfloat(0.75);
    }

    wait 40 + randomfloat(6);
    level notify("stop_mortar_smoke");
  }
}

function ref_135d5() {
  wait 15;
  level.ref_121a5 = scripts\cp\cp_modular_spawning::run_spawn_module("overwatch_soldiers_05_bombers");
}

function ref_12a06(var0) {
  var1 = randomfloatrange(var0 * -1, var0);
  var2 = randomfloatrange(var0 * -1, var0);
  return (var1, var2, 0);
}

function ref_1358f() {
  level endon("overwatch_final_tank_dead");
  level endon("game_ended");
  level.vehicle_occupancy_giveriotshield = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_1");
  thread ref_138bd(level, 60);
  wait 4;
  level.vehicle_occupancy_handleplayerbc = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_2");
  thread ref_138bd(level, 60);
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_giveriotshield);
  level.vehicle_occupancy_hidecashbag = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_3");
  thread ref_138bd(level, 60);
  wait 4;
  spawn_lmg_soldiers_04(level.vehicle_occupancy_handleplayerbc);
  level.vehicle_occupancy_instanceisregistered = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_jam5_4");
  thread ref_138bd(level, 60);
}

function ref_138bd(var0, var1) {
  wait var0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var1);
}

function spawn_lmg_soldiers_04(var0) {
  level endon("game_ended");
  var1 = 0;

  for(;;) {
    if(var0.currentmodulekills >= var0.spawn_count) {
      break;
    }

    if(var1 > 120) {
      break;
    }

    wait 0.5;
    var1 += 0.5;
  }
}

function watchalleyplayerexit(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var2 = undefined;

  if(isvector(var0)) {
    var2 = spawnStruct();
    var2.origin = var0;
    var2.angles = (0, 0, 0);
    var0 = var2;
  }

  var3 = self;
  var4 = undefined;

  if(!isent(self)) {
    var3 = var2;
    var4 = var3.origin;
  } else {
    var4 = self gettagorigin("j_shaft_top");
  }

  if(!isDefined(var1)) {
    var1 = getgroundposition(self.origin + anglesToForward(self.angles) * 2000, 8, 1000);
  }

  thread ref_142e2(var1);
  var5 = scripts\engine\utility::spawn_tag_origin(var4, (0, 0, 0));
  playFX(scripts\engine\utility::getfx("vfx_flare_launch"), var3.origin + (0, 0, 3) + anglesToForward(var3.angles) * 8, anglesToForward(var3.angles));
  playsoundatpos(var4, "weap_mortar_fire_dist");
  var5 show();
  var6 = 5;
  thread movemortar(var5, var4, var1, var6, 1200);
  var5 setModel("equipment_mortar_shell_improvised_01");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var5, "tag_origin");
  var5 playLoopSound("weap_mortar_fly_lp");
  wait var6 - 1.7;
  var5 playSound("weap_mortar_incoming");
  wait 1.7;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mortar_trail"), var5, "tag_origin");
  var5 stoploopsound();
  var7 = (0, 0, 40);
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", var1);
  thread ref_11d31(var1);
  var8 = spawn("script_model", var1 + (0, 0, 2));
  var8 setModel("tag_origin");
  var8 show();
  var8.angles = (270, 0, 0);
  var5 delete();
  wait 0.5;
  playFXOnTag(level._effect["vfx_ow_mortar_smoke"], var8, "tag_origin");
  level waittill("stop_mortar_smoke");
  stopFXOnTag(level._effect["vfx_ow_mortar_smoke"], var8, "tag_origin");
  wait 1;
  var8 delete();
}

function movemortar(var0, var1, var2, var3, var4) {
  var5 = 1200;

  if(isDefined(var4)) {
    var5 = var4;
  }

  var6 = 1 / var3 / 0.05;
  var7 = 0;

  while(var7 < 1) {
    var0.origin = scripts\engine\math::get_point_on_parabola(var1, var2, var5, var7);
    anglemortar(var0);
    var7 += var6;
    wait 0.05;
  }

  var0.origin = var2;
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

function ref_142e2(var0) {
  if(gettime() < level.ref_11e67) {
    return;
  }

  var1 = ["dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_kama_lass_mortar_attacking_10", "dx_cps_kama_lass_mortar_attacking_20"];
  var2 = scripts\cp\utility::give_all_players_nearby(var0, squared(384));
  var3 = scripts\engine\utility::random(var1);

  foreach(var5 in var2) {
    thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var5, var3);
  }

  level.ref_11e67 = gettime() + 30000;
}

function ref_11d31(var0) {
  var1 = 3;
  var2 = 45;
  wait var1;
  var3 = scripts\cp\cp_outline_utility::addoutlineoccluder(var0, 300);
  var4 = spawn("script_model", var0);
  var4 show();
  var5 = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(isDefined(var5)) {
    level notify("grenade_exploded_during_stealth", var4, "smoke_grenade_mp");
    var4 clonebrushmodeltoscriptmodel(var5);
    var4 setmovertransparentvolume();
  } else {
    var4 delete();
  }

  level waittill("stop_mortar_smoke");

  if(isDefined(var4)) {
    var4 delete();
  }

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var3);
}

function enable_jammer_damage(var0, var1) {
  thread mdl_allow_damage_jammers(level, var0);
  level waittill("jammer_lowhealth", var2);
  wait 0.75;
  level notify("jammer_destroyed");
  level.priority_player = var2;
}

function hint_jammer_damage(var0) {
  var1 = 193600;

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(level.players[var2].team == "allies" && level.players[var2] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(distancesquared(level.players[var2].origin, var0.origin) < var1) {
        level.players[var2] thread scripts\cp\cp_hud_message::tutorialprint(&"CP_SUBURBS_OBJECTIVES/SHOOT_JAMMER", 4);
      }
    }
  }
}

function mdl_allow_damage_jammers(var0, var1) {
  var2 = get_jammer_mdl(var0);
  thread allow_jammer_takedamage(var2);
  thread jammer_hitmarkers();
}

function get_jammer_mdl(var0) {
  var1 = undefined;

  switch (var0) {
    case "obj_jammer_01":
      var1 = "signal_jammer_mdl_01";
      break;
    case "obj_jammer_02":
      var1 = "signal_jammer_mdl_02";
      break;
    case "obj_jammer_03":
      var1 = "signal_jammer_mdl_03";
      break;
    case "obj_jammer_04":
      var1 = "signal_jammer_mdl_04";
      break;
    case "obj_jammer_05":
      var1 = "signal_jammer_mdl_05";
      break;
    case "obj_jammer_06":
      var1 = "signal_jammer_mdl_06";
      break;
  }

  var2 = getEnt(var1, "targetname");
  return var2;
}

function allow_jammer_takedamage(var0) {
  level endon("game_ended");
  var1 = 400;

  if(getdvarint("scr_overwatch_speed", 0) > 0) {
    var1 = 10;
  }

  self.health = var1;
  self.maxhealth = var1;
  var2 = var1 * 0.8;
  var3 = var1 * 0.6;
  var4 = var1 * 0.4;
  self setCanDamage(1);
  self setCanRadiusDamage(1);

  while(self.health > var2) {
    wait 0.1;
  }

  objective_sethot(var0, 0);
  playFXOnTag(level._effect["vfx_signal_jammer_damage_1"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_01_lp");

  while(self.health > var3) {
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_1"], self, "tag_origin");
  self stoploopsound();
  playFXOnTag(level._effect["vfx_signal_jammer_damage_2"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_02_lp");

  while(self.health > var4) {
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_2"], self, "tag_origin");
  self stoploopsound();
  playFXOnTag(level._effect["vfx_signal_jammer_damage_3"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_03_lp");

  while(self.health > 0) {
    wait 0.1;
  }

  var5 = undefined;
  self waittill("damage", var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);

  if(isDefined(var7) && isDefined(var7.team) && var7.team != "axis") {
    var5 = var7;
  }

  stopFXOnTag(level._effect["vfx_signal_jammer_damage_3"], self, "tag_origin");
  self stoploopsound();
  self playSound("scn_cp_stadium_jammer_dead");
  playFXOnTag(level._effect["vfx_signal_jammer_damage_4"], self, "tag_origin");
  self playLoopSound("scn_cp_stadium_jammer_damage_04_lp");
  level notify("jammer_lowhealth", var5);
  wait 120;
  stopFXOnTag(level._effect["vfx_signal_jammer_damage_4"], self, "tag_origin");
  self stoploopsound();
  self playSound("scn_cp_stadium_jammer_04_end");
}

function jammer_hitmarkers() {
  level endon("jammer_lowhealth");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var1) && isPlayer(var1)) {
      var1.lasthitmarkertime = undefined;
      var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_12dd6() {
  wait 10;
  scripts\engine\utility::flag_init("endgame_delay");
  level thread scripts\cp\utility::objective_update("obj_overwatch_exfil", undefined, undefined, undefined, 1, undefined, 2);
  var0 = scripts\engine\utility::getStruct("obj_exfil_landing", "targetname");
  var1 = scripts\engine\utility::getStruct("ow_exfil_spawn", "targetname");
  level.ref_1248f = var1;
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_exfil_landing");
  waitframe();
  level notify("call_exfil", var0.origin);
  level waittill("ready_to_exfil");
  ref_130a8(level.heli_trip_vehicle);

  foreach(var3 in level.players) {
    var3 thread scripts\cp_mp\xmike109::screenent_d("headhunter");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var3 thread scripts\cp_mp\xmike109::scriptable_callback("headhunter_mod");
        continue;
      }

      var3 thread scripts\cp_mp\xmike109::scriptable_callback("headhunter_mod_vet");
    }
  }

  scripts\cp\cp_achievement::update_achievement_all_players("SMUGGLED", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("PICKLES", 1);
  scripts\cp\cp_objectives::lua_objective_complete("obj_overwatch_exfil");
  scripts\cp\cp_objectives::screenent_c("major_objective");

  for(var5 = 0; var5 < level.players.size; var5++) {
    level.players[var5].ability_invulnerable = 1;
  }

  wait 1;
  scripts\cp\utility::skydiveontacinsertplacement();
  wait 1.5;
  wait 3;
  scripts\engine\utility::flag_set("endgame_delay");
}

function spawn_fake_loots() {
  var0 = ["brloot_munition_ammo"];
  var1 = getEntArray("overwatch_loot", "targetname");

  foreach(var3 in var1) {
    var3 thread scripts\cp\utility::create_fake_loot(var0);
  }
}

function spawn_overwatch_extraguns() {
  wait 1;
  var0 = scripts\engine\utility::getStructArray("overwatch_guns", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\cp\cp_weapon::buildweapon(var2.script_noteworthy, [], "none", "none", -1);
    var4 = createheadicon(var3);
    var5 = spawn("weapon_" + var4, var2.origin);

    if(!isDefined(var2.angles)) {
      var2.angles = (0, 0, 0);
    }

    var5.angles = var2.angles;
    var5 itemweaponsetammo(weaponclipsize(var3), weaponmaxammo(var3));
  }
}

function ref_135ac() {
  if(istrue(level.ref_11f69)) {
    return;
  }

  level.ref_11f69 = 1;

  if(!isDefined(level.atvs)) {
    level.atvs = [];
  }

  var0 = scripts\engine\utility::getStructArray("overwatch_atv_spawner_early", "targetname");
  level thread scripts\cp\vehicles\atv_cp::atv_cp_createfromstructs(var0, 1);
}

function spawn_exfil_heli_and_rpgs() {
  level endon("game_ended");
  wait 3;
  var0 = scripts\engine\utility::getStructArray("overwatch_atv_spawner_early", "targetname");
  var1 = var0[0];
  var2 = 9000000;
  var3 = [];
  var4 = vehicle_getarray();

  for(var5 = 0; var5 < var4.size; var5++) {
    if(isent(var4[var5]) && isDefined(var4[var5].vehiclename) && var4[var5].vehiclename == "atv" && !var4[var5] issuspendedvehicle() && distance2dsquared(var1.origin, var1.origin) < var2) {
      var3 = var4[var5];
    }
  }

  foreach(var7 in var3) {
    thread little_bird_mg_deathcallback();
    var7 hudoutlineenable("outline_nodepth_green");
  }

  var9 = level scripts\engine\utility::ref_143b9(60, "router_placed");
  level notify("disable_atv_outlines");

  foreach(var7 in var3) {
    if(isent(var7) && !var7 issuspendedvehicle()) {
      var7 hudoutlinedisable();
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

  scripts\engine\utility::ref_143a6("stop_remote_sequence", "gunshipPlayer_removed", "death");

  if(scripts\cp\utility::isignoremeenabled()) {
    scripts\cp\utility::allow_player_ignore_me(0);
    return;
  }
}

function play_vo_delay(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies", var3, var5, var6);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(isDefined(var2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var2);
    return;
  }
}

function vo_length(var0) {
  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  return var1;
}

function suicide_bomber_combat_func() {
  self endon("death");
  var0 = scripts\cp\utility::get_closest_living_player();
  self getenemyinfo(var0);

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

function ref_123ff() {
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
  level.ref_139b5 = 0;
}

function play_jammer_destroyed_vo() {
  if(!isDefined(level.vo_jammerdestroyed)) {
    level.vo_jammerdestroyed = 1;
  } else {
    level.vo_jammerdestroyed++;
  }

  var0 = undefined;
  var1 = undefined;
  level.ref_139b5 = 1;

  switch (level.vo_jammerdestroyed) {
    case 1:
      var0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_30";
      var1 = undefined;
      break;
    case 2:
      var0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_20";
      var1 = 1;
      break;
    case 3:
      var0 = "dx_cps_lass_overwatch_scrambler_destroyed_30";
      var1 = 2;
      break;
    case 4:
      var0 = "dx_cps_lass_overwatch_scrambler_destroyed_nogun_40";
      var1 = undefined;
      break;
    case 5:
      var0 = "dx_cps_lass_overwatch_all_scramblers_10";
      var1 = 3;
      level.vo_jammerdestroyed = undefined;
      break;
  }

  if(isDefined(var0)) {
    level.vehicle_cp_createlate = gettime();
    play_vo_delay(level, var0, undefined, undefined, undefined, 0.2);
  }

  if(isDefined(var1)) {
    switch (var1) {
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
        var2 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
        play_vo_delay(level, scripts\engine\utility::random(var2), undefined, undefined, undefined, 1);
        break;
      case 3:
        level notify("spawn_overwatch_heli_boss");
        break;
    }
  }

  level.ref_139b5 = 0;
}

function play_jammer_returning_vo() {
  if(!isDefined(level.vo_jammerreturning)) {
    level.vo_jammerreturning = 1;
  } else {
    level.vo_jammerreturning++;
  }

  level.ref_139b5 = 1;
  var0 = undefined;

  switch (level.vo_jammerreturning) {
    case 2:
      var0 = "dx_cps_lass_overwatch_scrambler_returning_10";
      break;
    case 3:
      var0 = "dx_cps_lass_overwatch_scrambler_returning_20";
      break;
    case 4:
      var0 = "dx_cps_lass_overwatch_scrambler_returning_30";
      break;
    case 5:
      var0 = "dx_cps_lass_overwatch_scrambler_returning_20";
      break;
  }

  if(isDefined(level.vehicle_cp_createlate)) {
    if(gettime() < level.vehicle_cp_createlate + 6000) {
      wait 6;
    }
  }

  if(isDefined(var0)) {
    wait 0.35;
    play_vo_delay(level, var0, undefined, undefined, undefined, 0.25);
  }

  level.ref_139b5 = 0;
}

function play_helicopter_vo() {
  level.ref_139b5 = 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_enemy_helo_nag_30", undefined, undefined);
  level.ref_139b5 = 0;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_lass_overwatch_enemy_helo_nag_30");
  play_vo_delay(level, "dx_cps_lass_overwatch_enemy_helo_nag_30", undefined, undefined, 1, undefined, 40);
  level.overwatch_boss waittill("death", var0);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_lass_overwatch_enemy_helo_nag_30");

  if(isDefined(var0) && isPlayer(var0)) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "obj_sitrep_success");
    return;
  }
}

function heli_help(var0) {
  level.overwatch_boss endon("death");
  level endon("game_ended");

  for(;;) {
    wait var0;
    thread give_all_players_munition(level);
  }
}

function tank_help(var0) {
  level endon("overwatch_tanks_dead");
  level endon("game_ended");

  for(;;) {
    wait var0;
    thread give_all_players_munition(level);
  }
}

function play_win_vo() {
  level.ref_139b5 = 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_mission_complete_10");
  wait 1;
  play_vo_delay(level, "dx_cps_kama_overwatch_mission_complete_20");
  wait 1;
  play_vo_delay(level, "dx_cps_lass_overwatch_mission_complete_30");
  wait 1;
  play_vo_delay(level, "dx_cps_kama_overwatch_mission_complete_40");
  level.ref_139b5 = 0;
}

function ref_130a8(var0) {
  foreach(var2 in level.players) {
    var2 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var2 in level.players) {
    if(!istrue(var2.try_to_punish_with_jugg)) {
      continue;
    }

    var5 = var2 getEye();
    var6 = spawn("script_model", var5);
    var6 setModel("tag_origin");
    var6.angles = (0, 200, 0);
    var6 linkTo(var0);
    var2 playerhide();
    var2 allowfire(0);
    var2 disableoffhandweapons();
    var2 disableusability();
    var2 allowmovement(0);
    var2 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var2, var6);
    var2 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}