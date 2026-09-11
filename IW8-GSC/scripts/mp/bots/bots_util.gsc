/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_util.gsc
***********************************************/

function bot_get_nodes_in_cone(var_0, var_1, var_2, var_3) {
  var_4 = getnodesinradius(self.origin, var_1, var_0);
  var_5 = [];
  var_6 = self getnearestnode();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectorNormalize(var_7 * (1, 1, 0));

  foreach(var_10 in var_4) {
    var_11 = vectorNormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);

    if(var_12 > var_2) {
      if(!var_3 || isDefined(var_6) && nodesvisible(var_10, var_6, 1)) {
        var_5 = var_10;
      }
    }
  }

  return var_5;
}

function bot_goal_can_override(var_0, var_1) {
  if(var_0 == "none") {
    return (var_1 == "none");
  }

  if(var_0 == "hunt") {
    return (var_1 == "hunt" || var_1 == "none");
  }

  if(var_0 == "guard") {
    return (var_1 == "guard" || var_1 == "hunt" || var_1 == "none");
  }

  if(var_0 == "objective") {
    return (var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none");
  }

  if(var_0 == "critical") {
    return (var_1 == "critical" || var_1 == "objective" || var_1 == "guard" || var_1 == "hunt" || var_1 == "none");
  }

  if(var_0 == "tactical") {
    return 1;
  }
}

function bot_set_personality(var_0) {
  self botsetpersonality(var_0);
  scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

function bot_set_difficulty(var_0, var_1) {
  if(var_0 == "default") {
    var_0 = bot_choose_difficulty_for_default();
  }

  var_3 = self botgetdifficulty();
  self botsetdifficulty(var_0);

  if(isPlayer(self) && var_3 != var_0) {
    self.pers["rankxp"] = get_rank_xp_for_bot();
    scripts\mp\rank::playerupdaterank();
    return;
  }
}

function bot_choose_difficulty_for_default() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];

    if(level.rankedmatch) {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
    } else {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "easy";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
    }
  }

  if(!isDefined(level.deadgreen)) {
    level.deadgreen = [];
  }

  if(!isDefined(level.deadgreen["allies"])) {
    level.deadgreen["allies"] = 0;
  }

  if(!isDefined(level.deadgreen["axis"])) {
    level.deadgreen["axis"] = 0;
  }

  if(!isDefined(level.deadgreen["all"])) {
    level.deadgreen["all"] = 0;
  }

  if(!isDefined(self.pers["bot_chosen_difficulty"])) {
    var_0 = undefined;

    if(level.teambased) {
      var_1 = self.team;

      if(!isDefined(var_1)) {
        var_1 = self.bot_team;
      }

      if(!isDefined(var_1)) {
        var_1 = self.pers["team"];
      }
    } else {
      var_1 = "all";
    }

    var_1 = level.deadgreen[var_1];
    var_2 = level.bot_difficulty_defaults[var_1];
    self.pers["bot_chosen_difficulty"] = propdeductflash(var_2);
    level.deadgreen[var_1] = (level.deadgreen[var_1] + 1) % level.bot_difficulty_defaults.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

function propdeductflash(var_0) {
  if(var_0 == "easy") {
    return "recruit";
  }

  if(var_0 == "normal") {
    return "regular";
  }

  if(var_0 == "hard") {
    return scripts\engine\utility::random(["hardened", "veteran"]);
  }
}

function bot_is_capturing() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone") {
      return true;
    }
  }

  return false;
}

function bot_is_patrolling() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "patrol") {
      return true;
    }
  }

  return false;
}

function bot_is_protecting() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "protect" || self.bot_defending_type == "protect_zone") {
      return true;
    }
  }

  return false;
}

function bot_is_bodyguarding() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "bodyguard") {
      return true;
    }
  }

  return false;
}

function bot_is_defending() {
  return isDefined(self.bot_defending);
}

function bot_is_defending_point(var_0) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, var_0)) {
      return true;
    }
  }

  return false;
}

function bot_is_guarding_player(var_0) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == var_0) {
    return true;
  }

  return false;
}

