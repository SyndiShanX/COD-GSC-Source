/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3453.gsc
***************************************/

bot_get_nodes_in_cone(var_00, var_01, var_02) {
  var_03 = self _meth_8533();
  var_04 = getnodesinradius(self.origin, var_00, 0, 512, "path", var_03);
  var_05 = [];
  var_06 = self getnearestnode();
  var_07 = anglesToForward(self getplayerangles());
  var_08 = vectornormalize(var_07 * (1, 1, 0));

  foreach(var_10 in var_04) {
    var_11 = vectornormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_08);

    if(var_12 > var_01) {
      if(!var_02 || isDefined(var_06) && nodesvisible(var_10, var_06, 1))
        var_05 = scripts\engine\utility::array_add(var_05, var_10);
    }
  }

  return var_05;
}

bot_goal_can_override(var_00, var_01) {
  if(var_00 == "none")
    return var_01 == "none";
  else if(var_00 == "hunt")
    return var_01 == "hunt" || var_01 == "none";
  else if(var_00 == "guard")
    return var_01 == "guard" || var_01 == "hunt" || var_01 == "none";
  else if(var_00 == "objective")
    return var_01 == "objective" || var_01 == "guard" || var_01 == "hunt" || var_01 == "none";
  else if(var_00 == "critical")
    return var_01 == "critical" || var_01 == "objective" || var_01 == "guard" || var_01 == "hunt" || var_01 == "none";
  else if(var_00 == "tactical")
    return 1;
}

bot_set_personality(var_00) {
  self botsetpersonality(var_00);
  scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(var_00) {
  if(var_00 == "default")
    var_00 = func_2D30();

  self botsetdifficulty(var_00);

  if(isplayer(self)) {
    self.pers["rankxp"] = scripts\mp\utility\game::get_rank_xp_for_bot();
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

  var_00 = self.func_2D32;

  if(!isDefined(var_00)) {
    var_01 = [];
    var_02 = self.team;

    if(!isDefined(var_02))
      var_02 = self.bot_team;

    if(!isDefined(var_02))
      var_02 = self.pers["team"];

    if(!isDefined(var_02))
      var_02 = "allies";

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
      var_06 = var_4.team;

      if(!isDefined(var_06))
        var_06 = var_4.bot_team;

      if(!isDefined(var_06))
        var_06 = var_4.pers["team"];

      if(!isDefined(var_06)) {
        continue;
      }
      if(!isDefined(var_1[var_06]))
        var_1[var_06] = [];

      if(!isDefined(var_1[var_06][var_05])) {
        var_1[var_06][var_05] = 1;
        continue;
      }

      var_1[var_06][var_05]++;
    }

    var_08 = -1;

    foreach(var_10 in level.bot_difficulty_defaults) {
      if(!isDefined(var_1[var_02]) || !isDefined(var_1[var_02][var_10])) {
        var_00 = var_10;
        break;
      } else if(var_08 == -1 || var_1[var_02][var_10] < var_08) {
        var_08 = var_1[var_02][var_10];
        var_00 = var_10;
      }
    }
  }

  if(isDefined(var_00))
    self.func_2D32 = var_00;

  return var_00;
}

bot_is_capturing() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone")
      return 1;
  }

  return 0;
}

bot_is_patrolling() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "patrol")
      return 1;
  }

  return 0;
}

bot_is_protecting() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "protect")
      return 1;
  }

  return 0;
}

bot_is_bodyguarding() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "bodyguard")
      return 1;
  }

  return 0;
}

bot_is_defending() {
  return isDefined(self.bot_defending);
}

bot_is_defending_point(var_00) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, var_00))
      return 1;
  }

  return 0;
}

bot_is_guarding_player(var_00) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == var_00)
    return 1;

  return 0;
}

bot_cache_entrances_to_bombzones() {
  var_00 = [];
  var_01 = [];
  var_02 = 0;

  foreach(var_04 in level.bombzones) {
    var_0[var_02] = scripts\engine\utility::random(var_4.bottargets).origin;
    var_1[var_02] = "zone" + var_4.label;
    var_2++;
  }

  func_2D18(var_00, var_01);
}

bot_cache_entrances_to_flags_or_radios(var_00, var_01) {
  wait 1.0;
  var_02 = [];
  var_03 = [];

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    if(isDefined(var_0[var_04].bottarget))
      var_2[var_04] = var_0[var_04].bottarget.origin;
    else {
      var_0[var_04].nearest_node = getclosestnodeinsight(var_0[var_04].origin);
      var_2[var_04] = var_0[var_04].nearest_node.origin;
    }

    var_3[var_04] = var_01 + var_0[var_04].script_label;
  }

  func_2D18(var_02, var_03);
}

