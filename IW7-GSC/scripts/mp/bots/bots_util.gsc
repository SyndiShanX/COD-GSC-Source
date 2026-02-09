/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_util.gsc
*********************************************/

bot_get_nodes_in_cone(var_0, var_1, var_2) {
  var_3 = self func_8533();
  var_4 = getnodesinradius(self.origin, var_0, 0, 512, "path", var_3);
  var_5 = [];
  var_6 = self getnearestnode();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectornormalize(var_7 * (1, 1, 0));
  foreach(var_10 in var_4) {
    var_11 = vectornormalize(var_10.origin - self.origin * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);
    if(var_12 > var_1) {
      if(!var_2 || isDefined(var_6) && nodesvisible(var_10, var_6, 1)) {
        var_5 = scripts\engine\utility::array_add(var_5, var_10);
      }
    }
  }

  return var_5;
}

bot_goal_can_override(var_0, var_1) {
  if(var_0 == "none") {
    return var_1 == "none";
  } else if(var_0 == "hunt") {
    return var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "guard") {
    return var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "objective") {
    return var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "critical") {
    return var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none";
  } else if(var_0 == "tactical") {
    return 1;
  }
}

bot_set_personality(var_0) {
  self botsetpersonality(var_0);
  scripts\mp\bots\_bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(var_0) {
  if(var_0 == "default") {
    var_0 = func_2D30();
  }

  self botsetdifficulty(var_0);
  if(isPlayer(self)) {
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

  var_0 = self.var_2D32;
  if(!isDefined(var_0)) {
    var_1 = [];
    var_2 = self.team;
    if(!isDefined(var_2)) {
      var_2 = self.bot_team;
    }

    if(!isDefined(var_2)) {
      var_2 = self.pers["team"];
    }

    if(!isDefined(var_2)) {
      var_2 = "allies";
    }

    foreach(var_4 in level.players) {
      if(var_4 == self) {
        continue;
      }

      if(!isai(var_4)) {
        continue;
      }

      var_5 = var_4 botgetdifficulty();
      if(var_5 == "default") {
        continue;
      }

      var_6 = var_4.team;
      if(!isDefined(var_6)) {
        var_6 = var_4.bot_team;
      }

      if(!isDefined(var_6)) {
        var_6 = var_4.pers["team"];
      }

      if(!isDefined(var_6)) {
        continue;
      }

      if(!isDefined(var_1[var_6])) {
        var_1[var_6] = [];
      }

      if(!isDefined(var_1[var_6][var_5])) {
        var_1[var_6][var_5] = 1;
        continue;
      }

      var_1[var_6][var_5]++;
    }

    var_8 = -1;
    foreach(var_10 in level.bot_difficulty_defaults) {
      if(!isDefined(var_1[var_2]) || !isDefined(var_1[var_2][var_10])) {
        var_0 = var_10;
        break;
      } else if(var_8 == -1 || var_1[var_2][var_10] < var_8) {
        var_8 = var_1[var_2][var_10];
        var_0 = var_10;
      }
    }
  }

  if(isDefined(var_0)) {
    self.var_2D32 = var_0;
  }

  return var_0;
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

bot_is_defending_point(var_0) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, var_0)) {
      return 1;
    }
  }

  return 0;
}

bot_is_guarding_player(var_0) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == var_0) {
    return 1;
  }

  return 0;
}

bot_cache_entrances_to_bombzones() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;
  foreach(var_4 in level.bombzones) {
    var_0[var_2] = ::scripts\engine\utility::random(var_4.bottargets).origin;
    var_1[var_2] = "zone" + var_4.label;
    var_2++;
  }

  func_2D18(var_0, var_1);
}

bot_cache_entrances_to_flags_or_radios(var_0, var_1) {
  wait(1);
  var_2 = [];
  var_3 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(isDefined(var_0[var_4].bottarget)) {
      var_2[var_4] = var_0[var_4].bottarget.origin;
    } else {
      var_0[var_4].nearest_node = getclosestnodeinsight(var_0[var_4].origin);
      var_2[var_4] = var_0[var_4].nearest_node.origin;
    }

    var_3[var_4] = var_1 + var_0[var_4].script_label;
  }

  func_2D18(var_2, var_3);
}

