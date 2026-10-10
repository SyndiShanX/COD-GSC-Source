/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_dd.gsc
***************************************************/

#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\game;
#namespace bots_gametype_dd;

function main() {
  setup_callbacks();
  bot_dd_start();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_dd_think;
  level.bot_funcs["notify_enemy_bots_bomb_used"] = &notify_enemy_team_bomb_used;

  level.var_904de0754f390c72 = &function_b6dcc7c53780923c;
}

function bot_dd_start() {
  thread function_6cffc65203b4d521();

  setup_bot_dd();
}

function setup_bot_dd() {
  bot_setup_objective_bottargets();
  bot_waittill_bots_enabled();
  succeeded = bot_verify_and_cache_bombzones(["_a", "_b"]);

  if(succeeded) {
    foreach(bombzone in level.objectives) {
      bombzone thread monitor_bombzone_control();
    }

    thread bot_dd_ai_director_update();
    level.bot_gametype_precaching_done = 1;
  }
}

function function_b6dcc7c53780923c(label, trigger) {
  trigger_origin = trigger.origin;
  tempstruct = spawnStruct();
  tempstruct.trigger = trigger;
  bot_setup_bot_targets([tempstruct]);
  wait 1;

  if(!isDefined(trigger)) {
    if(!isDefined(level.extra_bomb_zones)) {
      level.extra_bomb_zones = [];
    }

    level.extra_bomb_zones[level.extra_bomb_zones.size] = tempstruct;

    if(tempstruct.bottargets.size < 3) {
      start_time = gettime();
      bot_waittill_bots_enabled();
      time_elapsed = gettime() - start_time / 1000;

      if(time_elapsed < 5) {
        wait 5 - time_elapsed;
      }

      assertmsg("<dev string:x1c>" + label + "<dev string:x2a>" + trigger_origin + "<dev string:x3c>");
    }
  }
}

function bot_dd_think() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self.current_bombzone = undefined;
  self.defuser_bad_path_counter = 0;

  for(;;) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    wait 0.05;

    if(isDefined(self.current_bombzone) && !bombzone_is_active(self.current_bombzone)) {
      self.current_bombzone = undefined;
      bot_dd_clear_role();
    }

    if(inovertime()) {
      assert(level.objectives.size == 1);
      is_attacker = level.objectives["_a"].ownerteam != self.team;
    } else {
      is_attacker = self.team == game["attackers"];
    }

    if(is_attacker) {
      bot_pick_new_zone("attack");

      if(!isDefined(self.current_bombzone)) {
        continue;
      }

      bot_try_switch_attack_zone();
      bot_choose_attack_role();

      if(self.role == "sweep_zone") {
        if(!bot_is_defending_point(self.current_bombzone.curorigin)) {
          optional_params["min_goal_time"] = 2;
          optional_params["max_goal_time"] = 4;
          optional_params["override_origin_node"] = random(self.current_bombzone.bottargets);
          bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, optional_params);
        }
      } else if(self.role == "defend_zone") {
        if(!bot_is_defending_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin)) {
          optional_params["score_flags"] = "strongly_avoid_center";
          bot_protect_point(level.ddbombmodel[self.current_bombzone.objectivekey].origin, level.protect_radius, optional_params);
        }
      } else if(self.role == "investigate_someone_using_bomb") {
        investigate_someone_using_bomb();
      } else if(self.role == "atk_bomber") {
        plant_bomb();
      }

      continue;
    }

    bot_pick_new_zone("defend");

    if(!isDefined(self.current_bombzone)) {
      continue;
    }

    bot_choose_defend_role();

    if(self.role == "defend_zone") {
      if(!bot_is_defending_point(self.current_bombzone.curorigin)) {
        optional_params["score_flags"] = "strict_los";
        optional_params["override_origin_node"] = random(self.current_bombzone.bottargets);
        bot_protect_point(self.current_bombzone.curorigin, level.protect_radius, optional_params);
      }

      continue;
    }

    if(self.role == "investigate_someone_using_bomb") {
      investigate_someone_using_bomb();
      continue;
    }

    if(self.role == "defuser") {
      defuse_bomb();
    }
  }
}

function notify_enemy_team_bomb_used(type) {
  var_78477ecdee5f9959 = find_closest_bombzone_to_player(self);
  players = get_ai_hearing_bomb_plant_sound(type);

  foreach(player in players) {
    if(isDefined(player.current_bombzone) && var_78477ecdee5f9959 == player.current_bombzone) {
      player bot_dd_set_role("investigate_someone_using_bomb");
    }
  }
}

