/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_challenges.gsc
********************************************************/

register_default_challenges() {
  level.challenge_hotjoin_func = ::handle_challenge_hotjoin;
  level.challenge_pause_func = ::pause_challenge_func;
  scripts\cp\cp_challenge::register_challenge("long_shot", undefined, 0, undefined, undefined, ::activate_long_shot, ::deactivate_distance_shot, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("close_shot", undefined, 0, undefined, undefined, ::activate_close_shot, ::deactivate_distance_shot, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("jump_shot", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_marked", undefined, 0, undefined, undefined, ::activate_kill_marked, ::deactivate_kill_marked, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_headshots", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_melee", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_crawlers", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_nodamage", undefined, 0, undefined, undefined, ::activate_kill_nodamage, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::update_kill_nodamage);
  scripts\cp\cp_challenge::register_challenge("protect_player", undefined, 1, ::scripts\cp\cp_challenge::default_successfunc, undefined, ::activate_protect_a_player, ::deactivate_protect_a_player, undefined, ::update_protect_a_player);
  scripts\cp\cp_challenge::register_challenge("no_laststand", undefined, 1, ::scripts\cp\cp_challenge::default_successfunc, undefined, ::activate_no_laststand, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::update_no_laststand);
  scripts\cp\cp_challenge::register_challenge("no_bleedout", undefined, 1, ::scripts\cp\cp_challenge::default_successfunc, undefined, ::activate_no_bleedout, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::update_no_bleedout);
  scripts\cp\cp_challenge::register_challenge("multikills", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("area_kills", undefined, 0, undefined, undefined, ::activate_area_kills, ::deactivate_area_kills, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("window_boards", undefined, 0, undefined, undefined, ::activate_window_boards, ::deactivate_window_boards, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("dismember_arm", undefined, 0, undefined, undefined, ::activate_dismember_arm, ::deactivate_dismember_challenge, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("dismember_leg", undefined, 0, undefined, undefined, ::activate_dismember_leg, ::deactivate_dismember_challenge, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("kill_zombiewhodamagedme", undefined, 0, undefined, undefined, ::activate_kill_zombiewhodamagedme, ::deactivate_kill_zombiewhodamagedme, undefined, ::generic_update_challenge);
  scripts\cp\cp_challenge::register_challenge("challenge_failed", undefined, 0, undefined, undefined, ::scripts\cp\cp_challenge::default_resetsuccess, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, undefined);
  scripts\cp\cp_challenge::register_challenge("challenge_success", undefined, 0, undefined, undefined, ::scripts\cp\cp_challenge::default_resetsuccess, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, undefined);
  scripts\cp\cp_challenge::register_challenge("next_challenge", undefined, 0, undefined, undefined, ::scripts\cp\cp_challenge::default_resetsuccess, ::scripts\cp\cp_challenge::default_resetsuccess, undefined, undefined);
  level.master_challenge_list = ["jump_shot", "long_shot", "no_laststand", "no_bleedout", "protect_player", "kill_marked", "kill_nodamage", "kill_headshots", "kill_melee", "kill_crawlers", "dismember_arm", "dismember_leg", "window_boards", "multikills", "area_kills", "close_shot", "kill_zombiewhodamagedme"];
  level.tier_1_challenges = ["jump_shot", "long_shot", "multikills", "kill_melee", "no_laststand"];
  level.tier_2_challenges = ["window_boards", "close_shot", "kill_crawlers", "dismember_leg", "protect_player", "kill_nodamage"];
  level.tier_3_challenges = ["area_kills", "no_bleedout", "kill_zombiewhodamagedme", "dismember_arm", "kill_marked", "kill_headshots"];
  level.tier_1_challenges = scripts\engine\utility::array_randomize(level.tier_1_challenges);
  level.tier_2_challenges = scripts\engine\utility::array_randomize(level.tier_2_challenges);
  level.tier_3_challenges = scripts\engine\utility::array_randomize(level.tier_3_challenges);
}

generic_activate_challenge() {
  scripts\cp\cp_challenge::default_resetsuccess();
  self.current_progress = 0;
  scripts\cp\cp_challenge::update_challenge_progress(0, self.objective_icon);
  level thread generic_challenge_timer(self);
}

generic_update_challenge(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_progress = self.current_progress + param_00;
  if(self.current_progress >= self.objective_icon) {
    self.success = 1;
  }

  scripts\cp\cp_challenge::update_challenge_progress(self.current_progress, self.objective_icon);
  if(self.success) {
    level notify("current_challenge_ended");
    scripts\cp\cp_challenge::deactivate_current_challenge();
    return;
  }

  if(scripts\engine\utility::istrue(param_01)) {
    level notify("current_challenge_ended");
    self.success = 0;
    scripts\cp\cp_challenge::deactivate_current_challenge();
  }
}

generic_challenge_timer(param_00, param_01) {
  var_02 = int(level.challenge_data[param_00.ref].active_time[level.players.size - 1]);
  var_03 = int(gettime() + var_02 * 1000);
  foreach(var_05 in level.players) {
    var_05 setclientomnvar("ui_intel_timer", var_03);
  }

  level.current_challenge_timer = var_02;
  level.storechallengetime = var_02;
  level thread scripts\cp\cp_challenge::update_current_challenge_timer(param_01);
  param_00 thread scripts\cp\cp_challenge::default_timer(var_02);
}

activate_window_boards() {
  generic_activate_challenge();
  level thread window_boards_logic();
}

window_boards_logic() {
  level endon("stop_windowboard_logic");
  level endon("challenge_deactivated");
  for(;;) {
    level waittill("reboard", var_00);
    scripts\cp\cp_challenge::update_challenge("window_boards", var_00);
  }
}

deactivate_window_boards() {
  level notify("stop_windowboard_logic");
  scripts\cp\cp_challenge::default_resetsuccess();
}

add_to_dismember_queue(param_00) {
  if(!isDefined(level.dismember_queue)) {
    level.dismember_queue = [];
  }

  var_01 = spawnStruct();
  var_01.limb = param_00;
  var_01.processed = 0;
  level.dismember_queue = scripts\engine\utility::array_add_safe(level.dismember_queue, var_01);
}

activate_dismember_arm() {
  level.dismember_queue_func = ::add_to_dismember_queue;
  level.dismember_queue = [];
  generic_activate_challenge();
  level thread dismember_challenge_logic("arm");
}

activate_dismember_leg() {
  level.dismember_queue_func = ::add_to_dismember_queue;
  level.dismember_queue = [];
  generic_activate_challenge();
  level thread dismember_challenge_logic("leg");
}

dismember_challenge_logic(param_00) {
  level endon("stop_dismember_logic");
  level endon("challenge_deactivated");
  for(;;) {
    if(level.dismember_queue.size > 0) {
      foreach(var_02 in level.dismember_queue) {
        if(var_02.processed) {
          continue;
        }

        if(param_00 == "arm") {
          if(var_02.limb == 1 || var_02.limb == 2) {
            scripts\cp\cp_challenge::update_challenge("dismember_arm", 1);
          }
        } else if(param_00 == "leg") {
          if(var_02.limb == 4 || var_02.limb == 8) {
            scripts\cp\cp_challenge::update_challenge("dismember_leg", 1);
          }
        }

        var_02.processed = 1;
      }

      level.dismember_queue = [];
    }

    wait(0.1);
  }
}

deactivate_dismember_challenge() {
  level.dismember_queue_func = undefined;
  level.dismember_queue = undefined;
  level notify("stop_dismember_logic");
  scripts\cp\cp_challenge::default_resetsuccess();
}

activate_long_shot() {
  generic_activate_challenge();
  level thread distance_shot_logic("long_shot");
}

activate_close_shot() {
  generic_activate_challenge();
  level thread distance_shot_logic("close_shot");
}

distance_shot_logic(param_00) {
  level endon("stop_distanceshot_logic");
  level endon("challenge_deactivated");
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
          foreach(var_04 in level.players) {
            scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
          }

          var_02.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    foreach(var_06, var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
      if(!isDefined(var_02.agent_type)) {
        continue;
      }

      if(!scripts\cp\utility::should_be_affected_by_trap(var_02, 1, 1) && var_02.agent_type != "zombie_brute") {
        continue;
      }

      var_08 = undefined;
      foreach(var_04 in level.players) {
        if(is_distance_shot(var_04, undefined, var_02, param_00)) {
          var_08 = 1;
          scripts\cp\cp_outline::enable_outline_for_player(var_02, var_04, 0, 1, 0, "high");
          continue;
        }

        scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
      }

      var_02.marked_for_challenge = var_08;
      if(var_06 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.05);
  }
}

deactivate_distance_shot() {
  level notify("stop_distanceshot_logic");
  wait(1);
  foreach(var_01 in scripts\mp\mp_agent::getaliveagents()) {
    if(!isDefined(var_01.marked_for_challenge)) {
      continue;
    }

    var_01.marked_for_challenge = undefined;
    foreach(var_03 in level.players) {
      scripts\cp\cp_outline::disable_outline_for_player(var_01, var_03);
    }
  }

  scripts\cp\cp_challenge::default_resetsuccess();
}

activate_kill_marked() {
  generic_activate_challenge();
  level thread wait_for_marked_zombies(self);
}

wait_for_marked_zombies(param_00) {
  level endon("current_challenge_ended");
  level endon("challenge_deactivated");
  level.num_zombies_marked = 0;
  level.num_marked_zombies_killed = 0;
  for(;;) {
    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
        if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
          foreach(var_04 in level.players) {
            scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
          }

          level.num_zombies_marked--;
          var_02.marked_for_challenge = undefined;
        }
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
    }

    var_07 = scripts\mp\mp_agent::getaliveagents();
    foreach(var_02 in var_07) {
      if(!scripts\cp\utility::should_be_affected_by_trap(var_02, 1, 1)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
        continue;
      }

      var_02.marked_for_challenge = 1;
      scripts\cp\cp_outline::enable_outline(var_02, 0, 1, 0);
      var_02 thread remove_outline_on_death();
      level.num_zombies_marked++;
      while(level.num_zombies_marked >= param_00.objective_icon) {
        if(scripts\engine\utility::flag("pause_challenges")) {
          foreach(var_02 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
            if(scripts\engine\utility::istrue(var_02.marked_for_challenge)) {
              foreach(var_04 in level.players) {
                scripts\cp\cp_outline::disable_outline_for_player(var_02, var_04);
              }

              level.num_zombies_marked--;
              var_02.marked_for_challenge = undefined;
            }
          }

          scripts\engine\utility::flag_waitopen("pause_challenges");
        }

        wait(0.1);
      }
    }

    wait(0.05);
  }
}

deactivate_kill_marked() {
  foreach(var_01 in scripts\mp\mp_agent::getaliveagents()) {
    if(isDefined(var_01.marked_for_challenge)) {
      var_01.marked_for_challenge = undefined;
      scripts\cp\cp_outline::disable_outline(var_01);
    }
  }

  scripts\cp\cp_challenge::default_resetsuccess();
}

activate_area_kills() {
  generic_activate_challenge();
  level thread area_kills(self);
}

area_kills(param_00) {
  var_01 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_players_are_in(undefined, 1);
  var_02 = scripts\engine\utility::random(var_01);
  if(!isDefined(var_02)) {
    var_02 = spawnStruct();
    var_02.basename = "moon";
  } else if(var_02.basename == "arcade_back" || var_02.basename == "underground_route" || var_02.basename == "hidden_room") {
    var_02 = spawnStruct();
    var_02.basename = "moon";
  }

  var_03 = get_kill_spot_in_area(var_02);
  level.area_kill_fx = spawnfx(level._effect["challenge_ring"], var_03.origin + (0, 0, -15), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
  level.challenge_area_marker = spawnStruct();
  level.challenge_area_marker.origin = var_03.origin + (0, 0, -20);
  level.challenge_area_marker.fgetarg = -27120;
  wait(0.1);
  triggerfx(level.area_kill_fx);
  wait(0.1);
}

get_kill_spot_in_area(param_00) {
  var_01 = scripts\engine\utility::getstructarray("area_kill_" + param_00.basename, "targetname");
  return scripts\engine\utility::random(var_01);
}

deactivate_area_kills(param_00) {
  scripts\cp\cp_challenge::default_resetsuccess();
  level.area_kill_fx delete();
  level.challenge_area_marker = undefined;
}

activate_kill_zombiewhodamagedme() {
  generic_activate_challenge();
}

deactivate_kill_zombiewhodamagedme(param_00) {
  deactivate_distance_shot();
}

activate_kill_nodamage() {
  generic_activate_challenge();
  level thread fail_kill_nodamage(self);
  foreach(var_01 in level.players) {
    var_01 thread kill_nodamage_monitor();
  }
}

fail_kill_nodamage(param_00) {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  level waittill("kill_nodamage_failed");
  param_00.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
  level notify("kill_nodamage_complete");
}

kill_nodamage_monitor() {
  level endon("kill_nodamage_complete");
  level endon("challenge_deactivated");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(scripts\engine\utility::flag("pause_challenges")) {
      continue;
    }

    if(scripts\engine\utility::istrue(self.ability_invulnerable)) {
      continue;
    }

    if(isDefined(var_01) && isplayer(var_01) && scripts\cp\utility::is_hardcore_mode()) {
      level notify("kill_nodamage_failed");
      return;
    } else if(isDefined(var_01) && isagent(var_01)) {
      level notify("kill_nodamage_failed");
      return;
    }
  }
}

update_kill_nodamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.current_progress = self.current_progress + param_00;
  if(self.current_progress >= self.objective_icon) {
    self.success = 1;
  }

  scripts\cp\cp_challenge::update_challenge_progress(self.current_progress, self.objective_icon);
  if(self.success) {
    level notify("kill_nodamage_complete");
    scripts\cp\cp_challenge::deactivate_current_challenge();
  }
}

challenge_scalar_func(param_00) {
  var_01 = get_scalar_from_table(param_00);
  switch (param_00) {
    case "kill_nodamage":
    case "kill_crawlers":
    case "kill_melee":
    case "kill_headshots":
    case "kill_marked":
    case "jump_shot":
    case "long_shot":
      if(var_01 >= level.desired_enemy_deaths_this_wave) {
        var_01 = level.desired_enemy_deaths_this_wave - 2;
      }

      break;
  }

  return var_01;
}

get_scalar_from_table(param_00) {
  var_01 = level.zombie_challenge_table;
  var_02 = 0;
  var_03 = 1;
  var_04 = 99;
  var_05 = 1;
  var_06 = 9;
  for(var_07 = var_03; var_07 <= var_04; var_07++) {
    var_08 = tablelookup(var_01, var_02, var_07, var_05);
    if(var_08 == "") {
      return undefined;
    }

    if(var_08 != param_00) {
      continue;
    }

    var_09 = tablelookup(var_01, var_02, var_07, var_06);
    if(isDefined(var_09)) {
      var_09 = strtok(var_09, " ");
      if(var_09.size > 0) {
        return int(var_09[level.players.size - 1]);
      }
    }
  }
}

default_playerdamage_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  switch (level.current_challenge) {
    case "kill_zombiewhodamagedme":
      if(!scripts\engine\utility::istrue(param_01.marked_for_challenge)) {
        param_01 hudoutlineenableforclient(self, 0, 1, 0);
        param_01.marked_for_challenge = 1;
      }

      if(!scripts\engine\utility::array_contains(param_01.damaged_players, self)) {
        param_01.damaged_players[param_01.damaged_players.size] = self;
      }
      return 0;
  }

  return 1;
}

default_death_challenge_func(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.died_poorly)) {
    return 0;
  }

  if(scripts\engine\utility::flag("pause_challenges")) {
    return 0;
  }

  switch (level.current_challenge) {
    case "long_shot":
      if(is_distance_shot(param_01, param_04, self, "long_shot")) {
        scripts\cp\cp_challenge::update_challenge("long_shot", 1);
      }
      return 0;

    case "close_shot":
      if(is_distance_shot(param_01, param_04, self, "close_shot")) {
        scripts\cp\cp_challenge::update_challenge("close_shot", 1);
      }
      return 0;

    case "jump_shot":
      if(isDefined(param_01) && isplayer(param_01) && isDefined(param_04)) {
        if(((isDefined(self.killedby) && param_01 == self.killedby) || param_04 == param_01 getcurrentweapon()) && !param_01 isonground()) {
          scripts\cp\cp_challenge::update_challenge("jump_shot", 1);
        }

        return 0;
      }

      break;

    case "kill_marked":
      if(isDefined(self.marked_for_challenge) && param_03 != "MOD_SUICIDE") {
        scripts\cp\cp_challenge::update_challenge("kill_marked", 1);
      } else if(param_03 != "MOD_SUICIDE" || isDefined(self.marked_for_challenge) && param_03 == "MOD_SUICIDE") {
        scripts\cp\cp_challenge::update_challenge("kill_marked", 0, 1);
      }
      return 0;

    case "kill_melee":
      if(isDefined(param_01) && isplayer(param_01) && param_03 == "MOD_MELEE" || param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") {
        scripts\cp\cp_challenge::update_challenge("kill_melee", 1);
      }
      return 0;

    case "kill_nodamage":
      if(isDefined(param_01) && isplayer(param_01)) {
        scripts\cp\cp_challenge::update_challenge("kill_nodamage", 1);
      }
      return 0;

    case "kill_headshots":
      if(scripts\cp\utility::isheadshot(param_04, param_06, param_03, param_01) && !isDefined(self.marked_for_death)) {
        scripts\cp\cp_challenge::update_challenge("kill_headshots", 1);
      }
      return 0;

    case "kill_crawlers":
      if(scripts\cp\utility::is_zombie_agent() && self.is_crawler) {
        scripts\cp\cp_challenge::update_challenge("kill_crawlers", 1);
      }
      return 0;

    case "kill_before_enter":
      if(scripts\cp\utility::is_zombie_agent() && !self.entered_playspace) {
        scripts\cp\cp_challenge::update_challenge("kill_before_enter", 1);
      }
      return 0;

    case "multikills":
      if(!isDefined(param_01)) {
        return 0;
      }

      if(!isDefined(param_01.lastkilltime) || !isDefined(param_01.lastmultikilltime)) {
        return 0;
      }

      if(gettime() != param_01.lastkilltime) {
        param_01.lastkilltime = gettime();
        return 0;
      } else if(gettime() == param_01.lastkilltime && param_01.lastmultikilltime != gettime()) {
        scripts\cp\cp_challenge::update_challenge("multikills", 1);
        param_01.lastmultikilltime = gettime();
        param_01.lastkilltime = gettime() + 50;
        return 0;
      }
      return 0;

    case "area_kills":
      if(isDefined(level.challenge_area_marker)) {
        if(isDefined(param_01) && isplayer(param_01)) {
          if(distancesquared(param_01.origin, level.challenge_area_marker.origin) < level.challenge_area_marker.fgetarg) {
            scripts\cp\cp_challenge::update_challenge("area_kills", 1);
          }
        }
      }
      return 0;

    case "kill_zombiewhodamagedme":
      if(!isplayer(param_01)) {
        return 0;
      }

      if(scripts\engine\utility::array_contains(self.damaged_players, param_01)) {
        scripts\cp\cp_challenge::update_challenge("kill_zombiewhodamagedme", 1);
      }

      break;
  }

  return 1;
}

is_distance_shot(param_00, param_01, param_02, param_03) {
  if(isplayer(param_00) && isalive(param_00) && !param_00 scripts\cp\utility::isusingremote()) {
    if(param_03 == "long_shot") {
      return distancesquared(param_00.origin, param_02.origin) >= 90000;
    } else if(param_03 == "close_shot") {
      return distancesquared(param_00.origin, param_02.origin) <= 90000;
    }
  }

  return 0;
}

remove_outline_on_death() {
  level endon("game_ended");
  self waittill("death");
  if(isDefined(self.marked_for_challenge)) {
    scripts\cp\cp_outline::disable_outline(self);
  }
}

activate_no_bleedout() {
  level thread generic_challenge_timer(self, 1);
}

update_no_bleedout(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

activate_no_laststand() {
  level thread generic_challenge_timer(self, 1);
}

update_no_laststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  self.success = 0;
  scripts\cp\cp_challenge::deactivate_current_challenge();
}

activate_protect_a_player() {
  scripts\cp\cp_challenge::default_resetsuccess();
  var_00 = [];
  foreach(var_02 in level.players) {
    if(isalive(var_02) && !scripts\cp\cp_laststand::player_in_laststand(var_02)) {
      var_00[var_00.size] = var_02;
    }
  }

  var_04 = scripts\engine\utility::random(var_00);
  var_05 = getsubstr(var_04.vo_prefix, 1, 2);
  var_05 = int(var_05) - 1;
  foreach(var_02 in level.players) {
    var_07 = var_04 getentitynumber();
    var_02 setclientomnvar("ui_intel_target_player", var_05);
  }

  level.current_challenge_target_player = var_05;
  level thread generic_challenge_timer(self, 1);
  make_protect_head_icon_on(var_04);
  level thread watch_target_player(var_04, self);
  level thread protect_challenge_player_connect_monitor(var_04);
}

watch_target_player(param_00, param_01) {
  level endon("challenge_deactivated");
  param_00 scripts\engine\utility::waittill_any_3("death", "last_stand", "disconnect");
  if(isDefined(param_00.entityheadicons)) {
    param_00 remove_head_icon();
  }

  param_01.success = 0;
  update_protect_a_player();
}

update_protect_a_player() {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }

  scripts\cp\cp_challenge::deactivate_current_challenge();
  foreach(var_01 in level.players) {
    var_01 setclientomnvar("ui_intel_target_player", -1);
  }

  level.current_challenge_target_player = -1;
}

remove_head_icon() {
  foreach(var_01 in self.entityheadicons) {
    if(!isDefined(var_01)) {
      continue;
    }

    var_01 destroy();
  }

  foreach(var_01 in self.protect_head_icon) {
    if(isDefined(var_01)) {
      var_01 destroy();
      var_01 scripts\cp\zombies\zombie_afterlife_arcade::remove_from_icons_to_hide_in_afterlife(var_01.triggerportableradarping, var_01);
    }
  }
}

deactivate_protect_a_player() {
  level notify("deactivate_protect_player_challenge");
  scripts\cp\cp_challenge::default_resetsuccess();
  foreach(var_01 in level.players) {
    if(isDefined(var_01.entityheadicons)) {
      var_01 remove_head_icon();
    }
  }
}

make_protect_head_icon_on(param_00) {
  var_01 = 0;
  if(param_00.vo_prefix != "p5_") {
    return;
  } else {
    foreach(var_03 in level.players) {
      if(var_03 == param_00) {
        continue;
      } else if(var_03.vo_prefix == "p5_") {
        var_01 = 1;
      }
    }
  }

  if(!var_01) {
    return;
  }

  param_00.protect_head_icon = [];
  foreach(var_03 in level.players) {
    make_protect_head_icon_for(var_03, param_00);
  }
}

make_protect_head_icon_for(param_00, param_01) {
  var_02 = param_01 scripts\cp\utility::setheadicon(param_00, "cp_hud_song_widget", (0, 0, 72), 4, 4, undefined, undefined, undefined, 1, undefined, 0);
  var_02 scripts\cp\zombies\zombie_afterlife_arcade::add_to_icons_to_hide_in_afterlife(param_00, var_02);
  var_02.triggerportableradarping = param_00;
  param_01.protect_head_icon[param_01.protect_head_icon.size] = var_02;
  if(scripts\engine\utility::istrue(param_00.in_afterlife_arcade)) {
    var_02.alpha = 0;
  }
}

protect_challenge_player_connect_monitor(param_00) {
  level endon("game_ended");
  level endon("deactivate_protect_player_challenge");
  for(;;) {
    level waittill("connected", var_01);
    var_01 thread delay_make_protect_head_icon_for(var_01, param_00);
  }
}

delay_make_protect_head_icon_for(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_01 endon("disconnect");
  scripts\engine\utility::waitframe();
  if(scripts\cp\cp_challenge::current_challenge_is("protect_player")) {
    param_00 make_protect_head_icon_for(param_00, param_01);
  }
}

handle_challenge_hotjoin() {
  self endon("disconnect");
  wait(5);
  self setclientomnvar("ui_intel_prechallenge", level.current_challenge_pre_challenge);
  if(scripts\cp\cp_challenge::current_challenge_exist()) {
    self setclientomnvar("ui_intel_active_index", int(level.current_challenge_index));
    self setclientomnvar("ui_intel_progress_current", int(level.current_challenge_progress_current));
    self setclientomnvar("ui_intel_progress_max", int(level.current_challenge_progress_max));
    self setclientomnvar("ui_intel_percent", int(level.current_challenge_percent));
    self setclientomnvar("ui_intel_target_player", int(level.current_challenge_target_player));
    self setclientomnvar("ui_intel_title", int(level.current_challenge_title));
    if(level.current_challenge_timer > 0 && !scripts\engine\utility::flag("pause_challenges")) {
      self setclientomnvar("ui_intel_timer", int(gettime() + level.current_challenge_timer * 1000));
    }

    self setclientomnvar("ui_intel_challenge_scalar", level.current_challenge_scalar);
    self setclientomnvar("ui_intel_active_index", int(level.current_challenge_index));
    var_00 = level.current_zm_show_challenge;
    if(!scripts\engine\utility::flag("pause_challenges")) {
      var_00 = 10;
    }

    self setclientomnvar("zm_show_challenge", var_00);
  }

  if(level.current_challenge == "kill_nodamage") {
    thread kill_nodamage_monitor();
  }
}

pause_challenge_func() {
  if(!isDefined(level.current_challenge)) {
    return;
  }

  if(level.current_challenge == "area_kills") {
    level.area_kill_fx delete();
    scripts\engine\utility::flag_waitopen("pause_challenges");
    level.area_kill_fx = spawnfx(level._effect["challenge_ring"], level.challenge_area_marker.origin + (0, 0, 5), anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
    wait(0.25);
    triggerfx(level.area_kill_fx);
    return;
  }

  if(level.current_challenge == "kill_zombiewhodamagedme") {
    foreach(var_01 in scripts\mp\mp_agent::getaliveagentsofteam("axis")) {
      if(scripts\engine\utility::istrue(var_01.marked_for_challenge)) {
        if(isDefined(var_01.damaged_players)) {
          foreach(var_03 in var_01.damaged_players) {
            scripts\cp\cp_outline::disable_outline_for_player(var_01, var_03);
          }
        }

        var_01.damaged_players = [];
        var_01.marked_for_challenge = undefined;
      }
    }
  }
}