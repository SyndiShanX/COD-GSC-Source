/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\mp_alien_last_challenges.gsc
******************************************************/

register_last_challenges() {
  level.custom_onalienagentdamaged_func = ::last_custom_onalienagentdamaged_func;
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
  maps\mp\alien\_challenge_function::register_challenge("bomber_preexplode", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("flying_aliens", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("melee_gargoyles", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("melee_mammoth", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("higher_ground", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("kill_rhinos", undefined, 0, undefined, undefined, ::activate_kill_rhinos, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("lower_ground", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("new_weapon", undefined, 0, undefined, undefined, ::activate_new_weapons, ::deactivate_new_weapons, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("team_prone", undefined, 0, undefined, undefined, ::generic_activate_challenge, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("semi_autos_only", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_use_weapon_challenge, maps\mp\alien\_challenge_function::deactivate_weapon_challenge_waypoints, undefined, ::update_semi_autos_only);
  maps\mp\alien\_challenge_function::register_challenge("2_weapons_only", undefined, 0, undefined, undefined, ::activate_2_weapons_only_challenge, ::deactivate_2_weapons_only, undefined, ::update_2_weapons_only);
  maps\mp\alien\_challenge_function::register_challenge("melee_5_goons_last", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_melee_goons, maps\mp\alien\_challenge_function::deactivate_melee_goons, undefined, maps\mp\alien\_challenge_function::update_melee_goons);
  maps\mp\alien\_challenge_function::register_challenge("stay_within_area_1", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::deactivate_stay_within_area, undefined, ::last_update_stay_within_area);
  maps\mp\alien\_challenge_function::register_challenge("stay_within_area_2", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::deactivate_stay_within_area, undefined, ::last_update_stay_within_area);
  maps\mp\alien\_challenge_function::register_challenge("stay_within_area_3", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::deactivate_stay_within_area, undefined, ::last_update_stay_within_area);
  maps\mp\alien\_challenge_function::register_challenge("stay_within_area_4", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::deactivate_stay_within_area, undefined, ::last_update_stay_within_area);
  maps\mp\alien\_challenge_function::register_challenge("stay_within_area_5", 10, 0, undefined, ::last_pre_activate_stay_within_area, maps\mp\alien\_challenge_function::activate_stay_within_area, maps\mp\alien\_challenge_function::deactivate_stay_within_area, undefined, ::last_update_stay_within_area);
  maps\mp\alien\_challenge_function::register_challenge("kill_ancestor", undefined, 0, undefined, undefined, ::activate_kill_ancestor, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("weakpoint_damage", undefined, 0, undefined, undefined, ::activate_weakpoint_damage, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
  maps\mp\alien\_challenge_function::register_challenge("no_ancestor_damage", undefined, 0, undefined, undefined, ::activate_no_ancestor_damage, maps\mp\alien\_challenge_function::default_resetsuccess, undefined, ::generic_update_challenge);
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
      if(var_4.alien_type == "bomber" || maps\mp\alien\_utility::is_true(var_4.marked_for_challenge) || var_4.alien_type == "ancestor") {
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

activate_kill_rhinos() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  level thread watch_rhino_deaths(self);
}

watch_rhino_deaths(var_0) {
  level endon("rhino_challenge_complete");
  level endon("end_cycle");
  level.current_challenge_timer = 0;
  level thread fail_rhino_challenge();

  for(;;) {
    level waittill("rhino_killed");

    if(level.current_challenge_timer <= 0) {
      var_1 = int(gettime() + 20000);

      foreach(var_3 in level.players) {
        var_3 setclientomnvar("ui_intel_timer", var_1);
      }

      level.current_challenge_timer = 20;
      level thread maps\mp\alien\_challenge_function::update_current_challenge_timer();
      continue;
    }

    level notify("rhinos_killed");
    var_0.success = 1;
    maps\mp\alien\_challenge::deactivate_current_challenge();
    return;
  }
}

fail_rhino_challenge(var_0) {
  level endon("game_ended");
  level endon("rhinos_killed");
  level waittill("current_challenge_ended");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("rhino_challenge_complete");
}

activate_new_weapons() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  level thread watch_players_new_weapons(self);
}

watch_players_new_weapons(var_0) {
  level endon("stop_newweapon_challenge_monitor");

  for(;;) {
    level waittill("new_weapon_purchased", var_1);
    var_1.new_weapon_purchased = 1;
    level thread check_for_new_weapon_complete(var_0);
  }
}

check_for_new_weapon_complete(var_0) {
  var_1 = 1;

  foreach(var_3 in level.players) {
    if(!maps\mp\alien\_utility::is_true(var_3.new_weapon_purchased)) {
      var_1 = 0;
    }
  }

  if(var_1) {
    var_0.success = 1;
    level notify("stop_newweapon_challenge_monitor");
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

deactivate_new_weapons() {
  level notify("stop_newweapon_challenge_monitor");
  maps\mp\alien\_challenge_function::default_resetsuccess();
}

last_challenge_scalar_func(var_0) {
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

last_damage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return;
  }
  switch (level.current_challenge) {
    case "weakpoint_damage":
      if(!isDefined(var_8)) {
        return 0;
      }

      if(isDefined(var_6) && (var_6 == "head" || var_6 == "neck") && var_2 > 0 && isDefined(var_8.alien_type) && var_8.alien_type == "ancestor") {
        maps\mp\alien\_challenge::update_challenge("weakpoint_damage", var_2);
      }

      return 0;
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

last_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level.current_challenge)) {
    return 0;
  }

  if(level.current_challenge == "kill_marked" && !isDefined(self.marked_for_challenge) && var_3 == "MOD_SUICIDE") {
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
        maps\mp\alien\_challenge::update_challenge("jump_shot", 1);
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
      } else {
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
    case "bomber_preexplode":
      if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::get_alien_type() == "bomber" && var_3 != "MOD_SUICIDE") {
        maps\mp\alien\_challenge::update_challenge("bomber_preexplode", 1);
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
    case "flying_aliens":
      if(isDefined(var_1) && isplayer(var_1)) {
        if(maps\mp\alien\_utility::get_alien_type() == "bomber" && var_3 != "MOD_SUICIDE") {
          maps\mp\alien\_challenge::update_challenge("flying_aliens", 1);
        } else if(maps\mp\alien\_utility::get_alien_type() == "gargoyle" && maps\mp\alien\_utility::is_true(self.in_air)) {
          maps\mp\alien\_challenge::update_challenge("flying_aliens", 1);
        } else if(maps\mp\alien\_utility::get_alien_type() == "ancestor" && var_3 != "MOD_SUICIDE") {
          maps\mp\alien\_challenge::update_challenge("flying_aliens", 1);
        }
      }

      return 0;
    case "melee_gargoyles":
      if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::get_alien_type() == "gargoyle" && var_3 == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_gargoyles", 1);
      }

      return 0;
    case "melee_mammoth":
      if(isDefined(var_1) && isplayer(var_1) && maps\mp\alien\_utility::get_alien_type() == "mammoth" && var_3 == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_mammoth", 1);
      }

      return 0;
    case "higher_ground":
      if(isDefined(var_1) && isplayer(var_1)) {
        if(!isDefined(var_0) || isDefined(var_0) && !maps\mp\alien\_utility::is_trap(var_0)) {
          if(var_1.origin[2] - self.origin[2] > 55) {
            maps\mp\alien\_challenge::update_challenge("higher_ground", 1);
          }
        }
      }

      return 0;
    case "lower_ground":
      if(isDefined(var_1) && isplayer(var_1)) {
        if(!isDefined(var_0) || isDefined(var_0) && !maps\mp\alien\_utility::is_trap(var_0)) {
          if(self.origin[2] - var_1.origin[2] > 55) {
            maps\mp\alien\_challenge::update_challenge("lower_ground", 1);
          }
        }
      }

      return 0;
    case "kill_rhinos":
      if(isDefined(self.alien_type) && self.alien_type == "elite") {
        level notify("rhino_killed");
      }

      return 0;
    case "team_prone":
      if(isDefined(var_1) && isplayer(var_1) && isDefined(var_4) && var_4 == var_1 getcurrentweapon()) {
        var_9 = 1;

        foreach(var_11 in level.players) {
          if(var_11 getstance() != "prone") {
            var_9 = 0;
          }
        }

        if(var_9) {
          maps\mp\alien\_challenge::update_challenge("team_prone", 1);
        }
      }

      return 0;
    case "2_weapons_only":
    case "semi_autos_only":
      maps\mp\alien\_challenge::update_challenge(level.current_challenge, var_4, var_3);
      return 0;
    case "melee_5_goons_last":
      if(isDefined(self.alien_type) && self.alien_type == "goon" && isDefined(var_1) && isplayer(var_1) && var_3 == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_5_goons_last", 1);
      }

      return 0;
    case "stay_within_area_5":
    case "stay_within_area_4":
    case "stay_within_area_3":
    case "stay_within_area_2":
    case "stay_within_area_1":
      if(isDefined(var_1) && isplayer(var_1)) {
        maps\mp\alien\_challenge::update_challenge(level.current_challenge, self.origin, var_1.origin);
      }

      break;
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

update_semi_autos_only(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = maps\mp\_utility::getweaponclass(var_0);

  if(var_9 == "weapon_sniper" || var_9 == "weapon_dmr") {
    self.current_progress++;
  }

  maps\mp\alien\_challenge_function::update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = 1;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_weakpoint_damage() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  self.current_progress = 0;
  self.goal = self.goal * 1000;
  maps\mp\alien\_challenge_function::update_challenge_progress(0, self.goal);
}

activate_no_ancestor_damage() {
  self.current_progress = 0;
  var_0 = int(gettime() + self.goal * 1000);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_timer", var_0);
  }

  level.current_challenge_timer = self.goal;
  level thread maps\mp\alien\_challenge_function::update_current_challenge_timer();
  level thread wait_for_ancestor_player_damage(self);
  level thread complete_ancestor_damage_challenge(self);
}

wait_for_ancestor_player_damage(var_0) {
  level endon("game_ended");
  var_0 endon("success");
  level endon("ancestor_damage_challenge_complete");
  level waittill("ancestor_damage_taken");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

complete_ancestor_damage_challenge(var_0) {
  level endon("game_ended");
  level endon("ancestor_damage_taken");
  wait(var_0.goal);
  var_0.success = 1;
  level notify("ancestor_damage_challenge_complete");
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

activate_kill_ancestor() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  self.current_progress = 0;
  var_0 = int(gettime() + self.goal * 1000);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_intel_timer", var_0);
  }

  level.current_challenge_timer = self.goal;
  level thread maps\mp\alien\_challenge_function::update_current_challenge_timer();
  level thread wait_for_ancestor_death(self);
  level thread fail_ancestor_challenge(self);
}

wait_for_ancestor_death(var_0) {
  level endon("game_ended");
  var_0 endon("success");
  level endon("ancestor_challenge_failed");
  level waittill("ancestor_died");
  var_0.success = 1;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

fail_ancestor_challenge(var_0) {
  level endon("game_ended");
  var_0 endon("success");
  level endon("ancestor_died");
  wait(var_0.goal);
  level notify("ancestor_challenge_failed");
  var_0.success = 0;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

update_2_weapons_only(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = maps\mp\_utility::getbaseweaponname(var_0);

  if(issubstr(self.weapon1choice, var_9) || issubstr(self.weapon2choice, var_9)) {
    self.current_progress++;
  }

  maps\mp\alien\_challenge_function::update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = 1;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_2_weapons_only_challenge() {
  descent_activate_use_weapon_challenge();
  var_0 = maps\mp\alien\_utility::get_current_area_name();
  var_1 = [];
  var_2 = [];
  var_3 = 0;
  var_4 = common_scripts\utility::array_randomize(level.world_items);

  foreach(var_6 in var_4) {
    if(isDefined(var_6.areas) && var_6.areas[0] == var_0) {
      if(!isDefined(var_6.script_noteworthy)) {
        continue;
      }
      if(common_scripts\utility::array_contains(var_1, var_6.script_noteworthy)) {
        continue;
      }
      var_1[var_1.size] = var_6.script_noteworthy;
      var_7 = maps\mp\alien\_challenge_function::create_challenge_waypoints(var_6);
      var_2[var_2.size] = var_7;
      var_3++;

      if(var_3 >= 2) {
        break;
      }
    }
  }

  self.weapon1choice = maps\mp\_utility::getbaseweaponname(var_1[0]);
  self.weapon2choice = maps\mp\_utility::getbaseweaponname(var_1[1]);
  self.waypoints = var_2;
}

deactivate_2_weapons_only() {
  if(isDefined(self) && isDefined(self.waypoints)) {
    foreach(var_1 in self.waypoints) {
      var_1 destroy();
    }
  }

  maps\mp\alien\_challenge_function::default_resetsuccess();
}

descent_activate_use_weapon_challenge() {
  maps\mp\alien\_challenge_function::default_resetsuccess();
  self.current_progress = 0;
  maps\mp\alien\_challenge_function::update_challenge_progress(0, self.goal);
}

remove_outline_on_death() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.challenge_headicon)) {
    maps\mp\alien\_outline_proto::disable_outline(self);
  }
}

last_custom_onalienagentdamaged_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_5) && var_5 == "turret_dlc4_alien_shock") {
    last_shock_turret_hit_marker_override(var_1, "standard");

    if(isDefined(level.shock_turret_bullet_damage_scalar)) {
      var_2 = var_2 * level.shock_turret_bullet_damage_scalar;
    }
  }

  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "scriptable_destructible_barrel") {
    var_2 = var_2 + 750;
  }

  return var_2;
}

last_shock_turret_hit_marker_override(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0.owner thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_1);
  } else {
    var_0 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_1);
  }
}

challenge_ring_locations(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "transition_middle":
      var_2[var_2.size] = (1772, 1335, 25);
      var_2[var_2.size] = (973, 1414, 19);
      var_2[var_2.size] = (525, 1991, 15);
      break;
    case "transition_right":
      var_2[var_2.size] = (1897, 775, 11);
      var_2[var_2.size] = (2068, 253, 23);
      var_2[var_2.size] = (2547, 1524, 19);
      break;
    case "transition_left":
      var_2[var_2.size] = (-886, 933, 11);
      var_2[var_2.size] = (-1442, 994, 19);
      var_2[var_2.size] = (-2130, 1786, 203);
      break;
    case "transition_upper_left":
      var_2[var_2.size] = (-996, 3690, 11);
      break;
    case "transition_upper_right":
      var_2[var_2.size] = (1771, 3236, 11);
      break;
  }

  if(maps\mp\alien\_utility::is_true(var_1)) {
    return var_2;
  } else {
    return common_scripts\utility::random(var_2);
  }
}

last_pre_activate_stay_within_area() {
  var_0 = get_all_ring_locations(level.current_hive_name);

  if(isDefined(level.current_encounter_info) && isDefined(level.current_encounter_info.use_trigger) && isDefined(level.current_encounter_info.use_trigger.script_noteworthy) && level.current_encounter_info.use_trigger.script_noteworthy == "reverse_open") {
    var_0 = common_scripts\utility::array_reverse(var_0);
  }

  var_1 = var_0[0];
  var_2 = bulletTrace(var_1 + (0, 0, 20), var_1 - (0, 0, 20), 0, undefined, 1, 0, 1, 1);
  self.ring_ent = spawn("script_model", var_2["position"]);
  self.ring_ent setModel("tag_origin");
  wait 0.1;
  self.ring_fx = playFXOnTag(level._effect["challenge_ring"], self.ring_ent, "tag_origin");
  playsoundatpos(self.ring_ent.origin, "plr_challenge_ring");

  if(!isDefined(level.waypoint_icon)) {
    if(isDefined(level.ring_waypoint_icon)) {
      level.ring_waypoint_icon destroy();
    }

    var_3 = "waypoint_alien_blocker";
    var_4 = 14;
    var_5 = 14;
    var_6 = 0.75;
    var_7 = self.ring_ent.origin + (0, 0, 32);
    level.ring_waypoint_icon = maps\mp\alien\_hud::make_waypoint(var_3, var_4, var_5, var_6, var_7);
  }

  level thread move_challenge_ring(var_0, var_1, self, 0);
  return 1;
}

get_all_ring_locations(var_0) {
  return challenge_ring_locations(var_0, 1);
}

move_challenge_ring(var_0, var_1, var_2, var_3) {
  level endon("ring_challenge_ended");
  var_4 = 0;

  while(!isDefined(var_2.current_progress)) {
    wait 0.05;
  }

  var_5 = var_2.current_progress;

  for(;;) {
    while(var_5 == var_2.current_progress) {
      wait 0.05;
    }

    common_scripts\utility::waitframe();
    var_6 = var_2.current_progress - var_5;
    var_5 = var_2.current_progress;
    var_4 = var_4 + var_6;

    if(var_4 < 5) {
      continue;
    } else {
      var_4 = 0;
    }

    var_3++;

    if(var_3 >= var_0.size) {
      var_3 = 0;
    }

    var_7 = var_0[var_3];
    var_8 = bulletTrace(var_7 + (0, 0, 20), var_7 - (0, 0, 20), 0, undefined, 1, 0, 1, 1);

    if(isDefined(level.ring_waypoint_icon)) {
      level.ring_waypoint_icon.alpha = 0;
    }

    var_2.ring_ent moveto(var_8["position"], 2);
    playsoundatpos(var_2.ring_ent.origin, "plr_challenge_ring");
    wait 2.0;

    if(isDefined(level.ring_waypoint_icon)) {
      level.ring_waypoint_icon.alpha = 1.0;
      level.ring_waypoint_icon.x = var_8["position"][0];
      level.ring_waypoint_icon.y = var_8["position"][1];
      level.ring_waypoint_icon.z = var_8["position"][2] + 32;
    }
  }
}

last_update_stay_within_area(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(abs(var_1[2] - self.ring_ent.origin[2]) > 75) {
    return;
  }
  var_9 = distancesquared(var_1, self.ring_ent.origin);

  if(var_9 > self.distance_check) {
    return;
  }
  self.current_progress++;

  if(self.current_progress >= self.goal) {
    self.success = 1;
  }

  var_10 = self.goal - self.current_progress;
  maps\mp\alien\_challenge_function::update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}