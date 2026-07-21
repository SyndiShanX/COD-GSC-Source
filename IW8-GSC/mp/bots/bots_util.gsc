/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_util.gsc
***********************************************/

bot_get_nodes_in_cone(var_0, var_1, var_2, var_3) {
  var_4 = getnodesinradius(self.origin, var_1, var_0);
  var_5 = [];
  var_6 = self getnearestnode();
  var_7 = anglesToForward(self getplayerangles());
  var_8 = vectorNormalize(var_7 * (1, 1, 0));

  foreach(var_10 in var_4) {
    var_11 = vectorNormalize((var_10.origin - self.origin) * (1, 1, 0));
    var_12 = vectordot(var_11, var_8);

    if(var_12 > var_2) {
      if(!var_3 || isDefined(var_6) && nodesvisible(var_10, var_6, 1))
        var_5[var_5.size] = var_10;
    }
  }

  return var_5;
}

bot_goal_can_override(var_0, var_1) {
  if(var_0 == "_encstr_8BBA05185F8B99")
    return var_1 == "_encstr_8BBA05185F8B99";
  else if(var_0 == "_encstr_9ACC05B4156DF3")
    return var_1 == "_encstr_9ACC05B4156DF3" || var_1 == "_encstr_8BBA05185F8B99";
  else if(var_0 == "_encstr_AF2206AF7DE90BA7")
    return var_1 == "_encstr_AF2206AF7DE90BA7" || var_1 == "_encstr_9ACC05B4156DF3" || var_1 == "_encstr_8BBA05185F8B99";
  else if(var_0 == "_encstr_9A2B0A12F03587575B7BBEA5")
    return var_1 == "_encstr_9A2B0A12F03587575B7BBEA5" || var_1 == "_encstr_AF2206AF7DE90BA7" || var_1 == "_encstr_9ACC05B4156DF3" || var_1 == "_encstr_8BBA05185F8B99";
  else if(var_0 == "_encstr_99CC09DA9020C4ECD149AD")
    return var_1 == "_encstr_99CC09DA9020C4ECD149AD" || var_1 == "_encstr_9A2B0A12F03587575B7BBEA5" || var_1 == "_encstr_AF2206AF7DE90BA7" || var_1 == "_encstr_9ACC05B4156DF3" || var_1 == "_encstr_8BBA05185F8B99";
  else if(var_0 == "_encstr_99C209E34FC743616118AB")
    return 1;
}

bot_set_personality(var_0) {
  self botsetpersonality(var_0);
  scripts\mp\bots\bots_personality::bot_assign_personality_functions();
  self botclearscriptgoal();
}

bot_set_difficulty(var_0, var_1) {
  if(var_0 == "_encstr_8B1608EC43B8D647A113")
    var_0 = bot_choose_difficulty_for_default();

  var_3 = self botgetdifficulty();
  self botsetdifficulty(var_0);

  if(isPlayer(self) && var_3 != var_0) {
    self.pers["_encstr_851207B317B203FA5A"] = get_rank_xp_for_bot();
    scripts\mp\rank::playerupdaterank();
  }
}

bot_choose_difficulty_for_default() {
  if(!isDefined(level.bot_difficulty_defaults)) {
    level.bot_difficulty_defaults = [];

    if(level.rankedmatch) {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "_encstr_820E07FAE8780B3A4C";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "_encstr_83CC051A163991";
    } else {
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "_encstr_A260053D1AE31B";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "_encstr_820E07FAE8780B3A4C";
      level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "_encstr_83CC051A163991";
    }
  }

  if(!isDefined(level.deadgreen))
    level.deadgreen = [];

  if(!isDefined(level.deadgreen["_encstr_9A8507BA4040188D08"]))
    level.deadgreen["_encstr_9A8507BA4040188D08"] = 0;

  if(!isDefined(level.deadgreen["_encstr_8E8405EA382B2A"]))
    level.deadgreen["_encstr_8E8405EA382B2A"] = 0;

  if(!isDefined(level.deadgreen["_encstr_AF1904A7F929"]))
    level.deadgreen["_encstr_AF1904A7F929"] = 0;

  if(!isDefined(self.pers["_encstr_A23916C62DB34F81805F40F8739F397BFA17CBDE038AD10A"])) {
    var_0 = undefined;

    if(level.teambased) {
      var_1 = self.team;

      if(!isDefined(var_1))
        var_1 = self.bot_team;

      if(!isDefined(var_1))
        var_1 = self.pers["_encstr_8AEF05472BC2D6"];
    } else
      var_1 = "_encstr_AF1904A7F929";

    var_0 = level.deadgreen[var_1];
    var_2 = level.bot_difficulty_defaults[var_0];
    self.pers["_encstr_A23916C62DB34F81805F40F8739F397BFA17CBDE038AD10A"] = propdeductflash(var_2);
    level.deadgreen[var_1] = (level.deadgreen[var_1] + 1) % level.bot_difficulty_defaults.size;
  }

  return self.pers["_encstr_A23916C62DB34F81805F40F8739F397BFA17CBDE038AD10A"];
}

propdeductflash(var_0) {
  if(var_0 == "_encstr_A260053D1AE31B")
    return "_encstr_889F0893CA6CC9BA2D8E";
  else if(var_0 == "_encstr_820E07FAE8780B3A4C")
    return "_encstr_813008928DA89D31A8CA";
  else if(var_0 == "_encstr_83CC051A163991")
    return scripts\engine\utility::random(["_encstr_A7D409342C272359DC59C8", "_encstr_BAAF081BD348D7E299C8"]);
  else {}
}

