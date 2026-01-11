/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_util.gsc
*****************************************/

bot_get_nodes_in_cone(param_00, param_01, param_02) {
  var_03 = self _meth_8533();
  var_04 = getnodesinradius(self.origin, param_00, 0, 512, "path", var_03);
  var_05 = [];
  var_06 = self getnearestnode();
  var_07 = anglesToForward(self getplayerangles());
  var_08 = vectornormalize(var_07 * (1, 1, 0));
  foreach(var_0A in var_04) {
    var_0B = vectornormalize(var_0A.origin - self.origin * (1, 1, 0));
    var_0C = vectordot(var_0B, var_08);
    if(var_0C > param_01) {
      if(!param_02 || isDefined(var_06) && nodesvisible(var_0A, var_06, 1)) {
        var_05 = scripts\engine\utility::array_add(var_05, var_0A);
      }
    }
  }

  return var_05;
}

bot_goal_can_override(param_00, param_01) {
  if(param_00 == "none") {
    return param_01 == "none";
  } else if(param_00 == "hunt") {
    return param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "guard") {
    return param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "objective") {
    return param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "critical") {
    return param_01 == "critical" || param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
  } else if(param_00 == "tactical") {
    return 1;
  }
}

bot_set_personality(param_00) {
  self botsetpersonality(param_00);
  scripts\mp\bots\_bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(param_00) {
  if(param_00 == "default") {
    param_00 = func_2D30();
  }

  self botsetdifficulty(param_00);
  if(isplayer(self)) {
    self.pers["rankxp"] = ::scripts\mp\utility::get_rank_xp_for_bot();
    scripts\mp\rank::playerupdaterank();
  }
}

func_2D30() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];
    if(level.rankedmatch) {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "regular";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hardened";
    } else {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "recruit";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "regular";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hardened";
    }
  }

  var_00 = self.var_2D32;
  if(!isDefined(var_00)) {
    var_01 = [];
    var_02 = self.team;
    if(!isDefined(var_02)) {
      var_02 = self.bot_team;
    }

    if(!isDefined(var_02)) {
      var_02 = self.pers["team"];
    }

    if(!isDefined(var_02)) {
      var_02 = "allies";
    }

    foreach(var_04 in level.players) {
      if(var_04 == self) {
        continue;
      }

      if(!isai(var_04)) {
        continue;
      }

      var_05 = var_04 botgetdifficulty();
      if(var_05 == "default") {
        continue;
      }

      var_06 = var_04.team;
      if(!isDefined(var_06)) {
        var_06 = var_04.bot_team;
      }

      if(!isDefined(var_06)) {
        var_06 = var_04.pers["team"];
      }

      if(!isDefined(var_06)) {
        continue;
      }

      if(!isDefined(var_01[var_06])) {
        var_01[var_06] = [];
      }

      if(!isDefined(var_01[var_06][var_05])) {
        var_01[var_06][var_05] = 1;
        continue;
      }

      var_01[var_06][var_05]++;
    }

    var_08 = -1;
    foreach(var_0A in level.bot_difficulty_defaults) {
      if(!isDefined(var_01[var_02]) || !isDefined(var_01[var_02][var_0A])) {
        var_00 = var_0A;
        break;
      } else if(var_08 == -1 || var_01[var_02][var_0A] < var_08) {
        var_08 = var_01[var_02][var_0A];
        var_00 = var_0A;
      }
    }
  }

  if(isDefined(var_00)) {
    self.var_2D32 = var_00;
  }

  return var_00;
}

bot_is_capturing() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone") {
      return 1;
    }
  }

  return 0;
}

bot_is_patrolling() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "patrol") {
      return 1;
    }
  }

  return 0;
}

bot_is_protecting() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "protect") {
      return 1;
    }
  }

  return 0;
}

bot_is_bodyguarding() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "bodyguard") {
      return 1;
    }
  }

  return 0;
}

bot_is_defending() {
  return isDefined(self.bot_defending);
}

bot_is_defending_point(param_00) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, param_00)) {
      return 1;
    }
  }

  return 0;
}

bot_is_guarding_player(param_00) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == param_00) {
    return 1;
  }

  return 0;
}

bot_cache_entrances_to_bombzones() {
  var_00 = [];
  var_01 = [];
  var_02 = 0;
  foreach(var_04 in level.bombzones) {
    var_00[var_02] = ::scripts\engine\utility::random(var_04.bottargets).origin;
    var_01[var_02] = "zone" + var_04.label;
    var_02++;
  }

  func_2D18(var_00, var_01);
}

