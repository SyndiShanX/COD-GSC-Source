/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_dom.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#namespace bots_gametype_dom;

function main() {
  level.var_e6628286205f2ea7 = 1;

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    scripts\mp\gametypes\mgl_mp::function_9acf99e8c077e74d();
    return;
  }

  level.bot_ignore_precalc_paths = 0;
  setup_callbacks();
  setup_bot_dom(3, 5);
  level thread bot_monitor_enemy_camp_spots(&bot_valid_camp_assassin);

  thread function_f0399eb73eb290b1();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_dom_think;
  level.bot_funcs["should_start_cautious_approach"] = &should_start_cautious_approach_dom;
  level.bot_funcs["leader_dialog"] = &bot_dom_leader_dialog;

  if(!level.bot_ignore_precalc_paths) {
    level.bot_funcs["get_watch_node_chance"] = &bot_dom_get_node_chance;
  }
}

function crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype)) {
    return 0;
  }

  if(!isteamparticipant(self)) {
    return 1;
  }

  return bot_is_protecting();
}

function function_f0399eb73eb290b1() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  while(true) {
    if(getdvarint(@ "hash_9cac85d6351e1df") == 1) {
      flags = bot_get_all_possible_flags();

      foreach(flag in flags) {
        if(flag.trigger.classname != "<dev string:x1c>") {
          botdebugdrawtrigger(1, flag.trigger, (0, 1, 0), 1);
        } else {
          bot_draw_cylinder(flag.trigger.origin, flag.trigger.radius, flag.trigger.height, 0.05, undefined, (0, 1, 0), 1);
        }

        foreach(node in flag.nodes) {
          bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, (0, 1, 0), 1, 4);
        }
      }
    }

    wait 0.05;
  }
}

function monitor_flag_control() {
  self notify("monitor_flag_control");
  self endon("monitor_flag_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 1;
    team = scripts\mp\gametypes\dom::getflagteam();

    if(team != "neutral") {
      zone = getzonenearest(self.trigger.origin);

      if(isDefined(zone)) {
        botzonesetteam(zone, team);
      }
    }
  }
}

function monitor_flag_ownership() {
  self notify("monitor_flag_ownership");
  self endon("monitor_flag_ownership");
  self endon("death");
  level endon("game_ended");
  prev_team = scripts\mp\gametypes\dom::getflagteam();

  for(;;) {
    current_team = scripts\mp\gametypes\dom::getflagteam();

    if(current_team != prev_team) {
      level notify("flag_changed_ownership");
    }

    prev_team = current_team;
    wait 0.05;
  }
}

function setup_bot_dom(var_c09effe906c04618, var_c9d880ac3d2f2d31) {
  setdevdvarifuninitialized(@ "hash_d19b61818b442235", 0);
  setdevdvarifuninitialized(@ "hash_e1e41766847222dc", 0);

  bot_waittill_bots_enabled();
  flags = bot_get_all_possible_flags();

  if(flags.size > 3) {
    while(!isDefined(level.teleport_dom_finished_initializing)) {
      wait 0.05;
    }

    assert(flags.size % 3 == 0);
    flags_in_zone = [];

    foreach(flag in flags) {
      assert(isDefined(flag.teleport_zone));

      if(!isDefined(flags_in_zone[flag.teleport_zone])) {
        flags_in_zone[flag.teleport_zone] = [];
      }

      flags_in_zone[flag.teleport_zone] = array_add(flags_in_zone[flag.teleport_zone], flag);
    }

    foreach(teleport_zone, var_efe554850e96b933 in flags_in_zone) {
      level.entrance_points_finished_caching = 0;
      bot_cache_flag_distances(var_efe554850e96b933);
      bot_cache_entrances_to_gametype_array(var_efe554850e96b933, teleport_zone + "_flag", level.bot_ignore_precalc_paths);
    }
  } else {
    assert(flags.size == var_c09effe906c04618);
    bot_cache_entrances_to_gametype_array(flags, "flag", level.bot_ignore_precalc_paths);
    bot_cache_flag_distances(flags);
    thread bot_wait_for_event_flag_swap(flags);
  }

  foreach(flag in flags) {
    flag thread monitor_flag_control();
    flag thread monitor_flag_ownership();

    if(flag.objectivekey != "_a" && flag.objectivekey != "_b" && flag.objectivekey != "_c") {
      assertmsg("<dev string:x2e>" + flag.trigger.origin + "<dev string:x4e>");
    }

    flag.nodes = bot_get_valid_nodes_in_trigger(flag.trigger);
    flag.last_time_secured["allies"] = 0;
    flag.last_time_secured["axis"] = 0;
  }

  level.bot_dom_override_flag_targets = [];
  level.bot_dom_override_flag_targets["axis"] = [];
  level.bot_dom_override_flag_targets["allies"] = [];
  level.bot_gametype_precaching_done = 1;
}