bot_is_capturing() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "_encstr_95EB0866891B23FB85B3" || self.bot_defending_type == "_encstr_9B6F0DD8B0078E5739567DD3BD37CA")
      return 1;
  }

  return 0;
}

bot_is_patrolling() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "_encstr_96080730D8534E0A28")
      return 1;
  }

  return 0;
}

bot_is_protecting() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "_encstr_AF08083BAA57988D729B" || self.bot_defending_type == "_encstr_860B0DE1722558457FAB0E9222730D")
      return 1;
  }

  return 0;
}

bot_is_bodyguarding() {
  if(bot_is_defending()) {
    if(self.bot_defending_type == "_encstr_ADA30A13DE32CB76572CE432")
      return 1;
  }

  return 0;
}

bot_is_defending() {
  return isDefined(self.bot_defending);
}

bot_is_defending_point(var_0) {
  if(bot_is_defending()) {
    if(bot_vectors_are_equal(self.bot_defending_center, var_0))
      return 1;
  }

  return 0;
}

bot_is_guarding_player(var_0) {
  if(bot_is_bodyguarding() && self.bot_defend_player_guarding == var_0)
    return 1;

  return 0;
}

entrance_visible_from(var_0, var_1, var_2) {
  var_3 = (0, 0, 11);
  var_4 = (0, 0, 40);
  var_5 = undefined;

  if(var_2 == "_encstr_A5AD069B231F0BAF")
    return 1;
  else if(var_2 == "_encstr_B13D076BED70539F23")
    var_5 = var_4;
  else if(var_2 == "_encstr_922406F1A6FD5E05")
    var_5 = var_3;

  return sighttracepassed(var_1 + var_5, var_0 + var_5, 0, undefined);
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
  if(!isDefined(self.on_path_from))
    return 0;

  if(isDefined(self.on_path_from[var_0]) && isDefined(self.on_path_from[var_0][var_1]) && self.on_path_from[var_0][var_1])
    return 1;

  if(isDefined(self.on_path_from[var_1]) && isDefined(self.on_path_from[var_1][var_0]) && self.on_path_from[var_1][var_0])
    return 1;

  return 0;
}

get_all_connected_nodes(var_0) {
  var_1 = var_0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = getlinkednodes(var_0[var_2]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(!scripts\engine\utility::array_contains(var_1, var_3[var_4]))
        var_1 = scripts\engine\utility::array_add(var_1, var_3[var_4]);
    }
  }

  return var_1;
}

get_visible_nodes_array(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(nodesvisible(var_4, var_1, 1))
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  return var_2;
}

remove_ends_from_path(var_0) {
  var_0[var_0.size - 1] = undefined;
  var_0[0] = undefined;
  return scripts\engine\utility::array_removeundefined(var_0);
}

bot_waittill_bots_enabled(var_0) {
  while(!bot_bots_enabled_or_added(var_0))
    wait 0.5;
}

bot_bots_enabled_or_added(var_0) {
  if(botsystemstatus() != "_encstr_BA19049F4B2D")
    return 1;

  if(bots_exist(var_0))
    return 1;

  return 0;
}

bot_waittill_out_of_combat_or_time(var_0) {
  var_1 = gettime();

  for(;;) {
    if(isDefined(var_0)) {
      if(gettime() > var_1 + var_0)
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

bot_in_combat(var_0) {
  if(self.last_enemy_sight_time == 0)
    return 0;

  var_1 = gettime() - self.last_enemy_sight_time;
  var_2 = level.bot_out_of_combat_time;

  if(isDefined(var_0))
    var_2 = var_0;

  return var_1 < var_2;
}

bot_waittill_goal_or_fail(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) && isDefined(var_2)) {}

  if((!isDefined(var_1) || !isDefined(var_2)) && isDefined(var_3)) {}

  var_4 = ["_encstr_8B7205D9ED5958", "_encstr_86E5092BA829F7AB738DA4", "_encstr_866D08B0C561870B03FB", "_encstr_A3BE12E0F55418981BD79183E373D530FB8C0939", "_encstr_93F9149BD8C92DC18ED7B3EDB0D8BE6C0DB0E6ECB28C"];

  if(isDefined(var_1))
    var_4[var_4.size] = var_1;

  if(isDefined(var_2))
    var_4[var_4.size] = var_2;

  if(isDefined(var_3))
    var_4[var_4.size] = var_3;

  if(isDefined(var_0))
    var_5 = scripts\engine\utility::waittill_any_in_array_or_timeout(var_4, var_0);
  else
    var_5 = scripts\engine\utility::waittill_any_in_array_return(var_4);

  return var_5;
}

bot_usebutton_wait(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  childthread use_button_stopped_notify();
  var_3 = scripts\engine\utility::_id_143BC(var_0, var_1, var_2, "_encstr_B1021D93A3E097E2055163177D386AEF89E88DDDD9086209DF352F6F6FDD12", "_encstr_A12F0D50C70E70BFD21775906B1BEB");
  self notify("_encstr_B6CD17373AED07FAD5E659C4BA1DD1F637FADD2C3A1B43594E");
  return var_3;
}

use_button_stopped_notify(var_0, var_1) {
  self endon("_encstr_B6CD17373AED07FAD5E659C4BA1DD1F637FADD2C3A1B43594E");
  wait 0.05;

  while(self useButtonPressed())
    wait 0.05;

  self notify("_encstr_B1021D93A3E097E2055163177D386AEF89E88DDDD9086209DF352F6F6FDD12");
}

bots_exist(var_0) {
  foreach(var_2 in level.participants) {
    if(isai(var_2)) {
      if(isDefined(var_0) && var_0) {
        if(!scripts\mp\utility\entity::isteamparticipant(var_2))
          continue;
      }

      return 1;
    }
  }

  return 0;
}

bot_get_entrances_for_stance_and_index(var_0, var_1, var_2) {
  if(!isDefined(level.entrance_points_finished_caching))
    return undefined;

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
    } else
      var_1 = scripts\engine\utility::random(var_1);
  }

  var_11 = level.entrance_points[var_1];

  if(!isDefined(var_0) || var_0 == "_encstr_A5AD069B231F0BAF")
    return var_11;
  else if(var_0 == "_encstr_B13D076BED70539F23") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14.crouch_visible_from[var_1])
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
    }

    return var_12;
  } else if(var_0 == "_encstr_922406F1A6FD5E05") {
    var_12 = [];

    foreach(var_14 in var_11) {
      if(var_14.prone_visible_from[var_1])
        var_12 = scripts\engine\utility::array_add(var_12, var_14);
    }

    return var_12;
  }

  return undefined;
}