function plant_bomb() {
  self endon("change_role");
  assert(isDefined(self.current_bombzone));
  var_735fd56db96f509c = get_bombzone_node_to_plant_on(self.current_bombzone, 0);
  self botsetscriptgoal(var_735fd56db96f509c.origin, 0, "critical");
  pathresult = bot_waittill_goal_or_fail(undefined, "change_role");

  if(pathresult == "goal") {
    time_left = scripts\mp\gamelogic::gettimeremaining();
    var_87e36bcbd7af1d56 = time_left - level.planttime * 2 * 1000;
    var_d77e04d8d7105bb0 = gettime() + var_87e36bcbd7af1d56;

    if(var_87e36bcbd7af1d56 > 0) {
      bot_waittill_out_of_combat_or_time(var_87e36bcbd7af1d56);
    }

    var_5b45d81d67839650 = var_d77e04d8d7105bb0 > 0 && gettime() >= var_d77e04d8d7105bb0;
    succeeded = bombzone_press_use(level.planttime + 2, "bomb_planted", var_5b45d81d67839650);
    self botclearscriptgoal();

    if(succeeded) {
      bot_dd_clear_role();
    }
  }
}

function defuse_bomb() {
  self endon("change_role");
  self botsetpathingstyle("scripted");
  assert(isDefined(self.current_bombzone));
  var_2fea4b3d4aab8868 = get_bombzone_node_to_defuse_on(self.current_bombzone).origin;
  self botsetscriptgoal(var_2fea4b3d4aab8868, 20, "critical");
  pathresult = bot_waittill_goal_or_fail(undefined, "change_role");

  if(pathresult == "bad_path") {
    self.defuser_bad_path_counter++;

    if(self.defuser_bad_path_counter >= 4) {
      while(true) {
        nodes = getnodesinradiussorted(var_2fea4b3d4aab8868, 50, 0);
        potential_index = self.defuser_bad_path_counter - 4;

        if(nodes.size <= potential_index) {
          closest_point = botgetclosestnavigablepoint(var_2fea4b3d4aab8868, 50, self);

          if(isDefined(closest_point)) {
            self botsetscriptgoal(closest_point, 20, "critical");
          } else {
            break;
          }
        } else {
          self botsetscriptgoal(nodes[potential_index].origin, 20, "critical");
        }

        pathresult = bot_waittill_goal_or_fail(undefined, "change_role");

        if(pathresult == "bad_path") {
          self.defuser_bad_path_counter++;
          continue;
        }

        break;
      }
    }
  }

  if(pathresult == "goal") {
    time_passed = gettime() - self.current_bombzone.startbombtime;
    time_left = level.bombtimer * 1000 - time_passed;
    var_bae7d7b60ce8ffc3 = time_left - level.defusetime * 2 * 1000;
    var_bb36f4158262888d = gettime() + var_bae7d7b60ce8ffc3;

    if(var_bae7d7b60ce8ffc3 > 0) {
      bot_waittill_out_of_combat_or_time(var_bae7d7b60ce8ffc3);
    }

    var_8759dc70176704ad = var_bb36f4158262888d > 0 && gettime() >= var_bb36f4158262888d;
    succeeded = bombzone_press_use(level.defusetime + 2, "bomb_defused", var_8759dc70176704ad);

    if(!succeeded && self.defuser_bad_path_counter >= 4) {
      self.defuser_bad_path_counter++;
    }

    self botclearscriptgoal();

    if(succeeded) {
      bot_dd_clear_role();
    }
  }
}

function investigate_someone_using_bomb() {
  self endon("change_role");

  if(bot_is_defending()) {
    bot_defend_stop();
  }

  self botsetscriptgoalnode(random(self.current_bombzone.bottargets), "critical");
  result = bot_waittill_goal_or_fail();

  if(result == "goal") {
    wait 2;
    bot_dd_clear_role();
  }
}

function get_player_defusing_zone(zone) {
  players_defending_zone = get_players_at_zone(zone, self.team);

  foreach(player in players_defending_zone) {
    if(!isai(player)) {
      if(player.isdefusing) {
        return player;
      }
    }
  }

  foreach(player in players_defending_zone) {
    if(isai(player)) {
      if(isDefined(player.role) && player.role == "defuser") {
        return player;
      }
    }
  }

  return undefined;
}

function get_player_planting_zone(zone) {
  players_attacking_zone = get_players_at_zone(zone, self.team);

  foreach(player in players_attacking_zone) {
    if(!isai(player)) {
      if(player.isplanting) {
        return player;
      }
    }
  }

  foreach(player in players_attacking_zone) {
    if(isai(player)) {
      if(isDefined(player.role) && player.role == "atk_bomber") {
        return player;
      }
    }
  }

  return undefined;
}