function bot_wait_for_event_flag_swap(flags) {
  level endon("game_ended");
  level waittill("dom_flags_moved");
  bot_cache_entrances_to_gametype_array(flags, "flag", level.bot_ignore_precalc_paths, 1);
  bot_cache_flag_distances(flags);

  foreach(dom_flag in flags) {
    dom_flag.nodes = bot_get_valid_nodes_in_trigger(dom_flag);
  }

  foreach(player in level.participants) {
    if(isaiteamparticipant(player)) {
      player.force_new_goal = 1;
    }
  }
}

function bot_get_all_possible_flags() {
  if(isDefined(level.all_dom_flags)) {
    return level.all_dom_flags;
  }

  return level.objectives;
}

function bot_cache_flag_distances(flags) {
  if(!isDefined(level.flag_distances)) {
    level.flag_distances = [];
  }

  var_dea51d2a009ac6e7 = [];
  i = 0;

  foreach(flag in flags) {
    var_dea51d2a009ac6e7[i] = flag;
    i++;
  }

  for(i = 0; i < var_dea51d2a009ac6e7.size - 1; i++) {
    for(j = i + 1; j < var_dea51d2a009ac6e7.size; j++) {
      var_a5b88c96222e6a1b = distance(var_dea51d2a009ac6e7[i].trigger.origin, var_dea51d2a009ac6e7[j].trigger.origin);
      i_label = get_flag_label(var_dea51d2a009ac6e7[i]);
      j_label = get_flag_label(var_dea51d2a009ac6e7[j]);
      level.flag_distances[i_label][j_label] = var_a5b88c96222e6a1b;
      level.flag_distances[j_label][i_label] = var_a5b88c96222e6a1b;
    }
  }
}

function should_start_cautious_approach_dom(firstcheck) {
  if(firstcheck) {
    if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == "neutral" && flag_has_never_been_captured(self.current_flag)) {
      var_75ee0b273dd2ec6a = get_closest_flag(self.lastspawnpoint.origin);

      if(var_75ee0b273dd2ec6a == self.current_flag) {
        return 0;
      } else {
        var_7d6c59551603a4f2 = get_other_flag(var_75ee0b273dd2ec6a, self.current_flag);
        var_146177c4671f2f2d = distancesquared(var_75ee0b273dd2ec6a.trigger.origin, self.current_flag.trigger.origin);
        var_d886e066e440ed6f = distancesquared(var_7d6c59551603a4f2.trigger.origin, self.current_flag.trigger.origin);

        if(var_146177c4671f2f2d < var_d886e066e440ed6f) {
          return 0;
        }
      }
    }
  }

  return should_start_cautious_approach_default(firstcheck);
}

function bot_dom_debug_should_capture_all() {
  if(getDvar(@ "hash_d19b61818b442235") == "<dev string:x80>") {
    return true;
  }

  return false;
}

function bot_dom_debug_should_protect_all() {
  if(getDvar(@ "hash_e1e41766847222dc") == "<dev string:x80>") {
    return true;
  }

  return false;
}

function bot_dom_think() {
  self notify("bot_dom_think");
  self endon("bot_dom_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self.force_new_goal = 0;
  self.new_goal_time = 0;
  self.next_strat_level_check = 0;
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    bot_update_camp_assassin();
    cur_time = gettime();

    if(cur_time > self.next_strat_level_check) {
      self.next_strat_level_check = gettime() + 10000;
      self.strategy_level = self botgetdifficultysetting("strategyLevel");
    }

    if(cur_time > self.new_goal_time || self.force_new_goal) {
      if(should_delay_flag_decision()) {
        self.new_goal_time = cur_time + 5000;
      } else {
        self.force_new_goal = 0;
        bot_choose_flag();
        self.new_goal_time = cur_time + randomintrange(30000, 45000);
      }
    }

    waittill_notify_or_timeout("needs_new_flag_goal", 1);
  }
}

function should_delay_flag_decision() {
  if(self.force_new_goal) {
    return false;
  }

  if(!bot_is_capturing()) {
    return false;
  }

  if(self.current_flag scripts\mp\gametypes\dom::getflagteam() == self.team) {
    return false;
  }

  flag_capture_radius = get_flag_capture_radius();

  if(distancesquared(self.origin, self.current_flag.trigger.origin) < flag_capture_radius * 2 * flag_capture_radius * 2) {
    ally_flags = get_ally_flags(self.team);

    if(ally_flags.size == 2 && !array_contains(ally_flags, self.current_flag) && !bot_allowed_to_3_cap()) {
      return false;
    }

    return true;
  }

  return false;
}

function get_override_flag_targets() {
  return level.bot_dom_override_flag_targets[self.team];
}