entrance_visible_from(var_0, var_1, var_2) {
  var_3 = (0, 0, 11);
  var_4 = (0, 0, 40);
  var_5 = undefined;
  if(var_2 == "stand") {
    return 1;
  } else if(var_2 == "crouch") {
    var_5 = var_4;
  } else if(var_2 == "prone") {
    var_5 = var_3;
  }

  return sighttracepassed(var_1 + var_5, var_0 + var_5, 0, undefined);
}

func_2D18(var_0, var_1) {
  wait(0.1);
  var_2 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_1[var_3];
    var_2[var_4] = findentrances(var_0[var_3]);
    wait(0.05);
    for(var_5 = 0; var_5 < var_2[var_4].size; var_5++) {
      var_6 = var_2[var_4][var_5];
      var_6.is_precalculated_entrance = 1;
      var_6.prone_visible_from[var_4] = entrance_visible_from(var_6.origin, var_0[var_3], "prone");
      wait(0.05);
      var_6.crouch_visible_from[var_4] = entrance_visible_from(var_6.origin, var_0[var_3], "crouch");
      wait(0.05);
      for(var_7 = 0; var_7 < var_1.size; var_7++) {
        for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
          var_6.on_path_from[var_1[var_7]][var_1[var_8]] = 0;
          var_6.on_path_from[var_1[var_8]][var_1[var_7]] = 0;
        }
      }
    }
  }

  var_9 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    for(var_5 = var_3 + 1; var_5 < var_0.size; var_5++) {
      var_10 = get_extended_path(var_0[var_3], var_0[var_5]);
      var_9[var_1[var_3]][var_1[var_5]] = var_10;
      var_9[var_1[var_5]][var_1[var_3]] = var_10;
      foreach(var_12 in var_10) {
        var_12.on_path_from[var_1[var_3]][var_1[var_5]] = 1;
        var_12.on_path_from[var_1[var_5]][var_1[var_3]] = 1;
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

  level.precalculated_paths = scripts\engine\utility::array_combine_non_integer_indices(level.precalculated_paths, var_9);
  level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, var_0);
  level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, var_1);
  level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, var_2);
  level.entrance_points_finished_caching = 1;
}

get_extended_path(var_0, var_1) {
  var_2 = func_get_nodes_on_path(var_0, var_1);
  if(isDefined(var_2)) {
    var_2 = remove_ends_from_path(var_2);
    var_2 = get_all_connected_nodes(var_2);
  }

  return var_2;
}

func_get_path_dist(var_0, var_1) {
  return getpathdist(var_0, var_1);
}

func_get_nodes_on_path(var_0, var_1) {
  return getnodesonpath(var_0, var_1);
}

func_bot_get_closest_navigable_point(var_0, var_1, var_2) {
  return botgetclosestnavigablepoint(var_0, var_1, var_2);
}

node_is_on_path_from_labels(var_0, var_1) {
  if(!isDefined(self.on_path_from) || !isDefined(self.on_path_from[var_0]) || !isDefined(self.on_path_from[var_0][var_1])) {
    return 0;
  }

  return self.on_path_from[var_0][var_1];
}

get_all_connected_nodes(var_0) {
  var_1 = var_0;
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = getlinkednodes(var_0[var_2]);
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(!scripts\engine\utility::array_contains(var_1, var_3[var_4])) {
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_4]);
      }
    }
  }

  return var_1;
}

