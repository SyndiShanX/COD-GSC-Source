/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\mp_alien_dlc3_challenges.gsc
******************************************************/

register_dlc3_challenges() {
  level.custom_onalienagentdamaged_func = ::dlc3_custom_onalienagentdamaged_func;
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
  maps\mp\alien\_challenge_function::register_challenge("melee_5_goons_dlc3", undefined, 0, undefined, undefined, maps\mp\alien\_challenge_function::activate_melee_goons, maps\mp\alien\_challenge_function::deactivate_melee_goons, undefined, maps\mp\alien\_challenge_function::update_melee_goons);
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
    foreach(var_5, var_1 in maps\mp\alien\_spawnlogic::get_alive_agents()) {
      foreach(var_3 in level.players) {
        if(is_long_shot(var_3, undefined, var_1)) {
          var_1.marked_for_challenge = 1;
          maps\mp\alien\_outline_proto::enable_outline_for_player(var_1, var_3, 0, 1, "high");
          continue;
        }

        var_1.marked_for_challenge = undefined;

        if(isDefined(var_3.isferal) && var_3.isferal) {
          maps\mp\alien\_outline_proto::enable_outline_for_player(var_1, var_3, 4, 0, "high");
          continue;
        }

        maps\mp\alien\_outline_proto::disable_outline_for_player(var_1, var_3);
      }

      if(var_5 % 2 == 0) {
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
      if(!isalive(var_4) || maps\mp\alien\_utility::is_true(var_4.pet)) {
        continue;
      }
      if(var_4.alien_type == "bomber" || maps\mp\alien\_utility::is_true(var_4.marked_for_challenge)) {
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
    } else if(isDefined(var_1) && isagent(var_1) || var_5 == "alien_minion_explosion") {
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

dlc3_challenge_scalar_func(var_0) {
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

dlc3_damage_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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

dlc3_death_challenge_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
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
      }
      else {
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
        }
        else if(maps\mp\alien\_utility::get_alien_type() == "gargoyle" && maps\mp\alien\_utility::is_true(self.in_air)) {
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
          if(var_1.origin[2] - self.origin[2] > 100) {
            maps\mp\alien\_challenge::update_challenge("higher_ground", 1);
          }
        }
      }

      return 0;
    case "lower_ground":
      if(isDefined(var_1) && isplayer(var_1)) {
        if(!isDefined(var_0) || isDefined(var_0) && !maps\mp\alien\_utility::is_trap(var_0)) {
          if(self.origin[2] - var_1.origin[2] > 100) {
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
    case "semi_autos_only":
    case "2_weapons_only":
      maps\mp\alien\_challenge::update_challenge(level.current_challenge, var_4, var_3);
      return 0;
    case "melee_5_goons_dlc3":
      if(isDefined(self.alien_type) && self.alien_type == "goon" && isDefined(var_1) && isplayer(var_1) && var_3 == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_5_goons_dlc3", 1);
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

dlc3_custom_onalienagentdamaged_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_0) && isDefined(var_0.targetname) && var_0.targetname == "scriptable_destructible_barrel") {
    var_2 = var_2 + 750;
  }

  return var_2;
}

challenge_ring_locations(var_0) {
  var_1 = [];

  if(isDefined(level.drill)) {
    var_1[var_1.size] = level.drill.origin + (0, 0, 20);
  }

  switch (var_0) {
    case "area_01_hive_00":
      var_1[var_1.size] = (1539, -4996, 1260);
      var_1[var_1.size] = (315, -5325, 1013);
      break;
    case "area_01_hive_01":
      var_1[var_1.size] = (497, -4222, 1304);
      var_1[var_1.size] = (321, -4348, 1146);
      break;
    case "area_01_hive_02":
      var_1[var_1.size] = (1095, -4661, 957);
      var_1[var_1.size] = (1098, -4100, 1190);
      var_1[var_1.size] = (1539, -4996, 1260);
      break;
    case "area_01_hive_03":
      var_1[var_1.size] = (418, -3938, 1094);
      var_1[var_1.size] = (1372, -4020, 992);
      var_1[var_1.size] = (497, -4222, 1304);
      break;
    case "area_01_hive_04":
      var_1[var_1.size] = (1372, -4020, 992);
      var_1[var_1.size] = (1015, -4168, 1194);
      break;
    case "area_01_hive_05":
      var_1[var_1.size] = (754, -5036, 1389);
      var_1[var_1.size] = (1481, -4999, 1445);
      break;
    case "area_01_hive_06":
      var_1[var_1.size] = (882, -3373, 1500);
      var_1[var_1.size] = (497, -4222, 1304);
      break;
    case "area_01_hive_07":
      var_1[var_1.size] = (1450, -3124, 1404);
      var_1[var_1.size] = (865, -3329, 1524);
      break;
    case "area_01_hive_08":
      var_1[var_1.size] = (679, -2343, 1247);
      var_1[var_1.size] = (678, -3088, 1339);
      var_1[var_1.size] = (1074, -3053, 1147);
      break;
    case "area_01_hive_09":
      var_1[var_1.size] = (1450, -3124, 1404);
      var_1[var_1.size] = (1074, -3053, 1147);
      var_1[var_1.size] = (709, -2164, 1314);
      break;
    case "area_02_hive_01":
      var_1[var_1.size] = (-877, -1258, 1106);
      var_1[var_1.size] = (-922, -1395, 1259);
      var_1[var_1.size] = (-1227, -1813, 974);
      break;
    case "area_02_hive_02":
      var_1[var_1.size] = (-1227, -1813, 974);
      var_1[var_1.size] = (-2101, -1632, 1171);
      var_1[var_1.size] = (-1784, -1552, 1351);
      var_1[var_1.size] = (-2128, -1834, 1474);
      break;
    case "area_02_hive_03":
      var_1[var_1.size] = (-1579, -1258, 1277);
      var_1[var_1.size] = (-750, -213, 1299);
      break;
    case "area_02_hive_04":
      var_1[var_1.size] = (-2923, -2251, 956);
      break;
    case "area_02_hive_05":
      var_1[var_1.size] = (-3681, -2756, 1110);
      var_1[var_1.size] = (-3161, -2351, 1258);
      break;
    case "area_02_hive_06":
      var_1[var_1.size] = (-3758, -1862, 936);
      var_1[var_1.size] = (-2743, -2226, 1305);
      break;
    case "area_02_hive_07":
      var_1[var_1.size] = (-2640, -544, 1402);
      break;
    case "area_03_hive_01":
      var_1[var_1.size] = (-1433, 1450, 1158);
      var_1[var_1.size] = (-1654, 808, 1105);
      var_1[var_1.size] = (-1477, 1491, 951);
      var_1[var_1.size] = (-909, 827, 934);
      break;
    case "area_03_hive_02":
      var_1[var_1.size] = (-1433, 1450, 1158);
      var_1[var_1.size] = (-1477, 1491, 951);
      var_1[var_1.size] = (-2193, 1388, 998);
      var_1[var_1.size] = (-1759, 2007, 985);
      break;
    case "area_03_hive_03":
      var_1[var_1.size] = (-1580, 2449, 659);
      var_1[var_1.size] = (-1893, 3418, 719);
      var_1[var_1.size] = (-2525, 2805, 713);
      var_1[var_1.size] = (-1445, 2042, 941);
      break;
  }

  return common_scripts\utility::random(var_1);
}