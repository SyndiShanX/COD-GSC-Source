/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_util.gsc
***********************************************/

function bot_get_nodes_in_cone(var0, var1, var2, var3) {
  var4 = getnodesinradius(self.origin, var1, var0);
  var5 = [];
  var6 = self getnearestnode();
  var7 = anglesToForward(self getplayerangles());
  var8 = vectorNormalize(var7 * (1, 1, 0));

  foreach(var10 in var4) {
    var11 = vectorNormalize((var10.origin - self.origin) * (1, 1, 0));
    var12 = vectordot(var11, var8);

    if(var12 > var2) {
      if(!var3 || isDefined(var6) && nodesvisible(var10, var6, 1)) {
        var5 = var10;
      }
    }
  }

  return var5;
}

function bot_goal_can_override(var0, var1) {
  if(var0 == "none") {
    return (var1 == "none");
  }

  if(var0 == "hunt") {
    return (var1 == "hunt" || var1 == "none");
  }

  if(var0 == "guard") {
    return (var1 == "guard" || var1 == "hunt" || var1 == "none");
  }

  if(var0 == "objective") {
    return (var1 == "objective" || var1 == "guard" || var1 == "hunt" || var1 == "none");
  }

  if(var0 == "critical") {
    return (var1 == "critical" || var1 == "objective" || var1 == "guard" || var1 == "hunt" || var1 == "none");
  }

  if(var0 == "tactical") {
    return 1;
  }
}

function bot_set_personality(var0) {
  self botsetpersonality(var0);
  scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

function bot_set_difficulty(var0, var1) {
  if(var0 == "default") {
    var0 = bot_choose_difficulty_for_default();
  }

  var3 = self botgetdifficulty();
  self botsetdifficulty(var0);

  if(isPlayer(self) && var3 != var0) {
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
    var0 = undefined;

    if(level.teambased) {
      var1 = self.team;

      if(!isDefined(var1)) {
        var1 = self.bot_team;
      }

      if(!isDefined(var1)) {
        var1 = self.pers["team"];
      }
    } else {
      var1 = "all";
    }

    var1 = level.deadgreen[var1];
    var2 = level.bot_difficulty_defaults[var1];
    self.pers["bot_chosen_difficulty"] = propdeductflash(var2);
    level.deadgreen[var1] = (level.deadgreen[var1] + 1) % level.bot_difficulty_defaults.size;
  }

  return self.pers["bot_chosen_difficulty"];
}

function propdeductflash(var0) {
  if(var0 == "easy") {
    return "recruit";
  }

  if(var0 == "normal") {
    return "regular";
  }

  if(var0 == "hard") {
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

function bot_is_defending_point(var0) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, var0)) {
      return true;
    }
  }

  return false;
}

function bot_is_guarding_player(var0) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == var0) {
    return true;
  }

  return false;
}

function entrance_visible_from(var0, var1, var2) {
  var3 = (0, 0, 11);
  var4 = (0, 0, 40);
  var5 = undefined;

  if(var2 == "stand") {
    return 1;
  } else if(var2 == "crouch") {
    var5 = var4;
  } else if(var2 == "prone") {
    var5 = var3;
  }

  return sighttracepassed(var1 + var5, var0 + var5, 0, undefined);
}

function get_extended_path(var0, var1) {
  var2 = func_get_nodes_on_path(var0, var1);

  if(isDefined(var2)) {
    var2 = remove_ends_from_path(var2);
    var2 = get_all_connected_nodes(var2);
  }

  return var2;
}

function func_get_path_dist(var0, var1) {
  return getpathdist(var0, var1);
}

function func_get_nodes_on_path(var0, var1) {
  return getnodesonpath(var0, var1);
}

function func_bot_get_closest_navigable_point(var0, var1, var2) {
  return botgetclosestnavigablepoint(var0, var1, var2);
}

function node_is_on_path_from_labels(var0, var1) {
  if(!isDefined(self.on_path_from)) {
    return false;
  }

  if(isDefined(self.on_path_from[var0]) && isDefined(self.on_path_from[var0][var1]) && self.on_path_from[var0][var1]) {
    return true;
  }

  if(isDefined(self.on_path_from[var1]) && isDefined(self.on_path_from[var1][var0]) && self.on_path_from[var1][var0]) {
    return true;
  }

  return false;
}

function get_all_connected_nodes(var0) {
  var1 = var0;

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = getlinkednodes(var0[var2]);

    for(var4 = 0; var4 < var3.size; var4++) {
      if(!scripts\engine\utility::array_contains(var1, var3[var4])) {
        var1 = scripts\engine\utility::array_add(var1, var3[var4]);
      }
    }
  }

  return var1;
}

function get_visible_nodes_array(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(nodesvisible(var4, var1, 1)) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  return var2;
}

function remove_ends_from_path(var0) {
  var0[var0.size - 1] = undefined;
  var0[0] = undefined;
  return scripts\engine\utility::array_removeundefined(var0);
}

