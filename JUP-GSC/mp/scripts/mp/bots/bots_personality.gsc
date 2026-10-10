/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_personality.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\utility\entity;
#namespace bots_personality;

function setup_personalities() {
  level.bot_personality = [];
  level.bot_personality_list = [];
  level.bot_personality["active"][0] = "run_and_gun";
  level.bot_personality["active"][1] = "cqb";
  level.bot_personality["stationary"][0] = "camper";
  level.bot_personality_type = [];

  foreach(index, personality_array in level.bot_personality) {
    foreach(personality in personality_array) {
      level.bot_personality_type[personality] = index;
      level.bot_personality_list[level.bot_personality_list.size] = personality;
    }
  }

  level.bot_personality_types_desired = [];
  level.bot_personality_types_desired["active"] = 4;
  level.bot_personality_types_desired["stationary"] = 1;
  level.bot_pers_init = [];
  level.bot_pers_init["run_and_gun"] = &init_personality_default;
  level.bot_pers_init["camper"] = &init_personality_camper;
  level.bot_pers_update["run_and_gun"] = &update_personality_default;
  level.bot_pers_update["camper"] = &update_personality_camper;
}

function bot_assign_personality_functions() {
  self.personality = self botgetpersonality();
  self.pers["personality"] = self.personality;
  self.personality_init_function = level.bot_pers_init[self.personality];

  if(!isDefined(self.personality_init_function)) {
    self.personality_init_function = level.bot_pers_init["run_and_gun"];
  }

  self[[self.personality_init_function]]();
  self.personality_update_function = level.bot_pers_update[self.personality];

  if(!isDefined(self.personality_update_function)) {
    self.personality_update_function = level.bot_pers_update["run_and_gun"];
  }
}

function bot_balance_personality() {
  if(isDefined(self.personalitymanuallyset) && self.personalitymanuallyset) {
    return;
  }

  if(isDefined(self.pers["personality"])) {
    self botsetpersonality(self.pers["personality"]);
    return;
  }

  my_team = self.team;

  if(!isDefined(my_team) && !isDefined(self.bot_team)) {
    my_team = self.pers["team"];
  }

  assert(level.bot_personality.size == level.bot_personality_types_desired.size);
  var_55d47d98f8988a2d = getarraykeys(level.bot_personality_types_desired);
  perscounts = [];
  var_1560f7b587190cf0 = [];

  foreach(personality_type, personality_array in level.bot_personality) {
    var_1560f7b587190cf0[personality_type] = 0;

    foreach(personality in personality_array) {
      perscounts[personality] = 0;
    }
  }

  foreach(bot in level.participants) {
    if(bot == self) {
      continue;
    }

    if(!isteamparticipant(bot) || !isDefined(bot.has_balanced_personality)) {
      continue;
    }

    if(isDefined(bot.team) && bot.team == my_team || !level.teambased) {
      personality = bot botgetpersonality();
      personality_type = level.bot_personality_type[personality];
      perscounts[personality] += 1;
      var_1560f7b587190cf0[personality_type] += 1;
    }
  }

  var_e1631b2cd55e620b = [];

  foreach(type in var_55d47d98f8988a2d) {
    var_e1631b2cd55e620b[type] = int(var_1560f7b587190cf0[type] / level.bot_personality_types_desired[type]);
  }

  type_needed = undefined;

  for(i = 0; i < var_55d47d98f8988a2d.size && !isDefined(type_needed); i++) {
    var_d5e564acd20d2e2a = var_55d47d98f8988a2d[i];
    var_5ceedb6c6b6e3dd4 = 1;

    for(j = 0; j < var_55d47d98f8988a2d.size; j++) {
      var_d5e563acd20d2bf7 = var_55d47d98f8988a2d[j];

      if(var_d5e564acd20d2e2a != var_d5e563acd20d2bf7) {
        if(var_e1631b2cd55e620b[var_d5e564acd20d2e2a] >= var_e1631b2cd55e620b[var_d5e563acd20d2bf7]) {
          var_5ceedb6c6b6e3dd4 = 0;
        }
      }
    }

    if(var_5ceedb6c6b6e3dd4) {
      type_needed = var_d5e564acd20d2e2a;
    }
  }

  if(!isDefined(type_needed)) {
    var_4846c4bce18fd427 = [];

    foreach(type in var_55d47d98f8988a2d) {
      var_4846c4bce18fd427[type] = level.bot_personality_types_desired[type] - var_1560f7b587190cf0[type] % level.bot_personality_types_desired[type];
    }

    total_weight = 0;

    foreach(type in var_55d47d98f8988a2d) {
      total_weight += var_4846c4bce18fd427[type];
    }

    random_choice = randomfloat(total_weight);

    foreach(type in var_55d47d98f8988a2d) {
      if(random_choice < var_4846c4bce18fd427[type]) {
        type_needed = type;
        break;
      }

      random_choice -= var_4846c4bce18fd427[type];
    }
  }

  personality_needed = undefined;
  var_25a35f1f4bfacfa5 = undefined;
  var_7c1e7ac0e071d88e = 9999;
  var_6e83e2b8afbfa881 = undefined;
  var_7e2d2363d6ef89ea = -9999;
  var_51888c1474f8523d = array_randomize(level.bot_personality[type_needed]);

  foreach(personality in var_51888c1474f8523d) {
    if(perscounts[personality] < var_7c1e7ac0e071d88e) {
      var_25a35f1f4bfacfa5 = personality;
      var_7c1e7ac0e071d88e = perscounts[personality];
    }

    if(perscounts[personality] > var_7e2d2363d6ef89ea) {
      var_6e83e2b8afbfa881 = personality;
      var_7e2d2363d6ef89ea = perscounts[personality];
    }
  }

  if(var_7e2d2363d6ef89ea - var_7c1e7ac0e071d88e >= 2) {
    personality_needed = var_25a35f1f4bfacfa5;
  } else {
    personality_needed = random(level.bot_personality[type_needed]);
  }

  if(self botgetpersonality() != personality_needed) {
    self botsetpersonality(personality_needed);
  }

  self.has_balanced_personality = 1;
}

