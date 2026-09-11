/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_agent_patrol.gsc
***********************************************/

function initpatrolpoints() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait 1;
  level.bestpatrolpoint = undefined;
  level.previouspatrolpoint = undefined;
  var_0 = scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy");
  level.allspatrolpoints = var_0;
  var_1 = 1;
  level.last_player_seen = 0;

  foreach(var_3 in var_0) {
    var_3.patrolscore = 0;
    var_3.id = var_1;
    var_3.personalscore = 0;
    var_1++;
  }

  if(scripts\engine\utility::flag_exist("patrolPoints_initialized")) {
    scripts\engine\utility::flag_set("patrolPoints_initialized");
  }

  thread spatrolpointscoring();
}

function set_default_soldier_values() {
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

function set_default_patrol_values() {
  self notify("patrol_values_set");
  setpatrolstate("patrol", "patrol", 0, 0, 0, undefined, 0, 1);
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.damaged = undefined;
  thread exit_patrol_mode();
  thread soldier_player_listener();
  self.stealth_initialized = 1;
}

function watchfornotifies(var_0) {
  var_0 endon("death");
  var_0 notify("watchForNotifies");
  var_0 endon("watchForNotifies");
  var_0.notifycounter = [];
  var_1 = ["death", "alerted", "texthandler", "set_goal_pos_requested", "goal_reached", "stalled", "patrol_path", "stop_patrol_logic", "watchForBulletWhizby", "exit_patrol_mode", "watchForSoldierKilled", "alertNearbyEnemiesAfterDelay", "watchForWeaponFire", "alertNearbyLoop", "soldier_investigate", "alerted_hunt_mode", "hunt_player", "exit_stealth", "soldier_player_listener", "patrol_values_set", "goal"];

  foreach(var_3 in var_1) {
    var_0.notifycounter[var_3] = 0;
  }

  for(;;) {
    var_5 = var_0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_1);
    var_0.notifycounter[var_5]++;
  }
}

function patrol_state_text_handler(var_0) {
  var_0 endon("death");
  var_0 notify("texthandler");
  var_0 endon("texthandler");
  var_1 = var_0 getentitynumber();

  for(;;) {
    if(getDvar("stealth_show_states") == "") {
      level waittill("show_stealth_states");
    }

    if(isDefined(var_0.patrol_state) && isDefined(var_0._blackboard.movetype)) {} else if(isDefined(var_0.patrol_state)) {}

    wait 0.05;
  }
}

function target_patrol_path(var_0) {
  self endon("stop_patrol_logic");
  self endon("death");
  self endon("alerted");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = var_1[randomint(var_1.size)];

  for(;;) {
    thread setcooldown(var_2, var_2);
    setgoalandtimeout(var_2.origin);
    thread unsetcooldown(var_2);

    if(isDefined(var_2.target)) {
      var_1 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
      var_2 = var_1[randomint(var_1.size)];
      continue;
    }

    break;
  }
}

function spatrolpointscoring() {
  level endon("game_ended");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }

  var_0 = 12;
  level.excludedpatrolpoints = [];
  var_1 = level.allspatrolpoints;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8.cooldown) && isDefined(var_8.startingcooldown)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * var_8.cooldown / var_8.startingcooldown;
      }

      var_9 = clamp(var_9, 0, 500);
      var_8.patrolscore = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

function zpatrolpointscoring() {
  level endon("game_ended");

  if(!isDefined(level.allzpatrolpoints) || level.allzpatrolpoints.size < 1) {
    return;
  }

  var_0 = 12;
  level.excludedpatrolpoints = [];
  var_1 = level.allzpatrolpoints;
  var_2 = [];
  var_3 = 9 / var_0;
  var_4 = 3 / var_0;
  var_5 = 5;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      var_9 = 0;

      if(istrue(var_8.cooldown) && isDefined(var_8.startingcooldown)) {
        var_10 = var_3 * 500;
        var_9 = var_10 * var_8.cooldown / var_8.startingcooldown;
      }

      var_9 = clamp(var_9, 0, 500);
      var_8.patrolscore = int(var_9);
      var_6++;

      if(var_6 % 10 == 0) {
        break;
      }
    }

    wait 0.05;
  }
}