function bot_waittill_bots_enabled(var0) {
  while(!bot_bots_enabled_or_added(var0)) {
    wait 0.5;
  }
}

function bot_bots_enabled_or_added(var0) {
  if(botsystemstatus() != "off") {
    return true;
  }

  if(bots_exist(var0)) {
    return true;
  }

  return false;
}

function bot_waittill_out_of_combat_or_time(var0) {
  var1 = gettime();

  for(;;) {
    if(isDefined(var0)) {
      if(gettime() > var1 + var0) {
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

function bot_in_combat(var0) {
  if(self.last_enemy_sight_time == 0) {
    return false;
  }

  var1 = gettime() - self.last_enemy_sight_time;
  var2 = level.bot_out_of_combat_time;

  if(isDefined(var0)) {
    var2 = var0;
  }

  return var1 < var2;
}

function bot_waittill_goal_or_fail(var0, var1, var2, var3) {
  if(!isDefined(var1) && isDefined(var2)) {}

  if((!isDefined(var1) || !isDefined(var2)) && isDefined(var3)) {}

  var4 = ["goal", "bad_path", "no_path", "node_relinquished", "script_goal_changed"];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var4.size, var1);
  }

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var4.size, var2);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var4.size, var3);
  }

  if(isDefined(var0)) {
    var5 = scripts\engine\utility::waittill_any_in_array_or_timeout(var4, var0);
  } else {
    var5 = scripts\engine\utility::waittill_any_in_array_return(var5);
  }

  return var5;
}

function bot_usebutton_wait(var0, var1, var2) {
  level endon("game_ended");
  GscBinSkip4(0x35);
}

function use_button_stopped_notify(var0, var1) {
  self endon("stop_usebutton_watcher");
  wait 0.05;

  while(self useButtonPressed()) {
    wait 0.05;
  }

  self notify("use_button_no_longer_pressed");
}

function bots_exist(var0) {
  foreach(var2 in level.participants) {
    if(isai(var2)) {
      if(isDefined(var0) && var0) {
        if(!scripts\mp\utility\entity::isteamparticipant(var2)) {
          continue;
        }
      }

      return true;
    }
  }

  return false;
}

function bot_get_entrances_for_stance_and_index(var0, var1, var2) {
  if(!isDefined(level.entrance_points_finished_caching)) {
    return undefined;
  }

  if(isarray(var1)) {
    if(isDefined(var2) && var2) {
      var3 = undefined;
      var4 = 999999999;

      foreach(var6 in var1) {
        var7 = scripts\engine\utility::array_find(level.entrance_indices, var6);
        var8 = level.entrance_origin_points[var7];
        var9 = distancesquared(self.origin, var8);

        if(var9 < var4) {
          var3 = var6;
          var4 = var9;
        }
      }

      var1 = var3;
    } else {
      var1 = scripts\engine\utility::random(var1);
    }
  }

  var11 = level.entrance_points[var1];

  if(!isDefined(var0) || var0 == "stand") {
    return var11;
  } else if(var0 == "crouch") {
    var12 = [];

    foreach(var14 in var11) {
      if(var14.crouch_visible_from[var1]) {
        var12 = scripts\engine\utility::array_add(var12, var14);
      }
    }

    return var12;
  } else if(var12 == "prone") {
    var12 = [];

    foreach(var14 in var15) {
      if(var14.prone_visible_from[var13]) {
        var12 = scripts\engine\utility::array_add(var12, var14);
      }
    }

    return var12;
  }

  return undefined;
}

function bot_find_node_to_guard_player(var0, var1, var2) {
  var3 = undefined;
  var4 = self.bot_defend_player_guarding getvelocity();

  if(lengthsquared(var4) > 100) {
    var5 = getnodesinradius(var0, var1 * 1.75, var1 * 0.5, 500);
    var6 = [];
    var7 = vectorNormalize(var4);

    for(var8 = 0; var8 < var5.size; var8++) {
      var9 = vectorNormalize(var5[var8].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var9, var7) > 0.1) {
        var6 = var5[var8];
      }
    }
  } else {
    var6 = getnodesinradius(var1, var2, 0, 500);
  }

  if(isDefined(var3) && var3) {
    var10 = vectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    var11 = var6;
    var6 = [];

    foreach(var13 in var11) {
      var9 = vectorNormalize(var13.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var10, var9) > 0.2) {
        var6 = var13;
      }
    }
  }

  var15 = [];
  var16 = [];
  var17 = [];

  for(var8 = 0; var8 < var6.size; var8++) {
    var18 = distancesquared(var6[var8].origin, var1) > 10000;
    var19 = abs(var6[var8].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(var18) {
      var15 = var6[var8];
    }

    if(var19) {
      var16 = var6[var8];
    }

    if(var18 && var19) {
      var17 = var6[var8];
    }

    if(var8 % 100 == 99) {
      wait 0.05;
    }
  }

  if(var17.size > 0) {
    var4 = self botnodepick(var17, var17.size * 0.15, "node_capture", var1, undefined, self.defense_score_flags);
  }

  if(!isDefined(var4)) {
    wait 0.05;

    if(var16.size > 0) {
      var4 = self botnodepick(var16, var16.size * 0.15, "node_capture", var1, undefined, self.defense_score_flags);
    }

    if(!isDefined(var4) && var15.size > 0) {
      wait 0.05;
      var4 = self botnodepick(var15, var15.size * 0.15, "node_capture", var1, undefined, self.defense_score_flags);
    }
  }

  return var4;
}