function entrance_visible_from(var_0, var_1, var_2) {
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

function get_extended_path(var_0, var_1) {
  var_2 = func_get_nodes_on_path(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 = remove_ends_from_path(var_2);
    var_2 = get_all_connected_nodes(var_2);
  }

  return var_2;
}

function func_get_path_dist(var_0, var_1) {
  return getpathdist(var_0, var_1);
}

function func_get_nodes_on_path(var_0, var_1) {
  return getnodesonpath(var_0, var_1);
}

function func_bot_get_closest_navigable_point(var_0, var_1, var_2) {
  return botgetclosestnavigablepoint(var_0, var_1, var_2);
}

function node_is_on_path_from_labels(var_0, var_1) {
  if(!isDefined(self.on_path_from)) {
    return false;
  }

  if(isDefined(self.on_path_from[var_0]) && isDefined(self.on_path_from[var_0][var_1]) && self.on_path_from[var_0][var_1]) {
    return true;
  }

  if(isDefined(self.on_path_from[var_1]) && isDefined(self.on_path_from[var_1][var_0]) && self.on_path_from[var_1][var_0]) {
    return true;
  }

  return false;
}

function get_all_connected_nodes(var_0) {
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

function get_visible_nodes_array(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(nodesvisible(var_4, var_1, 1)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  return var_2;
}

function remove_ends_from_path(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return scripts\engine\utility::array_removeundefined(var_0);
}

function bot_waittill_bots_enabled(var_0) {
  while(!bot_bots_enabled_or_added(var_0)) {
    wait 0.5;
  }
}

function bot_bots_enabled_or_added(var_0) {
  if(botsystemstatus() != "off") {
    return true;
  }

  if(bots_exist(var_0)) {
    return true;
  }

  return false;
}

function bot_waittill_out_of_combat_or_time(var_0) {
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

    wait 0.05;
  }
}

function bot_in_combat(var_0) {
  if(self.last_enemy_sight_time == 0) {
    return false;
  }

  var_1 = gettime() - self.last_enemy_sight_time;
  var_2 = level.bot_out_of_combat_time;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  return var_1 < var_2;
}

function bot_waittill_goal_or_fail(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  if((!isDefined(var_1) || !isDefined(var_2)) && isDefined(var_3)) {}

  var_4 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_4.size, var_1);
  }

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_4.size, var_2);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_4.size, var_3);
  }

  if(isDefined(var_0)) {
    var_5 = scripts\engine\utility::waittill_any_in_array_or_timeout(var_4, var_0);
  } else {
    var_5 = scripts\engine\utility::waittill_any_in_array_return(var_5);
  }

  return var_5;
}

function bot_usebutton_wait(var_0, var_1, var_2) {
  level endon("game_ended");
  GscBinSkip4(0x35);
}

function use_button_stopped_notify(var_0, var_1) {
  self endon("stop_usebutton_watcher");
  wait 0.05;

  while(self useButtonPressed()) {
    wait 0.05;
  }

  self notify("use_button_no_longer_pressed");
}

function bots_exist(var_0) {
  foreach(var_2 in level.participants) {
    if(isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!scripts\mp\utility\entity::isteamparticipant(var_2)) {
          continue;
        }
      }

      return true;
    }
  }

  return false;
}

function bot_get_entrances_for_stance_and_index(var_0, var_1, var_2) {
  if(!isDefined(level.entrance_points_finished_caching)) {
    return undefined;
  }

  if(isarray(var_1)) {
    if(isDefined(var_2) && var_2) {
      var_3 = undefined;
      var_4 = 999999999;

      foreach(var_6 in var_1) {
        var_7 = scripts\engine\utility::array_find(level.entrance_indices, var_6);
        var_8 = level.entrance_origin_points[var_7];
        var_9 = distancesquared(self.origin, var_8);

        if(var_9 < var_4) {
          var_3 = var_6;
          var_4 = var_9;
        }
      }

      var_1 = var_3;
    } else {
      var_1 = scripts\engine\utility::random(var_1);
    }
  }

  var_11 = level.entrance_points[var_1];

  if(!isDefined(var_0) || var_0 == "stand") {
    return var_11;
  } else if(var_0 == "crouch") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14.crouch_visible_from[var_1]) {
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
      }
    }

    return var_12;
  } else if(var_12 == "prone") {
    var_12 = [];

    foreach(var_14 in var_15) {
      if(var_14.prone_visible_from[var_13]) {
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
      }
    }

    return var_12;
  }

  return undefined;
}