function has_override_flag_targets() {
  override_targets = get_override_flag_targets();
  return override_targets.size > 0;
}

function flag_has_been_captured_before(flag) {
  return !flag_has_never_been_captured(flag);
}

function flag_has_never_been_captured(flag) {
  return flag.firstcapture;
}

function bot_choose_flag() {
  flag = undefined;
  var_7ba2208479205cf2 = [];
  var_23b9e499d084cad = [];
  var_39c262926ffa6a00 = !istrue(level.precappoints);
  override_targets = get_override_flag_targets();

  if(override_targets.size > 0) {
    all_possible_flags = override_targets;
  } else {
    all_possible_flags = level.objectives;
  }

  foreach(flag in all_possible_flags) {
    team = flag scripts\mp\gametypes\dom::getflagteam();

    if(var_39c262926ffa6a00) {
      if(flag_has_been_captured_before(flag)) {
        var_39c262926ffa6a00 = 0;
      } else {
        assert(team == "<dev string:x85>");
      }
    }

    if(team != self.team) {
      var_7ba2208479205cf2[var_7ba2208479205cf2.size] = flag;
      continue;
    }

    var_23b9e499d084cad[var_23b9e499d084cad.size] = flag;
  }

  assert(has_override_flag_targets() || var_7ba2208479205cf2.size + var_23b9e499d084cad.size == 3);
  attacking = undefined;

  if(var_7ba2208479205cf2.size == 3) {
    assert(var_23b9e499d084cad.size == 0);
    attacking = 1;
  } else if(var_7ba2208479205cf2.size == 2) {
    assert(var_23b9e499d084cad.size <= 1);

    if(var_23b9e499d084cad.size == 1) {
      if(!bot_should_defend_flag(var_23b9e499d084cad[0], 1)) {
        attacking = 1;
      } else {
        attacking = !bot_should_defend(0.34);
      }

      if(bot_get_max_players_on_team(self.team) == 1) {
        attacking = 1;
      }
    } else if(var_23b9e499d084cad.size == 0) {
      attacking = 1;
    }
  } else if(var_7ba2208479205cf2.size == 1) {
    assert(var_23b9e499d084cad.size <= 2);

    if(var_23b9e499d084cad.size == 2) {
      if(bot_allowed_to_3_cap()) {
        if(!bot_should_defend_flag(var_23b9e499d084cad[0], 2) && !bot_should_defend_flag(var_23b9e499d084cad[1], 2)) {
          attacking = 1;
        } else if(self.strategy_level == 0) {
          attacking = !bot_should_defend(0.34);
        } else {
          attacking = !bot_should_defend(0.5);
        }
      } else {
        attacking = 0;
      }
    } else if(var_23b9e499d084cad.size == 1) {
      if(!bot_should_defend_flag(var_23b9e499d084cad[0], 1)) {
        attacking = 1;
      } else {
        attacking = !bot_should_defend(0.34);
      }
    } else if(var_23b9e499d084cad.size == 0) {
      attacking = 1;
    }
  } else if(var_7ba2208479205cf2.size == 0) {
    assert(var_23b9e499d084cad.size <= 3);
    attacking = 0;
  }

  assert(isDefined(attacking));

  if(attacking) {
    assert(var_7ba2208479205cf2.size >= 1 && var_7ba2208479205cf2.size <= 3);

    if(var_7ba2208479205cf2.size > 1) {
      triggers = [];

      foreach(var_38a5994c0cec51cd in var_7ba2208479205cf2) {
        triggers[triggers.size] = var_38a5994c0cec51cd.trigger;
      }

      var_7727a8a4f4a2e7fe = get_array_of_closest(self.origin, triggers);
      var_4a204ffc32301ef9 = [];

      foreach(sortedflag in var_7727a8a4f4a2e7fe) {
        foreach(objective in level.objectives) {
          if(objective.trigger == sortedflag) {
            var_4a204ffc32301ef9[var_4a204ffc32301ef9.size] = objective;
          }
        }
      }

      var_7727a8a4f4a2e7fe = var_4a204ffc32301ef9;
    } else {
      var_7727a8a4f4a2e7fe = var_7ba2208479205cf2;
    }

    if(var_39c262926ffa6a00 && !has_override_flag_targets()) {
      assert(var_7727a8a4f4a2e7fe.size == 3);
      var_9685536ce2ceda1 = get_num_allies_capturing_flag(var_7727a8a4f4a2e7fe[0], 1);

      if(var_9685536ce2ceda1 < min_num_bots_assaulting_first_flag()) {
        flag_num = 0;
      } else {
        var_be069de8ad079303 = 20;
        var_49628d88fda56715 = 65;
        var_c21ff692c3731f37 = 15;

        if(self.strategy_level == 0) {
          var_be069de8ad079303 = 50;
          var_49628d88fda56715 = 25;
          var_c21ff692c3731f37 = 25;
        } else if(self.strategy_level == 1) {
          var_be069de8ad079303 = 40;
          var_49628d88fda56715 = 40;
          var_c21ff692c3731f37 = 20;
        }

        random_roll = randomint(100);

        if(random_roll < var_be069de8ad079303) {
          flag_num = 0;
        } else if(random_roll < var_be069de8ad079303 + var_49628d88fda56715) {
          flag_num = 1;
        } else {
          flag_num = 2;
        }
      }

      goal_type = undefined;

      if(flag_num == 0) {
        goal_type = "critical";
      }

      capture_flag(var_7727a8a4f4a2e7fe[flag_num], goal_type);
      return;
    }

    if(var_7727a8a4f4a2e7fe.size == 1) {
      flag = var_7727a8a4f4a2e7fe[0];
    } else if(distancesquared(var_7727a8a4f4a2e7fe[0].trigger.origin, self.origin) < 102400) {
      flag = var_7727a8a4f4a2e7fe[0];
    } else {
      assert(var_7727a8a4f4a2e7fe.size >= 2 && var_7727a8a4f4a2e7fe.size <= 3);
      var_51eed82f15a0c64c = [];
      var_5eb2d3db89e5673b = [];

      for(i = 0; i < var_7727a8a4f4a2e7fe.size; i++) {
        dist = distance(var_7727a8a4f4a2e7fe[i].trigger.origin, self.origin);
        var_5eb2d3db89e5673b[i] = dist;
        var_51eed82f15a0c64c[i] = dist;
      }

      if(var_23b9e499d084cad.size == 1) {
        var_8b12e8f5719a1c61 = 1.5;

        for(i = 0; i < var_51eed82f15a0c64c.size; i++) {
          var_51eed82f15a0c64c[i] += level.flag_distances[get_flag_label(var_7727a8a4f4a2e7fe[i])][get_flag_label(var_23b9e499d084cad[0])] * var_8b12e8f5719a1c61;
        }
      }

      if(self.strategy_level == 0) {
        random_roll = randomint(100);

        if(random_roll < 50) {
          flag = var_7727a8a4f4a2e7fe[0];
        } else if(random_roll < 50 + 50 / (var_7727a8a4f4a2e7fe.size - 1)) {
          flag = var_7727a8a4f4a2e7fe[1];
        } else {
          flag = var_7727a8a4f4a2e7fe[2];
        }
      } else if(var_51eed82f15a0c64c.size == 2) {
        var_168860c6fed89ec2[0] = 50;
        var_168860c6fed89ec2[1] = 50;

        for(i = 0; i < var_7727a8a4f4a2e7fe.size; i++) {
          if(var_51eed82f15a0c64c[i] < var_51eed82f15a0c64c[1 - i]) {
            var_168860c6fed89ec2[i] += 20;
            var_168860c6fed89ec2[1 - i] -= 20;
          }

          if(var_5eb2d3db89e5673b[i] < 640) {
            var_168860c6fed89ec2[i] += 15;
            var_168860c6fed89ec2[1 - i] -= 15;
          }

          if(var_7727a8a4f4a2e7fe[i] scripts\mp\gametypes\dom::getflagteam() == "neutral") {
            var_168860c6fed89ec2[i] += 15;
            var_168860c6fed89ec2[1 - i] -= 15;
          }
        }

        random_roll = randomint(100);

        if(random_roll < var_168860c6fed89ec2[0]) {
          flag = var_7727a8a4f4a2e7fe[0];
        } else {
          flag = var_7727a8a4f4a2e7fe[1];
        }
      } else if(var_51eed82f15a0c64c.size == 3) {
        var_168860c6fed89ec2[0] = 34;
        var_168860c6fed89ec2[1] = 33;
        var_168860c6fed89ec2[2] = 33;

        for(i = 0; i < var_7727a8a4f4a2e7fe.size; i++) {
          var_226e0424f3cc40a6 = (i + 1) % 3;
          var_226e0324f3cc3e73 = (i + 2) % 3;

          if(var_51eed82f15a0c64c[i] < var_51eed82f15a0c64c[var_226e0424f3cc40a6] && var_51eed82f15a0c64c[i] < var_51eed82f15a0c64c[var_226e0324f3cc3e73]) {
            var_168860c6fed89ec2[i] += 36;
            var_168860c6fed89ec2[var_226e0424f3cc40a6] -= 18;
            var_168860c6fed89ec2[var_226e0324f3cc3e73] -= 18;
          }

          if(var_5eb2d3db89e5673b[i] < 640) {
            var_168860c6fed89ec2[i] += 15;
            var_168860c6fed89ec2[var_226e0424f3cc40a6] -= 7;
            var_168860c6fed89ec2[var_226e0324f3cc3e73] -= 8;
          }

          if(var_7727a8a4f4a2e7fe[i] scripts\mp\gametypes\dom::getflagteam() == "neutral") {
            var_168860c6fed89ec2[i] += 15;
            var_168860c6fed89ec2[var_226e0424f3cc40a6] -= 7;
            var_168860c6fed89ec2[var_226e0324f3cc3e73] -= 8;
          }
        }

        random_roll = randomint(100);

        if(random_roll < var_168860c6fed89ec2[0]) {
          flag = var_7727a8a4f4a2e7fe[0];
        } else if(random_roll < var_168860c6fed89ec2[0] + var_168860c6fed89ec2[1]) {
          flag = var_7727a8a4f4a2e7fe[1];
        } else {
          flag = var_7727a8a4f4a2e7fe[2];
        }
      }
    }
  } else {
    assert(var_23b9e499d084cad.size > 0);

    if(var_23b9e499d084cad.size > 1) {
      triggers = [];

      foreach(var_8fed5911f92e3192 in var_23b9e499d084cad) {
        triggers[triggers.size] = var_8fed5911f92e3192.trigger;
      }

      var_f9e86f3c87ab9f97 = get_array_of_closest(self.origin, triggers);
      var_4a204ffc32301ef9 = [];

      foreach(sortedflag in var_f9e86f3c87ab9f97) {
        foreach(objective in level.objectives) {
          if(objective.trigger == sortedflag) {
            var_4a204ffc32301ef9[var_4a204ffc32301ef9.size] = objective;
          }
        }
      }

      var_f9e86f3c87ab9f97 = var_4a204ffc32301ef9;
    } else {
      var_f9e86f3c87ab9f97 = var_23b9e499d084cad;
    }

    foreach(test_flag in var_f9e86f3c87ab9f97) {
      if(bot_should_defend_flag(test_flag, var_23b9e499d084cad.size)) {
        flag = test_flag;
        break;
      }
    }

    if(!isDefined(flag)) {
      assert(var_f9e86f3c87ab9f97.size > 0);

      if(self.strategy_level == 0) {
        flag = var_23b9e499d084cad[0];
      } else if(var_f9e86f3c87ab9f97.size == 2) {
        third_flag = get_other_flag(var_f9e86f3c87ab9f97[0], var_f9e86f3c87ab9f97[1]);
        triggers = [];

        foreach(entry in var_f9e86f3c87ab9f97) {
          triggers[triggers.size] = entry.trigger;
        }

        var_aef4149e235bfbe6 = get_array_of_closest(third_flag.trigger.origin, triggers);
        var_4a204ffc32301ef9 = [];

        foreach(sortedflag in var_aef4149e235bfbe6) {
          foreach(objective in level.objectives) {
            if(objective.trigger == sortedflag) {
              var_4a204ffc32301ef9[var_4a204ffc32301ef9.size] = objective;
            }
          }
        }

        var_aef4149e235bfbe6 = var_4a204ffc32301ef9;
        random_roll = randomint(100);

        if(random_roll < 70) {
          flag = var_aef4149e235bfbe6[0];
        } else {
          flag = var_aef4149e235bfbe6[1];
        }
      } else {
        assert(var_f9e86f3c87ab9f97.size == 1 || var_f9e86f3c87ab9f97.size == 3);
        flag = var_f9e86f3c87ab9f97[0];
      }
    }
  }

  if(attacking) {
    capture_flag(flag);
    return;
  }

  defend_flag(flag);
}