bot_find_node_to_guard_player(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = self.bot_defend_player_guarding getvelocity();

  if(lengthsquared(var_4) > 100) {
    var_5 = getnodesinradius(var_0, var_1 * 1.75, var_1 * 0.5, 500);
    var_6 = [];
    var_7 = vectorNormalize(var_4);

    for(var_8 = 0; var_8 < var_5.size; var_8++) {
      var_9 = vectorNormalize(var_5[var_8].origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_9, var_7) > 0.1)
        var_6[var_6.size] = var_5[var_8];
    }
  } else
    var_6 = getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_2) && var_2) {
    var_10 = vectorNormalize(self.bot_defend_player_guarding.origin - self.origin);
    var_11 = var_6;
    var_6 = [];

    foreach(var_13 in var_11) {
      var_9 = vectorNormalize(var_13.origin - self.bot_defend_player_guarding.origin);

      if(vectordot(var_10, var_9) > 0.2)
        var_6[var_6.size] = var_13;
    }
  }

  var_15 = [];
  var_16 = [];
  var_17 = [];

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    var_18 = distancesquared(var_6[var_8].origin, var_0) > 10000;
    var_19 = abs(var_6[var_8].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;

    if(var_18)
      var_15[var_15.size] = var_6[var_8];

    if(var_19)
      var_16[var_16.size] = var_6[var_8];

    if(var_18 && var_19)
      var_17[var_17.size] = var_6[var_8];

    if(var_8 % 100 == 99)
      wait 0.05;
  }

  if(var_17.size > 0)
    var_3 = self botnodepick(var_17, var_17.size * 0.15, "_encstr_A26D0DDD50ED01B167612BF95515EA", var_0, undefined, self.defense_score_flags);

  if(!isDefined(var_3)) {
    wait 0.05;

    if(var_16.size > 0)
      var_3 = self botnodepick(var_16, var_16.size * 0.15, "_encstr_A26D0DDD50ED01B167612BF95515EA", var_0, undefined, self.defense_score_flags);

    if(!isDefined(var_3) && var_15.size > 0) {
      wait 0.05;
      var_3 = self botnodepick(var_15, var_15.size * 0.15, "_encstr_A26D0DDD50ED01B167612BF95515EA", var_0, undefined, self.defense_score_flags);
    }
  }

  return var_3;
}

bot_find_node_to_capture_point(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = getnodesinradius(var_0, var_1, 0, 500);

  if(var_4.size > 0)
    var_3 = self botnodepick(var_4, var_4.size * 0.15, "_encstr_A26D0DDD50ED01B167612BF95515EA", var_0, var_2, self.defense_score_flags);

  return var_3;
}

bot_find_node_to_capture_zone(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0)
    var_2 = self botnodepick(var_0, var_0.size * 0.15, "_encstr_A26D0DDD50ED01B167612BF95515EA", undefined, var_1, self.defense_score_flags);

  return var_2;
}

bot_find_node_to_protect_zone(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0)
    var_2 = self botnodepick(var_0, var_0.size * 0.25, "_encstr_A26D0DDD50ED01B167612BF95515EA", var_1, undefined, self.defense_score_flags);

  return var_2;
}

bot_find_node_that_protects_point(var_0, var_1) {
  var_2 = undefined;
  var_3 = getnodesinradius(var_0, var_1, 0, 500);

  if(var_3.size > 0)
    var_2 = self botnodepick(var_3, var_3.size * 0.15, "_encstr_AAF90D354088CD51A77D2F5B4BC62B", var_0, self.defense_score_flags);

  return var_2;
}

bot_pick_random_point_in_radius(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = getnodesinradius(var_0, var_1, 0, 500);

  if(isDefined(var_6) && var_6.size >= 2)
    var_5 = bot_find_random_midpoint(var_6, var_2);

  if(!isDefined(var_5)) {
    if(!isDefined(var_3))
      var_3 = 0;

    if(!isDefined(var_4))
      var_4 = 1;

    var_7 = randomfloatrange(self.bot_defending_radius * var_3, self.bot_defending_radius * var_4);
    var_8 = anglesToForward((0, randomint(360), 0));
    var_5 = var_0 + var_8 * var_7;
  }

  return var_5;
}

bot_pick_random_point_from_set(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.size >= 2)
    var_3 = bot_find_random_midpoint(var_1, var_2);

  if(!isDefined(var_3)) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = var_4.origin - var_0;
    var_3 = var_0 + vectorNormalize(var_5) * length(var_5) * randomfloat(1.0);
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
        var_2 = ((var_6.origin[0] + var_7.origin[0]) * 0.5, (var_6.origin[1] + var_7.origin[1]) * 0.5, (var_6.origin[2] + var_7.origin[2]) * 0.5);

        if(isDefined(var_1) && self[[var_1]](var_2) == 1)
          return var_2;
      }
    }
  }

  return var_2;
}

