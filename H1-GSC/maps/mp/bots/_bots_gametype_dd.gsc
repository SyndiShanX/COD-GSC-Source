/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_dd.gsc
**********************************************/

main() {
  setup_callbacks();
  bot_dd_start();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_dd_think;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

bot_dd_start() {
  setup_bot_dd();
}

setup_bot_dd() {
  maps\mp\bots\_bots_gametype_common::bot_setup_bombzone_bottargets();
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  var_0 = maps\mp\bots\_bots_gametype_common::bot_verify_and_cache_bombzones(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level.bombzones)
    var_2 thread maps\mp\bots\_bots_gametype_common::monitor_bombzone_control();

    thread bot_dd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
  }
}

bot_dd_think() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while (!isdefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self.current_bombzone = undefined;
  self.defuser_bad_path_counter = 0;

  for (;;) {
    wait 0.05;

    if(isdefined(self.current_bombzone) && !bombzone_is_active(self.current_bombzone)) {
      self.current_bombzone = undefined;
      bot_dd_clear_role();
    }

    if(maps\mp\_utility::inovertime())
      var_0 = level.bombzones[0].ownerteam != self.team;
    else
      var_0 = self.team == game["attackers"];

    if(var_0) {
      bot_pick_new_zone("attack");

      if(!isdefined(self.current_bombzone)) {
        continue;
      }
      bot_try_switch_attack_zone();
      bot_choose_attack_role();

      if(self.role == "sweep_zone") {
        if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
          var_1["min_goal_time"] = 2;
          var_1["max_goal_time"] = 4;
          var_1["override_origin_node"] = common_scripts\utility::random(self.current_bombzone.bottargets);
          maps\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, var_1);
        }
      } else if(self.role == "defend_zone") {
        if(!maps\mp\bots\_bots_util::bot_is_defending_point(level.ddbombmodel[self.current_bombzone.label].origin)) {
          var_1["score_flags"] = "strongly_avoid_center";
          maps\mp\bots\_bots_strategy::bot_protect_point(level.ddbombmodel[self.current_bombzone.label].origin, level.protect_radius, var_1);
        }
      } else if(self.role == "investigate_someone_using_bomb")
        investigate_someone_using_bomb();
      else if(self.role == "atk_bomber")
        plant_bomb();

      continue;
    }

    bot_pick_new_zone("defend");

    if(!isdefined(self.current_bombzone)) {
      continue;
    }
    bot_choose_defend_role();

    if(self.role == "defend_zone") {
      if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.current_bombzone.curorigin)) {
        var_1["score_flags"] = "strict_los";
        var_1["override_origin_node"] = common_scripts\utility::random(self.current_bombzone.bottargets);
        maps\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, var_1);
      }

      continue;
    }

    if(self.role == "investigate_someone_using_bomb") {
      investigate_someone_using_bomb();
      continue;
    }

    if(self.role == "defuser")
      defuse_bomb();
  }
}

notify_enemy_team_bomb_used(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::find_closest_bombzone_to_player(self);
  var_2 = maps\mp\bots\_bots_gametype_common::get_ai_hearing_bomb_plant_sound(var_0);

  foreach(var_4 in var_2) {
    if(isdefined(var_4.current_bombzone) && var_1 == var_4.current_bombzone)
      var_4 bot_dd_set_role("investigate_someone_using_bomb");
  }
}

plant_bomb() {
  self endon("change_role");
  var_0 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_plant_on(self.current_bombzone, 0);
  self botsetscriptgoal(var_0.origin, 0, "critical");
  var_1 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_1 == "goal") {
    var_2 = maps\mp\gametypes\_gamelogic::gettimeremaining();
    var_3 = var_2 - level.planttime * 2 * 1000;
    var_4 = gettime() + var_3;

    if(var_3 > 0)
      maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_3);

    var_5 = var_4 > 0 && gettime() >= var_4;
    var_6 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.planttime + 2, "bomb_planted", var_5);
    self botclearscriptgoal();

    if(var_6)
      bot_dd_clear_role();
  }
}