function bombzone_is_active(zone) {
  if(zone.visibleteam == "any") {
    return true;
  }

  return false;
}

function get_active_bombzones() {
  active_bombzones = [];

  foreach(zone in level.objectives) {
    if(bombzone_is_active(zone)) {
      active_bombzones[active_bombzones.size] = zone;
    }
  }

  return active_bombzones;
}

function get_players_at_zone(zone, team) {
  var_4df404dbb0d6b517 = [];
  var_41f00d5086d9f26c = get_living_players_on_team(team);

  foreach(player in var_41f00d5086d9f26c) {
    if(isai(player)) {
      if(isDefined(player.current_bombzone) && player.current_bombzone == zone) {
        var_4df404dbb0d6b517 = array_add(var_4df404dbb0d6b517, player);
      }

      continue;
    }

    if(distancesquared(player.origin, zone.curorigin) < level.protect_radius * level.protect_radius) {
      var_4df404dbb0d6b517 = array_add(var_4df404dbb0d6b517, player);
    }
  }

  return var_4df404dbb0d6b517;
}

function bot_pick_dd_zone_with_fewer_defenders(zones, difference) {
  assert(zones.size == 2);
  num_at_zone[0] = get_players_at_zone(zones[0], game["defenders"]).size;
  num_at_zone[1] = get_players_at_zone(zones[1], game["defenders"]).size;

  if(num_at_zone[0] > num_at_zone[1] + difference) {
    return zones[1];
  }

  if(num_at_zone[0] + difference < num_at_zone[1]) {
    return zones[0];
  }
}

function bot_pick_new_zone(type) {
  new_zone = undefined;

  if(type == "attack") {
    new_zone = bot_choose_attack_zone();
  } else if(type == "defend") {
    new_zone = bot_choose_defend_zone();
  }

  if(isDefined(new_zone) && (!isDefined(self.current_bombzone) || self.current_bombzone != new_zone)) {
    self.current_bombzone = new_zone;
    bot_dd_clear_role();
  }
}

function bot_choose_defend_zone() {
  active_bombzones = get_active_bombzones();
  var_a622ba42eb483dab = undefined;

  if(active_bombzones.size == 1) {
    var_a622ba42eb483dab = active_bombzones[0];
  } else if(active_bombzones.size == 2) {
    num_at_zone[0] = get_players_at_zone(active_bombzones[0], game["defenders"]).size;
    num_at_zone[1] = get_players_at_zone(active_bombzones[1], game["defenders"]).size;
    bomb_planted_on[0] = is_bomb_planted_on(active_bombzones[0]);
    bomb_planted_on[1] = is_bomb_planted_on(active_bombzones[1]);

    if(bomb_planted_on[0] && bomb_planted_on[1] || !bomb_planted_on[0] && !bomb_planted_on[1]) {
      difference = 0;

      if(isDefined(self.current_bombzone)) {
        difference = 1;
      }

      var_a622ba42eb483dab = bot_pick_dd_zone_with_fewer_defenders(active_bombzones, difference);

      if(!isDefined(var_a622ba42eb483dab) && !isDefined(self.current_bombzone)) {
        var_a622ba42eb483dab = random(active_bombzones);
      }
    } else if(bomb_planted_on[0] || bomb_planted_on[1]) {
      var_655df04bd2181345 = ter_op(bomb_planted_on[0], 0, 1);
      var_49b95b5588ebf99b = ter_op(!bomb_planted_on[0], 0, 1);

      if(num_at_zone[var_655df04bd2181345] > num_at_zone[var_49b95b5588ebf99b] + 2) {
        var_a622ba42eb483dab = active_bombzones[var_49b95b5588ebf99b];
      } else if(num_at_zone[var_655df04bd2181345] <= num_at_zone[var_49b95b5588ebf99b]) {
        var_a622ba42eb483dab = active_bombzones[var_655df04bd2181345];
      } else if(!isDefined(self.current_bombzone)) {
        if(num_at_zone[var_655df04bd2181345] >= num_at_zone[var_49b95b5588ebf99b] + 2) {
          var_a622ba42eb483dab = active_bombzones[var_49b95b5588ebf99b];
        } else if(num_at_zone[var_655df04bd2181345] < num_at_zone[var_49b95b5588ebf99b] + 2) {
          var_a622ba42eb483dab = active_bombzones[var_655df04bd2181345];
        }
      }
    }
  }

  return var_a622ba42eb483dab;
}

function get_other_active_zone(test_zone) {
  active_zones = get_active_bombzones();
  assert(active_zones.size <= 2);

  foreach(zone in active_zones) {
    if(zone != test_zone) {
      return zone;
    }
  }
}