function bot_find_node_to_guard_player(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self.bot_defend_player_guarding getvelocity();

  if(lengthsquared(var_4) > 100) {
    var_5 = getnodesinradius(var_0, var_1 * 1.75, var_1 * 0.5, 500);
    var_6 = [];
    var_7 = vectorNormalize(var_4);

    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      var_9 = vectorNormalize(var_5[var_8].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_9, var_7) > 0.1) {
        var_6 = var_5[var_8];
      }
    }
  } else {
    var_6 = getnodesinradius(var_1, var_2, 0, 500);
  }

  if(isDefined(var_3) && var_3) {
    var_10 = vectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_11 = var_6;
    var_6 = [];

    foreach(var_13 in var_11) {
      var_9 = vectorNormalize(var_13.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_10, var_9) > 0.2) {
        var_6 = var_13;
      }
    }
  }

  var_15 = [];
  var_16 = [];
  var_17 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_18 = distancesquared(var_6[var_8].origin, var_1) > 10000;
    var_19 = abs(var_6[var_8].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(var_18) {
      var_15 = var_6[var_8];
    }

    if(var_19) {
      var_16 = var_6[var_8];
    }

    if(var_18 && var_19) {
      var_17 = var_6[var_8];
    }

    if(var_8 % 100 == 99) {
      wait 0.05;
    }
  }

  if(var_17.size > 0) {
    var_4 = self botnodepick(var_17, var_17.size * 0.15, "node_capture", var_1, undefined, self.defense_score_flags);
  }

  if(!isDefined(var_4)) {
    wait 0.05;

    if(var_16.size > 0) {
      var_4 = self botnodepick(var_16, var_16.size * 0.15, "node_capture", var_1, undefined, self.defense_score_flags);
    }

    if(!isDefined(var_4) && var_15.size > 0) {
      wait 0.05;
      var_4 = self botnodepick(var_15, var_15.size * 0.15, "node_capture", var_1, undefined, self.defense_score_flags);
    }
  }

  return var_4;
}

function bot_find_node_to_capture_point(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = getnodesinradius(var_0, var_1, 0, 500);

  if(var_4.size > 0) {
    var_3 = self botnodepick(var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self.defense_score_flags);
  }

  return var_3;
}

function bot_find_node_to_capture_zone(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = self botnodepick(var_0, var_0.size * 0.15, "node_capture", undefined, var_1, self.defense_score_flags);
  }

  return var_2;
}

function bot_find_node_to_protect_zone(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = self botnodepick(var_0, var_0.size * 0.25, "node_capture", var_1, undefined, self.defense_score_flags);
  }

  return var_2;
}

function bot_find_node_that_protects_point(var_0, var_1) {
  var_2 = undefined;
  var_3 = getnodesinradius(var_0, var_1, 0, 500);

  if(var_3.size > 0) {
    var_2 = self botnodepick(var_3, var_3.size * 0.15, "node_protect", var_0, self.defense_score_flags);
  }

  return var_2;
}

function bot_pick_random_point_in_radius(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_6) && var_6.size >= 2) {
    var_5 = bot_find_random_midpoint(var_6, var_2);
  }

  if(!isDefined(var_5)) {
    if(!isDefined(var_3)) {
      var_3 = 0;
    }

    if(!isDefined(var_4)) {
      var_4 = 1;
    }

    var_7 = randomfloatrange(self.bot_defending_radius * var_3, self.bot_defending_radius * var_4);
    var_8 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_8 * var_7;
  }

  return var_5;
}

function bot_pick_random_point_from_set(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.size >= 2) {
    var_3 = bot_find_random_midpoint(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectorNormalize(var_5) * length(var_5) * randomfloat(1);
  }

  return var_3;
}

function bot_find_random_midpoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = scripts\engine\utility::array_randomize(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_4];
      var_7 = var_3[var_5];

      if(nodesvisible(var_6, var_7, 1)) {
        var_2 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

        if(isDefined(var_1) && self[[var_1]](var_2) == 1) {
          return var_2;
        }
      }
    }
  }

  return var_2;
}

function defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node)) {
    return self.bot_defending_override_origin_node.origin;
  } else if(isDefined(self.bot_defending_center)) {
    return self.bot_defending_center;
  }

  return undefined;
}