get_visible_nodes_array(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_0) {
    if(nodesvisible(var_4, var_1, 1)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

remove_ends_from_path(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return scripts\engine\utility::array_removeundefined(var_0);
}

bot_waittill_bots_enabled(var_0) {
  var_1 = 1;
  while(!func_2D17(var_0)) {
    wait(0.5);
  }
}

func_2D17(var_0) {
  if(botautoconnectenabled()) {
    return 1;
  }

  if(bots_exist(var_0)) {
    return 1;
  }

  return 0;
}

bot_waittill_out_of_combat_or_time(var_0) {
  var_1 = gettime();
  for(;;) {
    if(isDefined(var_0)) {
      if(gettime() > var_1 + var_0) {
        return;
      }
    }

    if(!isDefined(self.enemy)) {
      return;
    } else if(!bot_in_combat()) {
      return;
    }

    wait(0.05);
  }
}

bot_in_combat(var_0) {
  var_1 = gettime() - self.last_enemy_sight_time;
  var_2 = level.bot_out_of_combat_time;
  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  return var_1 < var_2;
}

bot_waittill_goal_or_fail(var_0, var_1, var_2) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  var_3 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];
  if(isDefined(var_1)) {
    var_3[var_3.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_3[var_3.size] = var_2;
  }

  if(isDefined(var_0)) {
    var_4 = scripts\engine\utility::waittill_any_in_array_or_timeout(var_3, var_0);
  } else {
    var_4 = scripts\engine\utility::waittill_any_in_array_return(var_4);
  }

  return var_4;
}

bot_usebutton_wait(var_0, var_1, var_2) {
  level endon("game_ended");
  childthread use_button_stopped_notify();
  var_3 = scripts\engine\utility::waittill_any_timeout(var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_3;
}

use_button_stopped_notify(var_0, var_1) {
  self endon("stop_usebutton_watcher");
  wait(0.05);
  while(self usebuttonpressed()) {
    wait(0.05);
  }

  self notify("use_button_no_longer_pressed");
}

bots_exist(var_0) {
  foreach(var_2 in level.participants) {
    if(isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!scripts\mp\utility::isteamparticipant(var_2)) {
          continue;
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(var_0, var_1) {
  if(!isDefined(level.entrance_points_finished_caching) && !isDefined(self.defense_override_watch_nodes)) {
    return undefined;
  }

  var_2 = [];
  if(isDefined(self.defense_override_watch_nodes)) {
    var_2 = self.defense_override_watch_nodes;
  } else {
    var_2 = level.entrance_points[var_1];
  }

  if(!isDefined(var_0) || var_0 == "stand") {
    return var_2;
  } else if(var_0 == "crouch") {
    var_3 = [];
    foreach(var_5 in var_2) {
      if(var_5.crouch_visible_from[var_1]) {
        var_3 = scripts\engine\utility::array_add(var_3, var_5);
      }
    }

    return var_3;
  } else if(var_4 == "prone") {
    var_3 = [];
    foreach(var_7 in var_5) {
      if(var_7.prone_visible_from[var_3]) {
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }
    }

    return var_5;
  }

  return undefined;
}

bot_find_node_to_guard_player(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self func_8533();
  var_5 = self.bot_defend_player_guarding getvelocity();
  if(lengthsquared(var_5) > 100) {
    var_6 = getnodesinradius(var_0, var_1 * 1.75, var_1 * 0.5, 500, "path", var_4);
    var_7 = [];
    var_8 = vectornormalize(var_5);
    for(var_9 = 0; var_9 < var_6.size; var_9++) {
      var_10 = vectornormalize(var_6[var_9].origin - self.bot_defend_player_guarding.origin);
      if(vectordot(var_10, var_8) > 0.1) {
        var_7[var_7.size] = var_6[var_9];
      }
    }
  } else {
    var_7 = getnodesinradius(var_1, var_2, 0, 500, "path", var_5);
  }

  if(isDefined(var_2) && var_2) {
    var_11 = vectornormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_12 = var_7;
    var_7 = [];
    foreach(var_14 in var_12) {
      var_10 = vectornormalize(var_14.origin - self.bot_defend_player_guarding.origin);
      if(vectordot(var_11, var_10) > 0.2) {
        var_7[var_7.size] = var_14;
      }
    }
  }

  var_10 = [];
  var_11 = [];
  var_12 = [];
  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_13 = distancesquared(var_7[var_9].origin, var_0) > 10000;
    var_14 = abs(var_7[var_9].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;
    if(var_13) {
      var_10[var_10.size] = var_7[var_9];
    }

    if(var_14) {
      var_11[var_11.size] = var_7[var_9];
    }

    if(var_13 && var_14) {
      var_12[var_12.size] = var_7[var_9];
    }

    if(var_9 % 100 == 99) {
      wait(0.05);
    }
  }

  if(var_12.size > 0) {
    var_3 = self botnodepick(var_12, var_12.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
  }

  if(!isDefined(var_3)) {
    wait(0.05);
    if(var_11.size > 0) {
      var_3 = self botnodepick(var_11, var_11.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
    }

    if(!isDefined(var_3) && var_10.size > 0) {
      wait(0.05);
      var_3 = self botnodepick(var_10, var_10.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
    }
  }

  return var_3;
}

bot_find_node_to_capture_point(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self func_8533();
  var_5 = getnodesinradius(var_0, var_1, 0, 500, "path", var_4);
  if(var_5.size > 0) {
    var_3 = self botnodepick(var_5, var_5.size * 0.15, "node_capture", var_0, var_2, self.defense_score_flags);
  }

  return var_3;
}

bot_find_node_to_capture_zone(var_0, var_1) {
  var_2 = undefined;
  if(var_0.size > 0) {
    var_2 = self botnodepick(var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self.defense_score_flags);
  }

  return var_2;
}

bot_find_node_that_protects_point(var_0, var_1) {
  var_2 = undefined;
  var_3 = self func_8533();
  var_4 = getnodesinradius(var_0, var_1, 0, 500, "path", var_3);
  if(var_4.size > 0) {
    var_2 = self botnodepick(var_4, var_4.size * 0.15, "node_protect", var_0, self.defense_score_flags);
  }

  return var_2;
}

bot_pick_random_point_in_radius(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = self func_8533();
  var_7 = getnodesinradius(var_0, var_1, 0, 500, "path", var_6);
  if(isDefined(var_7) && var_7.size >= 2) {
    var_5 = bot_find_random_midpoint(var_7, var_2);
  }

  if(!isDefined(var_5)) {
    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    if(!isDefined(var_4)) {
      var_4 = 1;
    }

    var_8 = randomfloatrange(self.bot_defending_radius * var_3, self.bot_defending_radius * var_4);
    var_9 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_9 * var_8;
  }

  return var_5;
}

bot_pick_random_point_from_set(var_0, var_1, var_2) {
  var_3 = undefined;
  if(var_1.size >= 2) {
    var_3 = bot_find_random_midpoint(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectornormalize(var_5) * length(var_5) * randomfloat(1);
  }

  return var_3;
}

bot_find_random_midpoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = scripts\engine\utility::array_randomize(var_0);
  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_4];
      var_7 = var_3[var_5];
      if(nodesvisible(var_6, var_7, 1)) {
        var_2 = (var_6.origin[0] + var_7.origin[0] * 0.5, var_6.origin[1] + var_7.origin[1] * 0.5, var_6.origin[2] + var_7.origin[2] * 0.5);
        if(isDefined(var_1) && self[[var_1]](var_2) == 1) {
          return var_2;
        }
      }
    }
  }

  return var_2;
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

  if(!isalive(self.enemy)) {
    return 1;
  }

  return 0;
}

bot_recent_point_of_interest() {
  var_0 = undefined;
  var_1 = botmemoryflags("investigated", "killer_died");
  var_2 = botmemoryflags("investigated");
  var_3 = scripts\engine\utility::random(botgetmemoryevents(0, gettime() - 10000, 1, "death", var_1, self));
  if(isDefined(var_3)) {
    var_0 = var_3;
    self.bot_memory_goal_time = 10000;
  } else {
    var_4 = undefined;
    if(self botgetscriptgoaltype() != "none") {
      var_4 = self botgetscriptgoal();
    }

    var_5 = botgetmemoryevents(0, gettime() - -20536, 1, "kill", var_2, self);
    var_6 = botgetmemoryevents(0, gettime() - -20536, 1, "death", var_1, self);
    var_7 = [];
    foreach(var_9 in var_5) {
      var_7[var_7.size] = var_9;
    }

    foreach(var_9 in var_6) {
      var_7[var_7.size] = var_9;
    }

    var_3 = scripts\engine\utility::random(var_7);
    if(isDefined(var_3) > 0 && !isDefined(var_4) || distancesquared(var_4, var_3) > 1000000) {
      var_0 = var_3;
      self.bot_memory_goal_time = -20536;
    }
  }

  if(isDefined(var_0)) {
    var_13 = getzonenearest(var_0);
    var_14 = getzonenearest(self.origin);
    if(isDefined(var_13) && isDefined(var_14) && var_14 != var_13) {
      var_15 = botzonegetcount(var_13, self.team, "ally") + botzonegetcount(var_13, self.team, "path_ally");
      if(var_15 > 1) {
        var_0 = undefined;
      }
    }
  }

  if(isDefined(var_0)) {
    self.bot_memory_goal = var_0;
  }

  return var_0;
}

func_2D66(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

func_2D67(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

func_2D65(var_0, var_1, var_2, var_3, var_4) {}

bot_get_total_gun_ammo() {
  var_0 = 0;
  var_1 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

bot_out_of_ammo() {
  var_0 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_0 = self.weaponlist;
  } else {
    var_0 = self getweaponslistprimaries();
  }

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0) {
      return 0;
    }

    if(self getweaponammostock(var_2) > 0) {
      return 0;
    }
  }

  return 1;
}

bot_get_grenade_ammo() {
  var_0 = 0;
  var_1 = self getweaponslistoffhands();
  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

bot_grenade_matches_purpose(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  switch (var_0) {
    case "trap_directional":
      switch (var_1) {
        case "claymore_mp":
          return 1;
      }
      break;

    case "trap":
      switch (var_1) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }
      break;

    case "c4":
      switch (var_1) {
        case "c4_mp":
          return 1;
      }
      break;

    case "tacticalinsertion":
      switch (var_1) {
        case "flare_mp":
          return 1;
      }
      break;
  }

  return 0;
}

bot_get_grenade_for_purpose(var_0) {
  if(self botgetdifficultysetting("allowGrenades") != 0) {
    var_1 = self botfirstavailablegrenade("lethal");
    if(bot_grenade_matches_purpose(var_0, var_1)) {
      return "lethal";
    }

    var_1 = self botfirstavailablegrenade("tactical");
    if(bot_grenade_matches_purpose(var_0, var_1)) {
      return "tactical";
    }
  }
}

bot_watch_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");
  wait(1);
  var_8 = 1;
  while(var_8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < 16) {
        var_8 = 0;
      }
    }

    if(var_8) {
      wait(0.05);
    }
  }

  var_9 = self.origin;
  if(isDefined(var_0)) {
    self.watch_nodes = [];
    foreach(var_11 in var_0) {
      var_12 = 0;
      if(distance2dsquared(self.origin, var_11.origin) <= 10) {
        var_12 = 1;
      }

      var_13 = self getEye();
      var_14 = vectordot((0, 0, 1), vectornormalize(var_11.origin - var_13));
      if(abs(var_14) > 0.92) {
        var_12 = 1;
      }

      if(!var_12) {
        self.watch_nodes[self.watch_nodes.size] = var_11;
      }
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);
  foreach(var_11 in self.watch_nodes) {
    var_11.watch_node_chance[self.entity_number] = 1;
  }

  var_12 = gettime();
  var_13 = var_12;
  var_14 = [];
  var_15 = undefined;
  if(isDefined(var_1)) {
    var_15 = (0, var_1, 0);
  }

  var_16 = isDefined(var_15) && isDefined(var_2);
  var_17 = undefined;
  var_18 = undefined;
  for(;;) {
    var_19 = gettime();
    self notify("still_watching_nodes");
    var_1A = self botgetfovdot();
    if(isDefined(var_3) && var_19 >= var_3) {
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
      if(isDefined(self.enemy)) {
        var_1C = self lastknownpos(self.enemy);
        var_1D = self lastknowntime(self.enemy);
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
          var_11 = self.watch_nodes[var_20];
          var_24 = var_11 getnodenumber();
          if(var_16 && !scripts\engine\utility::within_fov(self.origin, var_15, var_11.origin, var_2)) {
            continue;
          }

          if(!isDefined(var_14[var_24])) {
            var_14[var_24] = 0;
          }

          if(scripts\engine\utility::within_fov(self.origin, self.angles, var_11.origin, var_1A)) {
            var_14[var_24] = var_19;
          }

          for(var_25 = 0; var_25 < var_23.size; var_25++) {
            if(var_14[var_23[var_25] getnodenumber()] > var_14[var_24]) {
              break;
            }
          }

          var_23 = scripts\engine\utility::array_insert(var_23, var_11, var_25);
        }

        var_17 = undefined;
        for(var_20 = 0; var_20 < var_23.size; var_20++) {
          if(randomfloat(1) > var_23[var_20].watch_node_chance[self.entity_number]) {
            continue;
          }

          var_11 = var_23[var_20];
          var_26 = (0, 0, 1);
          var_27 = self getEye();
          var_28 = (0, 0, self getplayerviewheight());
          var_18 = var_11.origin + var_28;
          var_29 = var_18 - var_27;
          var_29 = vectornormalize(var_29);
          var_22 = vectordot(var_29, var_26);
          if(var_22 > 0.939693) {
            continue;
          }

          var_17 = var_11;
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
    var_0 = scripts\engine\utility::waittill_any_timeout(0.5, "still_watching_nodes");
    if(!isDefined(var_0) || var_0 != "still_watching_nodes") {
      watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_1, self botgetfovdot())) {
      var_2 = self botpredictseepoint(var_1);
      if(isDefined(var_2)) {
        self botlookatpoint(var_2 + (0, 0, 40), 1, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, var_1);
  }
}

bot_get_known_attacker(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.classname)) {
    if(var_1.classname == "grenade") {
      if(!bot_ent_is_anonymous_mine(var_1)) {
        return var_0;
      }
    } else if(var_1.classname == "rocket") {
      if(isDefined(var_1.vehicle_fired_from)) {
        return var_1.vehicle_fired_from;
      }

      if(isDefined(var_1.type) && var_1.type == "remote" || var_1.type == "odin") {
        return var_1;
      }

      if(isDefined(var_1.owner)) {
        return var_1.owner;
      }
    } else if(var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt") {
      return undefined;
    }

    return var_1;
  }

  return var_0;
}

bot_ent_is_anonymous_mine(var_0) {
  if(!isDefined(var_0.weapon_name)) {
    return 0;
  }

  if(var_0.weapon_name == "c4_mp") {
    return 1;
  }

  if(var_0.weapon_name == "proximity_explosive_mp") {
    return 1;
  }

  return 0;
}

bot_vectors_are_equal(var_0, var_1) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

bot_add_to_bot_level_targets(var_0) {
  var_0.high_priority_for = [];
  if(var_0.bot_interaction_type == "use") {
    bot_add_to_bot_use_targets(var_0);
    return;
  }

  if(var_0.bot_interaction_type == "damage") {
    bot_add_to_bot_damage_targets(var_0);
    return;
  }
}

bot_remove_from_bot_level_targets(var_0) {
  var_0.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_use_targets(var_0) {
  if(!issubstr(var_0.var_9F, "trigger_use")) {
    return;
  }

  if(!isDefined(var_0.target)) {
    return;
  }

  if(isDefined(var_0.bot_target)) {
    return;
  }

  if(!isDefined(var_0.use_time)) {
    return;
  }

  var_1 = getnodearray(var_0.target, "targetname");
  if(var_1.size != 1) {
    return;
  }

  var_0.bot_target = var_1[0];
  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_damage_targets(var_0) {
  if(!issubstr(var_0.var_9F, "trigger_damage")) {
    return;
  }

  var_1 = getnodearray(var_0.target, "targetname");
  if(var_1.size != 2) {
    return;
  }

  var_0.bot_targets = var_1;
  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_0);
}

bot_get_string_index_for_integer(var_0, var_1) {
  var_2 = 0;
  foreach(var_5, var_4 in var_0) {
    if(var_2 == var_1) {
      return var_5;
    }

    var_2++;
  }

  return undefined;
}

bot_get_zones_within_dist(var_0, var_1) {
  for(var_2 = 0; var_2 < level.zonecount; var_2++) {
    var_3 = getzonenodeforindex(var_2);
    var_3.visited = 0;
  }

  var_4 = getzonenodeforindex(var_0);
  return bot_get_zones_within_dist_recurs(var_4, var_1);
}

bot_get_zones_within_dist_recurs(var_0, var_1) {
  var_2 = [];
  var_2[0] = getnodezone(var_0);
  var_0.visited = 1;
  var_3 = getlinkednodes(var_0);
  foreach(var_5 in var_3) {
    if(!var_5.visited) {
      var_6 = distance(var_0.origin, var_5.origin);
      if(var_6 < var_1) {
        var_7 = bot_get_zones_within_dist_recurs(var_5, var_1 - var_6);
        var_2 = scripts\engine\utility::array_combine(var_7, var_2);
      }
    }
  }

  return var_2;
}

bot_crate_is_command_goal(var_0) {
  return isDefined(var_0) && isDefined(var_0.command_goal) && var_0.command_goal;
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_0 = getdvarint("party_maxplayers", 0);
  var_0 = max(var_0, getdvarint("party_maxPrivatePartyPlayers", 0));
  if(var_0 > level.maxclients) {
    return level.maxclients;
  }

  return var_0;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait(0.05);
  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var_0 = level.bot_queued_process_queue[0];
      if(isDefined(var_0) && isDefined(var_0.owner)) {
        var_1 = undefined;
        if(isDefined(var_0.parm4)) {
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3, var_0.parm4);
        } else if(isDefined(var_0.parm3)) {
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3);
        } else if(isDefined(var_0.parm2)) {
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2);
        } else if(isDefined(var_0.parm1)) {
          var_1 = var_0.owner[[var_0.func]](var_0.parm1);
        } else {
          var_1 = var_0.owner[[var_0.func]]();
        }

        var_0.owner notify(var_0.name_complete, var_1);
      }

      var_2 = [];
      for(var_3 = 1; var_3 < level.bot_queued_process_queue.size; var_3++) {
        var_2[var_3 - 1] = level.bot_queued_process_queue[var_3];
      }

      level.bot_queued_process_queue = var_2;
    }

    wait(0.05);
  }
}