entrance_visible_from(var_00, var_01, var_02) {
  var_03 = (0, 0, 11);
  var_04 = (0, 0, 40);
  var_05 = undefined;

  if(var_02 == "stand")
    return 1;
  else if(var_02 == "crouch")
    var_05 = var_04;
  else if(var_02 == "prone")
    var_05 = var_03;

  return sighttracepassed(var_01 + var_05, var_00 + var_05, 0, undefined);
}

func_2D18(var_00, var_01) {
  wait 0.1;
  var_02 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_04 = var_1[var_03];
    var_2[var_04] = findentrances(var_0[var_03]);
    wait 0.05;

    for(var_05 = 0; var_05 < var_2[var_04].size; var_5++) {
      var_06 = var_2[var_04][var_05];
      var_6.is_precalculated_entrance = 1;
      var_6.prone_visible_from[var_04] = entrance_visible_from(var_6.origin, var_0[var_03], "prone");
      wait 0.05;
      var_6.crouch_visible_from[var_04] = entrance_visible_from(var_6.origin, var_0[var_03], "crouch");
      wait 0.05;

      for(var_07 = 0; var_07 < var_1.size; var_7++) {
        for(var_08 = var_07 + 1; var_08 < var_1.size; var_8++) {
          var_6.on_path_from[var_1[var_07]][var_1[var_08]] = 0;
          var_6.on_path_from[var_1[var_08]][var_1[var_07]] = 0;
        }
      }
    }
  }

  var_09 = [];

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    for(var_05 = var_03 + 1; var_05 < var_0.size; var_5++) {
      var_10 = get_extended_path(var_0[var_03], var_0[var_05]);
      var_9[var_1[var_03]][var_1[var_05]] = var_10;
      var_9[var_1[var_05]][var_1[var_03]] = var_10;

      foreach(var_12 in var_10) {
        var_12.on_path_from[var_1[var_03]][var_1[var_05]] = 1;
        var_12.on_path_from[var_1[var_05]][var_1[var_03]] = 1;
      }
    }
  }

  if(!isDefined(level.precalculated_paths))
    level.precalculated_paths = [];

  if(!isDefined(level.entrance_origin_points))
    level.entrance_origin_points = [];

  if(!isDefined(level.entrance_indices))
    level.entrance_indices = [];

  if(!isDefined(level.entrance_points))
    level.entrance_points = [];

  level.precalculated_paths = scripts\engine\utility::array_combine_non_integer_indices(level.precalculated_paths, var_09);
  level.entrance_origin_points = scripts\engine\utility::array_combine(level.entrance_origin_points, var_00);
  level.entrance_indices = scripts\engine\utility::array_combine(level.entrance_indices, var_01);
  level.entrance_points = scripts\engine\utility::array_combine_non_integer_indices(level.entrance_points, var_02);
  level.entrance_points_finished_caching = 1;
}

get_extended_path(var_00, var_01) {
  var_02 = func_get_nodes_on_path(var_00, var_01);

  if(isDefined(var_02)) {
    var_02 = remove_ends_from_path(var_02);
    var_02 = get_all_connected_nodes(var_02);
  }

  return var_02;
}

func_get_path_dist(var_00, var_01) {
  return getpathdist(var_00, var_01);
}

func_get_nodes_on_path(var_00, var_01) {
  return getnodesonpath(var_00, var_01);
}

func_bot_get_closest_navigable_point(var_00, var_01, var_02) {
  return botgetclosestnavigablepoint(var_00, var_01, var_02);
}

node_is_on_path_from_labels(var_00, var_01) {
  if(!isDefined(self.on_path_from) || !isDefined(self.on_path_from[var_00]) || !isDefined(self.on_path_from[var_00][var_01]))
    return 0;

  return self.on_path_from[var_00][var_01];
}

get_all_connected_nodes(var_00) {
  var_01 = var_00;

  for(var_02 = 0; var_02 < var_0.size; var_2++) {
    var_03 = getlinkednodes(var_0[var_02]);

    for(var_04 = 0; var_04 < var_3.size; var_4++) {
      if(!scripts\engine\utility::array_contains(var_01, var_3[var_04]))
        var_01 = scripts\engine\utility::array_add(var_01, var_3[var_04]);
    }
  }

  return var_01;
}