function bot_allowed_to_use_killstreaks() {
  if(!istrue(level.allowkillstreaks)) {
    return false;
  }

  if(scripts\mp\utility\game::iskillstreakdenied()) {
    return false;
  }

  if(bot_is_remote_or_linked()) {
    return false;
  }

  if(self isusingturret()) {
    return false;
  }

  if(isDefined(level.nukeincoming)) {
    return false;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return false;
  }

  if(isDefined(self.controlsfrozen) && self.controlsfrozen) {
    return false;
  }

  if(self isoffhandweaponreadytothrow()) {
    return false;
  }

  if(scripts\mp\utility\game::getgametypenumlives() > 0) {
    var_0 = 1;

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && !istestclient(self, var_2)) {
        var_0 = 0;
      }
    }

    if(var_0) {
      return false;
    }
  }

  if(istrue(self.debug_forest_combat)) {
    return false;
  }

  if(!bot_in_combat(500)) {
    return true;
  }

  if(!isalive(self.enemy)) {
    return true;
  }

  return false;
}

function bot_recent_point_of_interest() {
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

    var_5 = botgetmemoryevents(0, gettime() - 45000, 1, "kill", var_2, self);
    var_6 = botgetmemoryevents(0, gettime() - 45000, 1, "death", var_1, self);
    var_3 = scripts\engine\utility::random(scripts\engine\utility::array_combine(var_5, var_6));

    if(isDefined(var_3) > 0 && (!isDefined(var_4) || distancesquared(var_4, var_3) > 1000000)) {
      var_0 = var_3;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(var_0)) {
    var_7 = getzonenearest(var_0);
    var_8 = getzonenearest(self.origin);

    if(isDefined(var_7) && isDefined(var_8) && var_8 != var_7) {
      var_9 = botzonegetcount(var_7, self.team, "ally") + botzonegetcount(var_7, self.team, "path_ally");

      if(var_9 > 1) {
        var_0 = undefined;
      }
    }
  }

  if(isDefined(var_0)) {
    self.bot_memory_goal = var_0;
  }

  return var_0;
}

function bot_draw_cylinder(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

function bot_draw_cylinder_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

function bot_draw_circle(var_0, var_1, var_2, var_3, var_4) {}

function bot_get_total_gun_ammo() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  foreach(var_3 in var_1) {
    var_0 += self getweaponammoclip(var_3);
    var_0 += self getweaponammostock(var_3);
  }

  return var_0;
}

function bot_out_of_ammo() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_0 = self.weaponlist;
  } else {
    var_0 = self getweaponslistprimaries();
  }

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0) {
      return false;
    }

    if(self getweaponammostock(var_2) > 0) {
      return false;
    }
  }

  return true;
}

function bot_get_grenade_ammo() {
  var_0 = 0;
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1) {
    var_0 += self getweaponammostock(var_3);
  }

  return var_0;
}

function deactivate_laser_from_struct(var_0, var_1) {
  switch (var_0) {
    case "trap_directional":
      switch (var_1.basename) {
        case "claymore_mp":
          return true;
      }

      break;
    case "trap":
      switch (var_1.basename) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "at_mine_mp":
        case "trophy_mp":
          return true;
      }

      break;
    case "trap_follower":
      switch (var_1.basename) {
        case "tracking_drone_mp":
          return true;
      }

      break;
    case "c4":
      switch (var_1.basename) {
        case "c4_mp_p":
          return true;
      }

      break;
    case "tacticalinsertion":
      switch (var_1.basename) {
        case "flare_mp":
          return true;
      }

      break;
  }

  return false;
}