function min_num_bots_assaulting_first_flag() {
  team_limit = bot_get_max_players_on_team(self.team);
  return ceil(team_limit / 3);
}

function bot_allowed_to_3_cap() {
  if(self.strategy_level == 0) {
    return 1;
  }

  override_targets = get_override_flag_targets();

  if(override_targets.size == 3) {
    return 1;
  }

  enemy_score = scripts\mp\gamescore::_getteamscore(get_enemy_team(self.team));
  my_score = scripts\mp\gamescore::_getteamscore(self.team);
  var_8f891cbcd9fa1dd1 = 200 - enemy_score;
  var_30a11ea937e7f319 = 200 - my_score;
  var_d8a3aa3a65a5b213 = var_30a11ea937e7f319 * 0.5 > var_8f891cbcd9fa1dd1;
  return var_d8a3aa3a65a5b213;
}

function bot_should_defend(var_e8d030a9fa5114ee) {
  assert(var_e8d030a9fa5114ee >= 0 && var_e8d030a9fa5114ee <= 1);

  if(randomfloat(1) < var_e8d030a9fa5114ee) {
    return 1;
  }

  personality_type = level.bot_personality_type[self.personality];

  if(personality_type == "stationary") {
    return 1;
  } else if(personality_type == "active") {
    return 0;
  }

  assertmsg("<dev string:x90>");
}

