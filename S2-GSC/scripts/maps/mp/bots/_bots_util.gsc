/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_util.gsc
***********************************************/

bot_get_nodes_in_cone(var_0, var_1, var_2, var_3) {
  var_4 = _getnodesinradius(self.origin, var_1, var_0);
  var_5 = [];
  var_6 = self getnearestnode();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectorNormalize(var_7 * (1, 1, 0));

  foreach(var_10 in var_4) {
    var_11 = vectorNormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);

    if(var_12 > var_2) {
      if(!var_3 || isDefined(var_6) && _nodesvisible(var_10, var_6, 1)) {
        var_5[var_5.size] = var_10;
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
  maps\mp\bots\_bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(var_0, var_1) {
  if(var_0 == "default") {
    var_0 = bot_choose_difficulty_for_default();
  }

  var_3 = self botgetdifficulty();
  self botsetdifficulty(var_0);

  if(isPlayer(self) && var_3 != var_0) {
    maps\mp\_utility::set_rank_xp_and_prestige_for_bot();
    var_4 = maps\mp\gametypes\_rank::getrankforxp(maps\mp\gametypes\_rank::getrankxp());
    self.pers["rank"] = var_4;
    var_5 = self.pers["prestige"];
    self setrank(var_4, var_5);
  }
}

bot_choose_difficulty_for_default() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "easy";
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
    level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
  }

  if(!isDefined(level.bot_next_difficulty_type_index)) {
    level.bot_next_difficulty_type_index = [];
  }

  if(!isDefined(level.bot_next_difficulty_type_index["allies"])) {
    level.bot_next_difficulty_type_index["allies"] = 0;
  }

  if(!isDefined(level.bot_next_difficulty_type_index["axis"])) {
    level.bot_next_difficulty_type_index["axis"] = 0;
  }

  if(!isDefined(level.bot_next_difficulty_type_index["all"])) {
    level.bot_next_difficulty_type_index["all"] = 0;
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
    } else
      var_1 = "all";

    var_0 = level.bot_next_difficulty_type_index[var_1];
    var_2 = level.bot_difficulty_defaults[var_0];
    self.pers["bot_chosen_difficulty"] = get_difficulty_for_difficulty_type(var_2);
    level.bot_next_difficulty_type_index[var_1] = (level.bot_next_difficulty_type_index[var_1] + 1) % level.bot_difficulty_defaults.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

get_difficulty_for_difficulty_type(var_0) {
  if(var_0 == "easy") {
    return "recruit";
  } else if(var_0 == "normal") {
    return "regular";
  } else if(var_0 == "hard") {
    return common_scripts\utility::random(["hardened", "veteran"]);
  } else {}
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
    if(self.bot_defending_type == "protect" || self.bot_defending_type == "protect_zone") {
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

  return _sighttracepassed(var_1 + var_5, var_0 + var_5, 0, undefined);
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
  return _getpathdist(var_0, var_1);
}

func_get_nodes_on_path(var_0, var_1) {
  return _getnodesonpath(var_0, var_1);
}

func_bot_get_closest_navigable_point(var_0, var_1, var_2) {
  return _botgetclosestnavigablepoint(var_0, var_1, var_2);
}

node_is_on_path_from_labels(var_0, var_1) {
  if(!isDefined(self.on_path_from)) {
    return 0;
  }

  if(isDefined(self.on_path_from[var_0]) && isDefined(self.on_path_from[var_0][var_1]) && self.on_path_from[var_0][var_1]) {
    return 1;
  }

  if(isDefined(self.on_path_from[var_1]) && isDefined(self.on_path_from[var_1][var_0]) && self.on_path_from[var_1][var_0]) {
    return 1;
  }

  return 0;
}

get_all_connected_nodes(var_0) {
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = _getlinkednodes(var_0[var_2]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(!common_scripts\utility::_id_0F79(var_1, var_3[var_4])) {
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3[var_4]);
      }
    }
  }

  return var_1;
}

get_visible_nodes_array(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_nodesvisible(var_4, var_1, 1)) {
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
    }
  }

  return var_2;
}