function bot_watch_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("death_or_disconnect");

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

  wait 0.5;
  var_8 = 1;

  if(self isusingturret()) {
    var_8 = 0;
  }

  var_9 = squared(self botgetscriptgoalRadius());

  while(var_8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < var_9) {
        if(length(self getvelocity()) <= 1) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      wait 0.05;
    }
  }

  var_10 = self.origin;
  var_11 = (0, 0, self getplayerviewheight());

  if(isDefined(var_0)) {
    self.watch_nodes = [];

    foreach(var_13 in var_0) {
      var_14 = 0;

      if(distance2dsquared(self.origin, var_13.origin) <= 40) {
        var_14 = 1;
      }

      var_15 = self getEye();
      var_16 = vectordot((0, 0, 1), vectorNormalize(var_13.origin + var_11 - var_15));

      if(abs(var_16) > 0.92) {
        var_14 = 1;
      }

      if(!var_14) {
        self.watch_nodes[self.watch_nodes.size] = var_13;
      }
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }

  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);

  foreach(var_13 in self.watch_nodes) {
    var_13.watch_node_chance[self.entity_number] = 1;
    var_13.watch_node_base_chance[self.entity_number] = 1;
  }

  var_20 = [];

  for(var_21 = 0;; var_21++) {
    jumpiffalse(var_21 < self.watch_nodes.size) LOC_00000253;
    var_20 = [];
    var_22 = vectorNormalize(self.watch_nodes[var_21].origin - self.origin);

    for(var_23 = 0; var_23 < self.watch_nodes.size; var_23++) {
      if(var_21 == var_23) {
        continue;
      }

      var_24 = vectorNormalize(self.watch_nodes[var_23].origin - self.origin);
      var_25 = vectordot(var_22, var_24);

      if(var_25 > 0.94) {
        var_20 = scripts\engine\utility::array_add(var_20[var_21], var_23);
      }
    }
  }

  for(;;) {
    var_26 = -1;
    var_27 = 0;

    for(var_21 = 0; var_21 < self.watch_nodes.size; var_21++) {
      if(var_20[var_21].size > var_27) {
        var_26 = var_21;
        var_27 = var_20[var_21].size;
      }
    }

    if(var_26 == -1) {
      break;
    }

    self.watch_nodes[var_26].watch_node_chance[self.entity_number] = 0.5;
    self.watch_nodes[var_26].watch_node_base_chance[self.entity_number] = 0.5;
    var_20 = [];

    for(var_21 = 0; var_21 < var_20.size; var_21++) {
      if(scripts\engine\utility::array_contains(var_20[var_21], var_26)) {
        var_20 = scripts\engine\utility::array_remove(var_20[var_21], var_26);
      }
    }
  }

  var_28 = gettime();
  var_29 = var_28;
  var_30 = [];
  var_31 = undefined;

  if(isDefined(var_1)) {
    var_31 = (0, var_1, 0);
  }

  var_32 = isDefined(var_31) && isDefined(var_2);
  var_33 = undefined;
  var_34 = undefined;
  wait 0.1;

  for(;;) {
    var_35 = gettime();
    self notify("still_watching_nodes");
    var_36 = self botgetfovdot();

    if(isDefined(var_3) && var_35 >= var_3) {
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

    if(isDefined(var_34) && var_34.watch_node_chance[self.entity_number] == 0) {
      var_29 = var_35;
    }

    if(self.watch_nodes.size > 0) {
      var_37 = 0;

      if(isDefined(self.enemy)) {
        var_38 = self lastknownpos(self.enemy);
        var_39 = self lastknowntime(self.enemy);

        if(var_39 && var_35 - var_39 < 5000) {
          var_40 = vectorNormalize(var_38 - self.origin);
          var_41 = 0;

          for(var_21 = 0; var_21 < self.watch_nodes.size; var_21++) {
            var_42 = vectorNormalize(self.watch_nodes[var_21].origin - self.origin);
            var_25 = vectordot(var_40, var_42);

            if(var_25 > var_41) {
              var_41 = var_25;
              var_34 = self.watch_nodes[var_21];
              var_37 = 1;
            }
          }
        }
      }

      if(!var_37 && var_35 >= var_29) {
        var_43 = [];

        for(var_21 = 0; var_21 < self.watch_nodes.size; var_21++) {
          var_13 = self.watch_nodes[var_21];
          var_44 = var_13 getnodenumber();

          if(var_32 && !scripts\engine\utility::within_fov(self.origin, var_31, var_13.origin, var_2)) {
            continue;
          }

          if(distance2dsquared(self.origin, var_13.origin) <= 10) {
            continue;
          }

          if(!isDefined(var_30[var_44])) {
            var_30 = 0;
          }

          if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_13.origin, var_36)) {
            var_30 = var_35;
          }

          for(var_45 = 0; var_45 < var_43.size; var_45++) {
            if(var_30[var_43[var_45] getnodenumber()] > var_30[var_44]) {
              break;
            }
          }

          var_43 = scripts\engine\utility::array_insert(var_43, var_13, var_45);
        }

        var_33 = var_34;
        var_34 = undefined;

        if(var_43.size == 1) {
          var_34 = var_43[0];
        } else if(var_43.size > 1) {
          var_46 = [];
          var_47 = 0;

          for(var_21 = 0; var_21 < var_43.size; var_21++) {
            var_48 = 1 - var_21 / (var_43.size - 1) * 0.5;
            var_49 = [var_43[var_21], var_43[var_21].watch_node_chance[self.entity_number] * var_48];
            var_46 = var_49;
            var_47 += var_49[1];
          }

          var_50 = randomfloat(var_47);

          for(var_21 = 0; var_21 < var_46.size; var_21++) {
            if(var_50 < var_46[var_21][1]) {
              var_34 = var_46[var_21][0];
              break;
            }

            var_50 -= var_46[var_21][1];
          }
        }

        if(isDefined(var_34)) {
          var_29 = var_35 + randomintrange(3000, 5000);
          var_51 = !isDefined(var_33) || var_33 != var_34;

          if(var_51 && istrue(self.bot_can_change_stance_while_watching_nodes)) {
            GscBinSkip4(0x35, var_34);
          }
        }
      }

      if(isDefined(var_34)) {
        var_52 = var_34.origin + var_11;

        if(distance2dsquared(self.origin, var_52) <= 10) {
          self botlookatpoint(undefined);
          var_34 = undefined;
          var_29 = 0;
        } else {
          self botlookatpoint(var_52, 0.4, "script_search");
        }
      }
    }

    wait 0.2;
  }
}