function capture_flag(var_f0b1a2262b2f7dfc, override_goal_type, var_119041cda5e9adf2) {
  assert(isDefined(var_f0b1a2262b2f7dfc));
  self.current_flag = var_f0b1a2262b2f7dfc;

  if(bot_dom_debug_should_protect_all()) {
    optional_params["override_goal_type"] = override_goal_type;
    optional_params["entrance_points_index"] = get_flag_label(var_f0b1a2262b2f7dfc);
    bot_protect_point(var_f0b1a2262b2f7dfc.trigger.origin, get_flag_protect_radius(), optional_params);
  } else {
    optional_params["override_goal_type"] = override_goal_type;
    optional_params["entrance_points_index"] = get_flag_label(var_f0b1a2262b2f7dfc);
    bot_capture_zone(var_f0b1a2262b2f7dfc.trigger.origin, var_f0b1a2262b2f7dfc.nodes, var_f0b1a2262b2f7dfc.trigger, optional_params);
  }

  if(!isDefined(var_119041cda5e9adf2) || !var_119041cda5e9adf2) {
    thread monitor_flag_status(var_f0b1a2262b2f7dfc);
  }
}

function defend_flag(var_3e376080e8dc9e3a) {
  assert(isDefined(var_3e376080e8dc9e3a));
  self.current_flag = var_3e376080e8dc9e3a;

  if(bot_dom_debug_should_capture_all()) {
    optional_params["entrance_points_index"] = get_flag_label(var_3e376080e8dc9e3a);
    bot_capture_zone(var_3e376080e8dc9e3a.trigger.origin, var_3e376080e8dc9e3a.nodes, var_3e376080e8dc9e3a.trigger, optional_params);
  } else {
    optional_params["entrance_points_index"] = get_flag_label(var_3e376080e8dc9e3a);
    optional_params["nearest_node_to_center"] = var_3e376080e8dc9e3a.nearest_node;
    bot_protect_point(var_3e376080e8dc9e3a.trigger.origin, get_flag_protect_radius(), optional_params);
  }

  thread monitor_flag_status(var_3e376080e8dc9e3a);
}