remove_ends_from_path(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return common_scripts\utility::_id_0FA0(var_0);
}

bot_waittill_bots_enabled(var_0) {
  while(!bot_bots_enabled_or_added(var_0)) {
    wait 0.5;
  }
}

bot_bots_enabled_or_added(var_0) {
  if(_botautoconnectenabled() != "off") {
    return 1;
  }

  if(isDefined(level._id_0AA1) && level._id_0AA1) {
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

    if(!isDefined(self._id_0088)) {
      return;
    } else if(!bot_in_combat()) {
      return;
    }
    waitframe();
  }
}

bot_in_combat(var_0) {
  if(self.last_enemy_sight_time == 0) {
    return 0;
  }

  var_1 = gettime() - self.last_enemy_sight_time;
  var_2 = level.bot_out_of_combat_time;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  return var_1 < var_2;
}

bot_waittill_goal_or_fail(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  if((!isDefined(var_1) || !isDefined(var_2)) && isDefined(var_3)) {}

  var_4 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var_1)) {
    var_4[var_4.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4[var_4.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4[var_4.size] = var_3;
  }

  if(isDefined(var_0)) {
    var_5 = common_scripts\utility::waittill_any_in_array_or_timeout(var_4, var_0);
  } else {
    var_5 = common_scripts\utility::waittill_any_in_array_return(var_4);
  }

  return var_5;
}

bot_usebutton_wait(var_0, var_1, var_2) {
  level endon("game_ended");
  childthread use_button_stopped_notify();
  var_3 = common_scripts\utility::waittill_any_timeout(var_0, var_1, var_2, "use_button_no_longer_pressed", "finished_use");
  self notify("stop_usebutton_watcher");
  return var_3;
}

use_button_stopped_notify(var_0, var_1) {
  self endon("stop_usebutton_watcher");
  waitframe();

  while(self useButtonPressed()) {
    waitframe();
  }

  self notify("use_button_no_longer_pressed");
}

bots_exist(var_0) {
  foreach(var_2 in level.participants) {
    if(_isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!maps\mp\_utility::isteamparticipant(var_2)) {
          continue;
        }
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(var_0, var_1, var_2) {
  if(!isDefined(level.entrance_points_finished_caching)) {
    return undefined;
  }

  if(_isarray(var_1)) {
    if(isDefined(var_2) && var_2) {
      var_3 = undefined;
      var_4 = 999999999;

      foreach(var_6 in var_1) {
        var_7 = common_scripts\utility::_id_0F7E(level.entrance_indices, var_6);
        var_8 = level.entrance_origin_points[var_7];
        var_9 = distancesquared(self.origin, var_8);

        if(var_9 < var_4) {
          var_3 = var_6;
          var_4 = var_9;
        }
      }

      var_1 = var_3;
    } else
      var_1 = common_scripts\utility::random(var_1);
  }

  var_11 = level.entrance_points[var_1];

  if(!isDefined(var_0) || var_0 == "stand") {
    return var_11;
  } else if(var_0 == "crouch") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14.crouch_visible_from[var_1]) {
        var_12 = common_scripts\utility::_id_0F6F(var_12, var_14);
      }
    }

    return var_12;
  } else if(var_0 == "prone") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14.prone_visible_from[var_1]) {
        var_12 = common_scripts\utility::_id_0F6F(var_12, var_14);
      }
    }

    return var_12;
  }

  return undefined;
}