function bot_handle_stance_for_look(var_0) {
  if(isDefined(self.cur_defend_stance)) {
    var_1 = self.cur_defend_stance;

    if(var_1 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait 1;
    }

    if(var_1 == "prone") {
      if(watch_nodes_visible_prone(self getnearestnode(), var_0)) {
        self botsetstance("prone");
      } else {
        var_1 = "crouch";
      }
    }

    if(var_1 == "crouch") {
      if(watch_nodes_visible_crouch(self getnearestnode(), var_0)) {
        self botsetstance("crouch");
      } else {
        var_1 = "stand";
      }
    }

    if(var_1 == "stand") {
      self botsetstance("stand");
      return;
    }

    return;
  }
}

function watch_nodes_visible_prone(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0.pronevisiblenodes) || !isDefined(var_0.pronevisiblenodes[var_2])) {
    var_3 = sighttracepassed(var_0.origin + (0, 0, 11), var_1.origin + (0, 0, 11), 0, undefined);
    var_0.pronevisiblenodes[var_2] = var_3;
  }

  return var_0.pronevisiblenodes[var_2];
}

function watch_nodes_visible_crouch(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0.pronevisiblenodes) || !isDefined(var_0.pronevisiblenodes[var_2])) {
    var_3 = sighttracepassed(var_0.origin + (0, 0, 40), var_1.origin + (0, 0, 11), 0, undefined);
    var_0.pronevisiblenodes[var_2] = var_3;
  }

  return var_0.pronevisiblenodes[var_2];
}

function watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self.watch_nodes)) {
    foreach(var_1 in self.watch_nodes) {
      watch_node_clear_data(var_1);
    }
  }

  self.watch_nodes = undefined;
}

function watch_node_clear_data(var_0) {
  var_0.watch_node_chance[self.entity_number] = undefined;
  var_0.watch_node_base_chance[self.entity_number] = undefined;
}

function watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    var_0 = scripts\engine\utility::ref_143b9(0.5, "still_watching_nodes");

    if(!isDefined(var_0) || var_0 != "still_watching_nodes") {
      thread watch_nodes_stop();
      return;
    }
  }
}

function bot_leader_dialog(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_1, self botgetfovdot())) {
      var_2 = self botpredictseepoint(var_1);

      if(isDefined(var_2)) {
        self botlookatpoint(var_2 + (0, 0, 40), 1, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, var_1);
    return;
  }
}