defend_valid_center() {
  if(isDefined(self.bot_defending_override_origin_node))
    return self.bot_defending_override_origin_node.origin;
  else if(isDefined(self.bot_defending_center))
    return self.bot_defending_center;

  return undefined;
}

bot_allowed_to_use_killstreaks() {
  if(!istrue(level.allowkillstreaks))
    return 0;

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

  if(scripts\mp\utility\game::getgametypenumlives() > 0) {
    var_0 = 1;

    foreach(var_2 in level.participants) {
      if(isalive(var_2) && !istestclient(self, var_2))
        var_0 = 0;
    }

    if(var_0)
      return 0;
  }

  if(istrue(self.debug_forest_combat))
    return 0;

  if(!bot_in_combat(500))
    return 1;

  if(!isalive(self.enemy))
    return 1;

  return 0;
}

bot_recent_point_of_interest() {
  var_0 = undefined;
  var_1 = botmemoryflags("_encstr_969E0D96E6B3CA9B8E96EC2C3A5623", "_encstr_AF990C9A11FA1423723951680B92");
  var_2 = botmemoryflags("_encstr_969E0D96E6B3CA9B8E96EC2C3A5623");
  var_3 = scripts\engine\utility::random(botgetmemoryevents(0, gettime() - 10000, 1, "_encstr_AD75063D571AE108", var_1, self));

  if(isDefined(var_3)) {
    var_0 = var_3;
    self.bot_memory_goal_time = 10000;
  } else {
    var_4 = undefined;

    if(self botgetscriptgoaltype() != "_encstr_8BBA05185F8B99")
      var_4 = self botgetscriptgoal();

    var_5 = botgetmemoryevents(0, gettime() - 45000, 1, "_encstr_ABD70578F3D02C", var_2, self);
    var_6 = botgetmemoryevents(0, gettime() - 45000, 1, "_encstr_AD75063D571AE108", var_1, self);
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
      var_9 = botzonegetcount(var_7, self.team, "_encstr_AD830516C68DE5") + botzonegetcount(var_7, self.team, "_encstr_B2220A380BD1D0AF588DC6F2");

      if(var_9 > 1)
        var_0 = undefined;
    }
  }

  if(isDefined(var_0))
    self.bot_memory_goal = var_0;

  return var_0;
}

bot_draw_cylinder(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

bot_draw_cylinder_think(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

bot_draw_circle(var_0, var_1, var_2, var_3, var_4) {}

bot_get_total_gun_ammo() {
  var_0 = 0;
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_1 = self.weaponlist;
  else
    var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 = var_0 + self getweaponammoclip(var_3);
    var_0 = var_0 + self getweaponammostock(var_3);
  }

  return var_0;
}

bot_out_of_ammo() {
  var_0 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_0 = self.weaponlist;
  else
    var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2) > 0)
      return 0;

    if(self getweaponammostock(var_2) > 0)
      return 0;
  }

  return 1;
}

bot_get_grenade_ammo() {
  var_0 = 0;
  var_1 = self getweaponslistoffhands();

  foreach(var_3 in var_1)
  var_0 = var_0 + self getweaponammostock(var_3);

  return var_0;
}

deactivate_laser_from_struct(var_0, var_1) {
  switch (var_0) {
    case "_encstr_ADE71199DB51118FEA4A767BAAA4AB852D2E44":
      switch (var_1.basename) {
        case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
          return 1;
      }

      break;
    case "_encstr_85EF050C9D7062":
      switch (var_1.basename) {
        case "_encstr_ABC111DAF6D14BDB9BBEB9B2CDE6BD9CF56B07":
        case "_encstr_96D117C193B71E4BB5A547BCF5CA1E83C6BD37A59D56FA5B38":
        case "_encstr_81430B218B3F7018458997D78A":
        case "_encstr_92EA0A290B32FF88A90170EB":
          return 1;
      }

      break;
    case "_encstr_83E30EE8E42CC1F5CCDE8DC6B7EE56E4":
      switch (var_1.basename) {
        case "_encstr_BDEE121336D322733050B74F180B3FBAA3D8DD8A":
          return 1;
      }

      break;
    case "_encstr_8B07036CD0":
      switch (var_1.basename) {
        case "_encstr_9AAE0876FCB7603101DB":
          return 1;
      }

      break;
    case "_encstr_A18312AC2BC2345017F8FB82F6FB896A14333FE3":
      switch (var_1.basename) {
        case "_encstr_B635099C3C8FEDFB88E9EB":
          return 1;
      }

      break;
  }

  return 0;
}