defuse_bomb() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  var_0 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_defuse_on(self.current_bombzone).origin;
  self botsetscriptgoal(var_0, 20, "critical");
  var_1 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_1 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for (;;) {
        var_2 = getnodesinradiussorted(var_0, 50, 0);
        var_3 = self.defuser_bad_path_counter - 4;

        if(var_2.size <= var_3) {
          var_4 = botgetclosestnavigablepoint(var_0, 50, self);

          if(isdefined(var_4))
            self botsetscriptgoal(var_4, 20, "critical");
          else
            break;
        } else
          self botsetscriptgoal(var_2[var_3].origin, 20, "critical");

        var_1 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

        if(var_1 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_1 == "goal") {
    var_5 = self.current_bombzone.waittime * 1000;
    var_6 = var_5 - level.defusetime * 2 * 1000;
    var_7 = gettime() + var_6;

    if(var_6 > 0)
      maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_6);

    var_8 = var_7 > 0 && gettime() >= var_7;
    var_9 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.defusetime + 2, "bomb_defused", var_8);

    if(!var_9 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    self botclearscriptgoal();

    if(var_9)
      bot_dd_clear_role();
  }
}

investigate_someone_using_bomb() {
  self endon("change_role");

  if(maps\mp\bots\_bots_util::bot_is_defending())
    maps\mp\bots\_bots_strategy::bot_defend_stop();

  self botsetscriptgoalnode(common_scripts\utility::random(self.current_bombzone.bottargets), "critical");
  var_0 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

  if(var_0 == "goal") {
    wait 2;
    bot_dd_clear_role();
  }
}

get_player_defusing_zone(var_0) {
  var_1 = get_players_at_zone(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isdefusing)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isdefined(var_3.role) && var_3.role == "defuser")
        return var_3;
    }
  }

  return undefined;
}

get_player_planting_zone(var_0) {
  var_1 = get_players_at_zone(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      if(var_3.isplanting)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(isai(var_3)) {
      if(isdefined(var_3.role) && var_3.role == "atk_bomber")
        return var_3;
    }
  }

  return undefined;
}

bombzone_is_active(var_0) {
  if(var_0.visibleteam == "any")
    return 1;

  return 0;
}

get_active_bombzones() {
  var_0 = [];

  foreach(var_2 in level.bombzones) {
    if(bombzone_is_active(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_players_at_zone(var_0, var_1) {
  var_2 = [];
  var_3 = maps\mp\bots\_bots_gametype_common::get_living_players_on_team(var_1);

  foreach(var_5 in var_3) {
    if(isai(var_5)) {
      if(isdefined(var_5.current_bombzone) && var_5.current_bombzone == var_0)
        var_2 = common_scripts\utility::array_add(var_2, var_5);

      continue;
    }

    if(distancesquared(var_5.origin, var_0.curorigin) < level.protect_radius * level.protect_radius)
      var_2 = common_scripts\utility::array_add(var_2, var_5);
  }

  return var_2;
}

bot_pick_dd_zone_with_fewer_defenders(var_0, var_1) {
  var_2[0] = get_players_at_zone(var_0[0], game["defenders"]).size;
  var_2[1] = get_players_at_zone(var_0[1], game["defenders"]).size;

  if(var_2[0] > var_2[1] + var_1)
    return var_0[1];
  else if(var_2[0] + var_1 < var_2[1])
    return var_0[0];
}

bot_pick_new_zone(var_0) {
  var_1 = undefined;

  if(var_0 == "attack")
    var_1 = bot_choose_attack_zone();
  else if(var_0 == "defend")
    var_1 = bot_choose_defend_zone();

  if(isdefined(var_1) && (!isdefined(self.current_bombzone) || self.current_bombzone != var_1)) {
    self.current_bombzone = var_1;
    bot_dd_clear_role();
  }
}

bot_choose_defend_zone() {
  var_0 = get_active_bombzones();
  var_1 = undefined;

  if(var_0.size == 1)
    var_1 = var_0[0];
  else if(var_0.size == 2) {
    var_2[0] = get_players_at_zone(var_0[0], game["defenders"]).size;
    var_2[1] = get_players_at_zone(var_0[1], game["defenders"]).size;
    var_3[0] = is_bomb_planted_on(var_0[0]);
    var_3[1] = is_bomb_planted_on(var_0[1]);

    if(var_3[0] && var_3[1] || !var_3[0] && !var_3[1]) {
      var_4 = 0;

      if(isdefined(self.current_bombzone))
        var_4 = 1;

      var_1 = bot_pick_dd_zone_with_fewer_defenders(var_0, var_4);

      if(!isdefined(var_1) && !isdefined(self.current_bombzone))
        var_1 = common_scripts\utility::random(var_0);
    } else if(var_3[0] || var_3[1]) {
      var_5 = common_scripts\utility::ter_op(var_3[0], 0, 1);
      var_6 = common_scripts\utility::ter_op(!var_3[0], 0, 1);

      if(var_2[var_5] > var_2[var_6] + 2)
        var_1 = var_0[var_6];
      else if(var_2[var_5] <= var_2[var_6])
        var_1 = var_0[var_5];
      else if(!isdefined(self.current_bombzone)) {
        if(var_2[var_5] >= var_2[var_6] + 2)
          var_1 = var_0[var_6];
        else if(var_2[var_5] < var_2[var_6] + 2)
          var_1 = var_0[var_5];
      }
    }
  }

  return var_1;
}

get_other_active_zone(var_0) {
  var_1 = get_active_bombzones();

  foreach(var_3 in var_1) {
    if(var_3 != var_0)
      return var_3;
  }
}

bot_choose_attack_zone() {
  if(isdefined(self.current_bombzone)) {
    return;
  }
  if(!isdefined(level.current_zone_target) || !bombzone_is_active(level.current_zone_target) || gettime() > level.next_target_switch_time) {
    level.next_target_switch_time = gettime() + 1000 * randomintrange(30, 45);
    level.current_zone_target = common_scripts\utility::random(get_active_bombzones());
  }

  if(!isdefined(level.current_zone_target)) {
    return;
  }
  var_0 = level.current_zone_target;
  var_1 = get_other_active_zone(var_0);
  self.current_bombzone = undefined;

  if(isdefined(var_1)) {
    if(randomfloat(1.0) < 0.25)
      return var_1;
  }

  return var_0;
}

bot_try_switch_attack_zone() {
  var_0 = get_other_active_zone(self.current_bombzone);

  if(isdefined(var_0)) {
    var_1 = distance(self.origin, self.current_bombzone.curorigin);
    var_2 = distance(self.origin, var_0.curorigin);

    if(var_2 < var_1 * 0.6)
      self.current_bombzone = var_0;
  }
}

bot_choose_attack_role() {
  if(isdefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb")
      return;
  }

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone))
    var_0 = "defend_zone";
  else {
    var_1 = get_player_planting_zone(self.current_bombzone);

    if(!isdefined(var_1) || var_1 == self)
      var_0 = "atk_bomber";
    else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "atk_bomber";
        var_1 bot_dd_clear_role();
      }
    }
  }

  if(!isdefined(var_0))
    var_0 = "sweep_zone";

  bot_dd_set_role(var_0);
}