get_visible_nodes_array(var_00, var_01) {
  var_02 = [];

  foreach(var_04 in var_00) {
    if(nodesvisible(var_04, var_01, 1))
      var_02 = scripts\engine\utility::array_add(var_02, var_04);
  }

  return var_02;
}

remove_ends_from_path(var_00) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return scripts\engine\utility::array_removeundefined(var_00);
}

bot_waittill_bots_enabled(var_00) {
  var_01 = 1;

  while(!func_2D17(var_00))
    wait 0.5;
}

func_2D17(var_00) {
  if(botautoconnectenabled())
    return 1;

  if(bots_exist(var_00))
    return 1;

  return 0;
}

bot_waittill_out_of_combat_or_time(var_00) {
  var_01 = gettime();

  for(;;) {
    if(isDefined(var_00)) {
      if(gettime() > var_01 + var_00)
        return;
    }

    if(!isDefined(self.enemy))
      return;
    else if(!bot_in_combat()) {
      return;
    }
    wait 0.05;
  }
}

bot_in_combat(var_00) {
  var_01 = gettime() - self.last_enemy_sight_time;
  var_02 = level.bot_out_of_combat_time;

  if(isDefined(var_00))
    var_02 = var_00;

  return var_01 < var_02;
}

bot_waittill_goal_or_fail(var_00, var_01, var_02) {
  if(!isDefined(var_01) && isDefined(var_02)) {}

  var_03 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var_01))
    var_3[var_3.size] = var_01;

  if(isDefined(var_02))
    var_3[var_3.size] = var_02;

  if(isDefined(var_00))
    var_04 = scripts\engine\utility::waittill_any_in_array_or_timeout(var_03, var_00);
  else
    var_04 = scripts\engine\utility::waittill_any_in_array_return(var_03);

  return var_04;
}

