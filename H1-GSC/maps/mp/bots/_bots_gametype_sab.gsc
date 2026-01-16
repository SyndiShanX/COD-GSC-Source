/***********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_sab.gsc
***********************************************/

main() {
  setup_callbacks();
  bot_sab_start();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_sab_think;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

bot_sab_start() {
  if(maps\mp\_utility::is_true(game["tiebreaker"])) {
    maps\mp\bots\_bots_gametype_war::main();
    return;
  }

  setup_bot_sab();
}

setup_bot_sab() {
  maps\mp\bots\_bots_gametype_common::bot_setup_bombzone_bottargets();
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  var_0 = maps\mp\bots\_bots_gametype_common::bot_verify_and_cache_bombzones(["_allies", "_axis"]);

  if(var_0) {
    foreach(var_2 in level.bombzones)
    var_2 thread maps\mp\bots\_bots_gametype_common::monitor_bombzone_control();

    level.protect_radius = 600;
    level.bot_gametype_precaching_done = 1;
  }
}

bot_sab_think() {
  self notify("bot_sab_think");
  self endon("bot_sab_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while (!isdefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  var_0 = undefined;
  var_1 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
  var_2 = (0, 0, 0);
  self.defuser_bad_path_counter = 0;

  for (;;) {
    wait 0.05;

    if(!level.bombplanted) {
      var_3 = bot_sab_get_bomb_carrier();

      if(!isdefined(var_3) || var_3.team == self.team)
        var_0 = undefined;

      if(!isdefined(var_3)) {
        if(maps\mp\bots\_bots_util::bot_is_defending())
          maps\mp\bots\_bots_strategy::bot_defend_stop();

        self botsetscriptgoal(level.sabbomb.curorigin, 16, "critical");
      } else if(var_3 == self) {
        var_4 = level.bombzones[common_scripts\utility::get_enemy_team(self.team)];
        clear_non_tactical_goal();
        plant_bomb(var_4);
      } else if(var_3.team == self.team) {
        if(!maps\mp\bots\_bots_util::bot_is_guarding_player(var_3)) {
          clear_non_tactical_goal();
          maps\mp\bots\_bots_strategy::bot_guard_player(var_3, 400);
        }
      } else if(gettime() > level.sabbomb.lastclaimtime) {
        var_5 = level.bombzones[self.team];

        if(!isdefined(var_0)) {
          var_6 = distance(self.origin, level.sabbomb.curorigin);
          var_7 = distance(self.origin, var_5.curorigin);

          if(randomfloat(1.0) < 0.75 || var_6 < var_7)
            var_0 = "hunt_carrier";
          else
            var_0 = "defend_zone";

          if(maps\mp\bots\_bots_util::bot_is_defending())
            maps\mp\bots\_bots_strategy::bot_defend_stop();

          clear_non_tactical_goal();
        }

        if(var_0 == "hunt_carrier") {
          if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(var_2, level.sabbomb.curorigin)) {
            var_2 = level.sabbomb.curorigin;
            var_8 = var_2 - (0, 0, 75);
            var_9 = var_1 && distance(var_8, var_5.curorigin) > level.protect_radius;

            if(var_9) {
              var_10 = undefined;
              var_11 = getnodesonpath(var_8, common_scripts\utility::random(var_5.bottargets).origin);

              if(isdefined(var_11) && var_11.size > 0)
                var_10 = var_11[int(var_11.size * randomfloatrange(0.25, 0.75))].origin;

              if(isdefined(var_10) && maps\mp\bots\_bots_personality::find_ambush_node(var_10, 512))
                self botsetscriptgoalnode(self.node_ambushing_from, "guard", self.ambush_yaw);
              else
                var_9 = 0;
            }

            if(!var_9)
              self botsetscriptgoal(var_8, 32, "guard");
          }
        } else if(var_0 == "defend_zone") {
          if(!bot_is_protecting_point(var_5.curorigin)) {
            var_12["score_flags"] = "strict_los";
            var_12["override_origin_node"] = common_scripts\utility::random(var_5.bottargets);
            maps\mp\bots\_bots_strategy::bot_protect_point(var_5.curorigin, level.protect_radius, var_12);
          }
        }
      }

      continue;
    }

    var_13 = bot_sab_get_zone_planted_on();

    if(var_13.ownerteam != self.team) {
      if(!bot_is_protecting_point(level.sabbomb.curorigin)) {
        var_12["score_flags"] = "strongly_avoid_center";
        maps\mp\bots\_bots_strategy::bot_protect_point(level.sabbomb.curorigin, level.protect_radius, var_12);
      }
    } else {
      var_14 = bot_sab_get_bomb_defuser();

      if(!isdefined(var_14))
        self.role = "defuser";
      else if(isai(var_14)) {
        var_15 = distance(self.origin, var_13.curorigin);
        var_16 = distance(var_14.origin, var_13.curorigin);

        if(var_15 < var_16 * 0.9) {
          self.role = "defuser";
          var_14 bot_sab_clear_role();
        }
      }

      if(isdefined(self.role) && self.role == "defuser")
        defuse_bomb(var_13);
      else if(!bot_is_protecting_point(var_13.curorigin)) {
        var_12["min_goal_time"] = 2;
        var_12["max_goal_time"] = 4;
        var_12["override_origin_node"] = common_scripts\utility::random(var_13.bottargets);
        maps\mp\bots\_bots_strategy::bot_protect_point(var_13.curorigin, level.protect_radius, var_12);
      }
    }
  }
}

get_round_end_time() {
  if(level.bombplanted)
    return level.defuseendtime;
  else
    return gettime() + maps\mp\gametypes\_gamelogic::gettimeremaining();
}

clear_non_tactical_goal() {
  if(self botgetscriptgoaltype() != "tactical")
    self botclearscriptgoal();
}

plant_bomb(var_0) {
  self endon("change_role");
  var_1 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_plant_on(var_0, 0);
  self botsetscriptgoal(var_1.origin, 0, "critical");
  var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_2 == "goal") {
    var_3 = get_round_end_time() - gettime();
    var_4 = var_3 - level.planttime * 2 * 1000;
    var_5 = gettime() + var_4;

    if(var_4 > 0)
      maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_4);

    var_6 = var_5 > 0 && gettime() >= var_5;
    var_7 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.planttime + 2, "bomb_planted", var_6);
    clear_non_tactical_goal();
  }
}