function get_flag_capture_radius() {
  if(!isDefined(level.capture_radius)) {
    level.capture_radius = 158;
  }

  return level.capture_radius;
}

function get_flag_protect_radius() {
  if(!isDefined(level.protect_radius)) {
    worldbounds = self botgetworldsize();
    average_side = (worldbounds[0] + worldbounds[1]) / 2;
    level.protect_radius = min(1000, average_side / 3.5);
  }

  return level.protect_radius;
}

function bot_dom_leader_dialog(dialog, location) {
  if(issubstr(dialog, "losing") && dialog != "losing_score" && dialog != "losing_time" && dialog != "gamestate_domlosing") {
    var_f666be4a2abc34f6 = getsubstr(dialog, dialog.size - 2);
    flag_losing = get_specific_flag_by_label(var_f666be4a2abc34f6);
    assertex(isDefined(flag_losing), "<dev string:x9f>" + dialog + "<dev string:xbe>");

    if(isDefined(flag_losing) && bot_allow_to_capture_flag(flag_losing)) {
      self botmemoryevent("known_enemy", undefined, flag_losing.trigger.origin);

      if(!isDefined(self.last_losing_flag_react) || gettime() - self.last_losing_flag_react > 10000) {
        if(bot_is_protecting()) {
          var_d493bd9f5a8adf45 = distancesquared(self.origin, flag_losing.trigger.origin) < 490000;
          var_cba76c2fa6170699 = bot_is_protecting_flag(flag_losing);

          if(var_d493bd9f5a8adf45 || var_cba76c2fa6170699) {
            capture_flag(flag_losing);
            self.last_losing_flag_react = gettime();
          }
        }
      }
    }
  } else if(issubstr(dialog, "secured")) {
    var_f666be4a2abc34f6 = getsubstr(dialog, dialog.size - 2);
    flag_taken = get_specific_flag_by_label(var_f666be4a2abc34f6);
    assert(isDefined(flag_taken));
    flag_taken.last_time_secured[self.team] = gettime();
  }

  bot_leader_dialog(dialog, location);
}

function bot_allow_to_capture_flag(flag) {
  override_targets = get_override_flag_targets();

  if(override_targets.size == 0) {
    return true;
  }

  if(array_contains(override_targets, flag)) {
    return true;
  }

  return false;
}