bot_usebutton_wait(var_00, var_01, var_02) {
  level endon("game_ended");
  childthread use_button_stopped_notify();
  var_03 = scripts\engine\utility::waittill_any_timeout(var_00, var_01, var_02, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_03;
}

use_button_stopped_notify(var_00, var_01) {
  self endon("stop_usebutton_watcher");
  wait 0.05;

  while(self usebuttonpressed())
    wait 0.05;

  self notify("use_button_no_longer_pressed");
}

bots_exist(var_00) {
  foreach(var_02 in level.participants) {
    if(isai(var_02)) {
      if(isDefined(var_00) && var_00) {
        if(!scripts\mp\utility\game::isteamparticipant(var_02))
          continue;
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(var_00, var_01) {
  if(!isDefined(level.entrance_points_finished_caching) && !isDefined(self.defense_override_watch_nodes))
    return undefined;

  var_02 = [];

  if(isDefined(self.defense_override_watch_nodes))
    var_02 = self.defense_override_watch_nodes;
  else
    var_02 = level.entrance_points[var_01];

  if(!isDefined(var_00) || var_00 == "stand")
    return var_02;
  else if(var_00 == "crouch") {
    var_03 = [];

    foreach(var_05 in var_02) {
      if(var_5.crouch_visible_from[var_01])
        var_03 = scripts\engine\utility::array_add(var_03, var_05);
    }

    return var_03;
  } else if(var_00 == "prone") {
    var_03 = [];

    foreach(var_05 in var_02) {
      if(var_5.prone_visible_from[var_01])
        var_03 = scripts\engine\utility::array_add(var_03, var_05);
    }

    return var_03;
  }

  return undefined;
}

bot_find_node_to_guard_player(var_00, var_01, var_02) {
  var_03 = undefined;
  var_04 = self _meth_8533();
  var_05 = self.bot_defend_player_guarding getvelocity();

  if(lengthsquared(var_05) > 100) {
    var_06 = getnodesinradius(var_00, var_01 * 1.75, var_01 * 0.5, 500, "path", var_04);
    var_07 = [];
    var_08 = vectornormalize(var_05);

    for(var_09 = 0; var_09 < var_6.size; var_9++) {
      var_10 = vectornormalize(var_6[var_09].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_10, var_08) > 0.1)
        var_7[var_7.size] = var_6[var_09];
    }
  } else
    var_07 = getnodesinradius(var_00, var_01, 0, 500, "path", var_04);

  if(isDefined(var_02) && var_02) {
    var_11 = vectornormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_12 = var_07;
    var_07 = [];

    foreach(var_14 in var_12) {
      var_10 = vectornormalize(var_14.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_11, var_10) > 0.2)
        var_7[var_7.size] = var_14;
    }
  }

  var_16 = [];
  var_17 = [];
  var_18 = [];

  for(var_09 = 0; var_09 < var_7.size; var_9++) {
    var_19 = distancesquared(var_7[var_09].origin, var_00) > 10000;
    var_20 = abs(var_7[var_09].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(var_19)
      var_16[var_16.size] = var_7[var_09];

    if(var_20)
      var_17[var_17.size] = var_7[var_09];

    if(var_19 && var_20)
      var_18[var_18.size] = var_7[var_09];

    if(var_09 % 100 == 99)
      wait 0.05;
  }

  if(var_18.size > 0)
    var_03 = self botnodepick(var_18, var_18.size * 0.15, "node_capture", var_00, undefined, self.defense_score_flags);

  if(!isDefined(var_03)) {
    wait 0.05;

    if(var_17.size > 0)
      var_03 = self botnodepick(var_17, var_17.size * 0.15, "node_capture", var_00, undefined, self.defense_score_flags);

    if(!isDefined(var_03) && var_16.size > 0) {
      wait 0.05;
      var_03 = self botnodepick(var_16, var_16.size * 0.15, "node_capture", var_00, undefined, self.defense_score_flags);
    }
  }

  return var_03;
}

bot_find_node_to_capture_point(var_00, var_01, var_02) {
  var_03 = undefined;
  var_04 = self _meth_8533();
  var_05 = getnodesinradius(var_00, var_01, 0, 500, "path", var_04);

  if(var_5.size > 0)
    var_03 = self botnodepick(var_05, var_5.size * 0.15, "node_capture", var_00, var_02, self.defense_score_flags);

  return var_03;
}

bot_find_node_to_capture_zone(var_00, var_01) {
  var_02 = undefined;

  if(var_0.size > 0)
    var_02 = self botnodepick(var_00, var_0.size * 0.15, "node_capture", undefined, var_01, self.defense_score_flags);

  return var_02;
}

bot_find_node_that_protects_point(var_00, var_01) {
  var_02 = undefined;
  var_03 = self _meth_8533();
  var_04 = getnodesinradius(var_00, var_01, 0, 500, "path", var_03);

  if(var_4.size > 0)
    var_02 = self botnodepick(var_04, var_4.size * 0.15, "node_protect", var_00, self.defense_score_flags);

  return var_02;
}

bot_pick_random_point_in_radius(var_00, var_01, var_02, var_03, var_04) {
  var_05 = undefined;
  var_06 = self _meth_8533();
  var_07 = getnodesinradius(var_00, var_01, 0, 500, "path", var_06);

  if(isDefined(var_07) && var_7.size >= 2)
    var_05 = bot_find_random_midpoint(var_07, var_02);

  if(!isDefined(var_05)) {
    if(!isDefined(var_03))
      var_03 = 0;

    if(!isDefined(var_04))
      var_04 = 1;

    var_08 = randomfloatrange(self.bot_defending_radius * var_03, self.bot_defending_radius * var_04);
    var_09 = anglesToForward((0, randomint(360), 0));
    var_05 = var_00 + var_09 * var_08;
  }

  return var_05;
}

bot_pick_random_point_from_set(var_00, var_01, var_02) {
  var_03 = undefined;

  if(var_1.size >= 2)
    var_03 = bot_find_random_midpoint(var_01, var_02);

  if(!isDefined(var_03)) {
    var_04 = scripts\engine\utility::random(var_01);
    var_05 = var_4.origin - var_00;
    var_03 = var_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1.0);
  }

  return var_03;
}

bot_find_random_midpoint(var_00, var_01) {
  var_02 = undefined;
  var_03 = scripts\engine\utility::array_randomize(var_00);

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    for(var_05 = var_04 + 1; var_05 < var_3.size; var_5++) {
      var_06 = var_3[var_04];
      var_07 = var_3[var_05];

      if(nodesvisible(var_06, var_07, 1)) {
        var_02 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

        if(isDefined(var_01) && self[[var_01]](var_02) == 1)
          return var_02;
      }
    }
  }

  return var_02;
}

defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node))
    return self.bot_defending_override_origin_node.origin;
  else if(isDefined(self.bot_defending_center))
    return self.bot_defending_center;

  return undefined;
}