function bot_find_node_to_capture_point(var0, var1, var2) {
  var3 = undefined;
  var4 = getnodesinradius(var0, var1, 0, 500);

  if(var4.size > 0) {
    var3 = self botnodepick(var4, var4.size * 0.15, "node_capture", var0, var2, self.defense_score_flags);
  }

  return var3;
}

function bot_find_node_to_capture_zone(var0, var1) {
  var2 = undefined;

  if(var0.size > 0) {
    var2 = self botnodepick(var0, var0.size * 0.15, "node_capture", undefined, var1, self.defense_score_flags);
  }

  return var2;
}

function bot_find_node_to_protect_zone(var0, var1) {
  var2 = undefined;

  if(var0.size > 0) {
    var2 = self botnodepick(var0, var0.size * 0.25, "node_capture", var1, undefined, self.defense_score_flags);
  }

  return var2;
}

function bot_find_node_that_protects_point(var0, var1) {
  var2 = undefined;
  var3 = getnodesinradius(var0, var1, 0, 500);

  if(var3.size > 0) {
    var2 = self botnodepick(var3, var3.size * 0.15, "node_protect", var0, self.defense_score_flags);
  }

  return var2;
}

function bot_pick_random_point_in_radius(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = getnodesinradius(var0, var1, 0, 500);

  if(isDefined(var6) && var6.size >= 2) {
    var5 = bot_find_random_midpoint(var6, var2);
  }

  if(!isDefined(var5)) {
    if(!isDefined(var3)) {
      var3 = 0;
    }

    if(!isDefined(var4)) {
      var4 = 1;
    }

    var7 = randomfloatrange(self.bot_defending_radius * var3, self.bot_defending_radius * var4);
    var8 = anglesToForward((0, randomint(360), 0));
    var5 = var0 + var8 * var7;
  }

  return var5;
}

function bot_pick_random_point_from_set(var0, var1, var2) {
  var3 = undefined;

  if(var1.size >= 2) {
    var3 = bot_find_random_midpoint(var1, var2);
  }

  if(!isDefined(var3)) {
    var4 = scripts\engine\utility::random(var1);
    var5 = var4.origin - var0;
    var3 = var0 + vectorNormalize(var5) * length(var5) * randomfloat(1);
  }

  return var3;
}

function bot_find_random_midpoint(var0, var1) {
  var2 = undefined;
  var3 = scripts\engine\utility::array_randomize(var0);

  for(var4 = 0; var4 < var3.size; var4++) {
    for(var5 = var4 + 1; var5 < var3.size; var5++) {
      var6 = var3[var4];
      var7 = var3[var5];

      if(nodesvisible(var6, var7, 1)) {
        var2 = ((var6.origin[0] + var7.origin[0]) * 0.5, (var6.origin[1] + var7.origin[1]) * 0.5, (var6.origin[2] + var7.origin[2]) * 0.5);

        if(isDefined(var1) && self[[var1]](var2) == 1) {
          return var2;
        }
      }
    }
  }

  return var2;
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
    var0 = 1;

    foreach(var2 in level.participants) {
      if(isalive(var2) && !istestclient(self, var2)) {
        var0 = 0;
      }
    }

    if(var0) {
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
  var0 = undefined;
  var1 = botmemoryflags("investigated", "killer_died");
  var2 = botmemoryflags("investigated");
  var3 = scripts\engine\utility::random(botgetmemoryevents(0, gettime() - 10000, 1, "death", var1, self));

  if(isDefined(var3)) {
    var0 = var3;
    self.bot_memory_goal_time = 10000;
  } else {
    var4 = undefined;

    if(self botgetscriptgoaltype() != "none") {
      var4 = self botgetscriptgoal();
    }

    var5 = botgetmemoryevents(0, gettime() - 45000, 1, "kill", var2, self);
    var6 = botgetmemoryevents(0, gettime() - 45000, 1, "death", var1, self);
    var3 = scripts\engine\utility::random(scripts\engine\utility::array_combine(var5, var6));

    if(isDefined(var3) > 0 && (!isDefined(var4) || distancesquared(var4, var3) > 1000000)) {
      var0 = var3;
      self.bot_memory_goal_time = 45000;
    }
  }

  if(isDefined(var0)) {
    var7 = getzonenearest(var0);
    var8 = getzonenearest(self.origin);

    if(isDefined(var7) && isDefined(var8) && var8 != var7) {
      var9 = botzonegetcount(var7, self.team, "ally") + botzonegetcount(var7, self.team, "path_ally");

      if(var9 > 1) {
        var0 = undefined;
      }
    }
  }

  if(isDefined(var0)) {
    self.bot_memory_goal = var0;
  }

  return var0;
}

function bot_draw_cylinder(var0, var1, var2, var3, var4, var5, var6, var7, var8) {}

function bot_draw_cylinder_think(var0, var1, var2, var3, var4, var5, var6, var7, var8) {}

function bot_draw_circle(var0, var1, var2, var3, var4) {}

function bot_get_total_gun_ammo() {
  var0 = 0;
  var1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var1 = self.weaponlist;
  } else {
    var1 = self getweaponslistprimaries();
  }

  foreach(var3 in var1) {
    var0 += self getweaponammoclip(var3);
    var0 += self getweaponammostock(var3);
  }

  return var0;
}