function getscoredpatrolpoint2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = level.allspatrolpoints;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  } else {
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = "soldier_agent";
  }

  var_4 = 25;
  var_5 = scripts\cp\cp_agent_utils::getactiveagentsoftype(var_3);
  var_6 = sortbydistance(scripts\engine\utility::array_remove_array(var_1, var_2), var_0.origin);
  var_7 = [];
  var_8 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_5, undefined, 4, 256).size >= 3;
  var_9 = 5 / var_4;
  var_10 = 20 / var_4;

  foreach(var_12 in var_6) {
    var_13 = var_12.patrolscore;
    var_12.personalscore = 0;
    var_14 = 250;

    if(var_8 && distance(var_0.origin, var_12.origin) <= 500) {
      var_14 = 500;
    } else {
      var_15 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_12.origin);

      if(isDefined(var_12.target)) {
        var_16 = scripts\engine\utility::getStructArray(var_12.target, "targetname");

        if(var_16.size > 1) {
          var_17 = var_10 * 500;
          var_14 -= var_17;
        }

        var_18 = var_9 * 500;
        var_14 = var_18 * var_15;
      } else {
        var_14 = 500 * var_15;
      }
    }

    var_14 = clamp(var_14, 0, 500);
    var_14 = clamp(var_14 + var_13, 0, 999);
    var_12.personalscore = int(var_14);
    var_7 = var_12;

    if(var_14 <= 50) {
      return var_12;
    }
  }

  var_20 = scripts\cp\utility::array_sort_by_handler(var_7, &getpersonalpatrolscore)[0];
  return var_20;
}

function getpersonalpatrolscore() {
  if(isDefined(self.personalscore)) {
    return self.personalscore;
  }

  return 999;
}

function getpatrolscore() {
  if(isDefined(self.patrolscore)) {
    return self.patrolscore;
  }

  return 0;
}

function setcooldown(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("setCooldown");
  var_0 endon("setCooldown");
  var_0 endon("unsetCooldown");
  var_2 = 0.5 * var_1;
  var_2 = clamp(var_2, 0.1, var_2);
  var_3 = gettime() + var_2 * 1000;
  var_4 = var_1 / 20;
  var_4 = clamp(var_4, 0.05, var_4);
  var_5 = 0;
  var_0.patrolscore = 500;
  var_0.startingcooldown = var_1;

  while(gettime() < var_3) {
    var_0.cooldown = 20 - var_5;
    var_5++;
    wait var_4;
  }
}

function unsetcooldown(var_0) {
  var_0 notify("unsetCooldown");
  var_0.cooldown = undefined;
  var_0.startingcooldown = undefined;
}

function watchforstalledpos(var_0) {
  self notify("watchForStalledPos");
  self endon("watchForStalledPos");
  self endon("death");
  self endon("alerted");
  self endon("goal");
  self endon("goal_reached");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  var_1 = self.origin;
  var_2 = 0;
  var_3 = 10;

  for(;;) {
    if(self.origin == var_1) {
      var_2++;
    }

    if(var_2 >= var_3) {
      break;
    }

    wait 0.25;
  }

  self notify("stalled");
}

function setgoalandtimeout(var_0, var_1, var_2) {
  self notify("setGoalAndTimeout");
  self endon("setGoalAndTimeout");
  self endon("death");
  self endon("alerted");

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_0)) {
    var_3 = getclosestpointonnavmesh(var_0);
    thread watchforstalledpos(var_2);
    _setgoalpos(self, var_3, var_1);
    return;
  }

  wait 0.25;
}

function _setgoalpos(var_0, var_1, var_2) {
  var_0 notify("set_goal_pos_requested");
  var_0 endon("set_goal_pos_requested");
  var_0 endon("death");
  var_0 endon("stalled");

  if(isDefined(var_2)) {
    var_0.goalradius = var_2;
  } else {
    var_0.goalradius = 32;
  }

  var_3 = 0;

  foreach(var_5 in level.nearbyposarray) {
    if(distance(var_5, var_1) <= var_0.goalradius) {
      var_3 = 1;
      break;
    }
  }

  var_7 = 1;

  if(var_3) {
    var_8 = getrandomnavpoints(var_1, 50, 10, undefined, getrandomnavpoint(var_1, 32), 25);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_7 = 0;

      foreach(var_5 in level.nearbyposarray) {
        if(distance(var_5, var_11) <= 32) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1 = var_11;
        break;
      }
    }
  }

  thread manageposarray(var_0, var_1);
  var_0 setbtgoalpos(0, var_1);
  var_15 = var_0 scripts\engine\utility::ref_143ad("goal", "goal_reached");
}