bot_allowed_to_use_killstreaks() {
  if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
    if(isDefined(self.sidelinedbycommander) && self.sidelinedbycommander == 1)
      return 0;
  }

  if(scripts\mp\utility\game::iskillstreakdenied())
    return 0;

  if(bot_is_remote_or_linked())
    return 0;

  if(self isusingturret())
    return 0;

  if(isDefined(level.nukeincoming))
    return 0;

  if(isDefined(self.underwater) && self.underwater)
    return 0;

  if(isDefined(self.controlsfrozen) && self.controlsfrozen)
    return 0;

  if(self isoffhandweaponreadytothrow())
    return 0;

  if(!bot_in_combat(500))
    return 1;

  if(!isalive(self.enemy))
    return 1;

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

    if(self botgetscriptgoaltype() != "none")
      var_04 = self botgetscriptgoal();

    var_05 = botgetmemoryevents(0, gettime() - 45000, 1, "kill", var_02, self);
    var_06 = botgetmemoryevents(0, gettime() - 45000, 1, "death", var_01, self);
    var_07 = [];

    foreach(var_09 in var_05)
    var_7[var_7.size] = var_09;

    foreach(var_09 in var_06)
    var_7[var_7.size] = var_09;

    var_03 = scripts\engine\utility::random(var_07);

    if(isDefined(var_03) > 0 && (!isDefined(var_04) || distancesquared(var_04, var_03) > 1000000)) {
      var_00 = var_03;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(var_00)) {
    var_13 = getzonenearest(var_00);
    var_14 = getzonenearest(self.origin);

    if(isDefined(var_13) && isDefined(var_14) && var_14 != var_13) {
      var_15 = botzonegetcount(var_13, self.team, "ally") + botzonegetcount(var_13, self.team, "path_ally");

      if(var_15 > 1)
        var_00 = undefined;
    }
  }

  if(isDefined(var_00))
    self.bot_memory_goal = var_00;

  return var_00;
}

func_2D66(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {}

func_2D67(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {}

func_2D65(var_00, var_01, var_02, var_03, var_04) {}

bot_get_total_gun_ammo() {
  var_00 = 0;
  var_01 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_01 = self.weaponlist;
  else
    var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    var_00 = var_00 + self getweaponammoclip(var_03);
    var_00 = var_00 + self getweaponammostock(var_03);
  }

  return var_00;
}

bot_out_of_ammo() {
  var_00 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_00 = self.weaponlist;
  else
    var_00 = self getweaponslistprimaries();

  foreach(var_02 in var_00) {
    if(self getweaponammoclip(var_02) > 0)
      return 0;

    if(self getweaponammostock(var_02) > 0)
      return 0;
  }

  return 1;
}

bot_get_grenade_ammo() {
  var_00 = 0;
  var_01 = self getweaponslistall();

  foreach(var_03 in var_01)
  var_00 = var_00 + self getweaponammostock(var_03);

  return var_00;
}

bot_grenade_matches_purpose(var_00, var_01) {
  if(!isDefined(var_01))
    return 0;

  switch (var_00) {
    case "trap_directional":
      switch (var_01) {
        case "claymore_mp":
          return 1;
      }

      break;
    case "trap":
      switch (var_01) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "trophy_mp":
          return 1;
      }

      break;
    case "c4":
      switch (var_01) {
        case "c4_mp":
          return 1;
      }

      break;
    case "tacticalinsertion":
      switch (var_01) {
        case "flare_mp":
          return 1;
      }

      break;
  }

  return 0;
}

bot_get_grenade_for_purpose(var_00) {
  if(self botgetdifficultysetting("allowGrenades") != 0) {
    var_01 = self botfirstavailablegrenade("lethal");

    if(bot_grenade_matches_purpose(var_00, var_01))
      return "lethal";

    var_01 = self botfirstavailablegrenade("tactical");

    if(bot_grenade_matches_purpose(var_00, var_01))
      return "tactical";
  }
}

