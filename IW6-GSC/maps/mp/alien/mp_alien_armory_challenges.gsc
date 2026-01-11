/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\mp_alien_armory_challenges.gsc
********************************************************/

register_armory_challenges() {
  level.custom_onalienagentdamaged_func = ::armory_custom_onalienagentdamaged_func;
  level.challenge_ring_location_func = ::challenge_ring_locations;
  maps\mp\alien\_challenge_function::register_challenge("long_shot", undefined, 0, undefined, undefined, ::activate_long_shot, ::deactivate_long_shot, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("leaning_shot", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("sliding_shot", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("jump_shot", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("focus_fire", undefined, 0, undefined, undefined, ::generic_activate_challenge, ::deactivate_focus_fire, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("kill_marked", undefined, 0, undefined, undefined, ::activate_kill_marked, ::deactivate_kill_marked, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("barrel_kills", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("healthy_kills", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("minion_preexplode", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("kill_nodamage", undefined, 0, undefined, undefined, ::activate_kill_nodamage, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::update_kill_nodamage);
  maps\mp\alien\_challenge_function::register_challenge("kill_phantom", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("kill_eggs", undefined, 0, undefined, undefined, ::activate_shoot_spider_eggs, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("kill_spider", undefined, 0, undefined, undefined, ::activate_kill_spider, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
}

generic_activate_challenge() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  self.current_progress = 0;
  maps\mp\alien\_challenge_function::update_challenge_progress(0, self.goal);
}

generic_update_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.current_progress = self.current_progress + var_0;

  if(self.current_progress >= self.goal) {
    self.success = 1;
  }

  maps\mp\alien\_challenge_function::update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    level notify("current_challenge_ended");
    maps\mp\alien\_challenge::deactivate_current_challenge();
  } else if(maps\mp\alien\_utility::is_true(var_1)) {
    level notify("current_challenge_ended");
    self.success = 0;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_long_shot() {
  generic_activate_challenge();
  level thread long_shot_logic();
}

long_shot_logic() {
  level endon("stop_longshot_logic");

  for(;;) {
    foreach(var_6, var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
      if(!isalive(var_1)) {
        continue;
      }
      if(isDefined(var_1.pet)) {
        continue;
      }
      var_2 = undefined;

      foreach(var_4 in level.players) {
        if(is_long_shot(var_4, undefined, var_1)) {
          var_2 = 1;
          maps\mp\alien\_outline_proto::enable_outline_for_player(var_1, var_4, 0, 1, "high");
          continue;
        }

        if(isDefined(var_4.isferal) && var_4.isferal) {
          maps\mp\alien\_outline_proto::enable_outline_for_player(var_1, var_4, 4, 0, "high");
          continue;
        }

        maps\mp\alien\_outline_proto::disable_outline_for_player(var_1, var_4);
      }

      var_1.marked_for_challenge = var_2;

      if(var_6 % 2 == 0) {
        wait 0.05;
      }
    }

    wait 0.05;
  }
}

deactivate_long_shot() {
  level notify("stop_longshot_logic");

  foreach(var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
    if(isDefined(var_1.marked_for_challenge)) {
      var_1.marked_for_challenge = undefined;
      maps\mp\alien\_outline_proto::disable_outline(var_1);
    }
  }

  maps\mp\alien\_challenge_function::default_resetsuccess();
}

activate_kill_marked() {
  generic_activate_challenge();
  level thread wait_for_marked_aliens(self);
}

wait_for_marked_aliens(var_0) {
  level endon("current_challenge_ended");
  var_1 = 0;

  while(var_1 < var_0.goal) {
    var_2 = maps\mp\alien\_spawnlogic::get_alive_agents();

    foreach(var_4 in var_2) {
      if(!isalive(var_4) || isDefined(var_4.pet)) {
        continue;
      }
      if(var_4.alien_type == "spider" || maps\mp\alien\_utility::is_true(var_4.marked_for_challenge)) {
        continue;
      }
      var_4.marked_for_challenge = 1;
      maps\mp\alien\_outline_proto::enable_outline(var_4, 0, 1);
      var_4 thread remove_outline_on_death();
      var_1++;

      if(var_1 >= var_0.goal) {
        return;
      }
    }

    wait 0.05;
  }
}

deactivate_kill_marked() {
  foreach(var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
    if(isDefined(var_1.marked_for_challenge)) {
      var_1.marked_for_challenge = undefined;
      maps\mp\alien\_outline_proto::disable_outline(var_1);
    }
  }

  maps\mp\alien\_challenge_function::default_resetsuccess();
}

activate_kill_nodamage() {
  generic_activate_challenge();
  level thread fail_kill_nodamage(self);

  foreach(var_1 in level.players) {
    var_1 thread kill_nodamage_monitor();
  }
}

fail_kill_nodamage(var_0) {
  level endon("kill_nodamage_complete");
  level waittill("kill_nodamage_failed");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("kill_nodamage_complete");
}

kill_nodamage_monitor() {
  level endon("kill_nodamage_complete");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(maps\mp\alien\_utility::is_true(self.ability_invulnerable)) {
      continue;
    }
    if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::is_hardcore_mode()) {
      level notify("kill_nodamage_failed");
      return;
    } else if(isDefined(var_1) && isagent(var_1)) {
      level notify("kill_nodamage_failed");
      return;
    }
  }
}

update_kill_nodamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.current_progress = self.current_progress + var_0;

  if(self.current_progress >= self.goal) {
    self.success = 1;
  }

  maps\mp\alien\_challenge_function::update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    level notify("kill_nodamage_complete");
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

deactivate_focus_fire() {
  foreach(var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
    if(isDefined(var_1.damaged_by_players)) {
      maps\mp\alien\_outline_proto::disable_outline(var_1);
      var_1.damaged_by_players = [];
    }
  }

  maps\mp\alien\_challenge_function::default_resetsuccess();
}

activate_kill_spider() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  var_0 = int(gettime() + self.goal * 1000);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_timer", var_0);
  }

  level.current_challenge_timer = self.goal;
  level thread maps\mp\alien\_challenge_function::update_current_challenge_timer();
  level thread kill_spider_timer(self);
  thread update_kill_spider();
}

kill_spider_timer(var_0) {
  level endon("game_ended");
  level endon("spider_battle_end");
  wait(var_0.goal);
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("spider_challenge_failed");
}

update_kill_spider() {
  level endon("spider_challenge_failed");
  level waittill("spider_battle_end");
  self.success = 1;

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_shoot_spider_eggs() {
  generic_activate_challenge();
  level thread fail_spider_egg_challenge(self);
  level thread beat_spider_egg_challenge(self);
}

beat_spider_egg_challenge(var_0) {
  level endon("spider_battle_end");

  for(;;) {
    level waittill("egg_destroyed");
    maps\mp\alien\_challenge::update_challenge("kill_eggs", 1);
  }
}

fail_spider_egg_challenge(var_0) {
  level endon("current_challenge_ended");
  level waittill("spider_battle_end");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

armory_challenge_scalar_func(var_0) {
  var_1 = maps\mp\alien\_challenge_function::default_challenge_scalar_func(var_0);

  if(!isDefined(var_1)) {
    var_1 = get_scalar_from_table(var_0);
  }

  if(isDefined(var_1)) {}

  return var_1;
}

get_scalar_from_table(var_0) {
  var_1 = level.alien_challenge_table;
  var_2 = 0;
  var_3 = 1;
  var_4 = 99;
  var_5 = 1;
  var_6 = 9;

  for(var_7 = var_3; var_7 <= var_4; var_7++) {
    var_8 = tablelookup(var_1, var_2, var_7, var_5);

    if(var_8 == "") {
      return undefined;
    }

    if(var_8 != var_0) {
      continue;
    }
    var_9 = tablelookup(var_1, var_2, var_7, var_6);

    if(isDefined(var_9)) {
      var_9 = strtok(var_9, " ");

      if(var_9.size > 0) {
        return int(var_9[level.players.size - 1]);
      }
    }
  }
}

armory_damage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return;
  }
  switch (level.current_challenge) {
    case "focus_fire":
      if(!isDefined(var_8)) {
        return 0;
      }

      if(isDefined(var_1) && isplayer(var_1)) {
        if(!isDefined(var_8.damaged_by_players)) {
          var_8.damaged_by_players = [];
        }

        if(!common_scripts\utility::array_contains(var_8.damaged_by_players, var_1)) {
          var_8.damaged_by_players[var_8.damaged_by_players.size] = var_1;
          var_8 maps\mp\alien\_challenge_function::focus_fire_update_alien_outline(var_1);
        }
      }

      return 0;
  }

  return 1;
}

armory_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  switch (level.current_challenge) {
    case "long_shot":
      if(is_long_shot(var_1, var_4, self)) {
        maps\mp\alien\_challenge::update_challenge("long_shot", 1);
      }

      return 0;
    case "leaning_shot":
      if(isDefined(var_1) && isplayer(var_1) && isDefined(var_4) && var_4 == var_1 getcurrentweapon() && var_1 isleaning()) {
        maps\mp\alien\_challenge::update_challenge("leaning_shot", 1);
      }

      return 0;
    case "jump_shot":
      if(isDefined(var_1) && isplayer(var_1) && isDefined(var_4) && var_4 == var_1 getcurrentweapon() && !var_1 isonground()) {
        maps\mp\alien\_challenge::update_challenge("air_shot", 1);
      }

      return 0;
    case "sliding_shot":
      if(isDefined(var_1) && isplayer(var_1) && var_3 == "MOD_MELEE" && var_1 is_sliding()) {
        maps\mp\alien\_challenge::update_challenge("sliding_shot", 1);
      }

      return 0;
    case "focus_fire":
      if(isDefined(self.damaged_by_players) && self.damaged_by_players.size >= level.players.size) {
        maps\mp\alien\_challenge::update_challenge("focus_fire", 1);
        maps\mp\alien\_outline_proto::disable_outline_for_players(self, level.players);
      }

      return 0;
    case "kill_marked":
      if(isDefined(self.marked_for_challenge)) {
        maps\mp\alien\_challenge::update_challenge("kill_marked", 1);
      } else if(var_3 != "MOD_SUICIDE") {
        maps\mp\alien\_challenge::update_challenge("kill_marked", 0, 1);
      }

      return 0;
    case "barrel_kills":
      if(isDefined(var_1) && isplayer(var_1) && isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "scriptable_destructible_barrel") {
        maps\mp\alien\_challenge::update_challenge("barrel_kills", 1);
      }

      return 0;
    case "healthy_kills":
      if(isDefined(var_1) && isplayer(var_1) && var_1.health >= var_1.maxhealth) {
        maps\mp\alien\_challenge::update_challenge("healthy_kills", 1);
      }

      return 0;
    case "minion_preexplode":
      if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::get_alien_type() == "minion" && var_3 != "MOD_SUICIDE") {
        maps\mp\alien\_challenge::update_challenge("minion_preexplode", 1);
      }

      return 0;
    case "kill_phantom":
      if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::get_alien_type() == "locust" && maps\mp\alien\_utility::is_true(self.is_cloaking)) {
        maps\mp\alien\_challenge::update_challenge("kill_phantom", 1);
      }

      return 0;
    case "kill_nodamage":
      if(isDefined(var_1) && isplayer(var_1)) {
        maps\mp\alien\_challenge::update_challenge("kill_nodamage", 1);
      }

      return 0;
  }

  return 1;
}

is_long_shot(var_0, var_1, var_2) {
  if(isplayer(var_0) && isalive(var_0) && !var_0 maps\mp\_utility::isusingremote()) {
    if(distancesquared(var_0.origin, var_2.origin) >= 608400) {
      return 1;
    }
  }

  return 0;
}

is_sliding() {
  return isDefined(self.issliding) || isDefined(self.isslidinggraceperiod) && gettime() <= self.isslidinggraceperiod;
}

remove_outline_on_death() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.challenge_headicon)) {
    maps\mp\alien\_outline_proto::disable_outline(self);
  }
}

armory_custom_onalienagentdamaged_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "scriptable_destructible_barrel") {
    var_2 = var_2 + 750;
  }

  return var_2;
}