function manageposarray(var_0, var_1) {
  if(isDefined(var_1)) {
    level.nearbyposarray[level.nearbyposarray.size] = var_1;
    var_2 = var_0 scripts\engine\utility::waittill_any_in_array_return(["death", "set_goal_pos_requested", "alerted", "exit_stealth", "new_goal", "alerted_by_ai"]);

    if(scripts\engine\utility::array_contains(level.nearbyposarray, var_1)) {
      level.nearbyposarray = scripts\engine\utility::array_remove(level.nearbyposarray, var_1);
      return;
    }

    return;
  }
}

function patrol_path(var_0, var_1) {
  self notify("patrol_path");
  self endon("patrol_path");
  self endon("death");
  self endon("alerted");
  self endon("stop_patrol_logic");

  if(!isDefined(level.allspatrolpoints) || level.allspatrolpoints.size < 1) {
    return;
  }

  if(isDefined(level.allspatrolpoints) || level.allspatrolpoints.size > 1) {
    var_2 = level.allspatrolpoints;
    var_3 = scripts\engine\utility::array_combine([var_0], level.excludedpatrolpoints);
    var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, var_3, 10);

    if(var_4.size < 1) {
      var_2 = scripts\engine\utility::getStructArray(var_0.targetname, "targetname");
      var_4 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray(var_0.targetname, "targetname"), var_3, 5);
    }

    var_5 = scripts\engine\utility::getclosest(var_0.origin, var_4, 256);

    if(isDefined(var_5)) {
      var_6 = var_5;
    } else {
      var_6 = getscoredpatrolpoint2(self, var_5);
    }

    var_7 = var_6;
    var_4 = scripts\engine\utility::array_combine([var_6, var_7], level.excludedpatrolpoints);

    for(;;) {
      thread setcooldown(var_6, var_6);
      thread removeifalerted(self, var_6);
      setgoalandtimeout(var_6.origin);
      self.onpatrolpath = undefined;
      unsetcooldown(var_6);

      if(scripts\engine\utility::cointoss()) {
        wait randomfloatrange(2.5, 5);
      }

      var_3 = level.allspatrolpoints;

      if(isDefined(var_6)) {
        var_7 = var_6;
      }

      var_4 = scripts\engine\utility::array_combine([var_7, var_6], level.excludedpatrolpoints);
      var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_3, var_4, 5);
      var_6 = getscoredpatrolpoint2(self, var_5, var_4);
    }
    LOC_00000179:

      return;
  }
}

function removeifalerted(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("goal_reached");
  var_0 endon("goal");
  var_0 endon("stalled");
  var_0 endon("death");
  var_0 scripts\engine\utility::ref_143a5("death", "alerted");
  addtopatrolexclusion(0, var_1);
}

function addtopatrolexclusion(var_0, var_1) {
  if(istrue(var_0) && !scripts\engine\utility::array_contains(level.excludedpatrolpoints, var_1)) {
    level.excludedpatrolpoints = scripts\engine\utility::array_add(level.excludedpatrolpoints, var_1);
    return;
  }

  if(scripts\engine\utility::array_contains(level.excludedpatrolpoints, var_1)) {
    level.excludedpatrolpoints = scripts\engine\utility::array_remove(level.excludedpatrolpoints, var_1);
    return;
  }
}

function watchforbulletwhizby() {
  self notify("watchForBulletWhizby");
  self endon("watchForBulletWhizby");
  level endon("game_ended");
  self endon("death");
  self endon("alerted");

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1, var_2, var_3);

    if(isPlayer(var_0)) {
      self notify("stop_patrol_logic");
      setpatrolstate("investigating_whizby", "cqb", 0, 1, 0, var_2);
      break;
    }
  }
}