bot_queued_process(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(var_8, var_7 in level.bot_queued_process_queue) {
    if(var_7.owner == self && var_7.name == var_0) {
      self notify(var_7.name);
      level.bot_queued_process_queue[var_8] = undefined;
    }
  }

  var_7 = spawnStruct();
  var_7.owner = self;
  var_7.name = var_0;
  var_7.name_complete = var_7.name + "_done";
  var_7.func = var_1;
  var_7.parm1 = var_2;
  var_7.parm2 = var_3;
  var_7.parm3 = var_4;
  var_7.parm4 = var_5;
  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = var_7;
  if(!isDefined(level.bot_queued_process_level_thread_active)) {
    level.bot_queued_process_level_thread_active = 1;
    level thread bot_queued_process_level_thread();
  }

  self waittill(var_7.name_complete, var_9);
  return var_9;
}

bot_is_remote_or_linked() {
  return scripts\mp\utility::isusingremote() || self islinked();
}

bot_get_low_on_ammo(var_0) {
  var_1 = undefined;
  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_4 = weaponclipsize(var_3);
    var_5 = self getweaponammostock(var_3);
    if(var_5 <= var_4) {
      return 1;
    }

    if(self getfractionmaxammo(var_3) <= var_0) {
      return 1;
    }
  }

  return 0;
}