bot_watch_nodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("_encstr_8C661089321310BBEEC46F71C715F845FF6B");
  self endon("_encstr_8C661089321310BBEEC46F71C715F845FF6B");
  self endon("_encstr_95F2151237532153F0848E30710542EC27074146CB70DA");
  self endon("_encstr_86070DEB73A488448FCB4970221B0D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_4))
    self endon(var_4);

  if(isDefined(var_5))
    self endon(var_5);

  if(isDefined(var_6))
    self endon(var_6);

  if(isDefined(var_7))
    self endon(var_7);

  wait 0.5;
  var_8 = 1;

  if(self isusingturret())
    var_8 = 0;

  var_9 = squared(self botgetscriptgoalRadius());

  while(var_8) {
    if(self bothasscriptgoal() && self botpursuingscriptgoal()) {
      if(distancesquared(self botgetscriptgoal(), self.origin) < var_9) {
        if(length(self getvelocity()) <= 1)
          var_8 = 0;
      }
    }

    if(var_8)
      wait 0.05;
  }

  var_10 = self.origin;
  var_11 = (0, 0, self getplayerviewheight());

  if(isDefined(var_0)) {
    self.watch_nodes = [];

    foreach(var_13 in var_0) {
      var_14 = 0;

      if(distance2dsquared(self.origin, var_13.origin) <= 40)
        var_14 = 1;

      var_15 = self getEye();
      var_16 = vectordot((0, 0, 1), vectorNormalize(var_13.origin + var_11 - var_15));

      if(abs(var_16) > 0.92)
        var_14 = 1;

      if(!var_14)
        self.watch_nodes[self.watch_nodes.size] = var_13;
    }
  }

  if(!isDefined(self.watch_nodes)) {
    return;
  }
  thread watch_nodes_aborted();
  self.watch_nodes = scripts\engine\utility::array_randomize(self.watch_nodes);

  foreach(var_13 in self.watch_nodes) {
    var_13.watch_node_chance[self.entity_number] = 1.0;
    var_13.watch_node_base_chance[self.entity_number] = 1.0;
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

      if(var_25 > 0.94)
        var_20[var_21] = scripts\engine\utility::array_add(var_20[var_21], var_23);
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
    var_20[var_26] = [];

    for(var_21 = 0; var_21 < var_20.size; var_21++) {
      if(scripts\engine\utility::array_contains(var_20[var_21], var_26))
        var_20[var_21] = scripts\engine\utility::array_remove(var_20[var_21], var_26);
    }
  }

  var_28 = gettime();
  var_29 = var_28;
  var_30 = [];
  var_31 = undefined;

  if(isDefined(var_1))
    var_31 = (0, var_1, 0);

  var_32 = isDefined(var_31) && isDefined(var_2);
  var_33 = undefined;
  var_34 = undefined;
  wait 0.1;

  for(;;) {
    var_35 = gettime();
    self notify("_encstr_85B41516B498AC71E673729516402CB0A0D98BA8B9C74E");
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

    if(isDefined(var_34) && var_34.watch_node_chance[self.entity_number] == 0.0)
      var_29 = var_35;

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
          if(!isDefined(var_30[var_44]))
            var_30[var_44] = 0;

          if(scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_13.origin, var_36))
            var_30[var_44] = var_35;

          for(var_45 = 0; var_45 < var_43.size; var_45++) {
            if(var_30[var_43[var_45] getnodenumber()] > var_30[var_44]) {
              break;
            }
          }

          var_43 = scripts\engine\utility::array_insert(var_43, var_13, var_45);
        }

        var_33 = var_34;
        var_34 = undefined;

        if(var_43.size == 1)
          var_34 = var_43[0];
        else if(var_43.size > 1) {
          var_46 = [];
          var_47 = 0;

          for(var_21 = 0; var_21 < var_43.size; var_21++) {
            var_48 = 1.0 - var_21 / (var_43.size - 1) * 0.5;
            var_49 = [var_43[var_21], var_43[var_21].watch_node_chance[self.entity_number] * var_48];
            var_46[var_46.size] = var_49;
            var_47 = var_47 + var_49[1];
          }

          var_50 = randomfloat(var_47);

          for(var_21 = 0; var_21 < var_46.size; var_21++) {
            if(var_50 < var_46[var_21][1]) {
              var_34 = var_46[var_21][0];
              break;
            }

            var_50 = var_50 - var_46[var_21][1];
          }
        }

        if(isDefined(var_34)) {
          var_29 = var_35 + randomintrange(3000, 5000);
          var_51 = !isDefined(var_33) || var_33 != var_34;

          if(var_51 && istrue(self.bot_can_change_stance_while_watching_nodes))
            childthread bot_handle_stance_for_look(var_34);
        }
      }

      if(isDefined(var_34)) {
        var_52 = var_34.origin + var_11;

        if(distance2dsquared(self.origin, var_52) <= 10) {
          self botlookatpoint(undefined);
          var_34 = undefined;
          var_29 = 0;
        } else
          self botlookatpoint(var_52, 0.4, "_encstr_87DC0E4B639368ABD51153431A439EE1");
      }
    }

    wait 0.2;
  }
}

bot_handle_stance_for_look(var_0) {
  if(isDefined(self.cur_defend_stance)) {
    var_1 = self.cur_defend_stance;

    if(var_1 == "_encstr_922406F1A6FD5E05" && self getstance() == "_encstr_922406F1A6FD5E05") {
      self botsetstance("_encstr_B13D076BED70539F23");
      wait 1.0;
    }

    if(var_1 == "_encstr_922406F1A6FD5E05") {
      if(watch_nodes_visible_prone(self getnearestnode(), var_0))
        self botsetstance("_encstr_922406F1A6FD5E05");
      else
        var_1 = "_encstr_B13D076BED70539F23";
    }

    if(var_1 == "_encstr_B13D076BED70539F23") {
      if(watch_nodes_visible_crouch(self getnearestnode(), var_0))
        self botsetstance("_encstr_B13D076BED70539F23");
      else
        var_1 = "_encstr_A5AD069B231F0BAF";
    }

    if(var_1 == "_encstr_A5AD069B231F0BAF")
      self botsetstance("_encstr_A5AD069B231F0BAF");
  }
}

watch_nodes_visible_prone(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0.pronevisiblenodes) || !isDefined(var_0.pronevisiblenodes[var_2])) {
    var_3 = sighttracepassed(var_0.origin + (0, 0, 11), var_1.origin + (0, 0, 11), 0, undefined);
    var_0.pronevisiblenodes[var_2] = var_3;
  }

  return var_0.pronevisiblenodes[var_2];
}