bot_cache_entrances_to_flags_or_radios(param_00, param_01) {
  wait(1);
  var_02 = [];
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(isDefined(param_00[var_04].bottarget)) {
      var_02[var_04] = param_00[var_04].bottarget.origin;
    } else {
      param_00[var_04].nearest_node = getclosestnodeinsight(param_00[var_04].origin);
      var_02[var_04] = param_00[var_04].nearest_node.origin;
    }

    var_03[var_04] = param_01 + param_00[var_04].script_label;
  }

  func_2D18(var_02, var_03);
}

entrance_visible_from(param_00, param_01, param_02) {
  var_03 = (0, 0, 11);
  var_04 = (0, 0, 40);
  var_05 = undefined;
  if(param_02 == "stand") {
    return 1;
  } else if(param_02 == "crouch") {
    var_05 = var_04;
  } else if(param_02 == "prone") {
    var_05 = var_03;
  }

  return sighttracepassed(param_01 + var_05, param_00 + var_05, 0, undefined);
}

func_2D18(param_00, param_01) {
  wait(0.1);
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_04 = param_01[var_03];
    var_02[var_04] = findentrances(param_00[var_03]);
    wait(0.05);
    for(var_05 = 0; var_05 < var_02[var_04].size; var_05++) {
      var_06 = var_02[var_04][var_05];
      var_06.is_precalculated_entrance = 1;
      var_06.prone_visible_from[var_04] = entrance_visible_from(var_06.origin, param_00[var_03], "prone");
      wait(0.05);
      var_06.crouch_visible_from[var_04] = entrance_visible_from(var_06.origin, param_00[var_03], "crouch");
      wait(0.05);
      for(var_07 = 0; var_07 < param_01.size; var_07++) {
        for(var_08 = var_07 + 1; var_08 < param_01.size; var_08++) {
          var_06.on_path_from[param_01[var_07]][param_01[var_08]] = 0;
          var_06.on_path_from[param_01[var_08]][param_01[var_07]] = 0;
        }
      }
    }
  }

  var_09 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    for(var_05 = var_03 + 1; var_05 < param_00.size; var_05++) {
      var_0A = get_extended_path(param_00[var_03], param_00[var_05]);
      var_09[param_01[var_03]][param_01[var_05]] = var_0A;
      var_09[param_01[var_05]][param_01[var_03]] = var_0A;
      foreach(var_0C in var_0A) {
        var_0C.on_path_from[param_01[var_03]][param_01[var_05]] = 1;
        var_0C.on_path_from[param_01[var_05]][param_01[var_03]] = 1;
      }
    }
  }

  if(!isDefined(level.precalculated_paths)) {
    level.precalculated_paths = [];
  }

  if(!isDefined(level.entrance_origin_points)) {
    level.entrance_origin_points = [];
  }

  if(!isDefined(level.entrance_indices)) {
    level.entrance_indices = [];
  }

  if(!isDefined(level.entrance_points)) {
    level.entrance_points = [];
  }

  level.precalculated_paths = scripts\engine\utility::array_combine_non_integer_indices(level.precalculated_paths, var_09);
  level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, param_00);
  level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, param_01);
  level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, var_02);
  level.entrance_points_finished_caching = 1;
}

get_extended_path(param_00, param_01) {
  var_02 = func_get_nodes_on_path(param_00, param_01);
  if(isDefined(var_02)) {
    var_02 = remove_ends_from_path(var_02);
    var_02 = get_all_connected_nodes(var_02);
  }

  return var_02;
}

func_get_path_dist(param_00, param_01) {
  return getpathdist(param_00, param_01);
}

func_get_nodes_on_path(param_00, param_01) {
  return getnodesonpath(param_00, param_01);
}

func_bot_get_closest_navigable_point(param_00, param_01, param_02) {
  return botgetclosestnavigablepoint(param_00, param_01, param_02);
}

node_is_on_path_from_labels(param_00, param_01) {
  if(!isDefined(self.on_path_from) || !isDefined(self.on_path_from[param_00]) || !isDefined(self.on_path_from[param_00][param_01])) {
    return 0;
  }

  return self.on_path_from[param_00][param_01];
}

get_all_connected_nodes(param_00) {
  var_01 = param_00;
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_03 = getlinkednodes(param_00[var_02]);
    for(var_04 = 0; var_04 < var_03.size; var_04++) {
      if(!scripts\engine\utility::array_contains(var_01, var_03[var_04])) {
        var_01 = scripts\engine\utility::array_add(var_01, var_03[var_04]);
      }
    }
  }

  return var_01;
}

get_visible_nodes_array(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_00) {
    if(nodesvisible(var_04, param_01, 1)) {
      var_02 = scripts\engine\utility::array_add(var_02, var_04);
    }
  }

  return var_02;
}

remove_ends_from_path(param_00) {
  param_00[param_00.size - 1] = undefined;
  param_00[0] = undefined;
  return scripts\engine\utility::array_removeundefined(param_00);
}