bot_find_node_to_guard_player(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self.bot_defend_player_guarding getvelocity();

  if(_lengthsquared(var_4) > 100) {
    var_5 = _getnodesinradius(var_0, var_1 * 1.75, var_1 * 0.5, 500);
    var_6 = [];
    var_7 = vectorNormalize(var_4);

    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      var_9 = vectorNormalize(var_5[var_8].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_9, var_7) > 0.1) {
        var_6[var_6.size] = var_5[var_8];
      }
    }
  } else
    var_6 = _getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_2) && var_2) {
    var_10 = vectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_11 = var_6;
    var_6 = [];

    foreach(var_13 in var_11) {
      var_9 = vectorNormalize(var_13.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_10, var_9) > 0.2) {
        var_6[var_6.size] = var_13;
      }
    }
  }

  var_15 = [];
  var_16 = [];
  var_17 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_18 = distancesquared(var_6[var_8].origin, var_0) > 10000;
    var_19 = _abs(var_6[var_8].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(var_18) {
      var_15[var_15.size] = var_6[var_8];
    }

    if(var_19) {
      var_16[var_16.size] = var_6[var_8];
    }

    if(var_18 && var_19) {
      var_17[var_17.size] = var_6[var_8];
    }

    if(var_8 % 100 == 99) {
      waitframe();
    }
  }

  if(var_17.size > 0) {
    var_3 = self botnodepick(var_17, var_17.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
  }

  if(!isDefined(var_3)) {
    waitframe();

    if(var_16.size > 0) {
      var_3 = self botnodepick(var_16, var_16.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
    }

    if(!isDefined(var_3) && var_15.size > 0) {
      waitframe();
      var_3 = self botnodepick(var_15, var_15.size * 0.15, "node_capture", var_0, undefined, self.defense_score_flags);
    }
  }

  return var_3;
}

bot_find_node_to_capture_point(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = _getnodesinradius(var_0, var_1, 0, 500);

  if(var_4.size > 0) {
    var_3 = self botnodepick(var_4, var_4.size * 0.15, "node_capture", var_0, var_2, self.defense_score_flags);
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

_id_19CF(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_2 = self botnodepick(var_0, var_0.size * 0.25, "node_capture", var_1, undefined, self.defense_score_flags);
  }

  return var_2;
}

bot_find_node_that_protects_point(var_0, var_1) {
  var_2 = undefined;
  var_3 = _getnodesinradius(var_0, var_1, 0, 500);

  if(var_3.size > 0) {
    var_2 = self botnodepick(var_3, var_3.size * 0.15, "node_protect", var_0, self.defense_score_flags);
  }

  return var_2;
}

bot_pick_random_point_in_radius(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = _getnodesinradius(var_0, var_1, 0, 500);

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

    var_7 = _randomfloatrange(self.bot_defending_radius * var_3, self.bot_defending_radius * var_4);
    var_8 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_8 * var_7;
  }

  return var_5;
}

bot_pick_random_point_from_set(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.size >= 2) {
    var_3 = bot_find_random_midpoint(var_1, var_2);
  }

  if(!isDefined(var_3)) {
    var_4 = common_scripts\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectorNormalize(var_5) * length(var_5) * _randomfloat(1.0);
  }

  return var_3;
}

bot_find_random_midpoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = common_scripts\utility::array_randomize(var_0);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_4];
      var_7 = var_3[var_5];

      if(_nodesvisible(var_6, var_7, 1)) {
        var_2 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

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
  if(!maps\mp\_utility::_id_0F5C()) {
    return 0;
  }

  if(maps\mp\_utility::iskillstreakdenied()) {
    return 0;
  }

  if(bot_is_remote_or_linked()) {
    return 0;
  }

  if(self isusingturret()) {
    return 0;
  }

  if(isDefined(level._id_685D) || isDefined(level.nukecoolingdown)) {
    return 0;
  }

  if(isDefined(level.nobotscorestreaks)) {
    return 0;
  }

  if(isDefined(self.underwater) && self.underwater) {
    return 0;
  }

  if(isDefined(self.controlsfrozen) && self.controlsfrozen) {
    return 0;
  }

  if(!self _meth_85EB()) {
    return 0;
  }

  if(self isoffhandweaponreadytothrow()) {
    return 0;
  }

  if(maps\mp\_utility::getgametypenumlives() > 0) {
    var_0 = 1;

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && !_isalliedsentient(self, var_2)) {
        var_0 = 0;
      }
    }

    if(var_0) {
      return 0;
    }
  }

  if(common_scripts\utility::_id_562E(self._id_1B2F)) {
    return 0;
  }

  if(!bot_in_combat(500)) {
    return 1;
  }

  if(!isalive(self._id_0088)) {
    return 1;
  }

  return 0;
}