function bot_get_known_attacker(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.classname)) {
    if(var_1.classname == "grenade") {
      if(isDefined(var_0) && var_0.classname == "worldspawn") {
        return undefined;
      }

      if(!bot_ent_is_anonymous_mine(var_1)) {
        return var_0;
      }
    } else if(var_1.classname == "rocket") {
      if(isDefined(var_1.vehicle_fired_from)) {
        return var_1.vehicle_fired_from;
      }

      if(isDefined(var_1.type) && var_1.type == "remote") {
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

function bot_ent_is_anonymous_mine(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = var_0.weaponname;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(issubstr(var_1, "c4_mp_p")) {
    return true;
  }

  if(issubstr(var_1, "claymore_mp")) {
    return true;
  }

  if(issubstr(var_1, "mine_mp")) {
    return true;
  }

  if(issubstr(var_1, "proximity_explosive_mp")) {
    return true;
  }

  return false;
}

function bot_vectors_are_equal(var_0, var_1) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

function bot_add_to_bot_level_targets(var_0) {
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

function bot_remove_from_bot_level_targets(var_0) {
  var_0.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, var_0);
}

function bot_add_to_bot_use_targets(var_0) {
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

function bot_add_to_bot_damage_targets(var_0) {
  if(!issubstr(var_0.code_classname, "trigger_damage")) {
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

function bot_get_string_index_for_integer(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0) {
    if(var_2 == var_1) {
      return var_5;
    }

    var_2++;
  }

  return undefined;
}

function bot_get_zones_within_dist(var_0, var_1) {
  for(var_2 = 0; var_2 < level.zonecount; var_2++) {
    var_3 = getzonenodeforindex(var_2);
    var_3.visited = 0;
  }

  var_4 = getzonenodeforindex(var_0);
  return bot_get_zones_within_dist_recurs(var_4, var_1);
}

function bot_get_zones_within_dist_recurs(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, 0, getnodezone(var_0));
}

function bot_get_max_players_on_team(var_0) {
  return level.bot_max_players_on_team[var_0];
}

function bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

function bot_get_client_limit() {
  var_0 = getdvarint("OOTQKOTRM", 0);
  var_0 = max(var_0, getdvarint("ROMTTTNL", 0));

  if(var_0 > level.maxclients) {
    return level.maxclients;
  }

  return var_0;
}

function bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;

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
        var_2 = level.bot_queued_process_queue[var_3];
      }

      level.bot_queued_process_queue = var_2;
    }

    wait 0.05;
  }
}

function bot_queued_process(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(var_7 in level.bot_queued_process_queue) {
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
  jumpiftrue(isDefined(level.bot_queued_process_level_thread_active)) LOC_000000e6;
  level.bot_queued_process_level_thread_active = 1;
  thread bot_queued_process_level_thread();
  self waittill(var_7.name_complete, var_9);
  return var_9;
}

function bot_is_remote_or_linked() {
  return scripts\mp\utility\player::isusingremote() || self islinked();
}

function bot_get_low_on_ammo(var_0) {
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
      return true;
    }

    if(self getfractionmaxammo(var_3) <= var_0) {
      return true;
    }
  }

  return false;
}

function damagestatedata(var_0) {
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var_1 = self.weaponlist;
  } else {
    var_1 = self getweaponslistprimaries();
  }

  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_5.ref_11a53 = 0;
    var_6 = weaponclipsize(var_5);
    var_7 = self getweaponammostock(var_5);

    if(var_7 <= var_6 || self getfractionmaxammo(var_5) <= var_0) {
      var_3++;
    }
  }

  if(var_3 == var_1.size) {
    var_2 = 1;
  }

  return var_2;
}

function bot_point_is_on_pathgrid(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 256;
  }

  if(!isDefined(var_2)) {
    var_2 = 72;
  }

  var_3 = getclosestpointonnavmesh(var_0);
  var_4 = var_3 - var_0;

  if(length2dsquared(var_4) > var_1 * var_1) {
    return false;
  }

  if(abs(var_4[2]) > var_2) {
    return false;
  }

  return true;
}

function bot_monitor_enemy_camp_spots(var_0) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];

  for(;;) {
    wait 1;
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
        level.enemy_camp_spots[var_3.team] = var_3 botpredictenemycampspots(1);

        if(isDefined(level.enemy_camp_spots[var_3.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[var_3.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var_3.team], level.enemy_camp_assassin_goal[var_3.team])) {
            level.enemy_camp_assassin_goal[var_3.team] = scripts\engine\utility::random(level.enemy_camp_spots[var_3.team]);
          }

          if(isDefined(level.enemy_camp_assassin_goal[var_3.team])) {
            var_4 = [];

            foreach(var_6 in level.participants) {
              if(!isDefined(var_6.team)) {
                continue;
              }

              if(var_6[[var_0]]() && var_6.team == var_3.team) {
                var_4 = var_6;
              }
            }

            var_4 = sortbydistance(var_4, level.enemy_camp_assassin_goal[var_3.team]);

            if(var_4.size > 0) {
              level.enemy_camp_assassin[var_3.team] = var_4[0];
            }
          }
        }

        var_1 = 1;
      }
    }
  }
}