function monitor_flag_status(flag) {
  self notify("monitor_flag_status");
  self endon("monitor_flag_status");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_f2b47e412166c272 = get_num_ally_flags(self.team);
  var_82fe1c44f0e59dd5 = get_flag_capture_radius() * get_flag_capture_radius();
  var_9a86288b6e984514 = get_flag_capture_radius() * 3 * get_flag_capture_radius() * 3;
  var_278595174c3b888b = 1;

  while(var_278595174c3b888b) {
    needs_new_goal = 0;
    var_a78b2b0ebf2f977f = flag scripts\mp\gametypes\dom::getflagteam();
    var_877f0c734271995 = get_num_ally_flags(self.team);
    enemy_flags = get_enemy_flags(self.team);

    if(bot_is_capturing()) {
      if(var_a78b2b0ebf2f977f == self.team && flag.claimteam == "none") {
        if(!bot_dom_debug_should_capture_all()) {
          needs_new_goal = 1;
        }
      }

      if(var_877f0c734271995 == 2 && var_a78b2b0ebf2f977f != self.team && !bot_allowed_to_3_cap()) {
        if(distancesquared(self.origin, flag.trigger.origin) > var_82fe1c44f0e59dd5) {
          needs_new_goal = 1;
        }
      }

      foreach(enemy_flag in enemy_flags) {
        if(enemy_flag != flag && bot_allow_to_capture_flag(enemy_flag)) {
          if(distancesquared(self.origin, enemy_flag.trigger.origin) < var_9a86288b6e984514) {
            needs_new_goal = 1;
          }
        }
      }

      if(self istouching(flag.trigger) && flag.userate <= 0) {
        if(self bothasscriptgoal()) {
          script_goal = self botgetscriptgoal();
          script_goal_radius = self botgetscriptgoalRadius();

          if(distancesquared(self.origin, script_goal) < squared(script_goal_radius)) {
            var_b6f1deb8e946e67c = self getnearestnode();

            if(isDefined(var_b6f1deb8e946e67c)) {
              var_1aaf2917e47371a3 = undefined;

              foreach(defend_node in flag.nodes) {
                if(!nodesvisible(defend_node, var_b6f1deb8e946e67c, 1)) {
                  var_1aaf2917e47371a3 = defend_node.origin;
                  break;
                }
              }

              if(isDefined(var_1aaf2917e47371a3)) {
                self.defense_investigate_specific_point = var_1aaf2917e47371a3;
                self notify("defend_force_node_recalculation");
              }
            }
          }
        }
      }
    }

    if(bot_is_protecting()) {
      if(var_a78b2b0ebf2f977f != self.team) {
        if(!bot_dom_debug_should_protect_all()) {
          needs_new_goal = 1;
        }
      } else if(var_877f0c734271995 == 1 && var_f2b47e412166c272 > 1) {
        needs_new_goal = 1;
      }
    }

    var_f2b47e412166c272 = var_877f0c734271995;

    if(needs_new_goal) {
      self.force_new_goal = 1;
      var_278595174c3b888b = 0;
      self notify("needs_new_flag_goal");
      continue;
    }

    result = level waittill_notify_or_timeout_return("flag_changed_ownership", 1 + randomfloatrange(0, 2));
    var_a862627b64e75a21 = isDefined(result) && result == "timeout";

    if(!var_a862627b64e75a21) {
      assert(self.strategy_level <= 3);
      wait_time = max((3 - self.strategy_level) * 1 + randomfloatrange(-0.5, 0.5), 0);
      wait wait_time;
    }
  }
}

function bot_dom_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center) {
    return 1;
  }

  if(!isDefined(self.current_flag)) {
    return 1;
  }

  var_f43fb0e14ccfb9e1 = 0;
  var_a7ff1fe77b4291e1 = get_flag_label(self.current_flag);
  ally_flags = get_ally_flags(self.team);

  foreach(ally_flag in ally_flags) {
    if(ally_flag != self.current_flag) {
      var_f43fb0e14ccfb9e1 = node node_is_on_path_from_labels(var_a7ff1fe77b4291e1, get_flag_label(ally_flag));

      if(var_f43fb0e14ccfb9e1) {
        third_flag = get_other_flag(self.current_flag, ally_flag);
        var_8eb11236ac48ce3 = third_flag scripts\mp\gametypes\dom::getflagteam();

        if(var_8eb11236ac48ce3 != self.team) {
          if(node node_is_on_path_from_labels(var_a7ff1fe77b4291e1, get_flag_label(third_flag))) {
            var_f43fb0e14ccfb9e1 = 0;
          }
        }
      }
    }
  }

  if(var_f43fb0e14ccfb9e1) {
    return 0.2;
  }

  return 1;
}

function get_flag_label(flag) {
  flag_label = "";

  if(isDefined(flag.teleport_zone)) {
    flag_label += flag.teleport_zone + "_";
  }

  flag_label += "flag" + flag.objectivekey;
  return flag_label;
}