function bot_choose_attack_zone() {
  if(isDefined(self.current_bombzone)) {
    return;
  }

  if(!isDefined(level.current_zone_target) || !bombzone_is_active(level.current_zone_target) || gettime() > level.next_target_switch_time) {
    level.next_target_switch_time = gettime() + 1000 * randomintrange(30, 45);
    level.current_zone_target = random(get_active_bombzones());
  }

  if(!isDefined(level.current_zone_target)) {
    return;
  }

  target_zone = level.current_zone_target;
  var_c07ce18da8a3f3e4 = get_other_active_zone(target_zone);
  self.current_bombzone = undefined;

  if(isDefined(var_c07ce18da8a3f3e4)) {
    if(randomfloat(1) < 0.25) {
      return var_c07ce18da8a3f3e4;
    }
  }

  return target_zone;
}

function bot_try_switch_attack_zone() {
  assert(isDefined(self.current_bombzone));
  other_zone = get_other_active_zone(self.current_bombzone);

  if(isDefined(other_zone)) {
    dist_to_target = distance(self.origin, self.current_bombzone.curorigin);
    var_e16650182c449db1 = distance(self.origin, other_zone.curorigin);

    if(var_e16650182c449db1 < dist_to_target * 0.6) {
      self.current_bombzone = other_zone;
    }
  }
}

function bot_choose_attack_role() {
  assert(isDefined(self.current_bombzone));

  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb") {
      return;
    }
  }

  new_role = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    new_role = "defend_zone";
  } else {
    var_6eaa3366ba4607b8 = get_player_planting_zone(self.current_bombzone);

    if(!isDefined(var_6eaa3366ba4607b8) || var_6eaa3366ba4607b8 == self) {
      new_role = "atk_bomber";
    } else if(isai(var_6eaa3366ba4607b8)) {
      var_9f0d0574d42d275a = distance(self.origin, self.current_bombzone.curorigin);
      var_c7f0fa34e70e55c9 = distance(var_6eaa3366ba4607b8.origin, self.current_bombzone.curorigin);

      if(var_9f0d0574d42d275a < var_c7f0fa34e70e55c9 * 0.9) {
        new_role = "atk_bomber";
        var_6eaa3366ba4607b8 bot_dd_clear_role();
      }
    }
  }

  if(!isDefined(new_role)) {
    new_role = "sweep_zone";
  }

  bot_dd_set_role(new_role);
}

function bot_choose_defend_role() {
  assert(isDefined(self.current_bombzone));

  if(isDefined(self.role)) {
    if(self.role == "investigate_someone_using_bomb") {
      return;
    }
  }

  new_role = undefined;

  if(is_bomb_planted_on(self.current_bombzone)) {
    current_defuser = get_player_defusing_zone(self.current_bombzone);

    if(!isDefined(current_defuser) || current_defuser == self) {
      new_role = "defuser";
    } else if(isai(current_defuser)) {
      var_9f0d0574d42d275a = distance(self.origin, self.current_bombzone.curorigin);
      var_f226ecae7afafba6 = distance(current_defuser.origin, self.current_bombzone.curorigin);

      if(var_9f0d0574d42d275a < var_f226ecae7afafba6 * 0.9) {
        new_role = "defuser";
        current_defuser bot_dd_clear_role();
      }
    }
  }

  if(!isDefined(new_role)) {
    new_role = "defend_zone";
  }

  bot_dd_set_role(new_role);
}

function bot_dd_set_role(new_role) {
  if(!isDefined(self.role) || self.role != new_role) {
    bot_dd_clear_role();
    self.role = new_role;
  }
}

function bot_dd_clear_role() {
  self.role = undefined;
  self botclearscriptgoal();
  self botsetpathingstyle(undefined);
  bot_defend_stop();
  self notify("change_role");
  self.defuser_bad_path_counter = 0;
}

function bot_dd_ai_director_update() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  while(true) {
    foreach(zone in level.objectives) {
      foreach(player in level.players) {
        if(isDefined(player.role) && isDefined(player.current_bombzone) && player.current_bombzone == zone) {
          if(!bombzone_is_active(zone)) {
            if(player.role == "atk_bomber" || player.role == "defuser") {
              player bot_dd_clear_role();
            }

            continue;
          }

          if(is_bomb_planted_on(zone)) {
            if(player.role == "atk_bomber") {
              player bot_dd_clear_role();
            }
          }
        }
      }
    }

    wait 0.5;
  }
}

function is_bomb_planted_on(zone) {
  return istrue(zone.bombplanted);
}