watch_nodes_visible_crouch(var_0, var_1) {
  var_2 = var_1 getnodenumber();

  if(!isDefined(var_0.pronevisiblenodes) || !isDefined(var_0.pronevisiblenodes[var_2])) {
    var_3 = sighttracepassed(var_0.origin + (0, 0, 40), var_1.origin + (0, 0, 11), 0, undefined);
    var_0.pronevisiblenodes[var_2] = var_3;
  }

  return var_0.pronevisiblenodes[var_2];
}

watch_nodes_stop() {
  self notify("_encstr_95F2151237532153F0848E30710542EC27074146CB70DA");

  if(isDefined(self.watch_nodes)) {
    foreach(var_1 in self.watch_nodes)
    watch_node_clear_data(var_1);
  }

  self.watch_nodes = undefined;
}

watch_node_clear_data(var_0) {
  var_0.watch_node_chance[self.entity_number] = undefined;
  var_0.watch_node_base_chance[self.entity_number] = undefined;
}

watch_nodes_aborted() {
  self notify("_encstr_847414EE1647C6D0AF9BB7912BDC7DB04CB7271D2B23");
  self endon("_encstr_847414EE1647C6D0AF9BB7912BDC7DB04CB7271D2B23");
  self endon("_encstr_95F2151237532153F0848E30710542EC27074146CB70DA");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 = scripts\engine\utility::_id_143B9(0.5, "_encstr_85B41516B498AC71E673729516402CB0A0D98BA8B9C74E");

    if(!isDefined(var_0) || var_0 != "_encstr_85B41516B498AC71E673729516402CB0A0D98BA8B9C74E") {
      thread watch_nodes_stop();
      return;
    }
  }
}

bot_leader_dialog(var_0, var_1) {
  if(isDefined(var_1) && var_1 != (0, 0, 0)) {
    if(!scripts\engine\utility::within_fov(self.origin, self getplayerangles(), var_1, self botgetfovdot())) {
      var_2 = self botpredictseepoint(var_1);

      if(isDefined(var_2))
        self botlookatpoint(var_2 + (0, 0, 40), 1.0, "_encstr_8A700CB9C627D2C1E8EB9B2B2BDA");
    }

    self botmemoryevent("_encstr_BD560CF2309FE383DE9D4645A122", undefined, var_1);
  }
}

bot_get_known_attacker(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.classname)) {
    if(var_1.classname == "_encstr_8C8D08671D451291C849") {
      if(isDefined(var_0) && var_0.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0")
        return undefined;

      if(!bot_ent_is_anonymous_mine(var_1))
        return var_0;
    } else if(var_1.classname == "_encstr_8D8A07F05F6987BF4B") {
      if(isDefined(var_1.vehicle_fired_from))
        return var_1.vehicle_fired_from;

      if(isDefined(var_1.type) && var_1.type == "_encstr_A1530723371D084D2A")
        return var_1;

      if(isDefined(var_1.owner))
        return var_1.owner;
    } else if(var_1.classname == "_encstr_BD4E0B7B104D6AD4DB384717A0" || var_1.classname == "_encstr_85FE0DD5727A27098513298817CA23")
      return undefined;

    return var_1;
  }

  return var_0;
}

bot_ent_is_anonymous_mine(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1))
    var_1 = var_0.weaponname;

  if(!isDefined(var_1))
    return 0;

  if(issubstr(var_1, "_encstr_9AAE0876FCB7603101DB"))
    return 1;

  if(issubstr(var_1, "_encstr_ACC40CC1F8A321601715CFBFE0EA"))
    return 1;

  if(issubstr(var_1, "_encstr_AD4B08D64B37ACD7D60E"))
    return 1;

  if(issubstr(var_1, "_encstr_96D117C193B71E4BB5A547BCF5CA1E83C6BD37A59D56FA5B38"))
    return 1;

  return 0;
}

bot_vectors_are_equal(var_0, var_1) {
  return var_0[0] == var_1[0] && var_0[1] == var_1[1] && var_0[2] == var_1[2];
}

bot_add_to_bot_level_targets(var_0) {
  var_0.high_priority_for = [];

  if(var_0.bot_interaction_type == "_encstr_AB19049D0FC0")
    bot_add_to_bot_use_targets(var_0);
  else if(var_0.bot_interaction_type == "_encstr_B2BE0788BAF573592F")
    bot_add_to_bot_damage_targets(var_0);
  else {}
}

bot_remove_from_bot_level_targets(var_0) {
  var_0.already_used = 1;
  level.level_specific_bot_targets = scripts\engine\utility::array_remove(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_use_targets(var_0) {
  if(!issubstr(var_0.code_classname, "_encstr_AFF60C939B634707C80DAF8DE720")) {
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
  var_1 = getnodearray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size != 1) {
    return;
  }
  var_0.bot_target = var_1[0];

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_0);
}

bot_add_to_bot_damage_targets(var_0) {
  if(!issubstr(var_0.code_classname, "_encstr_A68E0FE89CB4ECCEACE4EB190BB52CB3B2")) {
    return;
  }
  var_1 = getnodearray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_1.size != 2) {
    return;
  }
  var_0.bot_targets = var_1;

  if(!isDefined(level.level_specific_bot_targets))
    level.level_specific_bot_targets = [];

  level.level_specific_bot_targets = scripts\engine\utility::array_add(level.level_specific_bot_targets, var_0);
}