function bot_out_of_ammo() {
  var0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var0 = self.weaponlist;
  } else {
    var0 = self getweaponslistprimaries();
  }

  foreach(var2 in var0) {
    if(self getweaponammoclip(var2) > 0) {
      return false;
    }

    if(self getweaponammostock(var2) > 0) {
      return false;
    }
  }

  return true;
}

function bot_get_grenade_ammo() {
  var0 = 0;
  var1 = self getweaponslistoffhands();

  foreach(var3 in var1) {
    var0 += self getweaponammostock(var3);
  }

  return var0;
}

function deactivate_laser_from_struct(var0, var1) {
  switch (var0) {
    case "trap_directional":
      switch (var1.basename) {
        case "claymore_mp":
          return true;
      }

      break;
    case "trap":
      switch (var1.basename) {
        case "motion_sensor_mp":
        case "proximity_explosive_mp":
        case "at_mine_mp":
        case "trophy_mp":
          return true;
      }

      break;
    case "trap_follower":
      switch (var1.basename) {
        case "tracking_drone_mp":
          return true;
      }

      break;
    case "c4":
      switch (var1.basename) {
        case "c4_mp_p":
          return true;
      }

      break;
    case "tacticalinsertion":
      switch (var1.basename) {
        case "flare_mp":
          return true;
      }

      break;
  }

  return false;
}