function bot_valid_camp_assassin() {
  if(!isDefined(self)) {
    return false;
  }

  if(!isai(self)) {
    return false;
  }

  if(!isDefined(self.team)) {
    return false;
  }

  if(self.team == "spectator") {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  if(!scripts\mp\utility\entity::isaiteamparticipant(self)) {
    return false;
  }

  if(!isDefined(self.personality) || self.personality == "camper") {
    return false;
  }

  return true;
}

function bot_update_camp_assassin() {
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
    return;
  }
}

function bot_force_stance_for_time(var_0, var_1) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetstance(var_0);
  wait var_1;
  self botsetstance("none");
}

function set_high_priority_target_for_bot(var_0) {
  if(!(isDefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, var_0))) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, var_0);
    var_0 notify("calculate_new_level_targets");
    return;
  }
}

function add_to_bot_use_targets(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.use_time = var_1;
    var_0.bot_interaction_type = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
    return;
  }
}

function remove_from_bot_use_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
    return;
  }
}

function add_to_bot_damage_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.bot_interaction_type = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
    return;
  }
}

function remove_from_bot_damage_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
    return;
  }
}

function notify_enemy_bots_bomb_used(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"])) {
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var_0);
    return;
  }
}

function get_rank_xp_for_bot() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bot_get_rank_xp"])) {
    return self[[level.bot_funcs["bot_get_rank_xp"]]]();
  }
}

function bot_israndom() {
  return self botisrandomized();
}

function client_is_dev_bot(var_0) {
  if(!isbot(var_0)) {
    return false;
  }

  if(!dev_spawning_bots()) {
    return false;
  }

  return true;
}

function dev_spawning_bots() {
  return false;
}

function damage_func(var_0) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait var_0;
  self botsetflag("disable_movement", 0);
}

function playerwaitforprestreaming(var_0) {
  var_1 = tablelookupgetnumrows(var_0);
  var_2 = spawnStruct();
  var_2.settings = [];
  var_2.settings["recruit"] = [];
  var_2.settings["regular"] = [];
  var_2.settings["hardened"] = [];
  var_2.settings["veteran"] = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = tablelookupbyrow(var_0, var_3, 0);
    var_2.settings["recruit"][var_4] = spawnStruct();
    var_2.settings["regular"][var_4] = spawnStruct();
    var_2.settings["hardened"][var_4] = spawnStruct();
    var_2.settings["veteran"][var_4] = spawnStruct();
    var_5 = tablelookupbyrow(var_0, var_3, 1);
    var_2.settings["recruit"][var_4] = var_5;
    var_6 = tablelookupbyrow(var_0, var_3, 2);
    var_2.settings["regular"][var_4] = var_6;
    var_7 = tablelookupbyrow(var_0, var_3, 3);
    var_2.settings["hardened"][var_4] = var_7;
    var_8 = tablelookupbyrow(var_0, var_3, 4);
    var_2.settings["veteran"][var_4] = var_8;
  }

  return var_2;
}

function debug_chopper_boss_combat(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.linked_brush;
  }

  var_2 = var_1.settings[var_0];
  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3) {
    if(var_5 == "burstFireType") {
      var_6 = var_1.settings[var_0][var_5];
    } else {
      var_6 = float(var_1.settings[var_0][var_5]);
    }

    self botsetdifficultysetting(var_5, var_6);
  }
}

function death_impulse(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level.linked_brush;
  }

  var_3 = var_2.settings[var_0];
  var_4 = getarraykeys(var_3);

  foreach(var_6 in var_4) {
    if(var_6 != var_1) {
      continue;
    }

    if(var_6 == "burstFireType") {
      var_7 = var_2.settings[var_0][var_6];
    } else {
      var_7 = float(var_3.settings[var_1][var_8]);
    }

    self botsetdifficultysetting(var_8, var_7);
    return;
  }

  var_7 = undefined;
}