bot_waittill_bots_enabled(param_00) {
  var_01 = 1;
  while(!func_2D17(param_00)) {
    wait(0.5);
  }
}

func_2D17(param_00) {
  if(botautoconnectenabled()) {
    return 1;
  }

  if(bots_exist(param_00)) {
    return 1;
  }

  return 0;
}

bot_waittill_out_of_combat_or_time(param_00) {
  var_01 = gettime();
  for(;;) {
    if(isDefined(param_00)) {
      if(gettime() > var_01 + param_00) {
        return;
      }
    }

    if(!isDefined(self.isnodeoccupied)) {
      return;
    } else if(!bot_in_combat()) {
      return;
    }

    wait(0.05);
  }
}

bot_in_combat(param_00) {
  var_01 = gettime() - self.last_enemy_sight_time;
  var_02 = level.bot_out_of_combat_time;
  if(isDefined(param_00)) {
    var_02 = param_00;
  }

  return var_01 < var_02;
}

bot_waittill_goal_or_fail(param_00, param_01, param_02) {
  if(!isDefined(param_01) && isDefined(param_02)) {}

  var_03 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];
  if(isDefined(param_01)) {
    var_03[var_03.size] = param_01;
  }

  if(isDefined(param_02)) {
    var_03[var_03.size] = param_02;
  }

  if(isDefined(param_00)) {
    var_04 = scripts\engine\utility::waittill_any_in_array_or_timeout(var_03, param_00);
  } else {
    var_04 = scripts\engine\utility::waittill_any_in_array_return(var_04);
  }

  return var_04;
}