function bot_watch_nodes(var0, var1, var2, var3, var4, var5, var6, var7) {
  self notify("bot_watch_nodes");
  self endon("bot_watch_nodes");
  self endon("bot_watch_nodes_stop");
  self endon("using_remote");
  self endon("death_or_disconnect");

  if(isDefined(var4)) {
    self endon(var4);
  }

  if(isDefined(var5)) {
    self endon(var5);
  }

  if(isDefined(var6)) {
    self endon(var6);
  }

  if(isDefined(var7)) {
    self endon(var7);
  }

  wait 0.5;
  var8 = 1;

  if(self isusingturret()) {
    var8 = 0;
  }

  var9 = squared(self botgetscriptgoalRadius());

  while(var8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < var9) {
        if(length(self getvelocity()) <= 1) {
          var8 = 0;
        }
      }
    }

    if(var8) {
      wait 0.05;
    }
  }

  var10 = self.origin;
  var11 = (0, 0, self getplayerviewheight());

  if(isDefined(var0)) {
    self.watch_nodes = [];

    foreach(var13 in var0) {
      var14 = 0;

      if(distance2dsquared(self.origin, var13.origin) <= 40) {
        var14 = 1;
      }

      var15 = self getEye();
      var16 = vectordot((0, 0, 1), vectorNormalize(var13.origin + var11 - var15));

      if(abs(var16) > 0.92) {
        var14 = 1;
      }

      if(!var14) {
        self.watch_nodes[self.watch_nodes.size] = var13;
      }
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }

  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);

  foreach(var13 in self.watch_nodes) {
    var13.watch_node_chance[self.entity_number] = 1;
    var13.watch_node_base_chance[self.entity_number] = 1;
  }

  var20 = [];

  for(var21 = 0;; var21++) {
    jumpiffalse(var21 < self.watch_nodes.size) LOC_00000253;
    var20 = [];
    var22 = vectorNormalize(self.watch_nodes[var21].origin - self.origin);

    for(var23 = 0; var23 < self.watch_nodes.size; var23++) {
      if(var21 == var23) {
        continue;
      }

      var24 = vectorNormalize(self.watch_nodes[var23].origin - self.origin);
      var25 = vectordot(var22, var24);

      if(var25 > 0.94) {
        var20 = scripts\engine\utility::array_add(var20[var21], var23);
      }
    }
  }

  for(;;) {
    var26 = -1;
    var27 = 0;

    for(var21 = 0; var21 < self.watch_nodes.size; var21++) {
      if(var20[var21].size > var27) {
        var26 = var21;
        var27 = var20[var21].size;
      }
    }

    if(var26 == -1) {
      break;
    }

    self.watch_nodes[var26].watch_node_chance[self.entity_number] = 0.5;
    self.watch_nodes[var26].watch_node_base_chance[self.entity_number] = 0.5;
    var20 = [];

    for(var21 = 0; var21 < var20.size; var21++) {
      if(scripts\engine\utility::array_contains(var20[var21], var26)) {
        var20 = scripts\engine\utility::array_remove(var20[var21], var26);
      }
    }
  }

  var28 = gettime();
  var29 = var28;
  var30 = [];
  var31 = undefined;

  if(isDefined(var1)) {
    var31 = (0, var1, 0);
  }

  var32 = isDefined(var31) && isDefined(var2);
  var33 = undefined;
  var34 = undefined;
  wait 0.1;

  for(;;) {
    var35 = gettime();
    self notify("still_watching_nodes");
    var36 = self botgetfovdot();

    if(isDefined(var3) && var35 >= var3) {
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

    if(isDefined(var34) && var34.watch_node_chance[self.entity_number] == 0) {
      var29 = var35;
    }

    if(self.watch_nodes.size > 0) {
      var37 = 0;

      if(isDefined(self.enemy)) {
        var38 = self lastknownpos(self.enemy);
        var39 = self lastknowntime(self.enemy);

        if(var39 && var35 - var39 < 5000) {
          var40 = vectorNormalize(var38 - self.origin);
          var41 = 0;

          for(var21 = 0; var21 < self.watch_nodes.size; var21++) {
            var42 = vectorNormalize(self.watch_nodes[var21].origin - self.origin);
            var25 = vectordot(var40, var42);

            if(var25 > var41) {
              var41 = var25;
              var34 = self.watch_nodes[var21];
              var37 = 1;
            }
          }
        }
      }

      if(!var37 && var35 >= var29) {
        var43 = [];

        for(var21 = 0; var21 < self.watch_nodes.size; var21++) {
          var13 = self.watch_nodes[var21];
          var44 = var13 getnodenumber();

          if(var32 && !scripts\engine\utility::within_fov(self.origin, var31, var13.origin, var2)) {
            continue;
          }

          if(distance2dsquared(self.origin, var13.origin) <= 10) {
            continue;
          }

          if(!isDefined(var30[var44])) {
            var30 = 0;
          }

          if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var13.origin, var36)) {
            var30 = var35;
          }

          for(var45 = 0; var45 < var43.size; var45++) {
            if(var30[var43[var45] getnodenumber()] > var30[var44]) {
              break;
            }
          }

          var43 = scripts\engine\utility::array_insert(var43, var13, var45);
        }

        var33 = var34;
        var34 = undefined;

        if(var43.size == 1) {
          var34 = var43[0];
        } else if(var43.size > 1) {
          var46 = [];
          var47 = 0;

          for(var21 = 0; var21 < var43.size; var21++) {
            var48 = 1 - var21 / (var43.size - 1) * 0.5;
            var49 = [var43[var21], var43[var21].watch_node_chance[self.entity_number] * var48];
            var46 = var49;
            var47 += var49[1];
          }

          var50 = randomfloat(var47);

          for(var21 = 0; var21 < var46.size; var21++) {
            if(var50 < var46[var21][1]) {
              var34 = var46[var21][0];
              break;
            }

            var50 -= var46[var21][1];
          }
        }

        if(isDefined(var34)) {
          var29 = var35 + randomintrange(3000, 5000);
          var51 = !isDefined(var33) || var33 != var34;

          if(var51 && istrue(self.bot_can_change_stance_while_watching_nodes)) {
            GscBinSkip4(0x35, var34);
          }
        }
      }

      if(isDefined(var34)) {
        var52 = var34.origin + var11;

        if(distance2dsquared(self.origin, var52) <= 10) {
          self botlookatpoint(undefined);
          var34 = undefined;
          var29 = 0;
        } else {
          self botlookatpoint(var52, 0.4, "script_search");
        }
      }
    }

    wait 0.2;
  }
}

function bot_handle_stance_for_look(var0) {
  if(isDefined(self.cur_defend_stance)) {
    var1 = self.cur_defend_stance;

    if(var1 == "prone" && self getstance() == "prone") {
      self botsetstance("crouch");
      wait 1;
    }

    if(var1 == "prone") {
      if(watch_nodes_visible_prone(self getnearestnode(), var0)) {
        self botsetstance("prone");
      } else {
        var1 = "crouch";
      }
    }

    if(var1 == "crouch") {
      if(watch_nodes_visible_crouch(self getnearestnode(), var0)) {
        self botsetstance("crouch");
      } else {
        var1 = "stand";
      }
    }

    if(var1 == "stand") {
      self botsetstance("stand");
      return;
    }

    return;
  }
}