bot_watch_nodes(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");
  wait 1.0;
  var_08 = 1;

  while(var_08) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < 16)
        var_08 = 0;
    }

    if(var_08)
      wait 0.05;
  }

  var_09 = self.origin;

  if(isDefined(var_00)) {
    self.watch_nodes = [];

    foreach(var_11 in var_00) {
      var_12 = 0;

      if(distance2dsquared(self.origin, var_11.origin) <= 10)
        var_12 = 1;

      var_13 = self getEye();
      var_14 = vectordot((0, 0, 1), vectornormalize(var_11.origin - var_13));

      if(abs(var_14) > 0.92)
        var_12 = 1;

      if(!var_12)
        self.watch_nodes[self.watch_nodes.size] = var_11;
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }
  if(isDefined(var_04))
    self endon(var_04);

  if(isDefined(var_05))
    self endon(var_05);

  if(isDefined(var_06))
    self endon(var_06);

  if(isDefined(var_07))
    self endon(var_07);

  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);

  foreach(var_11 in self.watch_nodes)
  var_11.watch_node_chance[self.entity_number] = 1.0;

  var_18 = gettime();
  var_19 = var_18;
  var_20 = [];
  var_21 = undefined;

  if(isDefined(var_01))
    var_21 = (0, var_01, 0);

  var_22 = isDefined(var_21) && isDefined(var_02);
  var_23 = undefined;
  var_24 = undefined;

  for(;;) {
    var_25 = gettime();
    self notify("still_watching_nodes");
    var_26 = self botgetfovdot();

    if(isDefined(var_03) && var_25 >= var_03) {
      return;
    }
    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      self botlookatpoint(undefined);
      wait 0.2;
      continue;
    }

    if(!self bothasscriptgoal() || !self botpursuingscriptgoal()) {
      wait 0.2;
      continue;
    }

    if(isDefined(var_23) && var_23.watch_node_chance[self.entity_number] == 0.0)
      var_19 = var_25;

    if(self.watch_nodes.size > 0) {
      var_27 = 0;

      if(isDefined(self.enemy)) {
        var_28 = self gettruenodeangles(self.enemy);
        var_29 = self lastknowntime(self.enemy);

        if(var_29 && var_25 - var_29 < 5000) {
          var_30 = vectornormalize(var_28 - self.origin);
          var_31 = 0;

          for(var_32 = 0; var_32 < self.watch_nodes.size; var_32++) {
            var_33 = vectornormalize(self.watch_nodes[var_32].origin - self.origin);
            var_34 = vectordot(var_30, var_33);

            if(var_34 > var_31) {
              var_31 = var_34;
              var_23 = self.watch_nodes[var_32];
              var_27 = 1;
            }
          }
        }
      }

      if(!var_27 && var_25 >= var_19) {
        var_35 = [];

        for(var_32 = 0; var_32 < self.watch_nodes.size; var_32++) {
          var_11 = self.watch_nodes[var_32];
          var_36 = var_11 getnodenumber();

          if(var_22 && !scripts\engine\utility::within_fov(self.origin, var_21, var_11.origin, var_02)) {
            continue;
          }
          if(!isDefined(var_20[var_36]))
            var_20[var_36] = 0;

          if(scripts\engine\utility::within_fov(self.origin, self.angles, var_11.origin, var_26))
            var_20[var_36] = var_25;

          for(var_37 = 0; var_37 < var_35.size; var_37++) {
            if(var_20[var_35[var_37] getnodenumber()] > var_20[var_36]) {
              break;
            }
          }

          var_35 = scripts\engine\utility::array_insert(var_35, var_11, var_37);
        }

        var_23 = undefined;

        for(var_32 = 0; var_32 < var_35.size; var_32++) {
          if(randomfloat(1) > var_35[var_32].watch_node_chance[self.entity_number]) {
            continue;
          }
          var_11 = var_35[var_32];
          var_38 = (0, 0, 1);
          var_39 = self getEye();
          var_40 = (0, 0, self _meth_8157());
          var_24 = var_11.origin + var_40;
          var_41 = var_24 - var_39;
          var_41 = vectornormalize(var_41);
          var_34 = vectordot(var_41, var_38);

          if(var_34 > 0.939693) {
            continue;
          }
          var_23 = var_11;
          var_19 = var_25 + randomintrange(3000, 5000);
          break;
        }
      }

      if(isDefined(var_23)) {
        var_40 = (0, 0, self _meth_8157());
        var_24 = var_23.origin + var_40;
        self botlookatpoint(var_24, 0.4, "script_search");
      }
    }

    wait 0.2;
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
    var_00 = scripts\engine\utility::waittill_any_timeout(0.5, "still_watching_nodes");

    if(!isDefined(var_00) || var_00 != "still_watching_nodes") {
      watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(var_00, var_01) {
  if(isDefined(var_01) && var_01 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self.angles, var_01, self botgetfovdot())) {
      var_02 = self botpredictseepoint(var_01);

      if(isDefined(var_02))
        self botlookatpoint(var_02 + (0, 0, 40), 1.0, "script_seek");
    }

    self botmemoryevent("known_enemy", undefined, var_01);
  }
}