function exit_patrol_mode() {
  self notify("exit_patrol_mode");
  self endon("exit_patrol_mode");
  self endon("death");
  self endon("alerted");
  thread watchforweaponfire();
  thread watchforbulletwhizby();
  thread watchforsoldierkilled(self);
  thread scripts\cp\cp_trigger_spawn::soldier_player_listener();

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_ents_return(self, "damage", self, "explode", self, "alerted_by_soldier", level, "large_explosion");

    if(!isDefined(var_0)) {
      continue;
    }

    if(istrue(self.posted)) {
      if(var_0 != "damage") {
        break;
      } else {
        continue;
      }

      continue;
    }

    break;
  }

  var_1 = 2;
  var_2 = 1;
  var_3 = 1;
  var_4 = 0;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "alerted_by_soldier":
        setpatrolstate("alerted_by_soldier", "combat", 1, 0, 0, undefined);
        var_2 = 1;
        var_3 = 0;
        var_4 = 0;
        break;
      case "damage":
        setpatrolstate("damaged", "combat", 1, 0, 0, undefined, 1);
        self.damaged = 1;
        var_3 = 1;
        var_4 = 1;
        break;
    }

    return;
  }
}

function watchforsoldierkilled(var_0) {
  var_0 notify("watchForSoldierKilled");
  var_0 endon("watchForSoldierKilled");
  var_0 endon("death");
  var_0 endon("alerted");

  for(;;) {
    var_1 = 0;
    level waittill("ai_killed", var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_7 != var_0.team) {
      continue;
    }

    if(istrue(var_0.posted)) {
      continue;
    }

    var_1 = isPlayer(var_5);
    var_8 = scripts\engine\math::get_dot(var_0.origin, var_0 getplayerangles(1), var_2);

    if(var_8 >= 0.573576 && sighttracepassed(var_0 getEye(), var_2, 0, var_0, 1)) {
      setpatrolstate(var_0, "witnessed_friendly_death", "sprint", 0, 1, 0, var_2, 0);
      break;
    }
  }
}

function setpatrolstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    if(var_1 == "cqb") {
      scripts\common\utility::demeanor_override("cqb");
      var_1 = "combat";
    } else if(var_1 == "combat") {
      scripts\common\utility::demeanor_override("combat");
    }

    scripts\asm\asm_bb::bb_requestmovetype(var_1);
  }

  self notify(var_0);
  self.patrol_state = var_0;
  var_9 = istrue(self.behinddoors);

  if(istrue(var_6)) {
    thread alertnearbyenemiesafterdelay(undefined, undefined, 1, 1);
  }

  if(istrue(var_7)) {
    if(isDefined(self.spawnpoint.target)) {
      thread target_patrol_path(self.spawnpoint);
      return;
    }

    thread _startsoldierpatrol(self);
    return;
  }

  if(istrue(var_4)) {
    thread alerted_hunt_mode(self);
    return;
  }

  if(istrue(var_3)) {
    if(isDefined(var_5)) {
      thread soldier_investigate(self, var_5);
      return;
    }

    var_10 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(var_10)) {
      thread soldier_investigate(self, var_10.origin);
      return;
    }

    thread soldier_investigate(self, getrandomnavpoint(self.origin, 256));
    return;
  }

  if(istrue(var_3)) {
    thread enter_combat();
    return;
  }
}

function alertnearbyenemiesafterdelay(var_0, var_1, var_2, var_3) {
  self notify("alertNearbyEnemiesAfterDelay");
  self endon("alertNearbyEnemiesAfterDelay");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  wait var_1;
  thread alert_all_nearby_enemies(var_0, var_2, undefined, var_3);
}

function watchforweaponfire() {
  level endon("game_ended");
  self notify("watchForWeaponFire");
  self endon("watchForWeaponFire");
  self endon("alerted");
  self endon("death");
  var_0 = 1500;

  for(;;) {
    level waittill("weapon_fired", var_1, var_2, var_3);

    if(istrue(self.posted)) {
      continue;
    }

    if(isagent(var_3) && var_3.team == self.team) {
      continue;
    }

    var_0 = 1500;

    if(isPlayer(var_3)) {
      var_0 *= var_3.perk_data["stealth_weapon_noise_scalar"];
    }

    var_4 = 0;

    foreach(var_6 in var_2.attachments) {
      if(issubstr(var_6, "silencer")) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      continue;
    }

    if(istrue(self.damaged)) {
      var_0 = int(var_0 * 1.5);
    }

    if(distance(var_1, self.origin) > var_0) {
      continue;
    }

    setpatrolstate("investigating_weapon_fire", "sprint", 0, 1, 0, var_1, 0);
    break;
  }
}