function get_other_flag(flag1, flag2) {
  assert(level.objectives.size == 3);

  foreach(objective in level.objectives) {
    if(objective != flag1 && objective != flag2) {
      return objective;
    }
  }
}

function get_specific_flag_by_letter(flag_letter) {
  assert(flag_letter == "<dev string:xc3>" || flag_letter == "<dev string:xc8>" || flag_letter == "<dev string:xcd>");
  flag_label = "_" + tolower(flag_letter);
  return get_specific_flag_by_label(flag_label);
}

function get_specific_flag_by_label(flag_label) {
  foreach(objective in level.objectives) {
    if(objective.objectivekey == flag_label) {
      return objective;
    }
  }
}

function get_closest_flag(origin) {
  closest_flag = undefined;
  var_d7e79a673c0d8d21 = undefined;

  foreach(objective in level.objectives) {
    var_4ea84b05d2e463a4 = distancesquared(objective.trigger.origin, origin);

    if(!isDefined(var_d7e79a673c0d8d21) || var_4ea84b05d2e463a4 < var_d7e79a673c0d8d21) {
      closest_flag = objective;
      var_d7e79a673c0d8d21 = var_4ea84b05d2e463a4;
    }
  }

  return closest_flag;
}

function get_num_allies_capturing_flag(flag, ignore_humans) {
  var_6fd52c0a557b6a40 = 0;
  flag_capture_radius = get_flag_capture_radius();

  foreach(other_player in level.participants) {
    if(!isDefined(other_player.team)) {
      continue;
    }

    if(other_player.team == self.team && other_player != self && isteamparticipant(other_player)) {
      if(isai(other_player)) {
        if(other_player bot_is_capturing_flag(flag)) {
          var_6fd52c0a557b6a40++;
        }

        continue;
      }

      if(!isDefined(ignore_humans) || !ignore_humans) {
        if(other_player istouching(flag)) {
          var_6fd52c0a557b6a40++;
        }
      }
    }
  }

  return var_6fd52c0a557b6a40;
}

function bot_is_capturing_flag(flag) {
  if(!bot_is_capturing()) {
    return 0;
  }

  return bot_target_is_flag(flag);
}

function bot_is_protecting_flag(flag) {
  if(!bot_is_protecting()) {
    return 0;
  }

  return bot_target_is_flag(flag);
}

function bot_target_is_flag(flag) {
  return self.current_flag == flag;
}

function get_num_ally_flags(team) {
  count = 0;

  foreach(objective in level.objectives) {
    flag_team = objective scripts\mp\gametypes\dom::getflagteam();

    if(flag_team == team) {
      count++;
    }
  }

  return count;
}

function get_enemy_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    flag_team = objective scripts\mp\gametypes\dom::getflagteam();

    if(flag_team == get_enemy_team(team)) {
      flags = array_add(flags, objective);
    }
  }

  return flags;
}

function get_ally_flags(team) {
  flags = [];

  foreach(objective in level.objectives) {
    flag_team = objective scripts\mp\gametypes\dom::getflagteam();

    if(flag_team == team) {
      flags = array_add(flags, objective);
    }
  }

  return flags;
}

function bot_should_defend_flag(potential_flag, var_2d7337cdf8f706c0) {
  var_26d0fe30296086c4 = get_max_num_defenders_wanted_per_flag(var_2d7337cdf8f706c0);
  players_defending_flag = get_players_defending_flag(potential_flag);
  return players_defending_flag.size < var_26d0fe30296086c4;
}

function get_max_num_defenders_wanted_per_flag(var_2d7337cdf8f706c0) {
  team_limit = bot_get_max_players_on_team(self.team);

  if(var_2d7337cdf8f706c0 == 1) {
    return ceil(team_limit / 6);
  }

  return ceil(team_limit / 3);
}

function get_players_defending_flag(potential_flag) {
  flag_protect_radius = get_flag_protect_radius();
  bots_defending = [];

  foreach(other_player in level.participants) {
    if(!isDefined(other_player.team)) {
      continue;
    }

    if(other_player.team == self.team && other_player != self && isteamparticipant(other_player)) {
      if(isai(other_player)) {
        if(other_player bot_is_protecting_flag(potential_flag)) {
          bots_defending = array_add(bots_defending, other_player);
        }

        continue;
      }

      var_c3d8550ca7e24e40 = gettime() - potential_flag.last_time_secured[self.team];

      if(var_c3d8550ca7e24e40 < 10000) {
        continue;
      }

      if(other_player isufo() || other_player isnoclip()) {
        continue;
      }

      if(distancesquared(potential_flag.trigger.origin, other_player.origin) < flag_protect_radius * flag_protect_radius) {
        bots_defending = array_add(bots_defending, other_player);
      }
    }
  }

  return bots_defending;
}