bot_usebutton_wait(param_00, param_01, param_02) {
  level endon("game_ended");
  childthread use_button_stopped_notify();
  var_03 = scripts\engine\utility::waittill_any_timeout_1(param_00, param_01, param_02, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_03;
}

use_button_stopped_notify(param_00, param_01) {
  self endon("stop_usebutton_watcher");
  wait(0.05);
  while(self usebuttonpressed()) {
    wait(0.05);
  }

  self notify("use_button_no_longer_pressed");
}

bots_exist(param_00) {
  foreach(var_02 in level.participants) {
    if(isai(var_02)) {
      if(isDefined(param_00) && param_00) {
        if(!scripts\mp\utility::isteamparticipant(var_02)) {
          continue;
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(param_00, param_01) {
  if(!isDefined(level.entrance_points_finished_caching) && !isDefined(self.defense_override_watch_nodes)) {
    return undefined;
  }

  var_02 = [];
  if(isDefined(self.defense_override_watch_nodes)) {
    var_02 = self.defense_override_watch_nodes;
  } else {
    var_02 = level.entrance_points[param_01];
  }

  if(!isDefined(param_00) || param_00 == "stand") {
    return var_02;
  } else if(param_00 == "crouch") {
    var_03 = [];
    foreach(var_05 in var_02) {
      if(var_05.crouch_visible_from[param_01]) {
        var_03 = scripts\engine\utility::array_add(var_03, var_05);
      }
    }

    return var_03;
  } else if(var_04 == "prone") {
    var_03 = [];
    foreach(var_07 in var_05) {
      if(var_07.prone_visible_from[var_03]) {
        var_05 = scripts\engine\utility::array_add(var_05, var_07);
      }
    }

    return var_05;
  }

  return undefined;
}

bot_find_node_to_guard_player(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = self _meth_8533();
  var_05 = self.bot_defend_player_guarding getvelocity();
  if(lengthsquared(var_05) > 100) {
    var_06 = getnodesinradius(param_00, param_01 * 1.75, param_01 * 0.5, 500, "path", var_04);
    var_07 = [];
    var_08 = vectornormalize(var_05);
    for(var_09 = 0; var_09 < var_06.size; var_09++) {
      var_0A = vectornormalize(var_06[var_09].origin - self.bot_defend_player_guarding.origin);
      if(vectordot(var_0A, var_08) > 0.1) {
        var_07[var_07.size] = var_06[var_09];
      }
    }
  } else {
    var_07 = getnodesinradius(param_01, param_02, 0, 500, "path", var_05);
  }

  if(isDefined(param_02) && param_02) {
    var_0B = vectornormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_0C = var_07;
    var_07 = [];
    foreach(var_0E in var_0C) {
      var_0A = vectornormalize(var_0E.origin - self.bot_defend_player_guarding.origin);
      if(vectordot(var_0B, var_0A) > 0.2) {
        var_07[var_07.size] = var_0E;
      }
    }
  }

  var_10 = [];
  var_11 = [];
  var_12 = [];
  for(var_09 = 0; var_09 < var_07.size; var_09++) {
    var_13 = distancesquared(var_07[var_09].origin, param_00) > 10000;
    var_14 = abs(var_07[var_09].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;
    if(var_13) {
      var_10[var_10.size] = var_07[var_09];
    }

    if(var_14) {
      var_11[var_11.size] = var_07[var_09];
    }

    if(var_13 && var_14) {
      var_12[var_12.size] = var_07[var_09];
    }

    if(var_09 % 100 == 99) {
      wait(0.05);
    }
  }

  if(var_12.size > 0) {
    var_03 = self botnodepick(var_12, var_12.size * 0.15, "node_capture", param_00, undefined, self.defense_score_flags);
  }

  if(!isDefined(var_03)) {
    wait(0.05);
    if(var_11.size > 0) {
      var_03 = self botnodepick(var_11, var_11.size * 0.15, "node_capture", param_00, undefined, self.defense_score_flags);
    }

    if(!isDefined(var_03) && var_10.size > 0) {
      wait(0.05);
      var_03 = self botnodepick(var_10, var_10.size * 0.15, "node_capture", param_00, undefined, self.defense_score_flags);
    }
  }

  return var_03;
}

bot_find_node_to_capture_point(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = self _meth_8533();
  var_05 = getnodesinradius(param_00, param_01, 0, 500, "path", var_04);
  if(var_05.size > 0) {
    var_03 = self botnodepick(var_05, var_05.size * 0.15, "node_capture", param_00, param_02, self.defense_score_flags);
  }

  return var_03;
}

bot_find_node_to_capture_zone(param_00, param_01) {
  var_02 = undefined;
  if(param_00.size > 0) {
    var_02 = self botnodepick(param_00, param_00.size * 0.15, "node_capture", undefined, param_01, self.defense_score_flags);
  }

  return var_02;
}

bot_find_node_that_protects_point(param_00, param_01) {
  var_02 = undefined;
  var_03 = self _meth_8533();
  var_04 = getnodesinradius(param_00, param_01, 0, 500, "path", var_03);
  if(var_04.size > 0) {
    var_02 = self botnodepick(var_04, var_04.size * 0.15, "node_protect", param_00, self.defense_score_flags);
  }

  return var_02;
}

bot_pick_random_point_in_radius(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  var_06 = self _meth_8533();
  var_07 = getnodesinradius(param_00, param_01, 0, 500, "path", var_06);
  if(isDefined(var_07) && var_07.size >= 2) {
    var_05 = bot_find_random_midpoint(var_07, param_02);
  }

  if(!isDefined(var_05)) {
    if(!isDefined(param_03)) {
      param_03 = 0;
    }

    if(!isDefined(param_04)) {
      param_04 = 1;
    }

    var_08 = randomfloatrange(self.bot_defending_radius * param_03, self.bot_defending_radius * param_04);
    var_09 = anglesToForward((0, randomint(360), 0));
    var_05 = param_00 + var_09 * var_08;
  }

  return var_05;
}

bot_pick_random_point_from_set(param_00, param_01, param_02) {
  var_03 = undefined;
  if(param_01.size >= 2) {
    var_03 = bot_find_random_midpoint(param_01, param_02);
  }

  if(!isDefined(var_03)) {
    var_04 = scripts\engine\utility::random(param_01);
    var_05 = var_04.origin - param_00;
    var_03 = param_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1);
  }

  return var_03;
}

bot_find_random_midpoint(param_00, param_01) {
  var_02 = undefined;
  var_03 = scripts\engine\utility::array_randomize(param_00);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    for(var_05 = var_04 + 1; var_05 < var_03.size; var_05++) {
      var_06 = var_03[var_04];
      var_07 = var_03[var_05];
      if(nodesvisible(var_06, var_07, 1)) {
        var_02 = (var_06.origin[0] + var_07.origin[0] * 0.5, var_06.origin[1] + var_07.origin[1] * 0.5, var_06.origin[2] + var_07.origin[2] * 0.5);
        if(isDefined(param_01) && self[[param_01]](var_02) == 1) {
          return var_02;
        }
      }
    }
  }

  return var_02;
}

defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node)) {
    return self.bot_defending_override_origin_node.origin;
  } else if(isDefined(self.bot_defending_center)) {
    return self.bot_defending_center;
  }

  return undefined;
}

bot_allowed_to_use_killstreaks() {
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    if(isDefined(self.sidelinedbycommander) && self.sidelinedbycommander == 1) {
      return 0;
    }
  }

  if(scripts\mp\utility::iskillstreakdenied()) {
    return 0;
  }

  if(bot_is_remote_or_linked()) {
    return 0;
  }

  if(self isusingturret()) {
    return 0;
  }

  if(isDefined(level.nukeincoming)) {
    return 0;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(isDefined(self.controlsfrozen) && self.controlsfrozen) {
    return 0;
  }

  if(self isoffhandweaponreadytothrow()) {
    return 0;
  }

  if(!bot_in_combat(500)) {
    return 1;
  }

  if(!isalive(self.isnodeoccupied)) {
    return 1;
  }

  return 0;
}

bot_recent_point_of_interest() {
  var_00 = undefined;
  var_01 = botmemoryflags("investigated", "killer_died");
  var_02 = botmemoryflags("investigated");
  var_03 = scripts\engine\utility::random(botgetmemoryevents(0, gettime() - 10000, 1, "death", var_01, self));
  if(isDefined(var_03)) {
    var_00 = var_03;
    self.bot_memory_goal_time = 10000;
  } else {
    var_04 = undefined;
    if(self botgetscriptgoaltype() != "none") {
      var_04 = self botgetscriptgoal();
    }

    var_05 = botgetmemoryevents(0, gettime() - -20536, 1, "kill", var_02, self);
    var_06 = botgetmemoryevents(0, gettime() - -20536, 1, "death", var_01, self);
    var_07 = [];
    foreach(var_09 in var_05) {
      var_07[var_07.size] = var_09;
    }

    foreach(var_09 in var_06) {
      var_07[var_07.size] = var_09;
    }

    var_03 = scripts\engine\utility::random(var_07);
    if(isDefined(var_03) > 0 && !isDefined(var_04) || distancesquared(var_04, var_03) > 1000000) {
      var_00 = var_03;
      self.bot_memory_goal_time = -20536;
    }
  }

  if(isDefined(var_00)) {
    var_0D = getzonenearest(var_00);
    var_0E = getzonenearest(self.origin);
    if(isDefined(var_0D) && isDefined(var_0E) && var_0E != var_0D) {
      var_0F = botzonegetcount(var_0D, self.team, "ally") + botzonegetcount(var_0D, self.team, "path_ally");
      if(var_0F > 1) {
        var_00 = undefined;
      }
    }
  }

  if(isDefined(var_00)) {
    self.bot_memory_goal = var_00;
  }

  return var_00;
}

func_2D66(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {}

func_2D67(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {}

func_2D65(param_00, param_01, param_02, param_03, param_04) {}

bot_get_total_gun_ammo() {
  var_00 = 0;
  var_01 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_01 = self.weaponlist;
  } else {
    var_01 = self getweaponslistprimaries();
  }

  foreach(var_03 in var_01) {
    var_00 = var_00 + self getweaponammoclip(var_03);
    var_00 = var_00 + self getweaponammostock(var_03);
  }

  return var_00;
}

bot_out_of_ammo() {
  var_00 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_00 = self.weaponlist;
  } else {
    var_00 = self getweaponslistprimaries();
  }

  foreach(var_02 in var_00) {
    if(self getweaponammoclip(var_02) > 0) {
      return 0;
    }

    if(self getweaponammostock(var_02) > 0) {
      return 0;
    }
  }

  return 1;
}

bot_get_grenade_ammo() {
  var_00 = 0;
  var_01 = self getweaponslistoffhands();
  foreach(var_03 in var_01) {
    var_00 = var_00 + self getweaponammostock(var_03);
  }

  return var_00;
}

bot_grenade_matches_purpose(param_00, param_01) {
  if(!isDefined(param_01)) {
    return 0;
  }

  switch (param_00) {
    case "trap_directional":
      switch (param_01) {
        case "claymore_mp":
          return 1;
      }
      break;

    case "trap":
      switch (param_01) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }
      break;

    case "c4":
      switch (param_01) {
        case "c4_mp":
          return 1;
      }
      break;

    case "tacticalinsertion":
      switch (param_01) {
        case "flare_mp":
          return 1;
      }
      break;
  }

  return 0;
}

bot_get_grenade_for_purpose(param_00) {
  if(self botgetdifficultysetting("allowGrenades") != 0) {
    var_01 = self botfirstavailablegrenade("lethal");
    if(bot_grenade_matches_purpose(param_00, var_01)) {
      return "lethal";
    }

    var_01 = self botfirstavailablegrenade("tactical");
    if(bot_grenade_matches_purpose(param_00, var_01)) {
      return "tactical";
    }
  }
}

bot_watch_nodes(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");
  wait(1);
  var_08 = 1;
  while(var_08) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < 16) {
        var_08 = 0;
      }
    }

    if(var_08) {
      wait(0.05);
    }
  }

  var_09 = self.origin;
  if(isDefined(param_00)) {
    self.watch_nodes = [];
    foreach(var_0B in param_00) {
      var_0C = 0;
      if(distance2dsquared(self.origin, var_0B.origin) <= 10) {
        var_0C = 1;
      }

      var_0D = self getEye();
      var_0E = vectordot((0, 0, 1), vectornormalize(var_0B.origin - var_0D));
      if(abs(var_0E) > 0.92) {
        var_0C = 1;
      }

      if(!var_0C) {
        self.watch_nodes[self.watch_nodes.size] = var_0B;
      }
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }

  if(isDefined(param_04)) {
    self endon(param_04);
  }

  if(isDefined(param_05)) {
    self endon(param_05);
  }

  if(isDefined(param_06)) {
    self endon(param_06);
  }

  if(isDefined(param_07)) {
    self endon(param_07);
  }

  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);
  foreach(var_0B in self.watch_nodes) {
    var_0B.watch_node_chance[self.entity_number] = 1;
  }

  var_12 = gettime();
  var_13 = var_12;
  var_14 = [];
  var_15 = undefined;
  if(isDefined(param_01)) {
    var_15 = (0, param_01, 0);
  }

  var_16 = isDefined(var_15) && isDefined(param_02);
  var_17 = undefined;
  var_18 = undefined;
  for(;;) {
    var_19 = gettime();
    self notify("still_watching_nodes");
    var_1A = self botgetfovdot();
    if(isDefined(param_03) && var_19 >= param_03) {
      return;
    }

    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      self botlookatpoint(undefined);
      wait(0.2);
      continue;
    }

    if(!self bothasscriptgoal() || !self botpursuingscriptgoal()) {
      wait(0.2);
      continue;
    }

    if(isDefined(var_17) && var_17.watch_node_chance[self.entity_number] == 0) {
      var_13 = var_19;
    }

    if(self.watch_nodes.size > 0) {
      var_1B = 0;
      if(isDefined(self.isnodeoccupied)) {
        var_1C = self lastknownpos(self.isnodeoccupied);
        var_1D = self lastknowntime(self.isnodeoccupied);
        if(var_1D && var_19 - var_1D < 5000) {
          var_1E = vectornormalize(var_1C - self.origin);
          var_1F = 0;
          for(var_20 = 0; var_20 < self.watch_nodes.size; var_20++) {
            var_21 = vectornormalize(self.watch_nodes[var_20].origin - self.origin);
            var_22 = vectordot(var_1E, var_21);
            if(var_22 > var_1F) {
              var_1F = var_22;
              var_17 = self.watch_nodes[var_20];
              var_1B = 1;
            }
          }
        }
      }

      if(!var_1B && var_19 >= var_13) {
        var_23 = [];
        for(var_20 = 0; var_20 < self.watch_nodes.size; var_20++) {
          var_0B = self.watch_nodes[var_20];
          var_24 = var_0B getnodenumber();
          if(var_16 && !scripts\engine\utility::within_fov(self.origin, var_15, var_0B.origin, param_02)) {
            continue;
          }

          if(!isDefined(var_14[var_24])) {
            var_14[var_24] = 0;
          }

          if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0B.origin, var_1A)) {
            var_14[var_24] = var_19;
          }

          for(var_25 = 0; var_25 < var_23.size; var_25++) {
            if(var_14[var_23[var_25] getnodenumber()] > var_14[var_24]) {
              break;
            }
          }

          var_23 = scripts\engine\utility::array_insert(var_23, var_0B, var_25);
        }

        var_17 = undefined;
        for(var_20 = 0; var_20 < var_23.size; var_20++) {
          if(randomfloat(1) > var_23[var_20].watch_node_chance[self.entity_number]) {
            continue;
          }

          var_0B = var_23[var_20];
          var_26 = (0, 0, 1);
          var_27 = self getEye();
          var_28 = (0, 0, self getplayerviewheight());
          var_18 = var_0B.origin + var_28;
          var_29 = var_18 - var_27;
          var_29 = vectornormalize(var_29);
          var_22 = vectordot(var_29, var_26);
          if(var_22 > 0.939693) {
            continue;
          }

          var_17 = var_0B;
          var_13 = var_19 + randomintrange(3000, 5000);
          break;
        }
      }

      if(isDefined(var_17)) {
        var_28 = (0, 0, self getplayerviewheight());
        var_18 = var_17.origin + var_28;
        self botlookatpoint(var_18, 0.4, "script_search");
      }
    }

    wait(0.2);
  }
}

watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");
  self.watch_nodes = undefined;
}

watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_timeout_1(0.5, "still_watching_nodes");
    if(!isDefined(var_00) || var_00 != "still_watching_nodes") {
      watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(param_00, param_01) {
  if(isDefined(param_01) && param_01 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self.angles, param_01, self botgetfovdot())) {
      var_02 = self botpredictseepoint(param_01);
      if(isDefined(var_02)) {
        self botlookatpoint(var_02 + (0, 0, 40), 1, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, param_01);
  }
}

bot_get_known_attacker(param_00, param_01) {
  if(isDefined(param_01) && isDefined(param_01.classname)) {
    if(param_01.classname == "grenade") {
      if(!bot_ent_is_anonymous_mine(param_01)) {
        return param_00;
      }
    } else if(param_01.classname == "rocket") {
      if(isDefined(param_01.vehicle_fired_from)) {
        return param_01.vehicle_fired_from;
      }

      if(isDefined(param_01.type) && param_01.type == "remote" || param_01.type == "odin") {
        return param_01;
      }

      if(isDefined(param_01.triggerportableradarping)) {
        return param_01.triggerportableradarping;
      }
    } else if(param_01.classname == "worldspawn" || param_01.classname == "trigger_hurt") {
      return undefined;
    }

    return param_01;
  }

  return param_00;
}

bot_ent_is_anonymous_mine(param_00) {
  if(!isDefined(param_00.weapon_name)) {
    return 0;
  }

  if(param_00.weapon_name == "c4_mp") {
    return 1;
  }

  if(param_00.weapon_name == "proximity_explosive_mp") {
    return 1;
  }

  return 0;
}

bot_vectors_are_equal(param_00, param_01) {
  return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

bot_add_to_bot_level_targets(param_00) {
  param_00.high_priority_for = [];
  if(param_00.bot_interaction_type == "use") {
    bot_add_to_bot_use_targets(param_00);
    return;
  }

  if(param_00.bot_interaction_type == "damage") {
    bot_add_to_bot_damage_targets(param_00);
    return;
  }
}

bot_remove_from_bot_level_targets(param_00) {
  param_00.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, param_00);
}

bot_add_to_bot_use_targets(param_00) {
  if(!issubstr(param_00.var_9F, "trigger_use")) {
    return;
  }

  if(!isDefined(param_00.target)) {
    return;
  }

  if(isDefined(param_00.bot_target)) {
    return;
  }

  if(!isDefined(param_00.use_time)) {
    return;
  }

  var_01 = getnodearray(param_00.target, "targetname");
  if(var_01.size != 1) {
    return;
  }

  param_00.bot_target = var_01[0];
  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, param_00);
}