function init_personality_camper() {
  clear_camper_data();
}

function init_personality_default() {
  clear_camper_data();
}

function update_personality_camper() {
  if(should_select_new_ambush_point() && !bot_is_defending() && !bot_is_remote_or_linked()) {
    goaltype = self botgetscriptgoaltype();
    var_8cbb02b399f5a5b2 = 0;

    if(!isDefined(self.camper_time_started_hunting)) {
      self.camper_time_started_hunting = 0;
    }

    var_cdca96a984fdb85 = goaltype == "hunt";
    var_a703a9e683f32f15 = gettime() > self.camper_time_started_hunting + 10000;

    if((!var_cdca96a984fdb85 || var_a703a9e683f32f15) && !bot_out_of_ammo()) {
      if(!self bothasscriptgoal()) {
        bot_random_path();
      }

      if(isDefined(level.override_find_camp_node)) {
        var_8cbb02b399f5a5b2 = [[level.override_find_camp_node]]();
      }

      if(!var_8cbb02b399f5a5b2) {
        var_8cbb02b399f5a5b2 = find_camp_node();

        if(!var_8cbb02b399f5a5b2) {
          self.camper_time_started_hunting = gettime();
        }
      }
    }

    if(isDefined(var_8cbb02b399f5a5b2) && var_8cbb02b399f5a5b2) {
      self.ambush_entrances = bot_queued_process("bot_find_ambush_entrances", &bot_find_ambush_entrances, self.node_ambushing_from, 1);
      trap_item = bot_get_ambush_trap_item("trap_directional", "trap", "c4");

      if(isDefined(trap_item)) {
        traptime = gettime();
        bot_set_ambush_trap(trap_item, self.ambush_entrances, self.node_ambushing_from, self.ambush_yaw);
        traptime = gettime() - traptime;

        if(traptime > 0 && isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
          self.ambush_end += traptime;
          self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
        }
      }

      if(!bot_has_tactical_goal() && !bot_is_defending() && isDefined(self.node_ambushing_from)) {
        set_goal = self botsetscriptgoalnode(self.node_ambushing_from, "camp", self.ambush_yaw);

        if(set_goal) {
          thread clear_script_goal_on("bad_path", "node_relinquished", "out_of_ammo");
          thread watch_out_of_ammo();
          thread bot_add_ambush_time_delayed("clear_camper_data", "goal");
          thread bot_watch_entrances_delayed("clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw);
          childthread bot_try_trap_follower("clear_camper_data", "goal");
        } else {
          clear_camper_data();
        }
      }

      return;
    }

    if(goaltype == "camp") {
      self botclearscriptgoal();
    }

    update_personality_default();
  }
}

function update_personality_default() {
  script_goal = undefined;
  var_f8cd7c50ce12c857 = self bothasscriptgoal();

  if(var_f8cd7c50ce12c857) {
    script_goal = self botgetscriptgoal();
  }

  if(gettime() - self.lastspawntime > 5000) {
    bot_try_trap_follower();
  }

  if(!bot_has_tactical_goal() && !bot_is_remote_or_linked()) {
    distsq = undefined;
    goalradius = undefined;

    if(var_f8cd7c50ce12c857) {
      distsq = distancesquared(self.origin, script_goal);
      goalradius = self botgetscriptgoalRadius();
      var_73a7bf31171d039a = goalradius * 2;

      if(isDefined(self.bot_memory_goal) && distsq < var_73a7bf31171d039a * var_73a7bf31171d039a) {
        var_3068ac978537c7be = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_73a7bf31171d039a, "kill", var_3068ac978537c7be, self);
        botflagmemoryevents(0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, var_73a7bf31171d039a, "death", var_3068ac978537c7be, self);
        self.bot_memory_goal = undefined;
        self.bot_memory_goal_time = undefined;
      }
    }

    if(!var_f8cd7c50ce12c857 || distsq < goalradius * goalradius) {
      var_74d7abd5f49c5c17 = bot_random_path();
      var_bf1b72d688bc972d = undefined;
      var_d99a6026e41a6cb1 = undefined;

      if(var_74d7abd5f49c5c17) {
        var_bf1b72d688bc972d = self botgetscriptgoal();
        var_d99a6026e41a6cb1 = self botgetscriptgoaltype();
      }

      var_b56cd59cc7090a01 = 25;

      if(istrue(self.encourage_explosive_use)) {
        var_b56cd59cc7090a01 = 50;
      }

      if(var_74d7abd5f49c5c17 && randomfloat(100) < var_b56cd59cc7090a01) {
        trap_item = bot_get_ambush_trap_item("trap_directional", "trap");

        if(isDefined(trap_item)) {
          ambush_point = self botgetscriptgoal();

          if(isDefined(ambush_point)) {
            ambush_node = getclosestnodeinsight(ambush_point);

            if(isDefined(ambush_node) && getlinkednodes(ambush_node).size > 0) {
              ambush_entrances = bot_find_ambush_entrances(ambush_node, 0);
              set_trap = bot_set_ambush_trap(trap_item, ambush_entrances, ambush_node);

              if(!isDefined(set_trap) || set_trap) {
                self botclearscriptgoal();
                var_74d7abd5f49c5c17 = bot_random_path();

                if(var_74d7abd5f49c5c17) {
                  var_bf1b72d688bc972d = self botgetscriptgoal();
                  var_d99a6026e41a6cb1 = self botgetscriptgoaltype();
                }
              }
            }
          }
        }
      }

      if(var_74d7abd5f49c5c17 && self bothasscriptgoal()) {
        var_7d6fe43b33853bbd = self botgetscriptgoal();
        var_e7073093c8c51701 = self botgetscriptgoaltype();
        var_c7db4bba18015b56 = bot_vectors_are_equal(var_bf1b72d688bc972d, var_7d6fe43b33853bbd);
        var_327022dffa914c44 = var_d99a6026e41a6cb1 == var_e7073093c8c51701;

        if(var_c7db4bba18015b56 && var_327022dffa914c44) {
          thread clear_script_goal_on("enemy", "bad_path", "goal", "node_relinquished", "search_end");
        }
      }
    }
  }
}