bot_recent_point_of_interest() {
  var_0 = undefined;
  var_1 = _botmemoryflags("investigated", "killer_died");
  var_2 = _botmemoryflags("investigated");
  var_3 = common_scripts\utility::random(_botgetmemoryevents(0, gettime() - 10000, 1, "death", var_1, self));

  if(isDefined(var_3)) {
    var_0 = var_3;
    self.bot_memory_goal_time = 10000;
  } else {
    var_4 = undefined;

    if(self botgetscriptgoaltype() != "none") {
      var_4 = self botgetscriptgoal();
    }

    var_5 = _botgetmemoryevents(0, gettime() - 45000, 1, "kill", var_2, self);
    var_6 = _botgetmemoryevents(0, gettime() - 45000, 1, "death", var_1, self);
    var_3 = common_scripts\utility::random(common_scripts\utility::_id_0F73(var_5, var_6));

    if(isDefined(var_3) > 0 && (!isDefined(var_4) || distancesquared(var_4, var_3) > 1000000)) {
      var_0 = var_3;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(var_0)) {
    var_7 = _getzonenearest(var_0);
    var_8 = _getzonenearest(self.origin);

    if(isDefined(var_7) && isDefined(var_8) && var_8 != var_7) {
      var_9 = _botzonegetcount(var_7, self.team, "ally") + _botzonegetcount(var_7, self.team, "path_ally");

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

_id_193A() {
  if(self bothasscriptgoal()) {
    var_0 = self botgetscriptgoal();

    if(distancesquared(self.origin, var_0) < 256) {
      return 1;
    }
  }

  return 0;
}

bot_draw_cylinder(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

bot_draw_cylinder_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

bot_draw_circle(var_0, var_1, var_2, var_3, var_4) {}

bot_get_total_gun_ammo() {
  var_0 = 0;
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

bot_out_of_ammo() {
  var_0 = self getweaponlistprimaries();

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

bot_item_matches_purpose(var_0, var_1) {
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
    case "trap_follower":
      switch (var_1) {
        case "tracking_drone_mp":
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
        case "s2_tactical_insertion_device_mp":
          return 1;
      }

      break;
  }

  return 0;
}

bot_watch_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("disconnect");
  self endon("death");

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

  var_9 = _squared(self botgetscriptgoalRadius());

  while(var_8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < var_9) {
        if(length(self getvelocity()) <= 1) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      waitframe();
    }
  }

  var_10 = self.origin;
  var_11 = (0, 0, self getplayerviewheight());

  if(isDefined(var_0)) {
    self.watch_nodes = [];

    foreach(var_13 in var_0) {
      var_14 = 0;

      if(_distance2dsquared(self.origin, var_13.origin) <= 40) {
        var_14 = 1;
      }

      var_15 = self getEye();
      var_16 = vectordot((0, 0, 1), vectorNormalize(var_13.origin + var_11 - var_15));

      if(_abs(var_16) > 0.92) {
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
  self.watch_nodes = common_scripts\utility::array_randomize(self.watch_nodes);

  foreach(var_13 in self.watch_nodes) {
    var_13.watch_node_chance[self.entity_number] = 1.0;
    var_13._id_A8C6[self.entity_number] = 1.0;
  }

  var_20 = [];

  for(var_21 = 0; var_21 < self.watch_nodes.size; var_21++) {
    var_20[var_21] = [];
    var_22 = vectorNormalize(self.watch_nodes[var_21].origin - self.origin);

    for(var_23 = 0; var_23 < self.watch_nodes.size; var_23++) {
      if(var_21 == var_23) {
        continue;
      }
      var_24 = vectorNormalize(self.watch_nodes[var_23].origin - self.origin);
      var_25 = vectordot(var_22, var_24);

      if(var_25 > 0.94) {
        var_20[var_21] = common_scripts\utility::_id_0F6F(var_20[var_21], var_23);
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
    self.watch_nodes[var_26]._id_A8C6[self.entity_number] = 0.5;
    var_20[var_26] = [];

    for(var_21 = 0; var_21 < var_20.size; var_21++) {
      if(common_scripts\utility::_id_0F79(var_20[var_21], var_26)) {
        var_20[var_21] = common_scripts\utility::_id_0F93(var_20[var_21], var_26);
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
    if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      self botlookatpoint(undefined);
      wait 0.2;
      continue;
    }

    if(!self bothasscriptgoal() || !self botpursuingscriptgoal()) {
      wait 0.2;
      continue;
    }

    if(isDefined(var_34) && var_34.watch_node_chance[self.entity_number] == 0.0) {
      var_29 = var_35;
    }

    if(self.watch_nodes.size > 0) {
      var_37 = 0;

      if(isDefined(self._id_0088)) {
        var_38 = self lastknownpos(self._id_0088);
        var_39 = self lastknowntime(self._id_0088);

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

          if(var_32 && !common_scripts\utility::within_fov(self.origin, var_31, var_13.origin, var_2)) {
            continue;
          }
          if(_distance2dsquared(self.origin, var_13.origin) <= 10) {
            continue;
          }
          if(!isDefined(var_30[var_44])) {
            var_30[var_44] = 0;
          }

          if(common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_13.origin, var_36)) {
            var_30[var_44] = var_35;
          }

          for(var_45 = 0; var_45 < var_43.size; var_45++) {
            if(var_30[var_43[var_45] getnodenumber()] > var_30[var_44]) {
              break;
            }
          }

          var_43 = common_scripts\utility::_id_0F86(var_43, var_13, var_45);
        }

        var_33 = var_34;
        var_34 = undefined;

        if(var_43.size == 1) {
          var_34 = var_43[0];
        } else if(var_43.size > 1) {
          var_46 = [];
          var_47 = 0;

          for(var_21 = 0; var_21 < var_43.size; var_21++) {
            var_48 = 1.0 - var_21 / (var_43.size - 1) * 0.5;
            var_49 = [var_43[var_21], var_43[var_21].watch_node_chance[self.entity_number] * var_48];
            var_46[var_46.size] = var_49;
            var_47 = var_47 + var_49[1];
          }

          var_50 = _randomfloat(var_47);

          for(var_21 = 0; var_21 < var_46.size; var_21++) {
            if(var_50 < var_46[var_21][1]) {
              var_34 = var_46[var_21][0];
              break;
            }

            var_50 = var_50 - var_46[var_21][1];
          }
        }

        if(isDefined(var_34)) {
          var_29 = var_35 + _randomintrange(3000, 5000);
          var_51 = !isDefined(var_33) || var_33 != var_34;

          if(var_51 && common_scripts\utility::_id_562E(self._id_1957)) {
            childthread _id_1A10(var_34);
          }
        }
      }

      if(isDefined(var_34)) {
        var_52 = var_34.origin + var_11;

        if(_distance2dsquared(self.origin, var_52) <= 10) {
          self botlookatpoint(undefined);
          var_34 = undefined;
          var_29 = 0;
        } else
          self botlookatpoint(var_52, 0.4, "script_search");
      }
    }

    wait 0.2;
  }
}

_id_1A10(var_0) {
  if(isDefined(self.cur_defend_stance)) {
    var_1 = self.cur_defend_stance;

    if(var_1 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait 1.0;
    }

    if(var_1 == "prone") {
      if(_id_A8CD(self getnearestnode(), var_0)) {
        self botsetstance("prone");
      } else {
        var_1 = "crouch";
      }
    }

    if(var_1 == "crouch") {
      if(_id_A8CC(self getnearestnode(), var_0)) {
        self botsetstance("crouch");
      } else {
        var_1 = "stand";
      }
    }

    if(var_1 == "stand") {
      self botsetstance("stand");
    }
  }
}

_id_A8CD(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0._id_777C) || !isDefined(var_0._id_777C[var_2])) {
    var_3 = _sighttracepassed(var_0.origin + (0, 0, 11), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_777C[var_2] = var_3;
  }

  return var_0._id_777C[var_2];
}

_id_A8CC(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0._id_777C) || !isDefined(var_0._id_777C[var_2])) {
    var_3 = _sighttracepassed(var_0.origin + (0, 0, 40), var_1.origin + (0, 0, 11), 0, undefined);
    var_0._id_777C[var_2] = var_3;
  }

  return var_0._id_777C[var_2];
}

watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self.watch_nodes)) {
    foreach(var_1 in self.watch_nodes) {
      _id_A8C8(var_1);
    }
  }

  self.watch_nodes = undefined;
}

_id_A8C8(var_0) {
  var_0.watch_node_chance[self.entity_number] = undefined;
  var_0._id_A8C6[self.entity_number] = undefined;
}

watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_timeout(0.5, "still_watching_nodes");

    if(!isDefined(var_0) || var_0 != "still_watching_nodes") {
      watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!common_scripts\utility::within_fov(self.origin, self getplayerangles(), var_1, self botgetfovdot())) {
      var_2 = self botpredictseepoint(var_1);

      if(isDefined(var_2)) {
        self botlookatpoint(var_2 + (0, 0, 40), 1.0, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, var_1);
  }
}

bot_get_known_attacker(var_0, var_1) {
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

      if(isDefined(var_1.type) && (var_1.type == "remote" || var_1.type == "odin")) {
        return var_1;
      }

      if(maps\mp\_utility::_id_579B()) {
        if(isDefined(var_1._id_0117) && var_1._id_0117.classname == "worldspawn") {
          return undefined;
        }
      }

      if(isDefined(var_1._id_0117)) {
        return var_1._id_0117;
      }
    } else if(var_1.classname == "worldspawn" || var_1.classname == "trigger_hurt")
      return undefined;

    return var_1;
  }

  return var_0;
}