bot_point_is_on_pathgrid(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 256;
  }

  if(!isDefined(var_2)) {
    var_2 = 50;
  }

  var_3 = getnodesinradiussorted(var_0, var_1, 0, var_2, "Path");
  foreach(var_5 in var_3) {
    var_6 = var_0 + (0, 0, 30);
    var_7 = var_5.origin + (0, 0, 30);
    var_8 = physicstrace(var_6, var_7);
    if(bot_vectors_are_equal(var_8, var_7)) {
      return 1;
    }

    wait(0.05);
  }

  return 0;
}

bot_monitor_enemy_camp_spots(var_0) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];
  for(;;) {
    wait(1);
    var_1 = [];
    if(!isDefined(var_0)) {
      continue;
    }

    foreach(var_3 in level.participants) {
      if(!isDefined(var_3.team)) {
        continue;
      }

      if(var_3[[var_0]]() && !isDefined(var_1[var_3.team])) {
        level.enemy_camp_assassin[var_3.team] = undefined;
        level.enemy_camp_spots[var_3.team] = var_3 getclosestenemysqdist(1);
        if(isDefined(level.enemy_camp_spots[var_3.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[var_3.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var_3.team], level.enemy_camp_assassin_goal[var_3.team])) {
            level.enemy_camp_assassin_goal[var_3.team] = ::scripts\engine\utility::random(level.enemy_camp_spots[var_3.team]);
          }

          if(isDefined(level.enemy_camp_assassin_goal[var_3.team])) {
            var_4 = [];
            foreach(var_6 in level.participants) {
              if(!isDefined(var_6.team)) {
                continue;
              }

              if(var_6[[var_0]]() && var_6.team == var_3.team) {
                var_4[var_4.size] = var_6;
              }
            }

            var_4 = sortbydistance(var_4, level.enemy_camp_assassin_goal[var_3.team]);
            if(var_4.size > 0) {
              level.enemy_camp_assassin[var_3.team] = var_4[0];
            }
          }
        }

        var_1[var_3.team] = 1;
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

bot_force_stance_for_time(var_0, var_1) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance(var_0);
  wait(var_1);
  self botsetstance("none");
}