function bot_try_trap_follower(endevent, waitevent) {}

function clear_script_goal_on(event1, event2, event3, event4, event5) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death_or_disconnect");
  self endon("start_tactical_goal");
  assertex(self bothasscriptgoal(), "<dev string:x1c>");
  var_15316f794a1b9615 = self botgetscriptgoal();
  keep_looping = 1;

  while(keep_looping) {
    result = waittill_any_return_6(event1, event2, event3, event4, event5, "script_goal_changed");
    keep_looping = 0;
    var_7b4ee638a6f8339c = 1;

    if(result == "node_relinquished" || result == "goal" || result == "script_goal_changed") {
      if(!self bothasscriptgoal()) {
        var_7b4ee638a6f8339c = 0;
      } else {
        var_3658f8e451e8136c = self botgetscriptgoal();
        var_7b4ee638a6f8339c = bot_vectors_are_equal(var_15316f794a1b9615, var_3658f8e451e8136c);
      }
    }

    if(result == "enemy" && isDefined(self.enemy)) {
      var_7b4ee638a6f8339c = 0;
      keep_looping = 1;
    }

    if(var_7b4ee638a6f8339c) {
      self botclearscriptgoal();
    }
  }
}

function watch_out_of_ammo() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death_or_disconnect");

  while(!bot_out_of_ammo()) {
    wait 0.5;
  }

  self notify("out_of_ammo");
}

