/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\mp_alien_beacon_challenges.gsc
********************************************************/

register_beacon_challenges() {
  level.custom_onalienagentdamaged_func = ::beacon_custom_onalienagentdamaged_func;
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
  maps\mp\alien\_challenge_function::register_challenge("kill_tentacle", undefined, 0, undefined, undefined, ::activate_kill_tentacle, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
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
  wait 1;

  foreach(var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
    foreach(var_3 in level.players) {
      if(isDefined(var_1.marked_for_challenge)) {
        maps\mp\alien\_outline_proto::disable_outline_for_player(var_1, var_3);
      }
    }

    var_1.marked_for_challenge = undefined;
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

activate_kill_tentacle() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  level thread fail_tentacle_challenge(self);
  level thread beat_tentacle_challenge(self);
}

beat_tentacle_challenge(var_0) {
  level endon("drill_detonated");
  level waittill("miniboss_beaten");
  var_0.success = 1;

  if(var_0.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

fail_tentacle_challenge(var_0) {
  level endon("miniboss_beaten");
  level waittill("drill_detonated");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

beacon_challenge_scalar_func(var_0) {
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

beacon_damage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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

beacon_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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

beacon_custom_onalienagentdamaged_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_5) && var_5 == "turret_minigun_alien_shock") {
    beacon_shock_turret_hit_marker_override(var_1, "standard");

    if(isDefined(level.shock_turret_bullet_damage_scalar)) {
      var_2 = var_2 * level.shock_turret_bullet_damage_scalar;
    }
  }

  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "scriptable_destructible_barrel") {
    var_2 = var_2 + 750;
  }

  return var_2;
}

beacon_shock_turret_hit_marker_override(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0.owner thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_1);
  } else {
    var_0 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_1);
  }
}

challenge_ring_locations(var_0) {
  var_1 = [];

  if(isDefined(level.drill)) {
    var_1[var_1.size] = level.drill.origin + (0, 0, 15);
  }

  switch (var_0) {
    case "mini_lung_00":
      var_1[var_1.size] = (-673, -697, 196);
      var_1[var_1.size] = (220, -2735, 188);
      var_1[var_1.size] = (-620, -2940, 60);
      break;
    case "well_deck_2":
      var_1[var_1.size] = (-186, -1823, 60);
      var_1[var_1.size] = (197, -1936, 188);
      break;
    case "well_deck_3":
      var_1[var_1.size] = (-1092, 87, -68);
      break;
    case "cargo_area_mini_1":
      var_1[var_1.size] = (521, 3238, 388);
      break;
    case "cargo_area_mini_2":
      var_1[var_1.size] = (40, 2564, 304);
      var_1[var_1.size] = (-577, 2159, 196);
      break;
    case "cargo_area_mini_3":
      break;
    case "cargo_area_mini_4":
      var_1[var_1.size] = (843, 2369, 244);
      var_1[var_1.size] = (-577, 2159, 196);
      break;
    case "cargo_area_main":
      break;
    case "top_deck_mini_1":
      var_1[var_1.size] = (-146, 3486, 1212);
      var_1[var_1.size] = (-46, 2461, 1212);
      break;
    case "top_deck_mini_2":
      var_1[var_1.size] = (218, 2991, 1348);
      var_1[var_1.size] = (-440, 3379, 1212);
      var_1[var_1.size] = (697, 2224, 1212);
      break;
    case "top_deck_mini_3":
      var_1[var_1.size] = (-10, 2756, 1348);
      var_1[var_1.size] = (-436, 2915, 1212);
      break;
    case "lab_mini_1":
      var_1[var_1.size] = (229, 5094, 1338);
      var_1[var_1.size] = (-768, 5276, 1338);
      var_1[var_1.size] = (159, 5307, 1468);
      break;
    case "lab_mini_2":
      var_1[var_1.size] = (-911, 5707, 1216);
      var_1[var_1.size] = (-277, 4604, 1468);
      var_1[var_1.size] = (-565, 5674, 1468);
      var_1[var_1.size] = (188, 5720, 1212);
      break;
    case "lab_mini_3":
      var_1[var_1.size] = (98, 4543, 1468);
      var_1[var_1.size] = (-741, 4914, 1468);
      var_1[var_1.size] = (-365, 4865, 1380);
      var_1[var_1.size] = (-909, 5309, 1216);
      break;
    case "lab_mini_4":
      var_1[var_1.size] = (-762, 4181, 1340);
      var_1[var_1.size] = (-210, 4854, 1380);
      var_1[var_1.size] = (224, 4710, 1338);
      break;
    case "lab_area_main":
      break;
  }

  return common_scripts\utility::random(var_1);
}