challenge_ring_locations(var_0) {
  var_1 = [];

  if(isDefined(level.drill)) {
    var_1[var_1.size] = level.drill.origin + (0, 0, 15);
  }

  switch (var_0) {
    case "checkpoint_hive_01":
      var_1[var_1.size] = (-3904, -6944, 656);
      var_1[var_1.size] = (-3296, -6688, 800);
      break;
    case "checkpoint_hive_02":
      var_1[var_1.size] = (-2304, -6848, 620);
      var_1[var_1.size] = (-2384, -5472, 620);
      var_1[var_1.size] = (-1824, -6592, 796);
      break;
    case "checkpoint_hive_03":
      var_1[var_1.size] = (-2656, -6336, 796);
      break;
    case "checkpoint_hive_04":
      var_1[var_1.size] = (-2754.5, -5745.5, 818.545);
      var_1[var_1.size] = (-1775.5, -6317, 818.545);
      break;
    case "checkpoint_hive_05":
      var_1[var_1.size] = (-3619.5, -5835.5, 598.5);
      var_1[var_1.size] = (-3907, -6235.5, 636.956);
      var_1[var_1.size] = (-3088.5, -5738, 804.456);
      break;
    case "compound_hive_01":
      var_1[var_1.size] = (-2716, -5047, 847.545);
      var_1[var_1.size] = (-2716, -4492.5, 847.545);
      var_1[var_1.size] = (-3600.5, -4886.5, 755.545);
      break;
    case "compound_hive_02":
      var_1[var_1.size] = (-3875.5, -4079, 721.045);
      var_1[var_1.size] = (-3025.5, -3949.5, 645.545);
      var_1[var_1.size] = (-3180, -4674.5, 607.545);
      break;
    case "compound_hive_03":
      var_1[var_1.size] = (-3872, -3136, 877.045);
      var_1[var_1.size] = (-3962.5, -3717, 639.045);
      var_1[var_1.size] = (-5127, -2992, 619.045);
      var_1[var_1.size] = (-4479.5, -3756, 844.545);
      break;
    case "compound_hive_04":
      var_1[var_1.size] = (-2954.78, -3323.5, 677.996);
      var_1[var_1.size] = (-2287.28, -3195, 677.996);
      break;
    case "compound_hive_05":
      var_1[var_1.size] = (-1269.28, -3383, 693.996);
      var_1[var_1.size] = (-1965.28, -3104, 711.996);
      break;
    case "compound_hive_06":
      var_1[var_1.size] = (-2138.28, -3246.5, 684.811);
      var_1[var_1.size] = (-1927.78, -3632, 817.811);
      var_1[var_1.size] = (-1770.78, -3315, 688.199);
      break;
    case "compound_hive_07":
      var_1[var_1.size] = (-3056.78, -2784, 851.996);
      var_1[var_1.size] = (-3381.28, -3157.5, 681.496);
      var_1[var_1.size] = (-3601.28, -3111.5, 878.496);
      break;
    case "compound_hive_08":
      var_1[var_1.size] = (-4069, -3665, 607.545);
      var_1[var_1.size] = (-3875.5, -4079, 721.045);
      var_1[var_1.size] = (-3180, -4674.5, 607.545);
      break;
    case "facility_hive_01":
      var_1[var_1.size] = (-2039.78, -1898, 684);
      var_1[var_1.size] = (-1550.78, -1185, 865.5);
      var_1[var_1.size] = (-2227.28, -1288, 684);
      break;
    case "facility_hive_02":
      var_1[var_1.size] = (-2927.28, -912.495, 681);
      var_1[var_1.size] = (-2816.78, -235.995, 818.5);
      var_1[var_1.size] = (-1671.78, -589.495, 862.5);
      break;
    case "facility_hive_03":
      var_1[var_1.size] = (-2852.78, -222.495, 845.5);
      var_1[var_1.size] = (-3284.28, -237.495, 812);
      var_1[var_1.size] = (-2559.28, -843.495, 1023);
      var_1[var_1.size] = (-3191.78, -1478, 812);
      break;
    case "facility_hive_04":
      var_1[var_1.size] = (-2527.28, -1754.5, 688.199);
      var_1[var_1.size] = (-3186.28, -1577.5, 810.699);
    case "facility_hive_05":
      var_1[var_1.size] = (-1666.28, -897.995, 860);
      var_1[var_1.size] = (-1322.28, -856.995, 1006);
      var_1[var_1.size] = (-2249.28, -1273.5, 1005.5);
    case "facility_hive_07":
      var_1[var_1.size] = (-1332.78, -871.995, 996.5);
      var_1[var_1.size] = (-2225.78, -1288, 990.5);
      var_1[var_1.size] = (-2631.28, -861.995, 990.5);
      break;
  }

  return common_scripts\utility::random(var_1);
}