function bot_add_ambush_time_delayed(endevent, waitfor) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death_or_disconnect");

  if(isDefined(endevent)) {
    self endon(endevent);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  starttime = gettime();

  if(isDefined(waitfor)) {
    self waittill(waitfor);
  }

  if(isDefined(self.ambush_end) && isDefined(self.node_ambushing_from)) {
    self.ambush_end += gettime() - starttime;
    self.node_ambushing_from.bot_ambush_end = self.ambush_end + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

function bot_watch_entrances_delayed(endevent, waitfor, entrances, yaw) {
  self notify("bot_watch_entrances_delayed");

  if(entrances.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death_or_disconnect");
    self endon(endevent);
    self endon("node_relinquished");
    self endon("bad_path");

    if(isDefined(waitfor)) {
      self waittill(waitfor);
    }

    self endon("path_enemy");
    childthread bot_watch_nodes(entrances, yaw, 0, self.ambush_end);
    childthread bot_monitor_watch_entrances_camp();
  }
}

function bot_monitor_watch_entrances_camp() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("death_or_disconnect");

  while(!isDefined(self.watch_nodes)) {
    wait 0.05;
  }

  while(isDefined(self.watch_nodes)) {
    foreach(node in self.watch_nodes) {
      node.watch_node_chance[self.entity_number] = node.watch_node_base_chance[self.entity_number];
    }

    prioritize_watch_nodes_toward_enemies(0.5);
    wait randomfloatrange(0.5, 0.75);
  }
}

function bot_find_ambush_entrances(ambush_node, var_40516918c495cf09) {
  self endon("disconnect");
  var_8b1a576d8e46a06f = [];
  entrances = findentrances(ambush_node.origin);
  assertex(entrances.size > 0, "<dev string:x58>" + ambush_node.origin + "<dev string:x81>");

  if(isDefined(entrances) && entrances.size > 0) {
    wait 0.05;
    crouching = ambush_node.type != "Cover Stand" && ambush_node.type != "Conceal Stand";

    if(crouching && var_40516918c495cf09) {
      entrances = self botnodescoremultiple(entrances, "node_exposure_vis", ambush_node.origin, "crouch");
    }

    foreach(node in entrances) {
      if(distancesquared(self.origin, node.origin) < 90000) {
        continue;
      }

      if(crouching && var_40516918c495cf09) {
        wait 0.05;

        if(!entrance_visible_from(node.origin, ambush_node.origin, "crouch")) {
          continue;
        }
      }

      var_8b1a576d8e46a06f[var_8b1a576d8e46a06f.size] = node;
    }
  }

  return var_8b1a576d8e46a06f;
}

function bot_filter_ambush_inuse(nodes) {
  assert(isDefined(nodes));
  resultnodes = [];
  now = gettime();
  nodessize = nodes.size;

  for(i = 0; i < nodessize; i++) {
    node = nodes[i];

    if(!isDefined(node.bot_ambush_end) || now > node.bot_ambush_end) {
      resultnodes[resultnodes.size] = node;
    }
  }

  return resultnodes;
}

function bot_filter_ambush_vicinity(nodes, bot, radius) {
  resultnodes = [];
  checkpoints = [];
  radiussq = radius * radius;

  if(level.teambased) {
    foreach(player in level.participants) {
      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isDefined(player.team)) {
        continue;
      }

      if(player.team == bot.team && player != bot && isDefined(player.node_ambushing_from)) {
        checkpoints[checkpoints.size] = player.node_ambushing_from.origin;
      }
    }
  }

  var_d3d9f13530067129 = checkpoints.size;
  nodessize = nodes.size;

  for(i = 0; i < nodessize; i++) {
    tooclose = 0;
    node = nodes[i];

    for(j = 0; !tooclose && j < var_d3d9f13530067129; j++) {
      distsq = distancesquared(checkpoints[j], node.origin);
      tooclose = distsq < radiussq;
    }

    if(!tooclose) {
      resultnodes[resultnodes.size] = node;
    }
  }

  return resultnodes;
}