function watch_nodes_visible_prone(var0, var1) {
  var2 = var1 getnodenumber();

  if(!isDefined(var0.pronevisiblenodes) || !isDefined(var0.pronevisiblenodes[var2])) {
    var3 = sighttracepassed(var0.origin + (0, 0, 11), var1.origin + (0, 0, 11), 0, undefined);
    var0.pronevisiblenodes[var2] = var3;
  }

  return var0.pronevisiblenodes[var2];
}

function watch_nodes_visible_crouch(var0, var1) {
  var2 = var1 getnodenumber();

  if(!isDefined(var0.pronevisiblenodes) || !isDefined(var0.pronevisiblenodes[var2])) {
    var3 = sighttracepassed(var0.origin + (0, 0, 40), var1.origin + (0, 0, 11), 0, undefined);
    var0.pronevisiblenodes[var2] = var3;
  }

  return var0.pronevisiblenodes[var2];
}

function watch_nodes_stop() {
  self notify("bot_watch_nodes_stop");

  if(isDefined(self.watch_nodes)) {
    foreach(var1 in self.watch_nodes) {
      watch_node_clear_data(var1);
    }
  }

  self.watch_nodes = undefined;
}

function watch_node_clear_data(var0) {
  var0.watch_node_chance[self.entity_number] = undefined;
  var0.watch_node_base_chance[self.entity_number] = undefined;
}

function watch_nodes_aborted() {
  self notify("watch_nodes_aborted");
  self endon("watch_nodes_aborted");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");

  for(;;) {
    var0 = scripts\engine\utility::ref_143b9(0.5, "still_watching_nodes");

    if(!isDefined(var0) || var0 != "still_watching_nodes") {
      thread watch_nodes_stop();
      return;
    }
  }
}

function bot_leader_dialog(var0, var1) {
  if(isDefined(var1) && var1 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var1, self botgetfovdot())) {
      var2 = self botpredictseepoint(var1);

      if(isDefined(var2)) {
        self botlookatpoint(var2 + (0, 0, 40), 1, "script_seek");
      }
    }

    self botmemoryevent("known_enemy", undefined, var1);
    return;
  }
}

function bot_get_known_attacker(var0, var1) {
  if(isDefined(var1) && isDefined(var1.classname)) {
    if(var1.classname == "grenade") {
      if(isDefined(var0) && var0.classname == "worldspawn") {
        return undefined;
      }

      if(!bot_ent_is_anonymous_mine(var1)) {
        return var0;
      }
    } else if(var1.classname == "rocket") {
      if(isDefined(var1.vehicle_fired_from)) {
        return var1.vehicle_fired_from;
      }

      if(isDefined(var1.type) && var1.type == "remote") {
        return var1;
      }

      if(isDefined(var1.owner)) {
        return var1.owner;
      }
    } else if(var1.classname == "worldspawn" || var1.classname == "trigger_hurt") {
      return undefined;
    }

    return var1;
  }

  return var0;
}

function bot_ent_is_anonymous_mine(var0) {
  var1 = var0.weapon_name;

  if(!isDefined(var1)) {
    var1 = var0.weaponname;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(issubstr(var1, "c4_mp_p")) {
    return true;
  }

  if(issubstr(var1, "claymore_mp")) {
    return true;
  }

  if(issubstr(var1, "mine_mp")) {
    return true;
  }

  if(issubstr(var1, "proximity_explosive_mp")) {
    return true;
  }

  return false;
}

function bot_vectors_are_equal(var0, var1) {
  return var0[0] == var1[0] && var0[1] == var1[1] && var0[2] == var1[2];
}

function bot_add_to_bot_level_targets(var0) {
  var0.high_priority_for = [];

  if(var0.bot_interaction_type == "use") {
    bot_add_to_bot_use_targets(var0);
    return;
  }

  if(var0.bot_interaction_type == "damage") {
    bot_add_to_bot_damage_targets(var0);
    return;
  }
}

function bot_remove_from_bot_level_targets(var0) {
  var0.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, var0);
}

function bot_add_to_bot_use_targets(var0) {
  if(!issubstr(var0.code_classname, "trigger_use")) {
    return;
  }

  if(!isDefined(var0.target)) {
    return;
  }

  if(isDefined(var0.bot_target)) {
    return;
  }

  if(!isDefined(var0.use_time)) {
    return;
  }

  var1 = getnodearray(var0.target, "targetname");

  if(var1.size != 1) {
    return;
  }

  var0.bot_target = var1[0];

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var0);
}

function bot_add_to_bot_damage_targets(var0) {
  if(!issubstr(var0.code_classname, "trigger_damage")) {
    return;
  }

  var1 = getnodearray(var0.target, "targetname");

  if(var1.size != 2) {
    return;
  }

  var0.bot_targets = var1;

  if(!isDefined(level.level_specific_bot_targets)) {
    level.level_specific_bot_targets = [];
  }

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var0);
}