bot_add_to_bot_damage_targets(param_00) {
  if(!issubstr(param_00.var_9F, "trigger_damage")) {
    return;
  }

  var_01 = getnodearray(param_00.target, "targetname");
  if(var_01.size != 2) {
    return;
  }

  param_00.bot_targets = var_01;
  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, param_00);
}

bot_get_string_index_for_integer(param_00, param_01) {
  var_02 = 0;
  foreach(var_05, var_04 in param_00) {
    if(var_02 == param_01) {
      return var_05;
    }

    var_02++;
  }

  return undefined;
}

bot_get_zones_within_dist(param_00, param_01) {
  for(var_02 = 0; var_02 < level.zonecount; var_02++) {
    var_03 = getzonenodeforindex(var_02);
    var_03.visited = 0;
  }

  var_04 = getzonenodeforindex(param_00);
  return bot_get_zones_within_dist_recurs(var_04, param_01);
}

bot_get_zones_within_dist_recurs(param_00, param_01) {
  var_02 = [];
  var_02[0] = getnodezone(param_00);
  param_00.visited = 1;
  var_03 = getlinkednodes(param_00);
  foreach(var_05 in var_03) {
    if(!var_05.visited) {
      var_06 = distance(param_00.origin, var_05.origin);
      if(var_06 < param_01) {
        var_07 = bot_get_zones_within_dist_recurs(var_05, param_01 - var_06);
        var_02 = scripts\engine\utility::array_combine(var_07, var_02);
      }
    }
  }

  return var_02;
}