bot_ent_is_anonymous_mine(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = var_0.weaponname;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(issubstr(var_1, "c4_mp")) {
    return 1;
  }

  if(issubstr(var_1, "claymore_mp")) {
    return 1;
  }

  if(issubstr(var_1, "proximity_explosive_mp")) {
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
  } else if(var_0.bot_interaction_type == "damage") {
    bot_add_to_bot_damage_targets(var_0);
  } else {}
}

bot_remove_from_bot_level_targets(var_0) {
  var_0._id_0CA3 = 1;
  level.level_specific_bot_targets = common_scripts\utility::_id_0F93(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_use_targets(var_0) {
  if(!issubstr(var_0._id_003B, "trigger_use")) {
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
  var_1 = _getnodearray(var_0.target, "targetname");

  if(var_1.size != 1) {
    return;
  }
  var_0.bot_target = var_1[0];

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = common_scripts\utility::_id_0F6F(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_damage_targets(var_0) {
  if(!issubstr(var_0._id_003B, "trigger_damage")) {
    return;
  }
  var_1 = _getnodearray(var_0.target, "targetname");

  if(var_1.size != 2) {
    return;
  }
  var_0.bot_targets = var_1;

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = common_scripts\utility::_id_0F6F(level.level_specific_bot_targets, var_0);
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
    var_3 = _getzonenodeforindex(var_2);
    var_3.visited = 0;
  }

  var_4 = _getzonenodeforindex(var_0);
  return bot_get_zones_within_dist_recurs(var_4, var_1);
}

bot_get_zones_within_dist_recurs(var_0, var_1) {
  var_2 = [];
  var_2[0] = _getnodezone(var_0);
  var_0.visited = 1;
  var_3 = _getlinkednodes(var_0);

  foreach(var_5 in var_3) {
    if(!var_5.visited) {
      var_6 = distance(var_0.origin, var_5.origin);

      if(var_6 < var_1) {
        var_7 = bot_get_zones_within_dist_recurs(var_5, var_1 - var_6);
        var_2 = common_scripts\utility::_id_0F73(var_7, var_2);
      }
    }
  }

  return var_2;
}

bot_crate_is_command_goal(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_253C) && var_0._id_253C;
}

bot_get_max_players_on_team(var_0) {
  return level.bot_max_players_on_team[var_0];
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_0 = _func_364();
  var_0 = max(var_0, getdvarint("5321", 0));

  if(var_0 > level.maxclients) {
    return level.maxclients;
  }

  return var_0;
}

bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  waitframe();

  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var_0 = level.bot_queued_process_queue[0];

      if(isDefined(var_0) && isDefined(var_0._id_0117)) {
        var_1 = undefined;

        if(isDefined(var_0.parm4)) {
          var_1 = var_0._id_0117[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3, var_0.parm4);
        } else if(isDefined(var_0.parm3)) {
          var_1 = var_0._id_0117[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3);
        } else if(isDefined(var_0.parm2)) {
          var_1 = var_0._id_0117[[var_0.func]](var_0.parm1, var_0.parm2);
        } else if(isDefined(var_0.parm1)) {
          var_1 = var_0._id_0117[[var_0.func]](var_0.parm1);
        } else {
          var_1 = var_0._id_0117[[var_0.func]]();
        }

        var_0._id_0117 notify(var_0.name_complete, var_1);
      }

      var_2 = [];

      for(var_3 = 1; var_3 < level.bot_queued_process_queue.size; var_3++) {
        var_2[var_3 - 1] = level.bot_queued_process_queue[var_3];
      }

      level.bot_queued_process_queue = var_2;
    }

    waitframe();
  }
}