function canpathtotarget(var_0, var_1) {
  var_2 = var_0 findpath(var_0.origin, var_1, 0, 0);

  if(var_2.size >= 1 && distance(var_2[var_2.size - 1], var_1) <= 64) {
    return 1;
  }

  return 0;
}

function alertnearbyloop(var_0) {
  var_0 notify("alertNearbyLoop");
  var_0 endon("alertNearbyLoop");
  var_0 endon("death");
  var_0 endon("patrol_values_set");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::ref_143ac("shooting");
    thread alertnearbyenemiesafterdelay();

    if(var_1 == "shooting") {
      wait 0.5;
    }
  }
}

function enter_combat() {
  self notify("alerted");
  self notify("enter_combat");
  self.goalradius = 64;
  self.nocorpse = undefined;
  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  scripts\common\utility::demeanor_override("frantic");
  thread get_enemy_info_loop(5);
}

function get_enemy_info_loop(var_0) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");
  var_1 = get_closest_available_player();

  if(!isDefined(var_1)) {
    level notify("no_target_player_found");
    return;
  } else {
    self clearentitytarget();
    self getenemyinfo(var_1);
    self.favoriteenemy = var_1;

    if(!isDefined(var_1.enemy_list)) {
      var_1.enemy_list = [];
    }

    if(!isDefined(self.target_enemy) || self.target_enemy != var_1) {
      self notify("changed_target");
      thread scripts\engine\utility::thread_on_notify_no_endon_death("changed_target", &clear_enemy_flags, var_1);
      thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &clear_enemy_flags, var_1);

      if(!scripts\engine\utility::array_contains(var_1.enemy_list, self)) {
        var_1.enemy_list[var_1.enemy_list.size] = self;
      }
    }

    self.target_enemy = var_1;
  }

  if(isDefined(self.script_goalvolume)) {
    self setgoalvolumeauto(self.script_goalvolume);
    return;
  }
}

function movetocovernode(var_0) {
  self setbtgoalnode(1, var_0);
  self setbtgoalRadius(1, self.goalradius);
  self setbtgoalheight(1, self.goalheight);
  self setbtgoalpos(0, var_0.origin);
  self.movetocovernodestarttime = gettime();
  self.movetocovernode = var_0;
  thread clearbtgoalonarrival();
}

function clearbtgoalonarrival() {
  self endon("death");
  self notify("ClearBTGoalArrival_reset");
  self endon("ClearBTGoalArrival_reset");
  self waittill("goal_reached");
  self clearbtgoal(1);
}

function get_closest_available_player() {
  var_0 = sortbydistance(level.players, self.origin);

  foreach(var_2 in var_0) {
    if(var_2 scripts\cp\utility::is_valid_player()) {
      if(!isDefined(var_2.hunted_count) || var_2.hunted_count.size < 3) {
        return var_2;
      }

      if(!isDefined(var_2.enemy_list) || var_2.enemy_list.size < int(24 / level.players.size)) {
        return var_2;
      }
    }
  }

  if(isDefined(self.enemy)) {
    return self.enemy;
  }

  return undefined;
}

function clear_enemy_flags(var_0) {
  if(isDefined(var_0)) {
    var_0.enemy_list = scripts\engine\utility::array_remove(var_0.enemy_list, self);
    return;
  }
}

function clear_hunted_flags(var_0) {
  if(isDefined(var_0)) {
    var_0.hunted_count = scripts\engine\utility::array_remove(var_0.hunted_count, self);
    return;
  }
}

function clear_pos_from_hunt_pos_array(var_0) {
  if(isDefined(var_0)) {
    var_0.hunted_count = scripts\engine\utility::array_remove(var_0.hunted_count, self);
    return;
  }
}

function hunt_player_delayed() {
  self endon("death");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  hunt_player(var_0, var_1);
}

function soldier_investigate(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("soldier_investigate");
  var_0 endon("soldier_investigate");
  var_0 endon("alerted");
  var_0 endon("death");
  setgoalandtimeout(var_0, var_1);

  if(var_0 scripts\cp\cp_trigger_spawn::trigger_temp_stealth_meter(2.6, undefined, "investigate")) {
    wait 5;

    foreach(var_3 in scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent")) {
      thread setalertedhuntmode(var_3);
    }
  }

  wait 5;
  thread setalertedhuntmode(var_0);
}