bot_choose_defend_role() {
  if(isdefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb")
      return;
  }

  var_0 = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    var_1 = get_player_defusing_zone(self.current_bombzone);

    if(!isdefined(var_1) || var_1 == self)
      var_0 = "defuser";
    else if(isai(var_1)) {
      var_2 = distance(self.origin, self.current_bombzone.curorigin);
      var_3 = distance(var_1.origin, self.current_bombzone.curorigin);

      if(var_2 < var_3 * 0.9) {
        var_0 = "defuser";
        var_1 bot_dd_clear_role();
      }
    }
  }

  if(!isdefined(var_0))
    var_0 = "defend_zone";

  bot_dd_set_role(var_0);
}

bot_dd_set_role(var_0) {
  if(!isdefined(self.role) || self.role != var_0) {
    bot_dd_clear_role();
    self.role = var_0;
  }
}

bot_dd_clear_role() {
  self.role = undefined;
  self botclearscriptgoal();
  self botsetpathingstyle(undefined);
  maps\mp\bots\_bots_strategy::bot_defend_stop();
  self notify("change_role");
  self.defuser_bad_path_counter = 0;
}

bot_dd_ai_director_update() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  for (;;) {
    foreach(var_1 in level.bombzones) {
      foreach(var_3 in level.players) {
        if(isdefined(var_3.role) && isdefined(var_3.current_bombzone) && var_3.current_bombzone == var_1) {
          if(!bombzone_is_active(var_1)) {
            if(var_3.role == "atk_bomber" || var_3.role == "defuser")
              var_3 bot_dd_clear_role();

            continue;
          }

          if(is_bomb_planted_on(var_1)) {
            if(var_3.role == "atk_bomber")
              var_3 bot_dd_clear_role();
          }
        }
      }
    }

    wait 0.5;
  }
}

is_bomb_planted_on(var_0) {
  return maps\mp\_utility::is_true(var_0.bombplantedon);
}