bot_queued_process(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(var_8, var_7 in level.bot_queued_process_queue) {
    if(var_7._id_0117 == self && var_7.name == var_0) {
      self notify(var_7.name);
      level.bot_queued_process_queue[var_8] = undefined;
    }
  }

  var_7 = spawnStruct();
  var_7._id_0117 = self;
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
  return maps\mp\_utility::isusingremote() || self islinked();
}

bot_get_low_on_ammo(var_0) {
  var_1 = self getweaponlistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _weaponclipsize(var_3);
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

  var_3 = _getnodesinradiussorted(var_0, var_1, 0, var_2, "Path");

  foreach(var_5 in var_3) {
    var_6 = var_0 + (0, 0, 30);
    var_7 = var_5.origin + (0, 0, 30);
    var_8 = _physicstrace(var_6, var_7);

    if(bot_vectors_are_equal(var_8, var_7)) {
      return 1;
    }

    waitframe();
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
    wait 1.0;
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
          if(!isDefined(level.enemy_camp_assassin_goal[var_3.team]) || !common_scripts\utility::_id_0F79(level.enemy_camp_spots[var_3.team], level.enemy_camp_assassin_goal[var_3.team])) {
            level.enemy_camp_assassin_goal[var_3.team] = common_scripts\utility::random(level.enemy_camp_spots[var_3.team]);
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

            var_4 = _sortbydistance(var_4, level.enemy_camp_assassin_goal[var_3.team]);

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

  if(!_isai(self)) {
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

  if(!maps\mp\_utility::isaiteamparticipant(self)) {
    return 0;
  }

  if(!isDefined(self.personality) || self.personality == "camper") {
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
    maps\mp\bots\_bots_strategy::bot_defend_stop();
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

bot_disable_movement_for_time(var_0) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait(var_0);
  self botsetflag("disable_movement", 0);
}