bot_get_string_index_for_integer(var_0, var_1) {
  var_2 = 0;

  foreach(var_5, var_4 in var_0) {
    if(var_2 == var_1)
      return var_5;

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

bot_get_max_players_on_team(var_0) {
  return level.bot_max_players_on_team[var_0];
}

bot_get_team_limit() {
  return int(bot_get_client_limit() / 2);
}

bot_get_client_limit() {
  var_0 = getdvarint("_encstr_87750A3D9EA82A699EA24953", 0);
  var_0 = max(var_0, getdvarint("_encstr_A6E609E995B709BF998E59", 0));

  if(var_0 > level.maxclients)
    return level.maxclients;

  return var_0;
}

bot_queued_process_level_thread() {
  self notify("_encstr_8696206E1850AFFB5D2B0F470110B3DAE0E127B233B15472343353B759A35B0548A9");
  self endon("_encstr_8696206E1850AFFB5D2B0F470110B3DAE0E127B233B15472343353B759A35B0548A9");
  wait 0.05;

  for(;;) {
    if(isDefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0) {
      var_0 = level.bot_queued_process_queue[0];

      if(isDefined(var_0) && isDefined(var_0.owner)) {
        var_1 = undefined;

        if(isDefined(var_0.parm4))
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3, var_0.parm4);
        else if(isDefined(var_0.parm3))
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2, var_0.parm3);
        else if(isDefined(var_0.parm2))
          var_1 = var_0.owner[[var_0.func]](var_0.parm1, var_0.parm2);
        else if(isDefined(var_0.parm1))
          var_1 = var_0.owner[[var_0.func]](var_0.parm1);
        else
          var_1 = var_0.owner[[var_0.func]]();

        var_0.owner notify(var_0.name_complete, var_1);
      }

      var_2 = [];

      for(var_3 = 1; var_3 < level.bot_queued_process_queue.size; var_3++)
        var_2[var_3 - 1] = level.bot_queued_process_queue[var_3];

      level.bot_queued_process_queue = var_2;
    }

    wait 0.05;
  }
}

bot_queued_process(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.bot_queued_process_queue))
    level.bot_queued_process_queue = [];

  foreach(var_8, var_7 in level.bot_queued_process_queue) {
    if(var_7.owner == self && var_7.name == var_0) {
      self notify(var_7.name);
      level.bot_queued_process_queue[var_8] = undefined;
    }
  }

  var_7 = spawnStruct();
  var_7.owner = self;
  var_7.name = var_0;
  var_7.name_complete = var_7.name + "_encstr_8BC7060775B84D3B";
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
  return scripts\mp\utility\player::isusingremote() || self islinked();
}

bot_get_low_on_ammo(var_0) {
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_1 = self.weaponlist;
  else
    var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = weaponclipsize(var_3);
    var_5 = self getweaponammostock(var_3);

    if(var_5 <= var_4)
      return 1;

    if(self getfractionmaxammo(var_3) <= var_0)
      return 1;
  }

  return 0;
}

damagestatedata(var_0) {
  var_1 = undefined;

  if(isDefined(self.weaponlist) && self.weaponlist.size > 0)
    var_1 = self.weaponlist;
  else
    var_1 = self getweaponslistprimaries();

  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_5._id_11A53 = 0;
    var_6 = weaponclipsize(var_5);
    var_7 = self getweaponammostock(var_5);

    if(var_7 <= var_6 || self getfractionmaxammo(var_5) <= var_0)
      var_3++;
  }

  if(var_3 == var_1.size)
    var_2 = 1;

  return var_2;
}

bot_point_is_on_pathgrid(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 256;

  if(!isDefined(var_2))
    var_2 = 72;

  var_3 = getclosestpointonnavmesh(var_0);
  var_4 = var_3 - var_0;

  if(length2dsquared(var_4) > var_1 * var_1)
    return 0;

  if(abs(var_4[2]) > var_2)
    return 0;

  return 1;
}

bot_monitor_enemy_camp_spots(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_ACF71DB5CF33D810EF1DA01B45DA490D2A4F330B772A9F2828B9EB936DA470");
  self endon("_encstr_ACF71DB5CF33D810EF1DA01B45DA490D2A4F330B772A9F2828B9EB936DA470");
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
          if(!isDefined(level.enemy_camp_assassin_goal[var_3.team]) || !scripts\engine\utility::array_contains(level.enemy_camp_spots[var_3.team], level.enemy_camp_assassin_goal[var_3.team]))
            level.enemy_camp_assassin_goal[var_3.team] = scripts\engine\utility::random(level.enemy_camp_spots[var_3.team]);

          if(isDefined(level.enemy_camp_assassin_goal[var_3.team])) {
            var_4 = [];

            foreach(var_6 in level.participants) {
              if(!isDefined(var_6.team)) {
                continue;
              }
              if(var_6[[var_0]]() && var_6.team == var_3.team)
                var_4[var_4.size] = var_6;
            }

            var_4 = sortbydistance(var_4, level.enemy_camp_assassin_goal[var_3.team]);

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

  if(self.team == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  if(!isalive(self))
    return 0;

  if(!scripts\mp\utility\entity::isaiteamparticipant(self))
    return 0;

  if(!isDefined(self.personality) || self.personality == "_encstr_B892078D2C5BE05927")
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
    self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team], 128, "_encstr_9A2B0A12F03587575B7BBEA5", undefined, 256);
    bot_waittill_goal_or_fail();
  }
}

bot_force_stance_for_time(var_0, var_1) {
  self notify("_encstr_BD271A11AA8BF860953A87F36FFAB8BFBBC2493EA20FA6716B0993FB");
  self endon("_encstr_BD271A11AA8BF860953A87F36FFAB8BFBBC2493EA20FA6716B0993FB");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botsetstance(var_0);
  wait(var_1);
  self botsetstance("_encstr_8BBA05185F8B99");
}

set_high_priority_target_for_bot(var_0) {
  if(!(isDefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, var_0))) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, var_0);
    var_0 notify("_encstr_A3D51C1BC263B15D8D851DB27DB92BBBEB63B2CE59D8FAA35893B395D1DC");
  }
}