defuse_bomb(var_0) {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  var_1 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_defuse_on(var_0).origin;
  self botsetscriptgoal(var_1, 20, "critical");
  var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

  if(var_2 == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      for (;;) {
        var_3 = getnodesinradiussorted(var_1, 50, 0);
        var_4 = self.defuser_bad_path_counter - 4;

        if(var_3.size <= var_4) {
          var_5 = botgetclosestnavigablepoint(var_1, 50, self);

          if(isdefined(var_5))
            self botsetscriptgoal(var_5, 20, "critical");
          else
            break;
        } else
          self botsetscriptgoal(var_3[var_4].origin, 20, "critical");

        var_2 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined, "change_role");

        if(var_2 == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(var_2 == "goal") {
    var_6 = get_round_end_time() - gettime();
    var_7 = var_6 - level.defusetime * 2 * 1000;
    var_8 = gettime() + var_7;

    if(var_7 > 0)
      maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_7);

    var_9 = var_8 > 0 && gettime() >= var_8;
    var_10 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.defusetime + 2, "bomb_defused", var_9);

    if(!var_10 && self.defuser_bad_path_counter >= 4)
      self.defuser_bad_path_counter++;

    clear_non_tactical_goal();

    if(var_10)
      bot_sab_clear_role();
  }
}

bot_sab_clear_role() {
  self.role = undefined;
  clear_non_tactical_goal();
  self botsetpathingstyle(undefined);
  maps\mp\bots\_bots_strategy::bot_defend_stop();
  self notify("change_role");
  self.defuser_bad_path_counter = 0;
}

bot_is_protecting_point(var_0) {
  return maps\mp\bots\_bots_util::bot_is_protecting() && maps\mp\bots\_bots_util::bot_is_defending_point(var_0);
}

bot_sab_get_bomb_carrier() {
  foreach(var_1 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_1) && maps\mp\_utility::is_true(var_1.isbombcarrier))
      return var_1;
  }
}

bot_sab_get_bomb_defuser() {
  foreach(var_1 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_1) && !isai(var_1)) {
      if(var_1.isdefusing)
        return var_1;
    }
  }

  foreach(var_1 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_1) && isai(var_1)) {
      if(isdefined(var_1.role) && var_1.role == "defuser")
        return var_1;
    }
  }

  return undefined;
}

bot_sab_get_zone_planted_on() {
  foreach(var_1 in level.bombzones) {
    if(var_1.bombplantedon)
      return var_1;
  }
}

notify_enemy_team_bomb_used(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::get_ai_hearing_bomb_plant_sound(var_0);
  var_2 = maps\mp\bots\_bots_gametype_common::find_closest_bombzone_to_player(self);

  foreach(var_4 in var_1)
  var_4 thread investigate_someone_using_bomb(var_2);
}

investigate_someone_using_bomb(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(maps\mp\bots\_bots_util::bot_is_defending())
    maps\mp\bots\_bots_strategy::bot_defend_stop();

  self botsetscriptgoalnode(common_scripts\utility::random(var_0.bottargets), "critical");
  var_1 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();

  if(var_1 == "goal") {
    wait 2;
    clear_non_tactical_goal();
  }
}