function alerted_hunt_mode(var_0) {
  var_0 notify("stop_patrol_logic");
  var_0 notify("alerted_hunt_mode");
  var_0 endon("alerted_hunt_mode");
  var_0 endon("hunt_player");
  var_0 endon("death");
  var_0 endon("patrol_values_set");
  var_0 endon("alerted");
  var_0.soldierhuntmode = undefined;
  var_0.alertedhuntmode = undefined;
  var_0.alerted_hunt_mode = 1;
  var_0.no_fallback = 1;

  for(;;) {
    if(istrue(var_0.behinddoors)) {
      var_1 = getnodesinradiussorted(var_0.origin, 512, 0, 24, "Cover");
      setgoalandtimeout(var_0, var_1[0].origin);
      continue;
    }

    var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_0 scripts\cp\utility::get_closest_living_player(), var_0);

    if(!isDefined(var_2)) {
      var_2 = var_0;
    }

    var_3 = getrandomnavpoint(var_2.origin, 1024);

    if(isDefined(var_3)) {
      setgoalandtimeout(var_0, var_3);
    } else {
      var_3 = getrandomnavpoint(var_0.origin, 256);
      setgoalandtimeout(var_0, var_3);
    }
  }
}

function hunt_player(var_0, var_1) {
  level endon("game_ended");
  self notify("hunt_player");
  self endon("hunt_player");
  self endon("death");

  if(isDefined(var_0)) {
    wait var_0;
  }

  while(!should_hunt_player()) {
    wait 1;
  }

  self.hunting_player = 1;
  self.no_fallback = 1;

  for(;;) {
    var_2 = scripts\cp\utility::get_closest_living_player();

    if(isalive(var_2)) {
      self getenemyinfo(var_2);
      self setgoalentity(var_2, 3);
    }

    wait 3;
  }
}

function should_hunt_player() {
  var_0 = 0;
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.hunting_player)) {
      var_0++;
    }
  }

  if(var_0 > level.players.size * 2) {
    return 0;
  }

  return 1;
}

function reduce_goalradius_over_time(var_0) {
  self notify("reduce_goalradius_over_time");
  self endon("reduce_goalradius_over_time");
  self endon("death");
  self endon("patrol_values_set");
  jumpiftrue(isDefined(var_0)) LOC_00000028;
  var_0 = 2;

  for(;;) {
    var_1 = self.goalradius - 100;

    if(self.goalradius < 250) {
      self.goalradius = 250;
    } else {
      self.goalradius = var_1;
    }

    wait var_0;
  }
}

function setweaponsfree(var_0) {
  var_0 notify("setWeaponsFree");
  var_0 endon("setWeaponsFree");
  var_0 endon("death");
  level endon("clearWeaponsFree");
  level endon("game_ended");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::ref_143ba(5, "shooting", "spotted_player");

    if(isDefined(var_1)) {
      if(var_1 != "timeout") {
        continue;
      }

      thread setalertedhuntmode(var_0);
      return;
    }
  }
}

function toggleweaponsfree(var_0) {
  if(istrue(var_0)) {
    scripts\engine\utility::flag_set("weapons_free");
    return;
  }

  scripts\engine\utility::flag_clear("weapons_free");
}

function clearweaponsfree() {
  level notify("clearWeaponsFree");

  foreach(var_1 in scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent")) {
    thread setalertedhuntmode(var_1);
  }
}

function setalertedhuntmode(var_0) {
  set_default_soldier_values(var_0);

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    setpatrolstate(var_0, "alerted_hunt_mode", "cqb", 0, 0, 1, undefined, 0);
    return;
  }

  setpatrolstate(var_0, "spotted_player", "combat", 1, 0, 0, undefined, 1);
}

function _startsoldierpatrol(var_0) {
  set_default_soldier_values(var_0);
  thread patrol_path(var_0, var_0.spawnpoint);
}

function soldier_player_listener() {
  level endon("game_ended");
  self notify("soldier_player_listener");
  self endon("soldier_player_listener");
  self endon("alerted");
  self endon("death");
  var_0 = ["dx_otn_usm1_exposed", "dx_otn_usm1_exposed_breaking", "dx_otn_usm1_exposed_open", "dx_otn_usm1_exposed_movement", "dx_otn_usm1_exposed_acquired"];

  for(;;) {
    foreach(var_2 in level.players) {
      if(isplayernearme(self, var_2)) {
        if(isDefined(level.last_player_seen) && gettime() >= level.last_player_seen + 5000) {
          level.last_player_seen = gettime();
          scripts\cp\utility::playsoundatpos_safe(self.origin, scripts\engine\utility::random(var_0));
        }

        setpatrolstate("spotted_player", "combat", 1, 0, 0, undefined, 1);
        return;
      }
    }

    wait 0.1;
  }
}