function bot_get_string_index_for_integer(var0, var1) {
  var2 = 0;

  foreach(var4 in var0) {
    if(var2 == var1) {
      return var5;
    }

    var2++;
  }

  return undefined;
}

function bot_get_zones_within_dist(var0, var1) {
  for(var2 = 0; var2 < level.zonecount; var2++) {
    var3 = getzonenodeforindex(var2);
    var3.visited = 0;
  }

  var4 = getzonenodeforindex(var0);
  return bot_get_zones_within_dist_recurs(var4, var1);
}

function bot_get_zones_within_dist_recurs(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, getnodezone(var0));
}

function bot_get_max_players_on_team(var0) {
  return level.bot_max_players_on_team[var0];
}

function bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

function bot_get_client_limit() {
  var0 = getdvarint("OOTQKOTRM", 0);
  var0 = max(var0, getdvarint("ROMTTTNL", 0));

  if(var0 > level.maxclients) {
    return level.maxclients;
  }

  return var0;
}

function bot_queued_process_level_thread() {
  self notify("bot_queued_process_level_thread");
  self endon("bot_queued_process_level_thread");
  wait 0.05;

  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var0 = level.bot_queued_process_queue[0];

      if(isDefined(var0) && isDefined(var0.owner)) {
        var1 = undefined;

        if(isDefined(var0.parm4)) {
          var1 = var0.owner[[var0.func]](var0.parm1, var0.parm2, var0.parm3, var0.parm4);
        } else if(isDefined(var0.parm3)) {
          var1 = var0.owner[[var0.func]](var0.parm1, var0.parm2, var0.parm3);
        } else if(isDefined(var0.parm2)) {
          var1 = var0.owner[[var0.func]](var0.parm1, var0.parm2);
        } else if(isDefined(var0.parm1)) {
          var1 = var0.owner[[var0.func]](var0.parm1);
        } else {
          var1 = var0.owner[[var0.func]]();
        }

        var0.owner notify(var0.name_complete, var1);
      }

      var2 = [];

      for(var3 = 1; var3 < level.bot_queued_process_queue.size; var3++) {
        var2 = level.bot_queued_process_queue[var3];
      }

      level.bot_queued_process_queue = var2;
    }

    wait 0.05;
  }
}

function bot_queued_process(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.bot_queued_process_queue)) {
    level.bot_queued_process_queue = [];
  }

  foreach(var7 in level.bot_queued_process_queue) {
    if(var7.owner == self && var7.name == var0) {
      self notify(var7.name);
      level.bot_queued_process_queue[var8] = undefined;
    }
  }

  var7 = spawnStruct();
  var7.owner = self;
  var7.name = var0;
  var7.name_complete = var7.name + "_done";
  var7.func = var1;
  var7.parm1 = var2;
  var7.parm2 = var3;
  var7.parm3 = var4;
  var7.parm4 = var5;
  level.bot_queued_process_queue[level.bot_queued_process_queue.size] = var7;
  jumpiftrue(isDefined(level.bot_queued_process_level_thread_active)) LOC_000000e6;
  level.bot_queued_process_level_thread_active = 1;
  thread bot_queued_process_level_thread();
  self waittill(var7.name_complete, var9);
  return var9;
}

function bot_is_remote_or_linked() {
  return scripts\mp\utility\player::isusingremote() || self islinked();
}

function bot_get_low_on_ammo(var0) {
  var1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var1 = self.weaponlist;
  } else {
    var1 = self getweaponslistprimaries();
  }

  foreach(var3 in var1) {
    var4 = weaponclipsize(var3);
    var5 = self getweaponammostock(var3);

    if(var5 <= var4) {
      return true;
    }

    if(self getfractionmaxammo(var3) <= var0) {
      return true;
    }
  }

  return false;
}

function damagestatedata(var0) {
  var1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0) {
    var1 = self.weaponlist;
  } else {
    var1 = self getweaponslistprimaries();
  }

  var2 = 0;
  var3 = 0;

  foreach(var5 in var1) {
    var5.ref_11a53 = 0;
    var6 = weaponclipsize(var5);
    var7 = self getweaponammostock(var5);

    if(var7 <= var6 || self getfractionmaxammo(var5) <= var0) {
      var3++;
    }
  }

  if(var3 == var1.size) {
    var2 = 1;
  }

  return var2;
}

function bot_point_is_on_pathgrid(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 256;
  }

  if(!isDefined(var2)) {
    var2 = 72;
  }

  var3 = getclosestpointonnavmesh(var0);
  var4 = var3 - var0;

  if(length2dsquared(var4) > var1 * var1) {
    return false;
  }

  if(abs(var4[2]) > var2) {
    return false;
  }

  return true;
}