bot_crate_is_command_goal(param_00) {
  return isDefined(param_00) && isDefined(param_00.command_goal) && param_00.command_goal;
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_00 = getdvarint("party_maxplayers", 0);
  var_00 = max(var_00, getdvarint("party_maxPrivatePartyPlayers", 0));
  if(var_00 > level.maxclients) {
    return level.maxclients;
  }

  return var_00;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait(0.05);
  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var_00 = level.bot_queued_process_queue[0];
      if(isDefined(var_00) && isDefined(var_00.triggerportableradarping)) {
        var_01 = undefined;
        if(isDefined(var_00.parm4)) {
          var_01 = var_00.triggerportableradarping[[var_00.func]](var_00.parm1, var_00.parm2, var_00.parm3, var_00.parm4);
        } else if(isDefined(var_00.parm3)) {
          var_01 = var_00.triggerportableradarping[[var_00.func]](var_00.parm1, var_00.parm2, var_00.parm3);
        } else if(isDefined(var_00.parm2)) {
          var_01 = var_00.triggerportableradarping[[var_00.func]](var_00.parm1, var_00.parm2);
        } else if(isDefined(var_00.parm1)) {
          var_01 = var_00.triggerportableradarping[[var_00.func]](var_00.parm1);
        } else {
          var_01 = var_00.triggerportableradarping[[var_00.func]]();
        }

        var_00.triggerportableradarping notify(var_00.name_complete, var_01);
      }

      var_02 = [];
      for(var_03 = 1; var_03 < level.bot_queued_process_queue.size; var_03++) {
        var_02[var_03 - 1] = level.bot_queued_process_queue[var_03];
      }

      level.bot_queued_process_queue = var_02;
    }

    wait(0.05);
  }
}