bot_get_known_attacker(var_00, var_01) {
  if(isDefined(var_01) && isDefined(var_1.classname)) {
    if(var_1.classname == "grenade") {
      if(!bot_ent_is_anonymous_mine(var_01))
        return var_00;
    } else if(var_1.classname == "rocket") {
      if(isDefined(var_1.vehicle_fired_from))
        return var_1.vehicle_fired_from;

      if(isDefined(var_1.type) && (var_1.type == "remote" || var_1.type == "odin"))
        return var_01;

      if(isDefined(var_1.owner))
        return var_1.owner;
    } else if(var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt")
      return undefined;

    return var_01;
  }

  return var_00;
}

bot_ent_is_anonymous_mine(var_00) {
  if(!isDefined(var_0.weapon_name))
    return 0;

  if(var_0.weapon_name == "c4_mp")
    return 1;

  if(var_0.weapon_name == "proximity_explosive_mp")
    return 1;

  return 0;
}

bot_vectors_are_equal(var_00, var_01) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

bot_add_to_bot_level_targets(var_00) {
  var_0.high_priority_for = [];

  if(var_0.bot_interaction_type == "use")
    bot_add_to_bot_use_targets(var_00);
  else if(var_0.bot_interaction_type == "damage")
    bot_add_to_bot_damage_targets(var_00);
  else {}
}

bot_remove_from_bot_level_targets(var_00) {
  var_0.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, var_00);
}

bot_add_to_bot_use_targets(var_00) {
  if(!issubstr(var_0.code_classname, "trigger_use")) {
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
  var_01 = getnodearray(var_0.target, "targetname");

  if(var_1.size != 1) {
    return;
  }
  var_0.bot_target = var_1[0];

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_00);
}

bot_add_to_bot_damage_targets(var_00) {
  if(!issubstr(var_0.code_classname, "trigger_damage")) {
    return;
  }
  var_01 = getnodearray(var_0.target, "targetname");

  if(var_1.size != 2) {
    return;
  }
  var_0.bot_targets = var_01;

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_00);
}

bot_get_string_index_for_integer(var_00, var_01) {
  var_02 = 0;

  foreach(var_05, var_04 in var_00) {
    if(var_02 == var_01)
      return var_05;

    var_2++;
  }

  return undefined;
}

bot_get_zones_within_dist(var_00, var_01) {
  for(var_02 = 0; var_02 < level.zonecount; var_2++) {
    var_03 = getzonenodeforindex(var_02);
    var_3.visited = 0;
  }

  var_04 = getzonenodeforindex(var_00);
  return bot_get_zones_within_dist_recurs(var_04, var_01);
}

bot_get_zones_within_dist_recurs(var_00, var_01) {
  var_02 = [];
  var_2[0] = getnodezone(var_00);
  var_0.visited = 1;
  var_03 = getlinkednodes(var_00);

  foreach(var_05 in var_03) {
    if(!var_5.visited) {
      var_06 = distance(var_0.origin, var_5.origin);

      if(var_06 < var_01) {
        var_07 = bot_get_zones_within_dist_recurs(var_05, var_01 - var_06);
        var_02 = scripts\engine\utility::array_combine(var_07, var_02);
      }
    }
  }

  return var_02;
}

bot_crate_is_command_goal(var_00) {
  return isDefined(var_00) && isDefined(var_0.command_goal) && var_0.command_goal;
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_00 = getdvarint("party_maxplayers", 0);
  var_00 = max(var_00, getdvarint("party_maxPrivatePartyPlayers", 0));

  if(var_00 > level.maxclients)
    return level.maxclients;

  return var_00;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;

  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var_00 = level.bot_queued_process_queue[0];

      if(isDefined(var_00) && isDefined(var_0.owner)) {
        var_01 = undefined;

        if(isDefined(var_0.parm4))
          var_01 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3, var_0.parm4);
        else if(isDefined(var_0.parm3))
          var_01 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3);
        else if(isDefined(var_0.parm2))
          var_01 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2);
        else if(isDefined(var_0.parm1))
          var_01 = var_0.owner[[var_0.func]](var_0.parm1);
        else
          var_01 = var_0.owner[[var_0.func]]();

        var_0.owner notify(var_0.name_complete, var_01);
      }

      var_02 = [];

      for(var_03 = 1; var_03 < level.bot_queued_process_queue.size; var_3++)
        var_2[var_03 - 1] = level.bot_queued_process_queue[var_03];

      level.bot_queued_process_queue = var_02;
    }

    wait 0.05;
  }
}