function bot_monitor_enemy_camp_spots(var0) {
  level endon("game_ended");
  self notify("bot_monitor_enemy_camp_spots");
  self endon("bot_monitor_enemy_camp_spots");
  level.enemy_camp_spots = [];
  level.enemy_camp_assassin_goal = [];
  level.enemy_camp_assassin = [];

  for(;;) {
    wait 1;
    var1 = [];

    if(!isDefined(var0)) {
      continue;
    }

    foreach(var3 in level.participants) {
      if(!isDefined(var3.team)) {
        continue;
      }

      if(var3[[var0]]() && !isDefined(var1[var3.team])) {
        level.enemy_camp_assassin[var3.team] = undefined;
        level.enemy_camp_spots[var3.team] = var3 botpredictenemycampspots(1);

        if(isDefined(level.enemy_camp_spots[var3.team])) {
          if(!isDefined(level.enemy_camp_assassin_goal[var3.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var3.team], level.enemy_camp_assassin_goal[var3.team])) {
            level.enemy_camp_assassin_goal[var3.team] = scripts\engine\utility::random(level.enemy_camp_spots[var3.team]);
          }

          if(isDefined(level.enemy_camp_assassin_goal[var3.team])) {
            var4 = [];

            foreach(var6 in level.participants) {
              if(!isDefined(var6.team)) {
                continue;
              }

              if(var6[[var0]]() && var6.team == var3.team) {
                var4 = var6;
              }
            }

            var4 = sortbydistance(var4, level.enemy_camp_assassin_goal[var3.team]);

            if(var4.size > 0) {
              level.enemy_camp_assassin[var3.team] = var4[0];
            }
          }
        }

        var1 = 1;
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

function bot_force_stance_for_time(var0, var1) {
  self notify("bot_force_stance_for_time");
  self endon("bot_force_stance_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetstance(var0);
  wait var1;
  self botsetstance("none");
}

function set_high_priority_target_for_bot(var0) {
  if(!(isDefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, var0))) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, var0);
    var0 notify("calculate_new_level_targets");
    return;
  }
}

function add_to_bot_use_targets(var0, var1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var0.use_time = var1;
    var0.bot_interaction_type = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var0);
    return;
  }
}

function remove_from_bot_use_targets(var0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var0);
    return;
  }
}

function add_to_bot_damage_targets(var0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var0.bot_interaction_type = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var0);
    return;
  }
}

function remove_from_bot_damage_targets(var0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var0);
    return;
  }
}

function notify_enemy_bots_bomb_used(var0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"])) {
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var0);
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

function client_is_dev_bot(var0) {
  if(!isbot(var0)) {
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

function damage_func(var0) {
  self notify("bot_disable_movement_for_time");
  self endon("bot_disable_movement_for_time");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botsetflag("disable_movement", 1);
  wait var0;
  self botsetflag("disable_movement", 0);
}

function playerwaitforprestreaming(var0) {
  var1 = tablelookupgetnumrows(var0);
  var2 = spawnStruct();
  var2.settings = [];
  var2.settings["recruit"] = [];
  var2.settings["regular"] = [];
  var2.settings["hardened"] = [];
  var2.settings["veteran"] = [];

  for(var3 = 0; var3 < var1; var3++) {
    var4 = tablelookupbyrow(var0, var3, 0);
    var2.settings["recruit"][var4] = spawnStruct();
    var2.settings["regular"][var4] = spawnStruct();
    var2.settings["hardened"][var4] = spawnStruct();
    var2.settings["veteran"][var4] = spawnStruct();
    var5 = tablelookupbyrow(var0, var3, 1);
    var2.settings["recruit"][var4] = var5;
    var6 = tablelookupbyrow(var0, var3, 2);
    var2.settings["regular"][var4] = var6;
    var7 = tablelookupbyrow(var0, var3, 3);
    var2.settings["hardened"][var4] = var7;
    var8 = tablelookupbyrow(var0, var3, 4);
    var2.settings["veteran"][var4] = var8;
  }

  return var2;
}

function debug_chopper_boss_combat(var0, var1) {
  if(!isDefined(var1)) {
    var1 = level.linked_brush;
  }

  var2 = var1.settings[var0];
  var3 = getarraykeys(var2);

  foreach(var5 in var3) {
    if(var5 == "burstFireType") {
      var6 = var1.settings[var0][var5];
    } else {
      var6 = float(var1.settings[var0][var5]);
    }

    self botsetdifficultysetting(var5, var6);
  }
}

function death_impulse(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = level.linked_brush;
  }

  var3 = var2.settings[var0];
  var4 = getarraykeys(var3);

  foreach(var6 in var4) {
    if(var6 != var1) {
      continue;
    }

    if(var6 == "burstFireType") {
      var7 = var2.settings[var0][var6];
    } else {
      var7 = float(var3.settings[var1][var8]);
    }

    self botsetdifficultysetting(var8, var7);
    return;
  }

  var7 = undefined;
}