bot_queued_process(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(var_08, var_07 in level.bot_queued_process_queue) {
    if(var_07.triggerportableradarping == self && var_07.name == param_00) {
      self notify(var_07.name);
      level.bot_queued_process_queue[var_08] = undefined;
    }
  }

  var_07 = spawnStruct();
  var_07.triggerportableradarping = self;
  var_07.name = param_00;
  var_07.name_complete = var_07.name + "_done";
  var_07.func = param_01;
  var_07.parm1 = param_02;
  var_07.parm2 = param_03;
  var_07.parm3 = param_04;
  var_07.parm4 = param_05;
  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = var_07;
  if(!isDefined(level.bot_queued_process_level_thread_active)) {
    level.bot_queued_process_level_thread_active = 1;
    level thread bot_queued_process_level_thread();
  }

  self waittill(var_07.name_complete, var_09);
  return var_09;
}

bot_is_remote_or_linked() {
  return scripts\mp\utility::isusingremote() || self islinked();
}

bot_get_low_on_ammo(param_00) {
  var_01 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_01 = self.weaponlist;
  } else {
    var_01 = self getweaponslistprimaries();
  }

  foreach(var_03 in var_01) {
    var_04 = weaponclipsize(var_03);
    var_05 = self getweaponammostock(var_03);
    if(var_05 <= var_04) {
      return 1;
    }

    if(self getfractionmaxammo(var_03) <= param_00) {
      return 1;
    }
  }

  return 0;
}

bot_point_is_on_pathgrid(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 256;
  }

  if(!isDefined(param_02)) {
    param_02 = 50;
  }

  var_03 = getnodesinradiussorted(param_00, param_01, 0, param_02, "Path");
  foreach(var_05 in var_03) {
    var_06 = param_00 + (0, 0, 30);
    var_07 = var_05.origin + (0, 0, 30);
    var_08 = physicstrace(var_06, var_07);
    if(bot_vectors_are_equal(var_08, var_07)) {
      return 1;
    }

    wait(0.05);
  }

  return 0;
}

bot_monitor_enemy_camp_spots(param_00) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];
  for(;;) {
    wait(1);
    var_01 = [];
    if(!isDefined(param_00)) {
      continue;
    }

    foreach(var_03 in level.participants) {
      if(!isDefined(var_03.team)) {
        continue;
      }

      if(var_03[[param_00]]() && !isDefined(var_01[var_03.team])) {
        level.enemy_camp_assassin[var_03.team] = undefined;
        level.enemy_camp_spots[var_03.team] = var_03 getclosestenemysqdist(1);
        if(isDefined(level.enemy_camp_spots[var_03.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[var_03.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var_03.team], level.enemy_camp_assassin_goal[var_03.team])) {
            level.enemy_camp_assassin_goal[var_03.team] = ::scripts\engine\utility::random(level.enemy_camp_spots[var_03.team]);
          }

          if(isDefined(level.enemy_camp_assassin_goal[var_03.team])) {
            var_04 = [];
            foreach(var_06 in level.participants) {
              if(!isDefined(var_06.team)) {
                continue;
              }

              if(var_06[[param_00]]() && var_06.team == var_03.team) {
                var_04[var_04.size] = var_06;
              }
            }

            var_04 = sortbydistance(var_04, level.enemy_camp_assassin_goal[var_03.team]);
            if(var_04.size > 0) {
              level.enemy_camp_assassin[var_03.team] = var_04[0];
            }
          }
        }

        var_01[var_03.team] = 1;
      }
    }
  }
}

bot_valid_camp_assassin() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.team)) {
    return 0;
  }

  if(self.team == "spectator") {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(!scripts\mp\utility::isaiteamparticipant(self)) {
    return 0;
  }

  if(self.personality == "camper") {
    return 0;
  }

  return 1;
}

bot_update_camp_assassin() {
  if(!isDefined(level.enemy_camp_assassin)) {
    return;
  }

  if(!isDefined(level.enemy_camp_assassin[self.team])) {
    return;
  }

  if(level.enemy_camp_assassin[self.team] == self) {
    scripts\mp\bots\_bots_strategy::bot_defend_stop();
    self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team], 128, "objective", undefined, 256);
    bot_waittill_goal_or_fail();
  }
}

bot_force_stance_for_time(param_00, param_01) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance(param_00);
  wait(param_01);
  self botsetstance("none");
}