function clear_camper_data() {
  self notify("clear_camper_data");

  if(isDefined(self.node_ambushing_from) && isDefined(self.node_ambushing_from.bot_ambush_end)) {
    self.node_ambushing_from.bot_ambush_end = undefined;
  }

  self.node_ambushing_from = undefined;
  self.point_to_ambush = undefined;
  self.ambush_yaw = undefined;
  self.ambush_entrances = undefined;
  self.ambush_duration = randomintrange(20000, 30000);
  self.ambush_end = -1;
}

function should_select_new_ambush_point() {
  if(bot_has_tactical_goal()) {
    return false;
  }

  if(gettime() > self.ambush_end) {
    return true;
  }

  if(!self bothasscriptgoal()) {
    return true;
  }

  return false;
}

function find_camp_node() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return bot_queued_process("find_camp_node_worker", &find_camp_node_worker);
}

function find_camp_node_worker() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death_or_disconnect");
  level endon("game_ended");
  clear_camper_data();

  if(!isDefined(level.zonecount) || level.zonecount <= 0) {
    return false;
  }

  myzone = getzonenearest(self.origin);
  targetzone = undefined;
  nextzone = undefined;
  faceangles = self getplayerangles();

  if(isDefined(myzone)) {
    zoneenemies = botzonenearestcount(myzone, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);

    if(!isDefined(zoneenemies)) {
      zoneenemies = botzonenearestcount(myzone, self.team, -1, "enemy_predict", ">", 0);
    }

    if(isDefined(zoneenemies)) {
      var_8125a9234b033718 = getzonenodeforindex(zoneenemies);
      linked_zones = getlinkednodes(var_8125a9234b033718);

      if(linked_zones.size == 0) {
        zoneenemies = undefined;
      }
    }

    if(!isDefined(zoneenemies)) {
      furthestdist = -1;
      furthestzone = -1;

      for(z = 0; z < level.zonecount; z++) {
        var_8125a9234b033718 = getzonenodeforindex(z);
        linked_zones = getlinkednodes(var_8125a9234b033718);

        if(linked_zones.size == 0) {
          continue;
        }

        zone_path = getzonepath(myzone, z);

        if(!isDefined(zone_path) || zone_path.size == 0) {
          continue;
        }

        var_8151fa2d560582fa = random(getzonenodes(z));

        if(isDefined(var_8151fa2d560582fa.targetname) && var_8151fa2d560582fa.targetname == "no_bot_random_path") {
          continue;
        }

        dist = distance2dsquared(getzoneorigin(z), self.origin);

        if(dist <= furthestdist) {
          continue;
        }

        furthestdist = dist;
        furthestzone = z;
      }

      if(furthestzone >= 0) {
        zoneenemies = furthestzone;
      }
    }

    if(!isDefined(zoneenemies)) {
      if(function_e0e7cc995b2f4194()) {
        assertmsg("<dev string:xbf>" + myzone + "<dev string:xec>" + getzoneorigin(myzone) + "<dev string:xfb>");
      }

      return false;
    }

    zonepath = getzonepath(myzone, zoneenemies);

    if(!isDefined(zonepath) || zonepath.size == 0) {
      if(function_e0e7cc995b2f4194()) {
        assertmsg("<dev string:x138>" + myzone + "<dev string:xec>" + getzoneorigin(myzone) + "<dev string:x15e>" + zoneenemies + "<dev string:xec>" + getzoneorigin(zoneenemies));
      }

      return false;
    }

    for(index = 0; index <= int(zonepath.size / 2); index++) {
      targetzone = zonepath[index];
      nextzone = zonepath[int(min(index + 1, zonepath.size - 1))];

      if(botzonegetcount(nextzone, self.team, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(targetzone) && isDefined(nextzone) && targetzone != nextzone) {
      faceangles = getzoneorigin(nextzone) - getzoneorigin(targetzone);
      faceangles = vectortoangles(faceangles);
    }
  }

  var_be95318b128cb635 = undefined;

  if(isDefined(targetzone)) {
    var_6039c1e5f7dfd683 = 1;
    zone_steps = 1;
    var_bd257189257844c3 = 0;

    while(var_6039c1e5f7dfd683) {
      var_def8cd540eab8dc = getzonenodesbydist(targetzone, 800 * zone_steps, 1);

      if(var_def8cd540eab8dc.size > 1024) {
        var_def8cd540eab8dc = getzonenodes(targetzone, 0);
      }

      wait 0.05;
      randomroll = randomint(100);

      if(randomroll < 66 && randomroll >= 33) {
        faceangles = (faceangles[0], faceangles[1] + 45, 0);
      } else if(randomroll < 33) {
        faceangles = (faceangles[0], faceangles[1] - 45, 0);
      }

      if(var_def8cd540eab8dc.size > 0) {
        while(var_def8cd540eab8dc.size > 1024) {
          var_def8cd540eab8dc[var_def8cd540eab8dc.size - 1] = undefined;
        }

        selectcount = int(clamp(var_def8cd540eab8dc.size * 0.15, 1, 10));

        if(var_bd257189257844c3) {
          var_def8cd540eab8dc = self botnodepickmultiple(var_def8cd540eab8dc, selectcount, selectcount, "node_camp", anglesToForward(faceangles), "lenient");
        } else {
          var_def8cd540eab8dc = self botnodepickmultiple(var_def8cd540eab8dc, selectcount, selectcount, "node_camp", anglesToForward(faceangles));
        }

        var_def8cd540eab8dc = bot_filter_ambush_inuse(var_def8cd540eab8dc);

        if(!isDefined(self.can_camp_near_others) || !self.can_camp_near_others) {
          var_1f46245610eec2e1 = 800;
          var_def8cd540eab8dc = bot_filter_ambush_vicinity(var_def8cd540eab8dc, self, var_1f46245610eec2e1);
        }

        if(var_def8cd540eab8dc.size > 0) {
          var_be95318b128cb635 = random_weight_sorted(var_def8cd540eab8dc);
        }
      }

      if(isDefined(var_be95318b128cb635)) {
        var_6039c1e5f7dfd683 = 0;
      } else if(isDefined(self.camping_needs_fallback_camp_location)) {
        if(zone_steps == 1 && !var_bd257189257844c3) {
          zone_steps = 3;
        } else if(zone_steps == 3 && !var_bd257189257844c3) {
          var_bd257189257844c3 = 1;
        } else if(zone_steps == 3 && var_bd257189257844c3) {
          var_6039c1e5f7dfd683 = 0;
        }
      } else {
        var_6039c1e5f7dfd683 = 0;
      }

      if(var_6039c1e5f7dfd683) {
        wait 0.05;
      }
    }
  }

  if(!isDefined(var_be95318b128cb635) || !self botnodeavailable(var_be95318b128cb635)) {
    return false;
  }

  self.node_ambushing_from = var_be95318b128cb635;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  self.ambush_yaw = faceangles[1];
  return true;
}

function function_e0e7cc995b2f4194() {
  if(!getdvarint(@ "hash_a4149c16169203e5", 0)) {
    return true;
  }

  if(!getdvarint(@ "hash_408bb6e481c357f4", 0)) {
    return true;
  }

  return false;
}

function find_ambush_node(var_b8b7e211f170a50d, var_dfe45df4596af64d) {
  clear_camper_data();

  if(isDefined(var_b8b7e211f170a50d)) {
    self.point_to_ambush = var_b8b7e211f170a50d;
  } else {
    var_b4a8e3757f09f084 = undefined;
    var_685b8946e5eac800 = getnodesinradius(self.origin, 5000, 0, 2000);

    if(var_685b8946e5eac800.size > 0) {
      var_b4a8e3757f09f084 = self botnodepick(var_685b8946e5eac800, var_685b8946e5eac800.size * 0.25, "node_exposed");
    }

    if(isDefined(var_b4a8e3757f09f084)) {
      self.point_to_ambush = var_b4a8e3757f09f084.origin;
    } else {
      return false;
    }
  }

  ambush_radius = 2000;

  if(isDefined(var_dfe45df4596af64d)) {
    ambush_radius = var_dfe45df4596af64d;
  }

  var_4703d99a1b9a1d4e = getnodesinradius(self.point_to_ambush, ambush_radius, 0, 1000);
  var_6cb886ab6cc39ae0 = undefined;
  assert(isDefined(var_4703d99a1b9a1d4e));

  if(var_4703d99a1b9a1d4e.size > 0) {
    selectcount = int(max(1, int(var_4703d99a1b9a1d4e.size * 0.15)));
    var_4703d99a1b9a1d4e = self botnodepickmultiple(var_4703d99a1b9a1d4e, selectcount, selectcount, "node_ambush", self.point_to_ambush);
  }

  assert(isDefined(var_4703d99a1b9a1d4e));
  var_4703d99a1b9a1d4e = bot_filter_ambush_inuse(var_4703d99a1b9a1d4e);

  if(var_4703d99a1b9a1d4e.size > 0) {
    var_6cb886ab6cc39ae0 = random_weight_sorted(var_4703d99a1b9a1d4e);
  }

  if(!isDefined(var_6cb886ab6cc39ae0) || !self botnodeavailable(var_6cb886ab6cc39ae0)) {
    return false;
  }

  self.node_ambushing_from = var_6cb886ab6cc39ae0;
  self.ambush_end = gettime() + self.ambush_duration;
  self.node_ambushing_from.bot_ambush_end = self.ambush_end;
  var_f145b0c599cca2dd = vectorNormalize(self.point_to_ambush - self.node_ambushing_from.origin);
  var_f9562f398e9050ea = vectortoangles(var_f145b0c599cca2dd);
  self.ambush_yaw = var_f9562f398e9050ea[1];
  return true;
}

function bot_random_path() {
  if(bot_is_remote_or_linked()) {
    return 0;
  }

  return self[[level.bot_random_path_function]]();
}

function bot_random_path_default() {
  result = 0;
  var_6f9e4387a0601b1b = 50;

  if(self.personality == "camper") {
    var_6f9e4387a0601b1b = 0;
  }

  goalpos = undefined;

  if(randomint(100) < var_6f9e4387a0601b1b) {
    goalpos = bot_recent_point_of_interest();
  }

  if(!isDefined(goalpos)) {
    goalpos = self botfindrandomgoal();
  }

  if(isDefined(goalpos)) {
    result = self botsetscriptgoal(goalpos, 128, "hunt");
  }

  return result;
}

function bot_setup_callback_class() {
  if(scripts\mp\bots\bots_loadout::function_a693c24def6fb1ed()) {
    return "callback";
  }

  return "class0";
}