function isplayernearme(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(istrue(var_1.ignoreme)) {
    return false;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);

  if(var_3 < 96) {
    if(vectordot(anglesToForward(var_0.angles), vectorNormalize(var_1.origin - var_0.origin)) > 0) {
      return true;
    }
  }

  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128) {
    var_5 = 0.75;
  } else if(var_7 < 200 || var_2 && var_1.perk_data["stealth_velocity_override"]) {
    var_5 = 1;
  } else {
    var_5 = 1.25;
  }

  if(var_3 > 1500 * var_5) {
    return false;
  }

  var_8 = var_0 cansee(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10) {
      return false;
    }

    var_11 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11) {
      return false;
    }

    var_12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12)) {
      return false;
    }

    var_13 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576) {
      var_5 -= 0.34;
    }

    if(var_4) {
      var_5 -= 0.34;
    }

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "prone") {
        return false;
      }

      return true;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "prone") {
        return false;
      }

      return true;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "prone" || var_14 == "crouch") {
        return false;
      }

      return true;
    }
  }

  return false;
}

function alert_all_nearby_enemies(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    toggleweaponsfree(1);
  }

  var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  var_3 = istrue(var_3);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6) || var_6 == self) {
      continue;
    }

    if(!isDefined(var_6.agent_type) || isDefined(var_6.agent_type) && var_6.agent_type != "soldier_agent") {
      continue;
    }

    if(!var_3 && isDefined(var_0) && distance2dsquared(self.origin, var_6.origin) > var_0) {
      continue;
    }

    if(!istrue(var_6.scripted_mode)) {
      continue;
    }

    if(var_6.team != self.team) {
      continue;
    }

    if(!istrue(var_2) && istrue(var_6.posted)) {
      continue;
    }

    var_6 notify("alerted_by_soldier");
  }
}

function debug_patrol_point_score_loop() {
  if(!scripts\engine\utility::flag_exist("patrolPoints_initialized")) {
    return;
  }

  scripts\engine\utility::flag_wait("patrolPoints_initialized");

  for(;;) {
    var_0 = getdvarint("scr_patrol_point_debug", 0);
    var_1 = getdvarint("scr_patrol_point_iso_debug", 0);

    if(var_0 != 0 && isDefined(level.players[0])) {
      var_2 = [];

      if(var_0 == 1) {
        var_2 = level.allzpatrolpoints;
      } else if(var_0 == 2) {
        var_2 = level.allspatrolpoints;
      }

      var_3 = sortbydistance(var_2, level.players[0].origin);
      var_4 = 0;

      foreach(var_6 in var_3) {
        if(var_1 > 0) {
          if(var_6.id != var_1) {
            goto LOC_0000016c;
          }
        }

        if(isDefined(var_6.patrolscore)) {
          if(isDefined(var_6.target)) {
            var_7 = scripts\engine\utility::getStructArray(var_6.target, "targetname");

            if(var_7.size >= 1) {
              foreach(var_9 in var_7) {
                thread scripts\engine\utility::draw_line_for_time(var_6.origin, var_9.origin, 1, 0, 0, 0.1);
              }
            } else {
              thread scripts\engine\utility::draw_line_for_time(var_6.origin, var_6.origin + (0, 0, 128), 1, 1, 0, 0.1);
            }
          }

          thread debug_patrol_point_score(level, var_6);
          var_4++;
        }
      }
    }

    wait 0.1;
  }
}

function debug_patrol_point_score(var_0, var_1) {
  var_2 = 0;
  var_3 = 125;
  var_4 = 300;
  var_5 = 500;
  var_6 = var_0.patrolscore;

  if(var_6 <= 0) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 1));
    return;
  }

  if(var_6 <= var_3) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (0, 1, 0));
    return;
  }

  if(var_6 <= var_4) {
    scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 1, 0));
    return;
  }

  scripts\cp\utility::drawsphere(var_0.origin, 20, var_1, (1, 0, 0));
}