bot_queued_process(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(level.bot_queued_process_queue))
    level.bot_queued_process_queue = [];

  foreach(var_08, var_07 in level.bot_queued_process_queue) {
    if(var_7.owner == self && var_7.name == var_00) {
      self notify(var_7.name);
      level.bot_queued_process_queue[var_08] = undefined;
    }
  }

  var_07 = spawnStruct();
  var_7.owner = self;
  var_7.name = var_00;
  var_7.name_complete = var_7.name + "_done";
  var_7.func = var_01;
  var_7.parm1 = var_02;
  var_7.parm2 = var_03;
  var_7.parm3 = var_04;
  var_7.parm4 = var_05;
  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = var_07;

  if(!isDefined(level.bot_queued_process_level_thread_active)) {
    level.bot_queued_process_level_thread_active = 1;
    level thread bot_queued_process_level_thread();
  }

  self waittill(var_7.name_complete, var_09);
  return var_09;
}

bot_is_remote_or_linked() {
  return scripts\mp\utility\game::isusingremote() || self getteamflagcount();
}

bot_get_low_on_ammo(var_00) {
  var_01 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_01 = self.weaponlist;
  else
    var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    var_04 = weaponclipsize(var_03);
    var_05 = self getweaponammostock(var_03);

    if(var_05 <= var_04)
      return 1;

    if(self getfractionmaxammo(var_03) <= var_00)
      return 1;
  }

  return 0;
}

bot_point_is_on_pathgrid(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = 256;

  if(!isDefined(var_02))
    var_02 = 50;

  var_03 = getnodesinradiussorted(var_00, var_01, 0, var_02, "Path");

  foreach(var_05 in var_03) {
    var_06 = var_00 + (0, 0, 30);
    var_07 = var_5.origin + (0, 0, 30);
    var_08 = _physicstrace(var_06, var_07);

    if(bot_vectors_are_equal(var_08, var_07))
      return 1;

    wait 0.05;
  }

  return 0;
}

bot_monitor_enemy_camp_spots(var_00) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];

  for(;;) {
    wait 1.0;
    var_01 = [];

    if(!isDefined(var_00)) {
      continue;
    }
    foreach(var_03 in level.participants) {
      if(!isDefined(var_3.team)) {
        continue;
      }
      if(var_03[[var_00]]() && !isDefined(var_1[var_3.team])) {
        level.enemy_camp_assassin[var_3.team] = undefined;
        level.enemy_camp_spots[var_3.team] = var_03 botpredictenemycampspots(1);

        if(isDefined(level.enemy_camp_spots[var_3.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[var_3.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var_3.team], level.enemy_camp_assassin_goal[var_3.team]))
            level.enemy_camp_assassin_goal[var_3.team] = scripts\engine\utility::random(level.enemy_camp_spots[var_3.team]);

          if(isDefined(level.enemy_camp_assassin_goal[var_3.team])) {
            var_04 = [];

            foreach(var_06 in level.participants) {
              if(!isDefined(var_6.team)) {
                continue;
              }
              if(var_06[[var_00]]() && var_6.team == var_3.team)
                var_4[var_4.size] = var_06;
            }

            var_04 = sortbydistance(var_04, level.enemy_camp_assassin_goal[var_3.team]);

            if(var_4.size > 0)
              level.enemy_camp_assassin[var_3.team] = var_4[0];
          }
        }

        var_1[var_3.team] = 1;
      }
    }
  }
}

bot_valid_camp_assassin() {
  if(!isDefined(self))
    return 0;

  if(!isai(self))
    return 0;

  if(!isDefined(self.team))
    return 0;

  if(self.team == "spectator")
    return 0;

  if(!isalive(self))
    return 0;

  if(!scripts\mp\utility\game::isaiteamparticipant(self))
    return 0;

  if(self.personality == "camper")
    return 0;

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
    scripts\mp\bots\bots_strategy::bot_defend_stop();
    self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team], 128, "objective", undefined, 256);
    bot_waittill_goal_or_fail();
  }
}

bot_force_stance_for_time(var_00, var_01) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetstance(var_00);
  wait(var_01);
  self botsetstance("none");
}