add_to_bot_use_targets(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_84491A98DE3A37FA2C3246AFE87BD78D95CE2B63BE1D1693D9CAA39B"])) {
    var_0.use_time = var_1;
    var_0.bot_interaction_type = "_encstr_AB19049D0FC0";
    [[level.bot_funcs["_encstr_84491A98DE3A37FA2C3246AFE87BD78D95CE2B63BE1D1693D9CAA39B"]]](var_0);
  }
}

remove_from_bot_use_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_B2381F42885DA7B9E0B3EDE77DB0712B86200A1970BDFB6F28DF0CF14DF8872BAE"]))
    [[level.bot_funcs["_encstr_B2381F42885DA7B9E0B3EDE77DB0712B86200A1970BDFB6F28DF0CF14DF8872BAE"]]](var_0);
}

add_to_bot_damage_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_84491A98DE3A37FA2C3246AFE87BD78D95CE2B63BE1D1693D9CAA39B"])) {
    var_0.bot_interaction_type = "_encstr_B2BE0788BAF573592F";
    [[level.bot_funcs["_encstr_84491A98DE3A37FA2C3246AFE87BD78D95CE2B63BE1D1693D9CAA39B"]]](var_0);
  }
}

remove_from_bot_damage_targets(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_B2381F42885DA7B9E0B3EDE77DB0712B86200A1970BDFB6F28DF0CF14DF8872BAE"]))
    [[level.bot_funcs["_encstr_B2381F42885DA7B9E0B3EDE77DB0712B86200A1970BDFB6F28DF0CF14DF8872BAE"]]](var_0);
}

notify_enemy_bots_bomb_used(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_93391C9BEDA34B33F2AF5637565B5EEB4CDEA3B9AF4C7BD6267D5D6E2B91"]))
    self[[level.bot_funcs["_encstr_93391C9BEDA34B33F2AF5637565B5EEB4CDEA3B9AF4C7BD6267D5D6E2B91"]]](var_0);
}

get_rank_xp_for_bot() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_A143108E65FB0759D57B590817E610CFE34A"]))
    return self[[level.bot_funcs["_encstr_A143108E65FB0759D57B590817E610CFE34A"]]]();
}

bot_israndom() {
  return self botisrandomized();
}

client_is_dev_bot(var_0) {
  if(!isbot(var_0))
    return 0;

  if(!dev_spawning_bots())
    return 0;

  return 1;
}

dev_spawning_bots() {
  return 0;
}

damage_func(var_0) {
  self notify("_encstr_9AA51E26BD1DEB462DCD0B898D56BE5BBD67CAB5CA37A3F5CCED39D7A3D2DACA");
  self endon("_encstr_9AA51E26BD1DEB462DCD0B898D56BE5BBD67CAB5CA37A3F5CCED39D7A3D2DACA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 1);
  wait(var_0);
  self botsetflag("_encstr_A7921191D29BC2268DCAF56BB7B3B2DA9537D1", 0);
}

playerwaitforprestreaming(var_0) {
  var_1 = tablelookupgetnumrows(var_0);
  var_2 = spawnStruct();
  var_2.settings = [];
  var_2.settings["_encstr_889F0893CA6CC9BA2D8E"] = [];
  var_2.settings["_encstr_813008928DA89D31A8CA"] = [];
  var_2.settings["_encstr_A7D409342C272359DC59C8"] = [];
  var_2.settings["_encstr_BAAF081BD348D7E299C8"] = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = tablelookupbyrow(var_0, var_3, 0);
    var_2.settings["_encstr_889F0893CA6CC9BA2D8E"][var_4] = spawnStruct();
    var_2.settings["_encstr_813008928DA89D31A8CA"][var_4] = spawnStruct();
    var_2.settings["_encstr_A7D409342C272359DC59C8"][var_4] = spawnStruct();
    var_2.settings["_encstr_BAAF081BD348D7E299C8"][var_4] = spawnStruct();
    var_5 = tablelookupbyrow(var_0, var_3, 1);
    var_2.settings["_encstr_889F0893CA6CC9BA2D8E"][var_4] = var_5;
    var_6 = tablelookupbyrow(var_0, var_3, 2);
    var_2.settings["_encstr_813008928DA89D31A8CA"][var_4] = var_6;
    var_7 = tablelookupbyrow(var_0, var_3, 3);
    var_2.settings["_encstr_A7D409342C272359DC59C8"][var_4] = var_7;
    var_8 = tablelookupbyrow(var_0, var_3, 4);
    var_2.settings["_encstr_BAAF081BD348D7E299C8"][var_4] = var_8;
  }

  return var_2;
}

debug_chopper_boss_combat(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level.linked_brush;

  var_2 = var_1.settings[var_0];
  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3) {
    if(var_5 == "_encstr_AB180E8A03783223D4D0235A9FA3EB6F")
      var_6 = var_1.settings[var_0][var_5];
    else
      var_6 = float(var_1.settings[var_0][var_5]);

    self botsetdifficultysetting(var_5, var_6);
  }
}

death_impulse(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = level.linked_brush;

  var_3 = var_2.settings[var_0];
  var_4 = getarraykeys(var_3);

  foreach(var_6 in var_4) {
    if(var_6 != var_1) {
      continue;
    }
    if(var_6 == "_encstr_AB180E8A03783223D4D0235A9FA3EB6F")
      var_7 = var_2.settings[var_0][var_6];
    else
      var_7 = float(var_2.settings[var_0][var_6]);

    self botsetdifficultysetting(var_6, var_7);
    return;
  }
}